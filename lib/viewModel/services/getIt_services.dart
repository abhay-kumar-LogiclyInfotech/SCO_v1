import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services/secure_storage_services.dart';

import 'alert_services.dart';
import 'auth_services.dart';
import 'media_services.dart';
import 'navigation_services.dart';


final GetIt getIt = GetIt.instance;

Future<bool> registerServices() async {
  try {
    getIt.registerSingleton<NavigationServices>(NavigationServices());
    getIt.registerSingleton<AlertServices>(AlertServices());
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<MediaServices>(MediaServices());
    getIt.registerSingleton<PermissionServices>(PermissionServices());
    getIt.registerSingleton<SecureStorageServices>(SecureStorageServices());


    // Verify registration
    debugPrint("Is NavigationServices registered? ${getIt.isRegistered<NavigationServices>()}");
    debugPrint("Is AuthService registered? ${getIt.isRegistered<AuthService>()}");
    debugPrint("Is AlertServices registered? ${getIt.isRegistered<AlertServices>()}");
    debugPrint("Is MediaServices registered? ${getIt.isRegistered<MediaServices>()}");
    debugPrint("Is PermissionServices registered? ${getIt.isRegistered<PermissionServices>()}");
    debugPrint("Is Secure Storage Services registered? ${getIt.isRegistered<SecureStorageServices>()}");



    return true;
  } catch (e) {
    debugPrint("Error registering services: $e");
    return false;
  }
}
