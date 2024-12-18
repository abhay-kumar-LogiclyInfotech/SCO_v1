import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services/splash_services.dart';

import 'alert_services.dart';
import 'auth_services.dart';
import 'media_services.dart';
import 'navigation_services.dart';

Future<bool> registerServices() async {
  final GetIt getIt = GetIt.instance;

  try {
    getIt.registerSingleton<NavigationServices>(NavigationServices());
    getIt.registerSingleton<AlertServices>(AlertServices());
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<SplashServices>(SplashServices());
    getIt.registerSingleton<MediaServices>(MediaServices());
    getIt.registerSingleton<PermissionServices>(PermissionServices());


    // Verify registration
    debugPrint("Is NavigationServices registered? ${getIt.isRegistered<NavigationServices>()}");
    debugPrint("Is AuthService registered? ${getIt.isRegistered<AuthService>()}");
    debugPrint("Is SplashServices registered? ${getIt.isRegistered<SplashServices>()}");
    debugPrint("Is AlertServices registered? ${getIt.isRegistered<AlertServices>()}");
    debugPrint("Is MediaServices registered? ${getIt.isRegistered<MediaServices>()}");
    debugPrint("Is PermissionServices registered? ${getIt.isRegistered<PermissionServices>()}");

    return true;
  } catch (e) {
    debugPrint("Error registering services: $e");
    return false;
  }
}
