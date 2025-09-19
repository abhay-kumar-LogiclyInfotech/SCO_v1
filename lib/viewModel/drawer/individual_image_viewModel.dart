import 'package:flutter/cupertino.dart';
import 'package:sco_v1/models/drawer/IndividualImageModel.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../../resources/app_urls.dart';

class IndividualImageViewModel with ChangeNotifier {
  //*------Accessing Api Services------*

  final DrawerRepository _drawerRepository = DrawerRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<IndividualImageModel> _individualImageResponse =
      ApiResponse.none();

  ApiResponse<IndividualImageModel> get individualImageResponse =>
      _individualImageResponse;

  set setIndividualImageResponse(ApiResponse<IndividualImageModel> response) {
    _individualImageResponse = response;
    notifyListeners();
  }

  Future<bool> individualImage(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required imageId}) async {
    try {

      setIndividualImageResponse = ApiResponse.loading();

      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.individualImage(headers: headers, imageId: imageId);

      //*-----Calling Api End-----*

      setIndividualImageResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      // debugPrint('Printing Error: $error');
      setIndividualImageResponse = ApiResponse.error(error.toString());
      return false;
    }
  }
}
