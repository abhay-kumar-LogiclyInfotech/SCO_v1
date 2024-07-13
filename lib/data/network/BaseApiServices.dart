import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> getGetApiServices(
      {required dynamic url, required dynamic headers});

  Future<dynamic> getPostApiHeadersBodyServices(
      {required dynamic url, required dynamic headers, required dynamic body});

  Future<dynamic> getMultipartApiServices({
    required String url,
    required Map<String, String> field,
    required List<http.MultipartFile> file,
    required Map<String, String> header,
  });
}
