import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/account/personal_details/GetProfilePictureUrlModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../models/account/personal_details/UpdatePersonalDetailsModel.dart';
import '../../../utils/constants.dart';
import '../../services/alert_services.dart';
import '../../services/auth_services.dart';

class UpdateProfilePictureViewModel with ChangeNotifier {
  late AuthService _authService;
  late AlertServices _alertServices;

  UpdateProfilePictureViewModel() {
    final GetIt getIt = GetIt.instance;
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();
  }

  String? _userId;

  setUserId() async {
    _userId = HiveManager.getUserId();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  final _myRepo = HomeRepository();

  ApiResponse<GetProfilePictureUrlModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetProfilePictureUrlModel> get apiResponse => _apiResponse;

  set setSaveAsDraftResponse(ApiResponse<GetProfilePictureUrlModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> updateProfilePicture({required dynamic base64String}) async {
    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {
      try {
        setLoading(true);
        setSaveAsDraftResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          "Content-Type": "application/x-www-form-urlencoded",
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        // Data in JSON format
        Map<String, String> jsonData = {
          "userId": _userId.toString(),
          "base64": base64String
        };

        // Convert JSON to URL-encoded form
        String urlEncodedData = Uri(queryParameters: jsonData).query;

        GetProfilePictureUrlModel response = await _myRepo.updateProfilePicture(
            userId: _userId ?? '', body: urlEncodedData, headers: headers);

        setSaveAsDraftResponse = ApiResponse.completed(response);
        setLoading(false);
        return true;
      } catch (error) {
        setSaveAsDraftResponse = ApiResponse.error(error.toString());
        setLoading(false);
        return false;
      }
    } else {
      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
      return false;
    }
  }
}
