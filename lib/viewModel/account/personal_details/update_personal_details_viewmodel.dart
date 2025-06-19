import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../models/account/personal_details/UpdatePersonalDetailsModel.dart';
import '../../../resources/app_urls.dart';
import '../../../utils/constants.dart';
import '../../services/alert_services.dart';
import '../../services/auth_services.dart';




class UpdatePersonalDetailsViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  UpdatePersonalDetailsViewModel()
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

  ApiResponse<UpdatePersonalDetailsModel> _apiResponse = ApiResponse.none();

  ApiResponse<UpdatePersonalDetailsModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<UpdatePersonalDetailsModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> updatePersonalDetails({required dynamic form}) async {
    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': AppUrls.basicAuth
        };

        final body = jsonEncode(form);
        // final body = FormData.fromMap(form);


        UpdatePersonalDetailsModel response = await _myRepo.updatePersonalDetails(userId: _userId ?? '',body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        _alertServices.toastMessage(response.message.toString());
        setLoading(false);
        return true;
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString());

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
