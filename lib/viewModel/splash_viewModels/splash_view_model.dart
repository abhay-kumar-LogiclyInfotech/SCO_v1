import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/viewModel/services/token_service.dart';

import '../../models/splash/commonData_model.dart';
import '../../utils/constants.dart';
import '../services/auth_services.dart';
import '../view_models.dart';


class SplashViewModel extends ChangeNotifier {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  final GetIt getIt = GetIt.instance;

  SplashViewModel() {
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
  }

  Future<void> checkUserAuthentication(BuildContext context) async {

    final bool isLoggedInKey = await _authService.isLoggedIn();
    final int counter = await _authService.getCounter();


    /// First We require token for common api calls
    await TokenService.instance.getToken(grantType: GrantType.password,tokenAccessType: TokenAccessType.common);


    // This is for LOV's
    final commonDataProvider = context.read<CommonDataViewModel>();

    bool isDataStored = HiveManager.isDataStored();
    if (isLoggedInKey && isDataStored) {
      if (counter < 20) {
        final response = HiveManager.getStoredData();

        if (response?.data?.response != null) {
          Map<String, Response> tempMap = {
            for (var res in response!.data!.response!) res.lovCode!: res
          };
          Constants.lovCodeMap = tempMap;
          // debugPrint('Data stored');
        }
        await _authService.incrementCounter();
        _navigationServices.pushReplacementNamed('/mainView');
      } else {
        await _authService.clearCounter();
        bool commonDataFetched = await commonDataProvider.fetchCommonData();
        if (commonDataFetched && HiveManager.isDataStored()) {
          _navigationServices.pushReplacementNamed('/mainView');
        }
      }
    } else {
      if (isDataStored) {
        final response = HiveManager.getStoredData();

        if (response?.data?.response != null) {
          Map<String, Response> tempMap = {
            for (var res in response!.data!.response!) res.lovCode!: res
          };
          Constants.lovCodeMap = tempMap;
          // debugPrint('Data stored');
        }
        await _authService.incrementCounter();
        _navigationServices.pushReplacementNamed('/loginView');
      }
      else {
        bool commonDataFetched = await commonDataProvider.fetchCommonData();
        if (commonDataFetched) {
          _navigationServices.pushReplacementNamed('/loginView');
        }
      }
    }
  }
}
