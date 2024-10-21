import 'dart:io';

import 'package:dio/dio.dart';
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
        logger.i('Request Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i('Response Status: ${response.statusCode}');
        logger.i('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        logger.e('Error: ${e.message}');
        if (e.response != null) {
          logger.e('Error Response Status: ${e.response?.statusCode}');
          logger.e('Error Response Data: ${e.response?.data}');
        }
        return handler.next(e);
      },
    ));
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
      );
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
      );
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
      );
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
      );
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
      );
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
          return FetchDataException('Unexpected error: ${error.message}');
      }
    } else if (error is SocketException) {
      return FetchDataException('No Internet Connection');
    } else if (error is FormatException) {
      return FetchDataException('Response format error: $error');
    } else {
      return AppExceptions('Unexpected Error', error.toString());
    }
  }

  String _errorMessage(Response response) {
    try {
      // If errors field exists, extract detailed error messages
      if (response.data != null) {
        final errorData = response.data;
        final error = errorData['error'];
        final errors = errorData['errors'];

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
