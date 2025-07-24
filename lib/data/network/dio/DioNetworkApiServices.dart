import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:logger/logger.dart';

import '../../app_exceptions.dart';
import 'DioBaseApiServices.dart';

class DioNetworkApiServices extends DioBaseApiServices {
  final Dio _dio = Dio();
  final Logger logger = Logger();

  DioNetworkApiServices() {
    // Initialize Logger
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.i('Request: ${options.method} ${options.uri}');
        logger.i('Request Headers: ${options.headers}');
        logger.d('Request Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d('Response Status: ${response.statusCode}');
        logger.d('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        logger.e('Error: ${e.message}');
        if (e.response != null) {
          logger.e('Error Response Status: ${e.response?.statusCode}');
          logger.e('Error Response Data: ${e.response?.data}');
        }
        return handler.next(e);
      },
    ));



    /// ssl pinning
    _dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: ["512382b53ff242ecec47530c17a443706a0e09f532a1b036d0c745aeb2bda0a0"]));


    /// ########################### To intercept traffic on Proxy Man using proxy ip and port ###########################
    String proxy = Platform.isAndroid ? '192.168.213.118:9090' : '192.168.213.118:9090';
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // If you intend to use a proxy, you can keep this.
        // However, if the proxy tries to intercept SSL, the connection will fail
        // because of the certificate pinning (assuming you remove badCertificateCallback).
        if(kDebugMode){
          client.findProxy = (uri) {
            return 'PROXY $proxy';
          };
        }
        // *** DO NOT ADD client.badCertificateCallback = (X509Certificate cert, String host, int port) => true; ***
        return client;
      },
      // This validateCertificate callback for IOHttpClientAdapter is generally
      // for low-level custom validation. For standard pinning, the
      // CertificatePinningInterceptor is more suitable.
      // If you're relying on the CertificatePinningInterceptor, you can often
      // leave this as true or remove it if not needed for other custom logic.
      validateCertificate: (cert, host, port) {
        return true;
      },
    );

  }



  @override
  Future<dynamic> dioGetApiService({
    required String url,
    required Map<String, dynamic>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
          extra: {
            'cache': true, // Enable cache for this request
          },
        ),
        queryParameters: queryParams,
      ).timeout(const Duration(minutes: 5));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> dioPostApiService({
    required String url,
    required Map<String, dynamic> headers,
    required dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      ).timeout(const Duration(minutes: 2));
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
      final response = await _dio.put(
        url,
        data: body,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      ).timeout(const Duration(minutes: 2));
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
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      ).timeout(const Duration(minutes: 2));
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
      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      ).timeout(const Duration(minutes: 2));
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
      final response = await _dio.request(
        url,
        data: data,
        options: Options(
          headers: headers,
          method: method,
          responseType: ResponseType.json,
        ),
      ).timeout(const Duration(minutes: 2));
      if(kDebugMode){debugPrint(response.statusCode.toString());}
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
        throw FetchDataException('Error occurred while communicating with server with status code ${response.statusCode}');
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
