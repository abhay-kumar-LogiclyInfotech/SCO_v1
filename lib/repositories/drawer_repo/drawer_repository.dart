import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/models/drawer/IndividualImageModel.dart';
import 'package:sco_v1/models/drawer/a_brief_about_sco_model.dart';
import 'package:sco_v1/models/drawer/faq_model.dart';
import 'package:sco_v1/models/drawer/news_and_events_model.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';

import '../../models/drawer/contact_us_model.dart';
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

  //*------ vision and mission -----*/
  Future<VisionAndMissionModel> visionAndMission(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _apiServices.getPostApiServices(
      url: AppUrls.getPageContentByUrl,
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

    List<NewsAndEventsModel> newsAndEventsList = [];

    for (var item in response) {
      newsAndEventsList.add(NewsAndEventsModel.fromJson(item));
    }

    return newsAndEventsList;
  }

//*------Get Individual Image-------*
  Future<IndividualImageModel> individualImage(
      {required dynamic imageId, required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
      url: "${AppUrls.individualImage}$imageId",
      headers: headers,
    );

    return IndividualImageModel.fromJson(response);
  }

  //*------Get Individual Image-------*
  Future<ABriefAboutScoModel> aBriefAboutSco(
      {required dynamic body, required dynamic headers}) async {
    dynamic response = await _apiServices.getPostApiServices(
      url: "https://sco.ae/jsonws/pageview.pagecontent/get-page-content-by-page-url",
      headers: headers,
      body: body
    );
    return ABriefAboutScoModel.fromJson(response);
  }
}
