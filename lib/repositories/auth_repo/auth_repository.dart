import 'package:dio/dio.dart';
import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_password_get_Security_question_model.dart';
import 'package:sco_v1/models/authentication/forgot_password/forgot_security_question_otp_verification_model.dart';
import 'package:sco_v1/models/authentication/get_security_questions_model.dart';
import 'package:sco_v1/models/authentication/otp_verification_model.dart';
import 'package:sco_v1/models/authentication/resend_otp_model.dart';
import 'package:sco_v1/models/authentication/terms_and_conditions_model.dart';
import 'package:sco_v1/models/authentication/update_security_question_model.dart';
import 'package:sco_v1/resources/app_urls.dart';

import '../../models/account/ChangePasswordModel.dart';
import '../../models/authentication/forgot_password/forgot_password_send_mail_model.dart';
import '../../models/authentication/login_model.dart';
import '../../models/authentication/signup_model.dart';

class AuthenticationRepository {
  //*-----Object of Api Services-----*
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

  //*-----Signup Method-----*
  Future<SignupModel> signup(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.signup,
      headers: headers,
      body: body,
    );
    return SignupModel.fromJson(response);
  }

  //*-----Otp verification method-----*
  Future<OtpVerificationModel> verifyOtp(
      {required dynamic headers,
      required dynamic body,
      required dynamic userId,
      required dynamic otp}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.verifyOtp(userId,otp),
      headers: headers,
      body: body,
    );

    return OtpVerificationModel.fromJson(response);
  }

  //*----- Resend Otp method-----*
  Future<ResendOtpModel> resendOtp({
    required dynamic headers,
    required dynamic body,
    required dynamic userId,
  }) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.resendVerificationOtp(userId),
      headers: headers,
      body: body,
    );

    return ResendOtpModel.fromJson(response);
  }

  //*-----Terms and Conditions-----*
  Future<TermsAndConditionsModel> termsAndConditions({
    required dynamic headers,
    required dynamic body,
    required dynamic userId,
  }) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: AppUrls.acceptUserTerms(userId),
      headers: headers,
      body: body,
    );

    return TermsAndConditionsModel.fromJson(response);
  }

  //*-----Security Question Setup Start-----*

  //*------Get Security Question-------*
  Future<GetSecurityQuestionsModel> getSecurityQuestions(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getSecurityQuestions(userId),
      headers: headers,
    );
    return GetSecurityQuestionsModel.fromJson(response);
  }

  //*------Update Security Question-------*
  Future<UpdateSecurityQuestionModel> updateSecurityQuestion(
      {required String userId,
      required Map<String, String> headers,
      required dynamic data}) async {
    dynamic response = await _dioBaseApiServices.dioMultipartApiService(
        method: 'PUT',
        url: AppUrls.updateSecurityQuestion(userId),
        headers: headers, data: data,);
    return UpdateSecurityQuestionModel.fromJson(response);
  }

//*-----Security Question Setup End-----*

//*-----Login Method-----*
  Future<LoginModel> login(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.login,
      headers: headers,
      body: body,
    );
    return LoginModel.fromJson(response);
  }

  //*-----Forgot Password Methods-----*

  //*------Forgot Password Get User Security Question-------*
  Future<ForgotPasswordGetSecurityQuestionModel> getForgotPasswordSecurityQuestionUsingEmail(
          {required String email, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getForgotPasswordSecurityQuestionUsingEmail(email),
      headers: headers,
    );
    return ForgotPasswordGetSecurityQuestionModel.fromJson(response);
  }

  //*------Forgot Password send password on mail------*/
  Future<ForgotPasswordSendMailModel> sendForgotPasswordOnMail(
      {required String userId,
      required Map<String, String> headers,
      }) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
        url: AppUrls.sendForgotPasswordOnEmail(userId),
        headers: headers,
        body: null
        );
    return ForgotPasswordSendMailModel.fromJson(response);
  }

  //*------Forgot Password Verify OTP-------*
  Future<ForgotSecurityQuestionOtpVerificationModel> getForgotSecurityQuestionVerificationOtp(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getForgotSecurityQuestionVerificationOtp(userId),
      headers: headers,
    );
    return ForgotSecurityQuestionOtpVerificationModel.fromJson(response);
  }


  //*-----Login Method-----*
  Future<ChangePasswordModel> changePassword(
      {required dynamic headers,required String userID, required dynamic formData}) async {
    dynamic response = await _dioBaseApiServices.dioMultipartApiService(
      url: AppUrls.changePassword(userID),
      headers: headers,
      data: formData,
      method: 'POST'
    );
    return ChangePasswordModel.fromJson(response);
  }

  //  Get Roles
  Future<LoginModel> getRoles(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getUserDetails(userId),
      headers: headers,
    );
    return LoginModel.fromJson(response);
  }

}
