import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';

import '../../../data/response/ApiResponse.dart';
import '../../../models/services/notes_models/UploadAttachmentToNoteModel.dart';
import '../../../utils/constants.dart';
import '../../services/alert_services.dart';
import '../../services/auth_services.dart';

class UploadAttachmentToNoteViewModel with ChangeNotifier {

  late AuthService _authService;
  late AlertServices _alertServices;

  UploadAttachmentToNoteViewModel()
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

  ApiResponse<UploadAttachmentToNoteModel> _apiResponse = ApiResponse.none();

  ApiResponse<UploadAttachmentToNoteModel> get apiResponse => _apiResponse;

  set setApiResponse(ApiResponse<UploadAttachmentToNoteModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> uploadAttachmentToNote({required dynamic form,required dynamic noteId}) async {
    final InternetController networkController = Get.find<InternetController>();

    // Check if the network is connected
    if (networkController.isConnected.value) {

      try {


        setLoading(true);
        setApiResponse = ApiResponse.loading();
        await setUserId();

        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': Constants.basicAuth
        };

        final body = jsonEncode(form);

        UploadAttachmentToNoteModel response = await _myRepo.uploadAttachmentToNote(userId: _userId ?? '',noteId:noteId,body: body,headers: headers);

        setApiResponse = ApiResponse.completed(response);
        _alertServices.toastMessage(response.message.toString());
        setLoading(false);
        return true;
      } catch (error) {
        setApiResponse = ApiResponse.error(error.toString());
        _alertServices.showErrorSnackBar(error.toString() ?? '');

        setLoading(false);
        return false;

      }}
    else{
      _alertServices.showErrorSnackBar("No Internet Connection is available");
      setLoading(false);
      return false;

    }
  }
}
