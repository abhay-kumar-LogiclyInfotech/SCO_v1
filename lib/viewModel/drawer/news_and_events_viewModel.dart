import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/drawer/news_and_events_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

class NewsAndEventsViewmodel with ChangeNotifier {
  //*------Necessary Services------*/
  late AlertServices _alertServices;

  NewsAndEventsViewmodel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*------Accessing Api Services------*

  final DrawerRepository _drawerRepository = DrawerRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<List<NewsAndEventsModel>> _newsAndEventsResponse =
      ApiResponse.none();

  ApiResponse<List<NewsAndEventsModel>> get newsAndEventsResponse =>
      _newsAndEventsResponse;

  set _setNewsAndEventsResponse(
      ApiResponse<List<NewsAndEventsModel>> response) {
    _newsAndEventsResponse = response;
    notifyListeners();
  }


  List<ParseNewsAndEventsModel> _parsedNewsAndEventsModelList = [];

  List<ParseNewsAndEventsModel> get parsedNewsAndEventsModelList => _parsedNewsAndEventsModelList;



  Future<bool> newsAndEvents(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      _setNewsAndEventsResponse = ApiResponse.loading();

      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.newsAndEvents(headers: headers);
      //*-----Calling Api End-----*

      _parsedNewsAndEventsModelList =
         response.map((element) {
        return ParseNewsAndEventsModel(
            content: element.content ?? "",
            description: element.description ?? "",
            title: element.title ?? "",
            publishDate: element.publishDate ?? "",
            coverImageFileEntryId: element.coverImageFileEntryId ?? "",
            entryUrl: element.entryUrl ?? "");
      }).toList();


      _setNewsAndEventsResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setNewsAndEventsResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.showErrorSnackBar(error.toString());

      return false;
    }
  }
}
