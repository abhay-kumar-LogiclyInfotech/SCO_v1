import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/apply_scholarship/FindDraftByConfigurationKeyModel.dart';
import 'package:sco_v1/models/apply_scholarship/SaveAsDraftModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../utils/constants.dart';
import '../../services/alert_services.dart';
class GetSubmittedApplicationDetailsByApplicationNumberViewModel with ChangeNotifier {

  late AlertServices _alertServices;

  GetSubmittedApplicationDetailsByApplicationNumberViewModel()
  {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
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

  getSubmittedApplicationDetailsByApplicationNumber({required dynamic applicationNumber}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {

        // print("Inside FindDraft ViewModel");

        setLoading(true);
        setApiResponse = ApiResponse.loading();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': Constants.basicAuthWithUsernamePassword
        };


        FindDraftByConfigurationKeyModel response = await _myRepo.getSubmittedApplicationDetailsByApplicationNumber(applicationNumber: applicationNumber,headers: headers);


        setApiResponse = ApiResponse.completed(response);
        // print(apiResponse.data);
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
