import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/models/drawer/faq_model.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';

import '../../resources/app_urls.dart';

class DrawerRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  //*------Faq's API method------*/
  Future<FaqModel> faq(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _apiServices.getPostApiServices(
      url: AppUrls.faq,
      headers: headers,
      body: body,
    );
    return FaqModel.fromJson(response);
  }



  //*------Faq's API method------*/
  Future<VisionAndMissionModel> visionAndMission(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _apiServices.getPostApiServices(
      url: AppUrls.visionAndMission,
      headers: headers,
      body: body,
    );
    return VisionAndMissionModel.fromJson(response);
  }
}
