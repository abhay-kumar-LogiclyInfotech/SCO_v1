
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


import 'auth_services.dart';
import 'navigation_services.dart';

class SplashServices {
  late NavigationServices _navigationServices;
  late AuthService _authService;

  SplashServices() {
    final GetIt _getIt = GetIt.instance;
    _navigationServices = _getIt.get<NavigationServices>();
    _authService = _getIt.get<AuthService>();
  }

  Future<void> checkUserAuthentication() async {
    final userToken = await _authService.getUserToken();


    if (userToken != null && userToken.isNotEmpty) {
      // _navigationServices.pushReplacementNamed('/userMainView');
    } else {
      _navigationServices.pushReplacementNamed('/loginView');
    }
  }
}

