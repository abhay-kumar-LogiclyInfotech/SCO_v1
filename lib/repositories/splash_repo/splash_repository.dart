import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/resources/app_urls.dart';

import '../../models/splash/commonData_model.dart';

class SplashRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<CommonDataModel> fetchCommonData({required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
        url: AppUrls.commonData, headers: headers);
    return CommonDataModel.fromJson(response);
  }


}
