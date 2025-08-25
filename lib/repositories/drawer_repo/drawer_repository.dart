import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/drawer/IndividualImageModel.dart';
import 'package:sco_v1/models/drawer/a_brief_about_sco_model.dart';
import 'package:sco_v1/models/drawer/faq_model.dart';
import 'package:sco_v1/models/drawer/news_and_events_model.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';

import '../../models/drawer/contact_us_model.dart';
import '../../resources/app_urls.dart';

class DrawerRepository {
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

  //*------Faq's API method------*/
  Future<FaqModel> faq(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.faq,
      headers: headers,
      queryParams: body,
    );
    return FaqModel.fromJson(response);
  }

  //*------ vision and mission -----*/
  Future<VisionAndMissionModel> visionAndMission({
    required dynamic headers,
    required dynamic body,
  }) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.getPageContentByUrl,
      headers: headers,
      body: body,
    );
    return VisionAndMissionModel.fromJson(response);
  }

  //*------Contact Us methods------*/
  // Future<ContactUsModel> contactUs(
  //     {required Map<String, String> headers,
  //     required FormData data}) async {
  //   dynamic response = await _dioBaseApiServices.dioMultipartApiService(
  //       method: 'POST',
  //       url: AppUrls.contactUs,
  //       headers: headers,
  //       data: data);
  //   return ContactUsModel.fromJson(response);
  // }
  Future<ContactUsModel> contactUs(
      {required Map<String, String> headers, required dynamic data}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.contactUs,
      headers: headers,
      body: data,
    );
    if (response != null && response.toString().isNotEmpty) {
      return ContactUsModel.fromJson(response);
    } else {
      return ContactUsModel(messageCode: "0000", message: "Request Submitted Successfully");
    }
  }

  //*------Get News and Events Method-------*
  Future<List<NewsData>> newsAndEvents({required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.newsAndEvents,
      headers: headers,
    );

    final responseModel = NewsAndEventsModel.fromJson(response);

    List<NewsData> newsAndEventsList = [];

    for (var item in responseModel.data ?? []) {
      newsAndEventsList.add(item);
    }

    return newsAndEventsList;
  }

//*------Get Individual Image-------*
  Future<IndividualImageModel> individualImage(
      {required dynamic imageId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: "${AppUrls.individualImage}$imageId",
      headers: headers,
    );

    return IndividualImageModel.fromJson(response);
  }

  //*------Get Individual Image-------*
  Future<ABriefAboutScoModel> aBriefAboutSco(
      {required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
        url: AppUrls.getPageContentByUrl, headers: headers, body: body);
    return ABriefAboutScoModel.fromJson(response);
  }
}
