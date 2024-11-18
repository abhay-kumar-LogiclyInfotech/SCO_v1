import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/apply_scholarship/SubmitApplicationModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../data/response/ApiResponse.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';


class SubmitApplicationViewmodel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  SubmitApplicationViewmodel()
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

  ApiResponse<SubmitApplicationModel> _apiResponse = ApiResponse.none();

  ApiResponse<SubmitApplicationModel> get apiResponse => _apiResponse;

  set setSaveAsDraftResponse(ApiResponse<SubmitApplicationModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

 Future<bool> submitApplication({dynamic form}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setSaveAsDraftResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/json',
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        final body = jsonEncode(form);

        SubmitApplicationModel response = await _myRepo.submitApplication(userId: _userId ?? '',body: body,headers: headers);

        setSaveAsDraftResponse = ApiResponse.completed(response);
        setLoading(false);
        return true;
      } catch (error) {
        setSaveAsDraftResponse = ApiResponse.error(error.toString());
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
