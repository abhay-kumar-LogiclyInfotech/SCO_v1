import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/viewModel/splash_viewModels/commonData_viewModel.dart';

import 'auth_services.dart';
import 'navigation_services.dart';

class SplashServices {
  late NavigationServices _navigationServices;
  late AuthService _authService;

  SplashServices() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
  }

  Future<void> checkUserAuthentication(BuildContext context) async {
    final bool isLoggedInKey = await _authService.isLoggedIn();
    final int counter = await _authService.getCounter();

    final provider = Provider.of<CommonDataViewModel>(context,listen: false);







    bool isDataStored = HiveManager.isDataStored();
    debugPrint("Common Data Already Stored: ${isDataStored.toString()}");
    if (isLoggedInKey && isDataStored) {
      if (counter < 20) {
        await _authService.incrementCounter();
        _navigationServices.pushReplacementNamed('/mainView');
      } else {
        await _authService.clearCounter();
        bool commonDataFetched = await provider.fetchCommonData();
        if (commonDataFetched && HiveManager.isDataStored()) {
          _navigationServices.pushReplacementNamed('/mainView');
        }
      }
    }

    else {
      bool commonDataFetched = await provider.fetchCommonData();
      if (commonDataFetched) {
        _navigationServices.pushReplacementNamed('/loginView');
      }
    }
  }
}
