// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
// import '../../data/response/ApiResponse.dart';
// import '../../models/authentication/update_security_question_model.dart';
// import '../../repositories/auth_repo/auth_repository.dart';
// import '../../utils/constants.dart';
// import '../language_change_ViewModel.dart';
// import '../services/alert_services.dart';
//
// class OtpVerificationViewModel with ChangeNotifier{
//
//   late AlertServices _alertServices;
//
//   OtpVerificationViewModel() {
//     final GetIt getIt = GetIt.instance;
//     _alertServices = getIt.get<AlertServices>();
//   }
//
// //*----------Update Security Question Start---------*
//
//   String? _userId;
//   String? _otp;
//
//   void setUserId(String? userId) async {
//     _userId = userId;
//     notifyListeners();
//   }
//
//   void setOtp(String? otp) async {
//     _otp = otp;
//     notifyListeners();
//   }
//
//   //*------Accessing Api Services------*
//   final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
//
//
//   ApiResponse<OtpVerificationViewModel> _otpVerificationResponse =
//   ApiResponse.none();
//
//   ApiResponse<OtpVerificationViewModel> get otpVerificationResponse =>
//       _otpVerificationResponse;
//
//   set setVerificationResponse(
//       ApiResponse<OtpVerificationViewModel> response) {
//     _otpVerificationResponse = response;
//     notifyListeners();
//   }
//
//   Future<bool> verifyOtp(
//       {required BuildContext context,
//         required LanguageChangeViewModel langProvider,
//         required String userId}) async {
//     try {
//       setVerificationResponse = ApiResponse.loading();
//
//       //*-----Create Headers Start-----*
//
//       final headers = {
//         'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//         'authorization': Constants.basicAuth
//       };
//       //*-----Create Headers End-----*
//
//       //*-----Create Body Start-----*
//
//       if (_userId == null ||
//           _otp == null ||
//           _userId!.isEmpty ||
//           _otp!.isEmpty) {
//         _alertServices.flushBarErrorMessages(
//           message: AppLocalizations.of(context)!.error_complete_profile,
//           context: context,
//           provider: langProvider,
//         );
//         return false;
//       }
//
//       //*-----Calling Api Start-----*
//       final response = await _authenticationRepository.updateSecurityQuestion(
//         userId: userId,
//         body: body,
//         headers: headers,
//       );
//       //*-----Calling Api End-----*
//
//       //Message to show status of the operation:
//       _alertServices.flushBarErrorMessages(
//         message: response.message.toString(),
//         context: context,
//         provider: langProvider,
//       );
//       setUpdateSecurityQuestionResponse = ApiResponse.completed(response);
//
//       return true;
//     } catch (error) {
//       debugPrint('Printing Error: $error');
//       setUpdateSecurityQuestionResponse = ApiResponse.error(error.toString());
//       //Message to show status of the operation:
//       _alertServices.flushBarErrorMessages(
//         message: error.toString(),
//         context: context,
//         provider: langProvider,
//       );
//       return false;
//     }
//   }
// //*----------Update Security Question End--------*
// }
