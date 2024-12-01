import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../utils/constants.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';

class GetNotificationsCountViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  GetNotificationsCountViewModel()
  {
    final GetIt getIt = GetIt.instance;
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();
  }
  String? _userEmiratesId;

  setEmiratesId() async {
    _userEmiratesId =  HiveManager.getEmiratesId();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }


  final _myRepo = HomeRepository();

  ApiResponse<dynamic> _apiResponse = ApiResponse.none();

  ApiResponse<dynamic> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<dynamic> response) {
    _apiResponse = response;
    notifyListeners();
  }

  getNotificationsCount() async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {
        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setEmiratesId();
        print(_userEmiratesId);
        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'authorization': Constants.basicAuth
        };

        dynamic response = await _myRepo.getNotificationsCount(userEmiratesId: _userEmiratesId ?? '',headers: headers);

        print(response);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        print(error);
        setLoading(false);
      }}
    else{

      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
