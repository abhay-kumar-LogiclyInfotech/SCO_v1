import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; import '../../../../resources/app_urls.dart';
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
  String? _userId;

  setIds() async {
    _emiratesId =  HiveManager.getEmiratesId();
    _userId =  HiveManager.getUserId();
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
        await setIds();

        // final headers = <String,String>{
        //   // 'Content-Type': 'application/x-www-form-urlencoded',
        //   // 'authorization': AppUrls.basicAuthWithUsernamePassword
        // };
        //
        // final body = <String,String>{
        //   "emiratesId": _emiratesId ?? '',
        //   "configKey": configurationKey ?? ''
        // };

        FindDraftByConfigurationKeyModel response = await _myRepo.findDraftByConfigurationKey(userId:_userId,emiratesId: _emiratesId,configKey: configurationKey,);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
      } catch (error,stackTrace) {
        setApiResponse = ApiResponse.error(error.toString());
        // _alertServices.showErrorSnackBar(error.toString());
        // print(stackTrace);
        setLoading(false);
      }}
    else{
      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
