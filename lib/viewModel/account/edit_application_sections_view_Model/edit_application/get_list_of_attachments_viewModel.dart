import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetListOfAttachmentsModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetListOfAttachmentsModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../../data/response/ApiResponse.dart';
import '../../../../utils/constants.dart';
import '../../../services/alert_services.dart';
import '../../../services/auth_services.dart';





class GetListOfAttachmentsViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  GetListOfAttachmentsViewModel()
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

  ApiResponse<GetListOfAttachmentsModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetListOfAttachmentsModel> get apiResponse => _apiResponse;

  set setUserProfileInfo(ApiResponse<GetListOfAttachmentsModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  getListOfAttachments() async {

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

        GetListOfAttachmentsModel response = await _myRepo.getListOfAttachments(userId: _userId ?? '',headers: headers);
        setUserProfileInfo = ApiResponse.completed(response);
        // _alertServices.toastMessage(response.message.toString());
        setLoading(false);
      } catch (error) {
        setUserProfileInfo = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString());
        setLoading(false);
      }}
    else{

      _alertServices.toastMessage("No Internet Connection is available");
      setLoading(false);
    }
  }
}
