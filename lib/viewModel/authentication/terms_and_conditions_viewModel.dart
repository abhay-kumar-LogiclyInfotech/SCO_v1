import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/terms_and_conditions_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

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
      {required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required String userId}) async {
    try {
      _setTermsAncConditionsResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*
      if (userId.isEmpty) {
        _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.error_complete_profile,
          // context: context,
          provider: langProvider,
        );
        return false;
      }

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create Headers End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.termsAndConditions(
        userId: userId,
        body: null,
        headers: headers,
      );
      //*-----Calling Api End-----*

      //Message to show status of the operation:
      _alertServices.flushBarErrorMessages(
        message: response.message.toString(),
        // context: context,
        provider: langProvider,
      );
      _setTermsAncConditionsResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setTermsAncConditionsResponse = ApiResponse.error(error.toString());
      //Message to show status of the operation:
      _alertServices.flushBarErrorMessages(
        message: error.toString(),
        // context: context,
        provider: langProvider,
      );
      return false;
    }
  }
//*----------Terms and Conditions End--------*
}
