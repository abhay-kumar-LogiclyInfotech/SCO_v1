import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/login_model.dart';
import 'package:sco_v1/viewModel/services/token_service.dart';

import '../../data/response/ApiResponse.dart';
import '../../hive/hive_manager.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';
import '../../l10n/app_localizations.dart';


class LoginViewModel with ChangeNotifier {
  late AlertServices _alertServices;
  late AuthService _authService;

  LoginViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _authService = getIt.get<AuthService>();

  }

  // Private fields
  String _username = '';
  String _password = '';
  String _deviceId = '';

  // Getter for username
  String get username => _username;

  // Setter for username
  set username(String value) {
    if (_username != value) {
      _username = value;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Getter for password
  String get password => _password;

  // Setter for password
  set password(String value) {
    if (_password != value) {
      _password = value;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Getter for deviceId
  String get deviceId => _deviceId;

  // Setter for deviceId
  set deviceId(String value) {
    if (_deviceId != value) {
      _deviceId = value;
      notifyListeners(); // Notify listeners about the change
    }
  }

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  ApiResponse<LoginModel> _loginResponse = ApiResponse.none();

  ApiResponse<LoginModel> get apiResponse => _loginResponse;

  set _setResponse(ApiResponse<LoginModel> response) {
    _loginResponse = response;
    notifyListeners();
  }

  //*------Login Method------*
  Future<bool> login(
      {
        // required BuildContext context,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization,
      }) async {
    try {

      if(_username.isEmpty || _password.isEmpty){
        return false;
      }

      _setResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*

      final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',};
      //*-----Create Headers End-----*

      //*-----Create Body Start----*
      final body = {
        "username": _username,
        "password": _password,
        "deviceId": _deviceId,
      };
      // *-----Create Body End-----*

      final response = await _authenticationRepository.login(
        headers: headers,
        body: body,
      );


      final data = response.data!;
      final userData = response.data!.user!;

      if(data.redirectUrl == null){
        await  HiveManager.storeUserId(userData.userId.toString());
        await  HiveManager.storeEmail(userData.emailAddress.toString());
        await  HiveManager.storeEmiratesId(userData.emirateId.toString().replaceAll('-', ''));
        await HiveManager.storeName(
            [
              userData.firstName?.trim() ?? '',
              userData.lastName?.trim() ?? ''
            ]
                .where((name) => name.isNotEmpty) // Exclude empty strings
                .join(' ') // Join the remaining names with a space
        );
        await HiveManager.storeRole(data.roles ?? []);
        await  _authService.saveAuthState(true);
        /// Getting the token saving the refresh token at the time of login.
        await TokenService.instance.getToken(grantType: GrantType.password, tokenAccessType: TokenAccessType.user);
        _setResponse = ApiResponse.completed(response);
        return true;
      }
      else{
        _alertServices.showErrorSnackBar(localization.completeRegistration);
        return false;
      }

    } catch (error) {
      _setResponse = ApiResponse.error(error.toString());
      _alertServices.showErrorSnackBar(error.toString());
      return false;
    }
  }
}
