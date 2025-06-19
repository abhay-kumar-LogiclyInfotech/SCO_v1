import 'package:flutter/cupertino.dart';
import '../../l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/terms_and_conditions_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';
import '../../resources/app_urls.dart';

class TermsAndConditionsViewModel with ChangeNotifier {
  late AlertServices _alertServices;

  TermsAndConditionsViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

//*----------Update Terms And Conditions Start---------*

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ApiResponse<TermsAndConditionsModel> _termsAndConditionsResponse =
      ApiResponse.none();

  ApiResponse<TermsAndConditionsModel> get termsAndConditionsResponse =>
      _termsAndConditionsResponse;

  set _setTermsAncConditionsResponse(
      ApiResponse<TermsAndConditionsModel> response) {
    _termsAndConditionsResponse = response;
    notifyListeners();
  }

  Future<bool> updateTermsAndConditions(
      {
        // required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required String userId}) async {
    try {

      //*-----Create Headers Start-----*
      if (userId.isEmpty) {
        // _alertServices.flushBarErrorMessages(
        //   // message: AppLocalizations.of(context)!.error_complete_profile,
        //   message: "Error in completing profile. please complete your profile through website",
        //   // context: context,
        //   provider: langProvider,
        // );
        _alertServices.showErrorSnackBar("Error in completing profile. please complete your profile through website");
        return false;
      }


      _setTermsAncConditionsResponse = ApiResponse.loading();

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': AppUrls.basicAuth
      };
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.termsAndConditions(
        userId: userId,
        body: null,
        headers: headers,
      );
      //*-----Calling Api End-----*
      _setTermsAncConditionsResponse = ApiResponse.completed(response);

      //Message to show status of the operation:
      // _alertServices.flushBarErrorMessages(
      //   message: response.message.toString(),
      //   // context: context,
      //   provider: langProvider,
      // );
      _alertServices.toastMessage(response.message.toString());

      return true;
    } catch (error) {
      // debugPrint('Printing Error: $error');
      _setTermsAncConditionsResponse = ApiResponse.error(error.toString());
      //Message to show status of the operation:
      // _alertServices.flushBarErrorMessages(
      //   message: error.toString(),
      //   // context: context,
      //   provider: langProvider,
      // );
      _alertServices.showErrorSnackBar(error.toString());
      return false;
    }
  }
//*----------Terms and Conditions End--------*
}
