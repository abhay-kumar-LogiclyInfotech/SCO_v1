//
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:sco_v1/models/drawer/news_and_events_model.dart';
// import 'package:sco_v1/repositories/home/home_repository.dart';
// import 'package:xml/xml.dart';
//
// import '../../data/response/ApiResponse.dart';
// import '../../models/home/HomeSliderModel.dart';
// import '../../repositories/drawer_repo/drawer_repository.dart';
// import '../../resources/app_urls.dart';
// import '../../utils/constants.dart';
// import '../../utils/utils.dart';
// import '../language_change_ViewModel.dart';
// import '../services/alert_services.dart';
//
// class HomeSliderViewModel with ChangeNotifier {
//   //*------Necessary Services------*/
//   late AlertServices _alertServices;
//
//   HomeSliderViewModel() {
//     final GetIt getIt = GetIt.instance;
//     _alertServices = getIt.get<AlertServices>();
//   }
//
//   //*------Accessing Api Services------*
//
//   final HomeRepository _homeRepository = HomeRepository();
//
//   //*------Get Security Question Method Start------*/
//   ApiResponse<List<HomeSliderModel>> _homeSliderResponse = ApiResponse.none();
//
//   ApiResponse<List<HomeSliderModel>> get homeSliderResponse =>
//       _homeSliderResponse;
//
//   set _setHomeSliderResponse(ApiResponse<List<HomeSliderModel>> response) {
//     _homeSliderResponse = response;
//     notifyListeners();
//   }
//
//   Future<bool> homeSlider({
//     required BuildContext context,
//     required LanguageChangeViewModel langProvider,
//   }) async {
//     try {
//       _setHomeSliderResponse = ApiResponse.loading();
//
//       //*-----Create Headers-----*
//       final headers = <String, String>{
//         'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//         'authorization': AppUrls.basicAuthWithUsernamePassword,
//       };
//
//       //*-----Calling Api Start-----*
//       final response = await _homeRepository.homeSlider(headers: headers);
//       //*-----Calling Api End-----*
//
//       // Ensure languageId is available
//       // final languageId = langProvider.languageId;
//       final languageId = getTextDirection(langProvider) == TextDirection.rtl
//           ? 'ar_SA'
//           : 'en_US'; // Use the current language ID from the provider
//
//       Service? parseServices(String xmlString) {
//         final document = XmlDocument.parse(xmlString);
//         Service? service;
//         for (var element in document.findAllElements('dynamic-element')) {
//           if (element.getAttribute('name') == 'ServiceName') {
//             service = Service.fromXml(element, languageId);
//           }
//         }
//         return service;
//       }
//
// // Parses each XML content in the response and filters out null services.
//       List<Service> parseServiceList(response) {
//
//         List<Service> services = [];
//
//         for (var element in response) {
//           final service = parseServices(element.content!);
//           if (service != null) {
//             services.add(service);
//           }
//         }
//
//         return services;
//       }
//
//       final list = parseServiceList(response);
//
//
//       // print(list.length);
//       list.forEach((action){
//         // debugPrint(action.serviceShortDescription);
//       });
//
//
//       _setHomeSliderResponse = ApiResponse.completed(response);
//
//       return true;
//     } catch (error) {
//       // debugPrint('Printing Error: $error');
//       _setHomeSliderResponse = ApiResponse.error(error.toString());
//       _alertServices.toastMessage(error.toString());
//
//       return false;
//     }
//   }
// }
//
// class Service {
//   final String title;
//   final String serviceName;
//   final String serviceImage;
//   final String serviceShortDescription;
//   final String linkToPage;
//   final String sortOrder;
//   final String urlLink;
//   final bool hideSlide;
//   final String fileEntryId;
//
//   Service({
//     required this.title,
//     required this.serviceName,
//     required this.serviceImage,
//     required this.serviceShortDescription,
//     required this.linkToPage,
//     required this.sortOrder,
//     required this.urlLink,
//     required this.hideSlide,
//     required this.fileEntryId,
//   });
//
//   factory Service.fromXml(XmlElement element, String languageId) {
//     return Service(
//       title: _getDynamicContent(element, 'Title', languageId),
//       serviceName: _getDynamicContent(element, 'ServiceName', languageId),
//       serviceImage: _getDynamicImageContent(element, languageId),
//       serviceShortDescription:
//           _getDynamicContent(element, 'ServiceShortDescription', languageId),
//       linkToPage: _getDynamicContent(element, 'LinkToPage74u3', languageId),
//       sortOrder: _getDynamicContent(element, 'SortOrder', languageId),
//       urlLink: _getDynamicContent(element, 'UrlLink', languageId),
//       hideSlide: _getBooleanDynamicContent(element, 'HideSlide', languageId),
//       fileEntryId: _getFileEntryId(element, languageId),
//     );
//   }
//
//   static String _getDynamicContent(
//       XmlElement element, String name, String languageId) {
//     final dynamicContent = element
//         .findElements('dynamic-element')
//         .where((e) => e.getAttribute('name') == name)
//         .expand((e) => e.findElements('dynamic-content'))
//         .where((e) =>
//             e.getAttribute('language-id') == languageId) // Filter by languageId
//         .map((e) => e.text)
//         .join();
//     return dynamicContent.replaceAll(RegExp(r'<!\[CDATA\[(.*?)\]\]>'), '${1}');
//   }
//
//   static String _getDynamicImageContent(XmlElement element, String languageId) {
//     final dynamicContent = element
//         .findElements('dynamic-element')
//         .where((e) => e.getAttribute('name') == 'image')
//         .expand((e) => e.findElements('dynamic-content'))
//         .where((e) => e.getAttribute('language-id') == languageId)
//         .map((e) => e.text)
//         .join();
//     return dynamicContent.replaceAll(RegExp(r'<!\[CDATA\[(.*?)\]\]>'), '${1}');
//   }
//
//   static bool _getBooleanDynamicContent(
//       XmlElement element, String name, String languageId) {
//     final dynamicContent = _getDynamicContent(element, name, languageId);
//     return dynamicContent.toLowerCase() == 'true';
//   }
//
//   static String _getFileEntryId(XmlElement element, String languageId) {
//     final dynamicContent = element
//         .findElements('dynamic-element')
//         .where((e) => e.getAttribute('type') == 'image')
//         .expand((e) => e.findElements('dynamic-content'))
//         .where((e) => e.getAttribute('language-id') == languageId)
//         .map((e) => e.text)
//         .join();
//
//     final match = RegExp(r'"fileEntryId":"(\d+)"').firstMatch(dynamicContent);
//     return match?.group(1) ?? '';
//   }
// }
