import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/open_authorization/open_authorization_model.dart';
import 'package:sco_v1/utils/key_constants.dart';
import 'package:sco_v1/viewModel/services/secure_storage_services.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/splash_repo/splash_repository.dart';
import '../../resources/app_urls.dart';

enum GrantType {
  password,
  refreshToken,
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
class OpenAuthorizationViewModel with ChangeNotifier {
  final GetIt getIt = GetIt.instance;

  Future<String?> get getCommonApiToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.accessTokenOfCommonApi); /// for common api
  Future<String?> get getApiToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.accessToken); /// for user api's


  Future<String?> get getCommonApiRefreshToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.refreshTokenOfCommonApi); /// for common api
  Future<String?> get getApiRefreshToken async => await getIt.get<SecureStorageServices>().readSecureData(KeyConstants.refreshToken); /// for user apis

  int? _expiryTime; // epoch seconds
  int? get expiryTime => _expiryTime;

  final SplashRepository _myRepo = SplashRepository();
  ApiResponse<OpenAuthorizationModel> apiResponse = ApiResponse.none();

  set _setApiResponse(ApiResponse<OpenAuthorizationModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<void> getToken({required GrantType grantType}) async {
    try {
      _setApiResponse = ApiResponse.loading();

      final refreshToken = await getCommonApiRefreshToken;

      final body = <String, String>{
        "grant_type": grantType.value,
        "username": dotenv.env[KeyConstants.usernameOfCommonApi]!,
        if (grantType == GrantType.password)
          "password": dotenv.env[KeyConstants.passwordOfCommonApi]!,
        if (grantType == GrantType.refreshToken && refreshToken != null)
          "refresh_token": refreshToken,
        "client_id": dotenv.env[KeyConstants.clientId]!,
        "client_secret": dotenv.env[KeyConstants.clientSecret]!,
      };

      final response = await _myRepo.getToken(body: body);

      // Save token & refresh token
      getIt.get<SecureStorageServices>().writeSecureData(
            KeyConstants.accessTokenOfCommonApi,
            response.accessToken!,
          );
      getIt.get<SecureStorageServices>().writeSecureData(
            KeyConstants.refreshTokenOfCommonApi,
            response.refreshToken!,
          );

      // Save expiry time (epoch seconds from now)
      _expiryTime = DateTime.now().add(Duration(seconds: response.expireIn!)).millisecondsSinceEpoch ~/ 1000;

      _setApiResponse = ApiResponse.completed(response);
    } catch (e) {
      debugPrint("Error in getting token: $e");
      _setApiResponse = ApiResponse.error("Error during accessing common token $e");
    }
  }
}


// // 1️⃣ Inject latest token (if available)
// final token = await getIt.get<SecureStorageServices>().readSecureData(options.path.contains('common-data') || options.path.contains('login') ? KeyConstants.accessTokenOfCommonApi : KeyConstants.accessToken,);
//
// // Only set if not already overridden
// if (token.isNotEmpty && options.headers['authorization'] == null) {
// options.headers['authorization'] = 'Bearer $token';
// }
//
// // 2️⃣ Special handling for token endpoint
// if (options.path == AppUrls.openAuthToken) {
// options.contentType = Headers.formUrlEncodedContentType;
// } else {
// options.contentType ??= Headers.jsonContentType;
// }



class OpenAuthInterceptor extends Interceptor {
  final OpenAuthorizationViewModel authorizationViewModel;
  bool _isRefreshing = false;
  final List<void Function(String)> _pendingRequests = [];

  OpenAuthInterceptor(this.authorizationViewModel);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = options.path.contains('common-data') || options.path.contains('login') ? await authorizationViewModel.getCommonApiToken : await authorizationViewModel.getApiToken;
    final expiry = authorizationViewModel.expiryTime;

  // 2️⃣ Special handling for token endpoint
    if (options.path == AppUrls.openAuthToken) {
      options.contentType = Headers.formUrlEncodedContentType;
    } else {
      options.contentType ??= Headers.jsonContentType;
    }

    if (token != null && expiry != null) {
      final timeLeft = DateTime.fromMillisecondsSinceEpoch(expiry * 1000).difference(DateTime.now()).inSeconds;

      if (timeLeft < 300) {
        if (!_isRefreshing) {
          _isRefreshing = true;

          try {
            await authorizationViewModel.getToken(grantType: GrantType.refreshToken);
            final newToken = await authorizationViewModel.getCommonApiToken;

            // Retry queued requests
            for (var callback in _pendingRequests) {
              callback(newToken!);
            }
            _pendingRequests.clear();

            _isRefreshing = false;

            // Continue current request with new token
            options.headers['Authorization'] = 'Bearer $newToken';
            return handler.next(options);
          } catch (e) {
            _isRefreshing = false;
            return handler.reject(
              DioException(requestOptions: options, error: 'Token refresh failed: $e'),
            );
          }
        } else {
          // Queue this request until refresh completes
          _pendingRequests.add((String newToken) {
            options.headers['Authorization'] = 'Bearer $newToken';
            handler.next(options);
          });
          return;
        }
      } else {
        // Token still valid
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    return handler.next(options);
  }
}

