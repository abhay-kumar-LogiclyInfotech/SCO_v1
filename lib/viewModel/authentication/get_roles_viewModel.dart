import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sco_v1/models/authentication/login_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../hive/hive_manager.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';
import '../services/navigation_services.dart';

class GetRoleViewModel with ChangeNotifier {
  late AlertServices _alertServices;
  late NavigationServices _navigationServices;
  late AuthService _authService;

  GetRoleViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
  }

  String? _userId;

  setUserId() async {
    _userId =  HiveManager.getUserId();
  }


  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  ApiResponse<LoginModel> _loginResponse = ApiResponse.none();

  ApiResponse<LoginModel> get apiResponse => _loginResponse;

  set _setResponse(ApiResponse<LoginModel> response) {
    _loginResponse = response;
    notifyListeners();
  }

  //*------ Get Roles Method------*
  Future<bool> getRoles() async {
    try {

      await setUserId();


      //*-----Create Headers Start-----*

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create Headers End-----*

      _setResponse = ApiResponse.loading();


      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.getRoles(
        userId: _userId ?? '',
        headers: headers,
      );
      //*-----Calling Api End-----*

      _setResponse = ApiResponse.completed(response);

      final data = response.data!;
      final userData = response.data!.user!;

      await  HiveManager.storeRole(data.roles ?? []);
      // _alertServices.toastMessage(response.message.toString(),);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      _setResponse = ApiResponse.error(error.toString());
      // _alertServices.toastMessage(
      //  "${error}Please do check you password");
      return false;
    }
  }
}
