import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sco_v1/data/response/ApiResponse.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';
import 'package:sco_v1/repositories/splash_repo/splash_repository.dart';
import 'package:sco_v1/utils/constants.dart';

class CommonDataViewModel with ChangeNotifier {
  final SplashRepository _myRepo = SplashRepository();
  ApiResponse<CommonDataModel> _apiResponse = ApiResponse.loading();

  ApiResponse<CommonDataModel> get apiResponse => _apiResponse;

  set apiResponse(ApiResponse<CommonDataModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> fetchCommonData() async {
    try {
      final String basicAuth = 'Basic ${base64Encode(utf8.encode('${Constants.USERNAME}:${Constants.PASSWORD}'))}';
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      };

      final response = await _myRepo.fetchCommonData(headers: headers);


      // Clear existing data in Hive and store new data
      HiveManager.clearData();
      HiveManager.storeData(response);

      // Optionally, update local constants or perform additional actions
      // Constants.lovCodeMap = {
      //   for (var response in response.data!.response!)
      //     response.lovCode!: response
      // };
      //
      // // Debug print or further processing
      // debugPrint(Constants.lovCodeMap["MARITAL_STATUS"]!.values![0].valueArabic.toString());

      // Update API response state
      apiResponse = ApiResponse.completed(response);
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error in fetchCommonData: $error');
      }
      // Update API response state for error
      apiResponse = ApiResponse.error('Failed to fetch common data: $error');
      return false;
    }
  }
}
