import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; import '../../../../resources/app_urls.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/UpdatePeopleSoftApplicationModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../../data/response/ApiResponse.dart';
import '../../../../resources/app_urls.dart';
import '../../../../utils/constants.dart';
import '../../../services/alert_services.dart';
import '../../../services/auth_services.dart';




class EditApplicationSectionsViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  EditApplicationSectionsViewModel()
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

  ApiResponse<UpdatePeopleSoftApplicationModel> _apiResponse = ApiResponse.none();

  ApiResponse<UpdatePeopleSoftApplicationModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<UpdatePeopleSoftApplicationModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  editApplicationSections({required EditApplicationSection sectionType,required dynamic applicationNumber,required dynamic form}) async {

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
        final url  = getEditSectionUrl(sectionType:sectionType,userId: _userId ?? '',applicationNumber: applicationNumber);

        UpdatePeopleSoftApplicationModel response = await _myRepo.editApplicationSection(url:url,applicationNumber: applicationNumber,body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        _alertServices.toastMessage(response.message.toString());
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

  String getEditSectionUrl(
      {required EditApplicationSection sectionType,
      required String userId,
      required String applicationNumber}){
    switch (sectionType) {
      case EditApplicationSection.employmentHistory:
        return '${AppUrls.baseUrl}e-services/$userId/update-ps-application/workexp/$applicationNumber';
      case EditApplicationSection.education:
        return '${AppUrls.baseUrl}e-services/$userId/update-ps-application/education/$applicationNumber';
      case EditApplicationSection.requiredExaminations:
        return '${AppUrls.baseUrl}e-services/$userId/update-ps-application/update-test-score/$applicationNumber';
      case EditApplicationSection.universityPriority:
        return '${AppUrls.baseUrl}e-services/$userId/update-ps-application/update-wish-list/$applicationNumber';
      default:
        return '';
    }
  }


// https://stg.sco.ae/o/mopa-sco-api/e-services/{userId}/update-ps-application/update-test-score/{applicationNo}
// https://stg.sco.ae/o/mopa-sco-api/e-services/{userId}/update-ps-application/update-wish-list/{applicationNo}
// https://stg.sco.ae/o/mopa-sco-api/e-services/{userId}/update-ps-application/workexp/{applicationNo}
// https://stg.sco.ae/o/mopa-sco-api/e-services/{userId}/update-ps-application/education/{applicationNo}
}
