import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';


import '../../models/splash/commonData_model.dart';
import '../../resources/app_urls.dart';

class SplashRepository {

  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

  Future<CommonDataModel> fetchCommonData(
      {required Map<String, String> headers}) async {
    try {
      dynamic response = await _dioBaseApiServices.dioGetApiService(
        url: AppUrls.commonData,
        headers: headers,
      );
      return CommonDataModel.fromJson(response);
    } catch (error) {
      // debugPrint('Error fetching common data: $error');
      throw Exception('Failed to fetch common data');
    }
  }
}
