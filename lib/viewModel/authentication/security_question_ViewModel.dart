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
      ApiResponse.none();

  ApiResponse<GetSecurityQuestionsModel> get getSecurityQuestionResponse =>
      _getSecurityQuestionResponse;

  set setGetSecurityQuestionResponse(
      ApiResponse<GetSecurityQuestionsModel> response) {
    _getSecurityQuestionResponse = response;
    notifyListeners();
  }

  //Get Questions Function:
  Future<bool> getSecurityQuestions(
      {
        // required BuildContext context,
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
          message: error.toString(),
          // context: context,
          provider: langProvider);
      return false;
    }
  }

//*----------Get Security Question End--------*
}


