

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../controller/internet_controller.dart';
import '../../data/response/ApiResponse.dart';
import '../../hive/hive_manager.dart';
import '../../models/notifications/DecreaseNotificationCountModel.dart';
import '../../repositories/home/home_repository.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';

class DecreaseNotificationCountViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  DecreaseNotificationCountViewModel()
  {
    final GetIt getIt = GetIt.instance;
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();
  }
  String? _userId;

  setUserId() async {
    _userId =  HiveManager.getUserId();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }


  final _myRepo = HomeRepository();

  ApiResponse<DecreaseNotificationCountModel> _apiResponse = ApiResponse.none();

  ApiResponse<DecreaseNotificationCountModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<DecreaseNotificationCountModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> decreaseNotificationCount({dynamic form}) async {

    final InternetController networkController = Get.find<InternetController>();
    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {
        setLoading(true);
        setApiResponse = ApiResponse.loading();
        // await setUserId();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        final body = Uri(queryParameters: form).query;

        DecreaseNotificationCountModel response = await _myRepo.decreaseNotificationCount(body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
        return true;
      } catch (error) {
        print(error.toString());
        setApiResponse = ApiResponse.error(error.toString());
        setLoading(false);
        return false;
      }}
    else{
      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
      return false;
    }
  }
}
