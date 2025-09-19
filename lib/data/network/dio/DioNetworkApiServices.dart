import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:logger/logger.dart';
import 'package:sco_v1/utils/key_constants.dart';

import '../../../resources/app_urls.dart';
import '../../../view/authentication/login/login_view.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services/token_service.dart';
import '../../app_exceptions.dart';
import 'DioBaseApiServices.dart';

class DioNetworkApiServices extends DioBaseApiServices {
  final Dio _dio = Dio();
  final Logger logger = Logger();

  final GetIt getIt = GetIt.instance;

  bool _isRefreshing = false;
  final List<Function(RequestOptions)> _pendingRequests = [];


  /// print request
  logRequest(RequestOptions options){
    if(kDebugMode){
      debugPrint('#################################### custom Authorization used ####################################');
      logger.i('Request: ${options.method} ${options.uri}');
      logger.i('Request Headers: ${options.headers}');
      logger.i('Request Data: ${jsonEncode(options.data.toString())}');
    }
  }

  // print error
  logErrors(DioException e){
    if(kDebugMode){
      logger.e('Error: ${e.message}');
      logger.e('Error Response Status: ${e.response?.statusCode}');
      logger.e('Error Response Data: ${e.response?.data}');
    }
  }

  // log response
  logResponse(Response response){
    if(kDebugMode){
      logger.d('Response Status: ${response.statusCode}');
      log('Response Data: ${jsonEncode(response.data.toString())}');
    }
  }

  DioNetworkApiServices() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {

        // Special content type handling for token endpoint
        if (options.path == AppUrls.openAuthToken) {
          options.contentType = Headers.formUrlEncodedContentType;
        }


        // Skip token injection if Authorization already provided
        if (options.headers.containsKey('Authorization')) {
          logRequest(options);
          return handler.next(options);
        }



        if(options.path.contains('common-data') || (options.path == AppUrls.login) || (options.path == AppUrls.signup) || (options.path == AppUrls.openAuthToken)){
          debugPrint('#################################### common token added ####################################');
          options.headers['Authorization'] = 'Bearer ${await TokenService.instance.getCommonApiToken}';
        }else{
          debugPrint('#################################### user token added ####################################');
          options.headers['Authorization'] = 'Bearer ${await TokenService.instance.getUserApiAccessToken}';
        }


       logRequest(options);
        return handler.next(options);
      },
        onError: (DioException e, handler) async {
          try {
            // 1. Skip interceptor for token refresh calls
            if (e.requestOptions.path.contains('/token')) {
              return handler.next(e);
            }

            // 2. Extract message
            String? errorMessage;
            final responseData = e.response?.data;
            if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
              errorMessage = responseData['message']?.toString();
            }

            // 3. Handle token expiration
            if (errorMessage == 'Invalid or expired token') {
              final reqOptions = e.requestOptions;

              // Prevent multiple refresh calls
              if (!_isRefreshing) {
                _isRefreshing = true;

                try {
                  // Refresh BOTH tokens
                  final commonRefreshed = await TokenService.instance.getToken(
                    grantType: GrantType.refreshToken,
                    tokenAccessType: TokenAccessType.common,
                  );
                  final userRefreshed = await TokenService.instance.getToken(
                    grantType: GrantType.refreshToken,
                    tokenAccessType: TokenAccessType.user,
                  );

                  _isRefreshing = false;

                  if (commonRefreshed && userRefreshed) {
                    // Retry all queued requests AFTER tokens are refreshed
                    for (var callback in _pendingRequests) {
                      callback(reqOptions);
                    }
                    _pendingRequests.clear();

                    // Retry the failed request
                    final newAccessToken =
                    await TokenService.instance.getUserApiAccessToken;
                    reqOptions.headers['Authorization'] = 'Bearer $newAccessToken';

                    final retryResponse = await _dio.fetch(reqOptions);
                    return handler.resolve(retryResponse);
                  } else {
                    // Refresh failed → force logout
                    _pendingRequests.clear();
                    GetIt.instance.get<NavigationServices>().clearStackAndPush(MaterialPageRoute(builder: (_) => const LoginView()));
                    return handler.reject(e);
                  }
                } catch (err) {
                  _isRefreshing = false;
                  _pendingRequests.clear();
                  return handler.reject(
                    err is DioException ? err : DioException(requestOptions: reqOptions, error: err.toString()),
                  );
                }
              } else {
                // Queue requests during refresh
                final completer = Completer<Response>();
                _pendingRequests.add((requestOptions) async {
                  try {
                    final cloneReq = await _dio.fetch(requestOptions);
                    completer.complete(cloneReq);
                  } catch (err) {
                    completer.completeError(err);
                  }
                });
                return completer.future.then((value) => handler.resolve(value));
              }
            }

            /// print errors
            logErrors(e);

          } catch (err) {
            logger.e('Interceptor Error: $err');
          }

          return handler.next(e);
        },
      onResponse: (response, handler) {
        logResponse(response);
        return handler.next(response);
      },
    ));

    // SSL pinning
    _dio.interceptors.add(CertificatePinningInterceptor(
      allowedSHAFingerprints: [dotenv.env[KeyConstants.sha256SslFingerPrints]!],
    ));

  }


  /// SSL PINNING WORKING CODE
  // DioNetworkApiServices(){
  //
  //   // Initialize Logger
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       logger.i('Request: ${options.method} ${options.uri}');
  //       logger.i('Request Headers: ${options.headers}');
  //       logger.d('Request Data: ${options.data}');
  //       return handler.next(options);
  //     },
  //     onResponse: (response, handler) {
  //       logger.d('Response Status: ${response.statusCode}');
  //       logger.d('Response Data: ${response.data}');
  //       return handler.next(response);
  //     },
  //     onError: (DioException e, handler) {
  //       logger.e('Error: ${e.message}');
  //       if (e.response != null) {
  //         logger.e('Error Response Status: ${e.response?.statusCode}');
  //         logger.e('Error Response Data: ${e.response?.data}');
  //       }
  //       return handler.next(e);
  //     },
  //   ));
  //
  //
  //
  //
  //   /// ssl pinning
  //   _dio.interceptors.add(CertificatePinningInterceptor(
  //       allowedSHAFingerprints: [
  //         dotenv.env[KeyConstants.sha256SslFingerPrints]!
  //       ]));
  //
  //
  //
  //   /// ########################### To intercept traffic on Proxy Man using proxy ip and port ###########################
  //   // String proxy = Platform.isAndroid ? '172.29.236.246:9090' : '172.29.236.246:9090';
  //   _dio.httpClientAdapter = IOHttpClientAdapter(
  //     createHttpClient: () {
  //       final client = HttpClient();
  //       // If you intend to use a proxy, you can keep this.
  //       // However, if the proxy tries to intercept SSL, the connection will fail
  //       // because of the certificate pinning (assuming you remove badCertificateCallback).
  //       // if(kDebugMode){
  //       //   client.findProxy = (uri) {
  //       //     return 'PROXY $proxy';
  //       //   };
  //       // }
  //       // *** DO NOT ADD client.badCertificateCallback = (X509Certificate cert, String host, int port) => true; ***
  //       return client;
  //     }, // This validateCertificate callback for IOHttpClientAdapter is generally
  //     // for low-level custom validation. For standard pinning, the
  //     // CertificatePinningInterceptor is more suitable.
  //     // If you're relying on the CertificatePinningInterceptor, you can often
  //     // leave this as true or remove it if not needed for other custom logic.
  //     validateCertificate: (cert, host, port) {
  //       return true;
  //     },
  //   );
  // }

  @override
  Future<dynamic> dioGetApiService({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await _dio
          .get(
            url,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
              extra: {
                'cache': true, // Enable cache for this request
              },
            ),
            queryParameters: queryParams,
          )
          .timeout(const Duration(minutes: 5));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioPostApiService({
    required String url,
    Map<String, dynamic>? headers,
    required dynamic body,
  }) async {
    try {
      final response = await _dio
          .post(
            url,
            data: body,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(minutes: 2));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioPutApiService({
    required String url,
    required Map<String, dynamic> headers,
    required dynamic body,
  }) async {
    try {
      final response = await _dio
          .put(
            url,
            data: body,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(minutes: 2));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioPatchApiService({
    required String url,
    required Map<String, dynamic> headers,
    required dynamic body,
  }) async {
    try {
      final response = await _dio
          .patch(
            url,
            data: body,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(minutes: 2));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioDeleteApiService({
    required String url,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await _dio
          .delete(
            url,
            options: Options(
              headers: headers,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(minutes: 2));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioMultipartApiService({
    required String method,
    required String url,
    required FormData data,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await _dio
          .request(
            url,
            data: data,
            options: Options(
              headers: headers,
              method: method,
              responseType: ResponseType.json,
            ),
          )
          .timeout(const Duration(minutes: 2));
      if (kDebugMode) {
        debugPrint(response.statusCode.toString());
      }
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(_errorMessage(response));
      case 401:
        throw UnAuthorizedException(_errorMessage(response));
      case 404:
        throw UserNotFoundException(_errorMessage(response));
      case 422:
        // Handle 422 Unprocessable Entity
        throw ValidationException(_errorMessage(response));
      case 429:
        throw TooManyRequestsException(_errorMessage(response));
      case 500:
        throw InternalServerErrorException(_errorMessage(response));
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }

  AppExceptions _handleError(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.connectionTimeout:
          return FetchDataException('Connection timeout');
        case DioErrorType.sendTimeout:
          return FetchDataException('Send timeout');
        case DioErrorType.receiveTimeout:
          return FetchDataException('Receive timeout');
        case DioErrorType.badResponse:
          // Check for status code 422 specifically
          //   if (error.response?.statusCode == 422) {
          if (error.response?.statusCode != null) {
            return ValidationException(_errorMessage(error.response!));
          }
          return FetchDataException(
              'Received invalid status code: ${error.response?.statusCode}');
        case DioErrorType.cancel:
          return FetchDataException('Request cancelled');
        case DioErrorType.badCertificate:
          return FetchDataException('Certification Error');
        case DioErrorType.connectionError:
          return FetchDataException('Connection Error occurred');
        case DioErrorType.unknown:
          // return FetchDataException('Unexpected error: ${error.message}');
          return FetchDataException(' ${error.message}');
      }
    } else if (error is SocketException) {
      return FetchDataException(error.message);
    } else if (error is FormatException) {
      return FetchDataException('Response format error: $error');
    } else {
      // return AppExceptions('Unexpected Error', error.toString());
      return AppExceptions('', error.toString());
    }
  }

  String _errorMessage(Response response) {
    try {
      // If errors field exists, extract detailed error messages
      if (response.data != null) {
        final errorData = response.data;
        final error = errorData['error'];
        final errors = errorData['errors'];
        final message = errorData['message'];

        if (message != null) {
          return message.toString();
        }

        if (error != null) {
          return error.toString();
        }
        if (errors != null) {
          return errors.toString();
        }
      }
      return 'Unknown error occurred';
    } catch (e) {
      return 'Unknown error occurred with status code: ${response.statusCode}';
    }
  }
}
