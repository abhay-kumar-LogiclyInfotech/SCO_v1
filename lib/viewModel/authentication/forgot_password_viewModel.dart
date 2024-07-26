import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_password_get_Security_question_model.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';
import '../services/navigation_services.dart';

class ForgotPasswordViewModel with ChangeNotifier {
//*------Necessary Services------*/
  late AlertServices _alertServices;
  late NavigationServices _navigationServices;
  late AuthService _authService;

  ForgotPasswordViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
  }

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  ApiResponse<
      ForgotPasswordGetSecurityQuestionModel>_getSecurityQuestionResponse = ApiResponse
      .none();

  ApiResponse<
      ForgotPasswordGetSecurityQuestionModel> get getSecurityQuestionResponse =>
      _getSecurityQuestionResponse;

  set _setGetSecurityQuestionResponse(
      ApiResponse<ForgotPasswordGetSecurityQuestionModel> response) {
    _getSecurityQuestionResponse = response;
    notifyListeners();
  }

  Future<bool> getSecurityQuestion(
      {required String email, required BuildContext context, required LanguageChangeViewModel langProvider}) async {
    try {
      _setGetSecurityQuestionResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*

      final headers = <String, String>{'authorization': Constants.basicAuth};
      //*-----Create Headers End-----*

      if (email.isEmpty) {
        return false;
      }

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository
          .getForgotPasswordSecurityQuestion(email: email, headers: headers);

      //*-----Calling Api End-----*

      _setGetSecurityQuestionResponse = ApiResponse.completed(response);


      //*-----Extracting Data and validating if response in empty or not-----*
      final String securityQuestion = getSecurityQuestionResponse.data?.data
          ?.securityQuestion?.securityQuestion.toString() ?? "";
      final String securityAnswer = getSecurityQuestionResponse.data?.data
          ?.securityQuestion?.securityAnswer.toString() ?? "";
      final String userId = getSecurityQuestionResponse
          .data?.data?.securityQuestion?.userId
          .toString() ??
          "";

      if (securityQuestion.isEmpty || securityAnswer.isEmpty || userId.isEmpty) {
        _alertServices.flushBarErrorMessages(context: context,
            message: "Something went wrong with you account. Please try again later or contact the administrator.",provider: langProvider);
        return false;
      }


    return true;
  }
  catch (error)  {
  debugPrint('Printing Error: $error');
  _setGetSecurityQuestionResponse = ApiResponse.error(error.toString());
  //Message to show status of the operation:
  _alertServices.flushBarErrorMessages(
  message: error.toString(),
  context: context,
  provider: langProvider,
  );
  return false;
  }
}}
