
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';
import 'package:html/parser.dart' as htmlParser;


import '../../../data/response/ApiResponse.dart';
import '../../../resources/app_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../drawer/vision_and_mission_viewModel.dart';
import '../../language_change_ViewModel.dart';
import '../../services/alert_services.dart';

class GetPageContentByUrlViewModel with ChangeNotifier {
//*------Necessary Services------*/
  late AlertServices _alertServices;

  GetPageContentByUrlViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*------Accessing Api Services------*

  final HomeRepository _homeRepository = HomeRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<VisionAndMissionModel> _apiResponse =
  ApiResponse.none();

  ApiResponse<VisionAndMissionModel> get apiResponse =>
      _apiResponse;

  set _setApiResponse(
      ApiResponse<VisionAndMissionModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Content? _content;

  Content? get content => _content;

  Future<bool> getPageContentByUrl() async {
    try {
      _setApiResponse = ApiResponse.loading();
      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': AppUrls.basicAuthWithUsernamePassword
      };
      //*-----Create Body-----*
      final body = <String, String>{
        "pageUrl": "/web/sco/scholarship-whithin-the-uae/bachelor-s-degree-scholarship/bachelor-s-degree-applying-procedures"
      };

      //*-----Calling Api Start-----*
      final response = await _homeRepository.getPageContentByUrl(headers: headers, body: body);
      // log(response.content!);

      // log(cleanDraftXmlToJson(response.content!));

      final jsonOutput = xmlToJson(response.data?.content ?? '');
      //*-----Calling Api End-----*


      _setApiResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      // debugPrint('Printing Error: $error');
      _setApiResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.toastMessage(error.toString());

      return false;
    }
  }
}





