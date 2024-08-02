import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/viewModel/splash_viewModels/commonData_viewModel.dart';

import '../../models/splash/commonData_model.dart';
import '../../utils/constants.dart';
import '../drawer/a_brief_about_sco_viewModel.dart';
import '../drawer/news_and_events_viewModel.dart';
import '../language_change_ViewModel.dart';
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
    //*------Making call to simple Apis--------*
    Future<void> callBasicApis() async {
      //*------Api call for SCO About Us-------*/
      // Initialize data after widget build phase:
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final langProvider =
            Provider.of<LanguageChangeViewModel>(context, listen: false);
        final provider =
            Provider.of<ABriefAboutScoViewModel>(context, listen: false);
        await provider.aBriefAboutSco(
            context: context, langProvider: langProvider);
      });

    }

    final bool isLoggedInKey = await _authService.isLoggedIn();
    final int counter = await _authService.getCounter();

    final provider = Provider.of<CommonDataViewModel>(context, listen: false);

    bool isDataStored = HiveManager.isDataStored();
    debugPrint("Common Data Already Stored: ${isDataStored.toString()}");
    if (isLoggedInKey && isDataStored) {
      if (counter < 20) {
        final response = HiveManager.getStoredData();

        if (response?.data?.response != null) {
          Map<String, Response> tempMap = {
            for (var res in response!.data!.response!) res.lovCode!: res
          };
          Constants.lovCodeMap = tempMap;
          debugPrint('Data stored');
        }
        await _authService.incrementCounter();
        await callBasicApis();
        _navigationServices.pushReplacementNamed('/mainView');
      } else {
        await _authService.clearCounter();
        bool commonDataFetched = await provider.fetchCommonData();
        if (commonDataFetched && HiveManager.isDataStored()) {
          await callBasicApis();
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
          debugPrint('Data stored');
        }
        await _authService.incrementCounter();
        await callBasicApis();
        _navigationServices.pushReplacementNamed('/mainView');
      } else {
        bool commonDataFetched = await provider.fetchCommonData();
        if (commonDataFetched) {
          await callBasicApis();
          _navigationServices.pushReplacementNamed('/mainView');
        }
      }
    }
  }
}
