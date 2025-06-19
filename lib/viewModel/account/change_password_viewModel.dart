
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/auth_repo/auth_repository.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/account/ChangePasswordModel.dart';
import '../../resources/app_urls.dart';
import '../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';


class ChangePasswordViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  ChangePasswordViewModel()
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


  final _myRepo = AuthenticationRepository();

  ApiResponse<ChangePasswordModel> _apiResponse = ApiResponse.none();

  ApiResponse<ChangePasswordModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<ChangePasswordModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future changePassword({required dynamic passwordOne,required dynamic passwordTwo}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {

        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          // 'Content-Type': 'application/json',
          'authorization': AppUrls.basicAuthWithUsernamePassword
        };

        final body = FormData.fromMap({
          'userId': _userId,
          'passwordOne': passwordOne,
          'passwordTwo': passwordTwo,
        });


        ChangePasswordModel response = await _myRepo.changePassword(headers: headers,formData:body);
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
}
