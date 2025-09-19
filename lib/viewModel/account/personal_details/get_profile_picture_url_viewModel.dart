import 'package:flutter/cupertino.dart';
import 'package:get/get.dart'; import '../../../../resources/app_urls.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../models/account/personal_details/GetProfilePictureUrlModel.dart';
import '../../../utils/constants.dart';
import '../../services/alert_services.dart';
import '../../services/auth_services.dart';



class GetProfilePictureUrlViewModel with ChangeNotifier {
  late AuthService _authService;
  late AlertServices _alertServices;


  GetProfilePictureUrlViewModel()
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

  ApiResponse<GetProfilePictureUrlModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetProfilePictureUrlModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<GetProfilePictureUrlModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  getProfilePictureUrl() async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {
        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          // 'authorization': AppUrls.basicAuth
        };

        GetProfilePictureUrlModel response = await _myRepo.getProfilePictureUrl(userId: _userId ?? '',headers: headers);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        // _alertServices.showErrorSnackBar(error.toString());

        setLoading(false);
      }}
    else{
      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
