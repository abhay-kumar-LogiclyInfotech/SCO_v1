import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/models/drawer/a_brief_about_sco_model.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';
import 'package:xml/xml.dart' as xml;

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../language_change_ViewModel.dart';

class GetAllActiveScholarshipsViewModel with ChangeNotifier {
  //*------Accessing Api Services------*

  final HomeRepository _homeRepository = HomeRepository();

  ApiResponse<List<GetAllActiveScholarshipsModel>> _apiResponse = ApiResponse.none();

  ApiResponse<List<GetAllActiveScholarshipsModel>> get apiResponse => _apiResponse;

  set _setApiResponse(ApiResponse<List<GetAllActiveScholarshipsModel>> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> getAllActiveScholarships(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    InternetController _internetController =  Get.find<InternetController>();

    if (_internetController.isConnected.value) {
      try {
        _setApiResponse = ApiResponse.loading();

        // clearing the list first
        _apiResponse.data?.clear();

        //*-----Create Headers-----*
        final headers = <String, String>{
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        //*-----Calling Api Start-----*
        final response =
            await _homeRepository.getAllActiveScholarships(headers: headers);
        //*-----Calling Api End-----*

        _setApiResponse = ApiResponse.completed(response);
        return true;
      } catch (error) {
        debugPrint('Printing Error: $error');
        _setApiResponse = ApiResponse.error(error.toString());
        return false;
      }
    } else {
      return false;
    }
  }
}
