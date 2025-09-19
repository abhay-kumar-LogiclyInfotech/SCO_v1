import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/utils/key_constants.dart';
import 'package:sco_v1/viewModel/services/secure_storage_services.dart';

import '../../repositories/splash_repo/splash_repository.dart';
import '../../view/authentication/login/login_view.dart';
import '../view_models.dart';

enum GrantType {
  password,
  refreshToken,
}
enum TokenAccessType {
  user,
  common,
}

extension GrantTypeValue on GrantType {
  String get value {
    switch (this) {
      case GrantType.password:
        return 'password';
      case GrantType.refreshToken:
        return 'refresh_token';
    }
  }
}

/// ViewModel
class TokenService {
  // Private named constructor
  TokenService._internal();

  // The single static instance
  static final TokenService instance = TokenService._internal();

  final GetIt getIt = GetIt.instance;
  final _splashRepo = SplashRepository();


  Future<String?> get getCommonApiToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.commonApiAccessToken); /// for common api
  Future<String?> get getCommonApiRefreshToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.commonApiRefreshToken); /// for common api

  Future<String?> get getUserApiAccessToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.userApiAccessToken); /// for common api
  Future<String?> get getUserApiRefreshToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.userApiRefreshToken); /// for common api


  Future<bool> getToken({required GrantType grantType,required TokenAccessType tokenAccessType,String? email}) async {
    try {
      final commonApiRefreshToken = await getCommonApiRefreshToken;
      final userApiRefreshToken = await getUserApiRefreshToken;

      /// IF Fetching the token for user
      final userEmail = email ??  HiveManager.getEmail() ?? '';

      final body = <String, String>{
        "grant_type": grantType.value,
        "username": (tokenAccessType == TokenAccessType.user) ? userEmail : dotenv.env[KeyConstants.usernameOfCommonApi]!,
        if (grantType == GrantType.password) /// dont need password for user
          "password": dotenv.env[KeyConstants.passwordOfCommonApi]!,
        if (grantType == GrantType.refreshToken && commonApiRefreshToken != null && tokenAccessType == TokenAccessType.common)
          "refresh_token": commonApiRefreshToken,
        if (grantType == GrantType.refreshToken && userApiRefreshToken != null && tokenAccessType == TokenAccessType.user)
          "refresh_token": userApiRefreshToken,
        "client_id": dotenv.env[KeyConstants.clientId]!,
        "client_secret": dotenv.env[KeyConstants.clientSecret]!,
      };

      final response = await _splashRepo.getToken(body: body);

      if(tokenAccessType == TokenAccessType.common){
        // Save token & refresh token
        await getIt.get<SecureStorageServices>().writeSecureData(KeyConstants.commonApiAccessToken, response.accessToken!,);
        await getIt.get<SecureStorageServices>().writeSecureData(KeyConstants.commonApiRefreshToken, response.refreshToken!,);
      }
      if(tokenAccessType == TokenAccessType.user){
        // Save token & refresh token
        await getIt.get<SecureStorageServices>().writeSecureData(KeyConstants.userApiAccessToken, response.accessToken!,);
        await getIt.get<SecureStorageServices>().writeSecureData(KeyConstants.userApiRefreshToken, response.refreshToken!,);
      }

      return true;


    } catch (e) {
      debugPrint("Error in getting token: $e");
      // _setApiResponse = ApiResponse.error("Error during accessing common token $e");

      GetIt.instance.get<NavigationServices>().clearStackAndPush(MaterialPageRoute(builder: (context) => const LoginView()));
      return false;
    }
  }
}

