import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_password_get_Security_question_model.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_password_send_mail_model.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_security_question_otp_verification_model.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../data/response/ApiResponse.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';

class ForgotPasswordViewModel with ChangeNotifier {
//*------Necessary Services------*/
  late AlertServices _alertServices;

  ForgotPasswordViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*------Accessing Api Services------*

  //*---common for all methods-----*/
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<ForgotPasswordGetSecurityQuestionModel>
      _getSecurityQuestionResponse = ApiResponse.none();

  ApiResponse<ForgotPasswordGetSecurityQuestionModel>
      get getSecurityQuestionResponse => _getSecurityQuestionResponse;

  set _setGetSecurityQuestionResponse(
      ApiResponse<ForgotPasswordGetSecurityQuestionModel> response) {
    _getSecurityQuestionResponse = response;
    notifyListeners();
  }

  Future<bool> getSecurityQuestion(
      {required String email,
      // required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      //
      // if (email.isEmpty) {
      //   _alertServices.showErrorSnackBar("something went wrong...");
      //   return false;
      // }

      _setGetSecurityQuestionResponse = ApiResponse.loading();


      //*-----Create Headers Start-----*

      final headers = <String, String>{'authorization': Constants.basicAuth};
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.getForgotPasswordSecurityQuestionUsingEmail(email: email, headers: headers);

      //*-----Calling Api End-----*

      _setGetSecurityQuestionResponse = ApiResponse.completed(response);

      //*-----Extracting Data and validating if response in empty or not-----*
      final String securityQuestion = getSecurityQuestionResponse
              .data?.data?.securityQuestion?.securityQuestion
              .toString() ??
          "";
      final String securityAnswer = getSecurityQuestionResponse
              .data?.data?.securityQuestion?.securityAnswer
              .toString() ??
          "";
      final String userId = getSecurityQuestionResponse
              .data?.data?.securityQuestion?.userId
              .toString() ??
          "";

      if (securityQuestion.isEmpty ||
          securityAnswer.isEmpty ||
          userId.isEmpty) {
        // _alertServices.toastMessage(AppLocalizations.of(context)!.something_went_wrong,);
        _alertServices.showErrorSnackBar("Something went wrong...");
        return false;
      }
      _alertServices.toastMessage(response.message.toString());
      return true;
    } catch (error) {
      // debugPrint('Printing Error: $error');
      _setGetSecurityQuestionResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.showErrorSnackBar(error.toString());

      return false;
    }
  }

//*------Get Security Question Method End---------*/






//*------Send Password through mail Start--------*/
  ApiResponse<ForgotPasswordSendMailModel> _sendForgotPasswordSendMailResponse =
      ApiResponse.none();

  ApiResponse<ForgotPasswordSendMailModel>
      get sendForgotPasswordSendMailResponse =>
          _sendForgotPasswordSendMailResponse;

  set _setSendForgotPasswordSendMailResponse(
      ApiResponse<ForgotPasswordSendMailModel> response) {
    _sendForgotPasswordSendMailResponse = response;
    notifyListeners();
  }

  //method start:
  Future<bool> sendForgotPasswordOnMail({
    required String userId,
    required BuildContext context,
    required LanguageChangeViewModel langProvider,
  }) async {
    try {

      if (userId.isEmpty) {
        _alertServices.showErrorSnackBar("something went wrong...");
        return false;
      }
      _setSendForgotPasswordSendMailResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*
      final headers = <String, String>{'authorization': Constants.basicAuth};
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.sendForgotPasswordOnMail(
        userId: userId,
        headers: headers,
      );

      //*-----Calling Api End-----*
      _setSendForgotPasswordSendMailResponse = ApiResponse.completed(response);
      _alertServices.toastMessage(AppLocalizations.of(context)!.password_sent_successfully);
      return true;
    } catch (e) {
      // debugPrint('Error: $e');
      _alertServices.showErrorSnackBar(e.toString());
      return false;
    }
  }

//*-----Send Password through mail End---------*/




//*------Forgot Security Question send Verification Code Start---------*/
  ApiResponse<ForgotSecurityQuestionOtpVerificationModel>
      _forgotSecurityQuestionOtpVerificationResponse = ApiResponse.none();

  ApiResponse<ForgotSecurityQuestionOtpVerificationModel>
      get forgotSecurityQuestionOtpVerificationResponse =>
          _forgotSecurityQuestionOtpVerificationResponse;

  set _setForgotSecurityQuestionOtpVerificationResponse(
      ApiResponse<ForgotSecurityQuestionOtpVerificationModel> response) {
    _forgotSecurityQuestionOtpVerificationResponse = response;
    notifyListeners();
  }

  Future<bool> getForgotSecurityQuestionVerificationOtp({
    required String userId,
    // required BuildContext context,
  }) async {
    try {

      if (userId.isEmpty) {
        _alertServices.showErrorSnackBar("something went wrong...");
        return false;
      }
      _setForgotSecurityQuestionOtpVerificationResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*
      final headers = <String, String>{'authorization': Constants.basicAuth};
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository
          .getForgotSecurityQuestionVerificationOtp(
        userId: userId,
        headers: headers,
      );
      //*-----Calling Api End-----*
      _setForgotSecurityQuestionOtpVerificationResponse = ApiResponse.completed(response);
      _alertServices.toastMessage(response.message.toString());

      return true;
    } catch (e) {
      // debugPrint('Error: $e');
      _alertServices.showErrorSnackBar(e.toString());
      return false;
    }
  }
//*------Forgot Security Question send Verification Code End---------*/
}
