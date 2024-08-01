import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/models/drawer/faq_model.dart';
import 'package:sco_v1/models/drawer/news_and_events_model.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';
import 'package:sco_v1/viewModel/drawer/contact_us_viewModel.dart';

import '../../models/drawer/contact_us_model.dart';
import '../../models/splash/commonData_model.dart';
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

  //*------Contact Us methods------*/
  Future<ContactUsModel> contactUs(
      {required Map<String, String> headers,
        required Map<String, String> fields}) async {
    dynamic response = await _apiServices.getMultipartApiServices(
        method: 'POST',
        url: AppUrls.contactUs,
        headers: headers,
        files: [],
        fields: fields);
    return ContactUsModel.fromJson(response);
  }



  //*------Get News and Events Method-------*
  Future<List<NewsAndEventsModel>> newsAndEvents(
      {required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
      url: AppUrls.newsAndEvents,
      headers: headers,
    );

    List<NewsAndEventsModel> _newsAndEventsList = [];

    for(var item in response){
      _newsAndEventsList.add(NewsAndEventsModel.fromJson(item));
    }

    return _newsAndEventsList;
  }
}
