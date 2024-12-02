import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services/splash_services.dart';

import 'alert_services.dart';
import 'auth_services.dart';
import 'media_services.dart';
import 'navigation_services.dart';

// Future<bool> registerServices() async {
//   if (kDebugMode) {
//     print(
//         "Inside the Register services function in the utils.dart------------>>>>>>>>>Registering getIt services");
//   }
//
//   final GetIt getIt = GetIt.instance;
//
//   try {
//
//     getIt.registerSingleton<NavigationServices>(NavigationServices());
//     if (kDebugMode) {
//       print("-------------------------------Navigation services Registered");
//     }
//     getIt.registerSingleton<AuthService>(AuthService());
//     if (kDebugMode) {
//       print("-------------------------------Authentication services Registered");
//     }
//     getIt.registerSingleton<SplashServices>(SplashServices());
//     if (kDebugMode) {
//       print("-------------------------------SplashServices Registered");
//     }
//
//     getIt.registerSingleton<AlertServices>(AlertServices());
//     if (kDebugMode) {
//       print("-------------------------------AlertServices Registered");
//     }
//
//     getIt.registerSingleton<MediaServices>(MediaServices());
//     if (kDebugMode) {
//       print("-------------------------------MediaServies Registered");
//     }
//
//     getIt.registerSingleton<PermissionServices>(PermissionServices());
//     if (kDebugMode) {
//       print("-------------------------------Permission Services Registered");
//     }
//
//     return true;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Something wrong while Registering Services... error found is $e");
//     }
//     return false;
//   }
// }
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
    print("Is NavigationServices registered? ${getIt.isRegistered<NavigationServices>()}");
    print("Is AuthService registered? ${getIt.isRegistered<AuthService>()}");
    print("Is SplashServices registered? ${getIt.isRegistered<SplashServices>()}");
    print("Is AlertServices registered? ${getIt.isRegistered<AlertServices>()}");
    print("Is MediaServices registered? ${getIt.isRegistered<MediaServices>()}");
    print("Is PermissionServices registered? ${getIt.isRegistered<PermissionServices>()}");

    return true;
  } catch (e) {
    print("Error registering services: $e");
    return false;
  }
}
