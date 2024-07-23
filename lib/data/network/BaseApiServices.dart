import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> getGetApiServices(
      {required dynamic url, required dynamic headers});

  Future<dynamic> getPostApiServices(
      {required dynamic url, required dynamic headers, required dynamic body});

  Future<dynamic> getPutApiServices(
      {required dynamic url, required dynamic headers, required dynamic body});

  Future<dynamic> getMultipartApiServices({
    required String method,
    required String url,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    required Map<String, String> headers,
  });
}
