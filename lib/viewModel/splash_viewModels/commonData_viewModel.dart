
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/data/response/ApiResponse.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';
import 'package:sco_v1/repositories/splash_repo/splash_repository.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';


class CommonDataViewModel with ChangeNotifier {

  late AlertServices _alertServices;
  CommonDataViewModel(){
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  final SplashRepository _myRepo = SplashRepository();
  ApiResponse<CommonDataModel> apiResponse = ApiResponse.none();


  set _setApiResponse(ApiResponse<CommonDataModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<bool> fetchCommonData() async {
    try {

      _setApiResponse = ApiResponse.loading();

      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await _myRepo.fetchCommonData(headers: headers);


      // Clear existing data in Hive and store new data
      await HiveManager.clearData();
      await HiveManager.storeData(response);

      // Update API response state
      _setApiResponse = ApiResponse.completed(response);
      return true;
    } catch (error) {
      _setApiResponse = ApiResponse.error('Failed to fetch common data: $error');
      _alertServices.showErrorSnackBar(error.toString() ?? '');
      return false;
    }
  }
}
