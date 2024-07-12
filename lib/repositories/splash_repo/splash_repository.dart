import 'package:flutter/cupertino.dart';

import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../models/splash/commonData_model.dart';
import '../../resources/app_urls.dart';

class SplashRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<CommonDataModel> fetchCommonData(
      {required Map<String, String> headers}) async {
    try {
      dynamic response = await _apiServices.getGetApiServices(
        url: AppUrls.commonData,
        headers: headers,
      );
      return CommonDataModel.fromJson(response);
    } catch (error) {
      debugPrint('Error fetching common data: $error');
      throw Exception('Failed to fetch common data');
    }
  }
}
