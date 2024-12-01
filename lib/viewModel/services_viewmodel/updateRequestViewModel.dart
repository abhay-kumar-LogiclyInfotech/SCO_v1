import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/services/UpdateRequestModel.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';


class UpdateRequestViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  UpdateRequestViewModel()
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

  Future<bool> updateRequest({dynamic form}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {
        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/json',
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        final body = jsonEncode(form);

        UpdateRequestModel response = await _myRepo.updateRequest(userId: _userId ?? '',body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        _alertServices.toastMessage(response.message.toString());
        setLoading(false);
        return true;
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.toastMessage(error.toString());
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
