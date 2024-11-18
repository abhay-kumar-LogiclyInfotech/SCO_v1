import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../utils/constants.dart';
import '../../models/services/GetAllRequestsModel.dart';
import '../services/alert_services.dart';
import '../services/auth_services.dart';

class GetAllRequestsViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  GetAllRequestsViewModel()
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

  ApiResponse<GetAllRequestsModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetAllRequestsModel> get apiResponse => _apiResponse;

  set setUserProfileInfo(ApiResponse<GetAllRequestsModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  getAllRequests() async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setUserProfileInfo = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'authorization': Constants.basicAuth
        };

        GetAllRequestsModel response = await _myRepo.getAllRequests(userId: _userId ?? '',headers: headers);

        setUserProfileInfo = ApiResponse.completed(response);
        setLoading(false);
      } catch (error) {
        setUserProfileInfo = ApiResponse.error(error.toString());
        print(error);
        setLoading(false);
      }}
    else{

      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
