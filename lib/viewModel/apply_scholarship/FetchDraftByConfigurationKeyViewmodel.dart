import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/apply_scholarship/FindDraftByConfigurationKeyModel.dart';
import 'package:sco_v1/models/apply_scholarship/SaveAsDraftModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../data/response/ApiResponse.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';


class FindDraftByConfigurationKeyViewmodel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  FindDraftByConfigurationKeyViewmodel()
  {
    final GetIt getIt = GetIt.instance;
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();
  }
  String? _emiratesId;

  setEmiratesId() async {
    _emiratesId =  HiveManager.getEmiratesId();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }


  final _myRepo = HomeRepository();

  ApiResponse<FindDraftByConfigurationKeyModel> _apiResponse = ApiResponse.none();

  ApiResponse<FindDraftByConfigurationKeyModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<FindDraftByConfigurationKeyModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  findDraftByConfigurationKey({required dynamic configurationKey}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setEmiratesId();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        final body = {
          "emiratesId": _emiratesId ?? '',
          "configKey": configurationKey ?? ''
        };

        FindDraftByConfigurationKeyModel response = await _myRepo.findDraftByConfigurationKey(body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString());
        setLoading(false);
      }}
    else{
      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
