import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../../data/response/ApiResponse.dart';
import '../../../../utils/constants.dart';
import '../../../models/services/notes_models/GetSpecificNoteDetailsModel.dart';
import '../../services/alert_services.dart';
import '../../services/auth_services.dart';



class GetSpecificNoteDetailsViewModel with ChangeNotifier {

  late AlertServices _alertServices;

  GetSpecificNoteDetailsViewModel()
  {
    final GetIt getIt = GetIt.instance;
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

  ApiResponse<GetSpecificNoteDetailsModel> _apiResponse = ApiResponse.none();

  ApiResponse<GetSpecificNoteDetailsModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<GetSpecificNoteDetailsModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  getSpecificNoteDetails({required noteId}) async {

    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'authorization': Constants.basicAuth
        };

        GetSpecificNoteDetailsModel response = await _myRepo.getSpecificNoteDetails(userId: _userId ?? '',noteId:noteId,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        setLoading(false);
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString() ?? '');

        setLoading(false);
      }}
    else{

      _alertServices.showErrorSnackBar("No Internet Connection is available");
      setLoading(false);
    }
  }
}
