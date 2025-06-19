

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; import '../../../../resources/app_urls.dart';
import 'package:get_it/get_it.dart';

import '../../controller/internet_controller.dart';
import '../../data/response/ApiResponse.dart';
import '../../hive/hive_manager.dart';
import '../../models/services/UpdateRequestModel.dart';
import '../../repositories/home/home_repository.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';

class CreateRequestViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  CreateRequestViewModel()
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

  ApiResponse<UpdateRequestModel> _apiResponse = ApiResponse.none();

  ApiResponse<UpdateRequestModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<UpdateRequestModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> createRequest({dynamic form}) async {

    final InternetController networkController = Get.find<InternetController>();
    // Check if the network is connected
    if (networkController.isConnected.value) {

          try {
        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/json',
          'authorization': AppUrls.basicAuthWithUsernamePassword
        };

        final body = jsonEncode(form);

        UpdateRequestModel response = await _myRepo.createRequest(userId: _userId ?? '',body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        _alertServices.toastMessage(response.message.toString() ?? '');
        setLoading(false);
        return true;
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.toastMessage(error.toString() ?? '');

        setLoading(false);
        return false;
      }}
    else{
      _alertServices.showErrorSnackBar("No Internet Connection is available");
      setLoading(false);
      return false;
    }
  }
}
