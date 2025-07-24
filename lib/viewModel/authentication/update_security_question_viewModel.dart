import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/authentication/update_security_question_model.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';
import '../../resources/app_urls.dart';

class UpdateSecurityQuestionViewModel with ChangeNotifier {
  late AlertServices _alertServices;

  UpdateSecurityQuestionViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

//*----------Update Security Question Start---------*

  String? _securityQuestion;
  String? _securityAnswer;

  void setSecurityQuestion(String? securityQuestion) async {
    _securityQuestion = securityQuestion;
    notifyListeners();
  }

  void setSecurityAnswer(String? securityAnswer) async {
    _securityAnswer = securityAnswer;
    notifyListeners();
  }

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ApiResponse<UpdateSecurityQuestionModel> _updateSecurityQuestionResponse =
      ApiResponse.none();

  ApiResponse<UpdateSecurityQuestionModel> get updateSecurityQuestionResponse =>
      _updateSecurityQuestionResponse;

  set setUpdateSecurityQuestionResponse(
      ApiResponse<UpdateSecurityQuestionModel> response) {
    _updateSecurityQuestionResponse = response;
    notifyListeners();
  }

  Future<bool> updateSecurityQuestion(
      {
        // required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required String userId}) async {
    try {

      //*-----Create Headers Start-----*

      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'authorization': AppUrls.basicAuth
      };
      //*-----Create Headers End-----*

      //*-----Create Body Start-----*

      if (_securityQuestion == null ||
          _securityAnswer == null ||
          _securityQuestion!.isEmpty ||
          _securityAnswer!.isEmpty ||
          userId.isEmpty) {
        return false;
      }

      setUpdateSecurityQuestionResponse = ApiResponse.loading();

      final formData = FormData.fromMap({
        "securityQuestion": _securityQuestion!,
        "securityAnswer": _securityAnswer!,
      });

      //*-----Create Body End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.updateSecurityQuestion(
        userId: userId,
        data: formData,
        headers: headers,
      );

      //*-----Calling Api End-----*

      //Message to show status of the operation:
      setUpdateSecurityQuestionResponse = ApiResponse.completed(response);
      _alertServices.toastMessage(response.message.toString());
      return true;
    } catch (error) {
      // debugPrint('Printing Error: $error');
      setUpdateSecurityQuestionResponse = ApiResponse.error(error.toString());
      //Message to show status of the operation:
      // _alertServices.toastMessage(
      //   error.toString()
      // );
      _alertServices.showErrorSnackBar(error.toString());
      return false;
    }
  }

//*----------Update Security Question End--------*
}
