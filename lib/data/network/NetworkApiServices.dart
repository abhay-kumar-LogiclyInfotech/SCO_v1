import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiServices(
      {required dynamic url, required dynamic headers}) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(minutes: 5));

      debugPrint(response.statusCode.toString());
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> getPostApiServices(
      {required dynamic url,
      required dynamic headers,
      required dynamic body}) async {
    try {
      final response = await http
          .post(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(minutes: 2));
      debugPrint(response.statusCode.toString());
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> getPutApiServices(
      {required dynamic url,
        required dynamic headers,
        required dynamic body}) async {
    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: headers)
          .timeout(const Duration(minutes: 2));
      debugPrint(response.statusCode.toString());
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }


  @override
  Future<dynamic> getMultipartApiServices({
    required String method,
    required String url,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    required Map<String, String> headers,
  }) async {
    try {
      final request = http.MultipartRequest(method, Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll(fields);
      request.files.addAll(files);

      final response =
          await request.send().timeout(const Duration(seconds: 30));
      debugPrint(response.statusCode.toString());
      final responseString = await response.stream.bytesToString();
      return _handleResponse(
          http.Response(responseString, response.statusCode));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response);
      case 400:
        throw BadRequestException(_errorMessage(response));
      case 401:
        throw UnAuthorizedException(_errorMessage(response));
      case 404:
        throw UserNotFoundException(_errorMessage(response));
      case 500:
        throw InternalServerErrorException(_errorMessage(response));
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }

  dynamic _decodeResponse(http.Response response) {
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw FormatException(
          'Failed to parse response as JSON: ${response.body}');
    }
  }

  AppExceptions _handleError(dynamic error) {
    if (error is SocketException) {
      return FetchDataException('No Internet Connection');
    } else if (error is FormatException) {
      return FormatException('Response format error: $error');
    } else {
      return AppExceptions(" Unexpected Error", "$error");
    }
  }

  String _errorMessage(http.Response response) {
    try {
      return jsonDecode(response.body)['message'];
    } catch (e) {
      return ' Unknown error occurred with status code: ${response.statusCode}';
    }
  }
}
