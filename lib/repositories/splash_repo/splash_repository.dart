import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/open_authorization/open_authorization_model.dart';

import '../../models/splash/commonData_model.dart';
import '../../resources/app_urls.dart';

class SplashRepository {
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

  /// Fetch List of values for dropdowns and etc..
  Future<CommonDataModel> fetchCommonData(
      {required Map<String, String> headers}) async {
    try {
      dynamic response = await _dioBaseApiServices.dioGetApiService(
        url: AppUrls.commonData,
        headers: headers,
      );
      return CommonDataModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  /// Get Token
  Future<OpenAuthorizationModel> getToken({required dynamic body}) async {
    return OpenAuthorizationModel.fromJson(
      await _dioBaseApiServices.dioPostApiService(
        url: AppUrls.openAuthToken,
        body: body,
      ),
    );
  }
}
