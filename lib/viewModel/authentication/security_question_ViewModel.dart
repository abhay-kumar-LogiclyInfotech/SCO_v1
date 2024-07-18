import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/get_security_questions_model.dart';
import 'package:sco_v1/models/authentication/update_security_question_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

class SecurityQuestionViewModel with ChangeNotifier {
  late AlertServices _alertServices;

  SecurityQuestionViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*----------Get Security Question Start--------*

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ApiResponse<GetSecurityQuestionsModel> _getSecurityQuestionResponse =
      ApiResponse.loading();

  ApiResponse<GetSecurityQuestionsModel> get getSecurityQuestionResponse =>
      _getSecurityQuestionResponse;

  set setGetSecurityQuestionResponse(
      ApiResponse<GetSecurityQuestionsModel> response) {
    _getSecurityQuestionResponse = response;
    notifyListeners();
  }

  //Get Questions Function:
  Future<bool> getSecurityQuestions(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required String userId}) async {
    try {
      //*-----Create Headers Start-----*
      setGetSecurityQuestionResponse = ApiResponse.loading();

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.getSecurityQuestions(
        userId: userId,
        headers: headers,
      );
      //*-----Calling Api End-----*

      setGetSecurityQuestionResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      setGetSecurityQuestionResponse = ApiResponse.error(error.toString());
      _alertServices.flushBarErrorMessages(
          message: error.toString(), context: context, provider: langProvider);
      return false;
    }
  }

//*----------Get Security Question End--------*

//------------------------------------------------------------------------------------------------

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

  ApiResponse<UpdateSecurityQuestionModel> _updateSecurityQuestionResponse =
      ApiResponse.loading();

  ApiResponse<UpdateSecurityQuestionModel> get updateSecurityQuestionResponse =>
      _updateSecurityQuestionResponse;

  set setUpdateSecurityQuestionResponse(
      ApiResponse<UpdateSecurityQuestionModel> response) {
    _updateSecurityQuestionResponse = response;
    notifyListeners();
  }

  Future<bool> updateSecurityQuestion(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required String userId}) async {
    try {
      setUpdateSecurityQuestionResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
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
      final body = {
        "securityQuestion": _securityQuestion,
        "securityAnswer": _securityAnswer,
      };
      //*-----Create Body End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.updateSecurityQuestion(
        userId: userId,
        body: body,
        headers: headers,
      );
      //*-----Calling Api End-----*

      //Message to show status of the operation:
      _alertServices.flushBarErrorMessages(
        message: response.message.toString(),
        context: context,
        provider: langProvider,
      );
      setUpdateSecurityQuestionResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      setUpdateSecurityQuestionResponse = ApiResponse.error(error.toString());
      //Message to show status of the operation:
      _alertServices.flushBarErrorMessages(
        message: error.toString(),
        context: context,
        provider: langProvider,
      );
      return false;
    }
  }
//*----------Update Security Question End--------*
}
