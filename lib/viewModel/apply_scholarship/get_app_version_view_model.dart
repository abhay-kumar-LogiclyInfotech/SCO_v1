
import 'package:flutter/cupertino.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/apply_scholarship/get_app_version_model.dart';
import '../services/alert_services.dart';
import '../services/getIt_services.dart';


class GetAppVersionViewModel with ChangeNotifier {

  final AlertServices _alertServices = getIt.get<AlertServices>();
  
  
  final _myRepo = HomeRepository();

  ApiResponse<GetAppVersionModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetAppVersionModel> get apiResponse => _apiResponse;

  set _setApiResponse(ApiResponse<GetAppVersionModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> getAppVersion() async {
    

      try {
        _setApiResponse = ApiResponse.loading();
        final response = await _myRepo.getAppVersion();
        _setApiResponse = ApiResponse.completed(response);
        return true;
      } catch (error) {
        _setApiResponse = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString());
        return false;
      }}
  }

