// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:sco_v1/controller/internet_controller.dart';
// import 'package:sco_v1/hive/hive_manager.dart';
// import 'package:sco_v1/models/apply_scholarship/SaveAsDraftModel.dart';
// import 'package:sco_v1/repositories/home/home_repository.dart';
// import 'package:sco_v1/viewModel/services/alert_services.dart';
// import 'package:sco_v1/viewModel/services/auth_services.dart';
//
// import '../../data/response/ApiResponse.dart';
// import '../../utils/constants.dart';
// import 'models/TestModel.dart';
//
// class TestApi with ChangeNotifier {
//   late AuthService _authService;
//   late AlertServices _alertServices;
//
//   TestApi() {
//     final GetIt getIt = GetIt.instance;
//     _authService = getIt.get<AuthService>();
//     _alertServices = getIt.get<AlertServices>();
//   }
//
//   bool _isLoading = true;
//
//   bool get isLoading => _isLoading;
//
//   void setLoading(val) {
//     _isLoading = val;
//     notifyListeners();
//   }
//
//   final _myRepo = HomeRepository();
//
//   ApiResponse<TestModel> _apiResponse = ApiResponse.none();
//
//   ApiResponse<TestModel> get apiResponse => _apiResponse;
//
//   set setApiResponse(ApiResponse<TestModel> response) {
//     _apiResponse = response;
//     notifyListeners();
//   }
//
//   testApi() async {
//     final InternetController networkController = Get.find<InternetController>();
//
//     // Check if the network is connected
//     if (networkController.isConnected.value) {
//       try {
//         setLoading(true);
//         setApiResponse = ApiResponse.loading();
//
//         final headers = {
//           'Content-Type': 'application/json',
//           'authorization': "Bearer 2138|OSwyfaZJIr1nZWNac4ikkWpcQySbzv7ygDeyCPNhc83e7c8c"
//           // 'authorization': Constants.basicAuthWithUsernamePassword
//         };
//
//         final body = jsonEncode({
//           "address": {
//             "address_id": "511",
//             "name": "Dikshit",
//             "email": "dikshitsharma588@gmail.com",
//             "city": "lalyar",
//             "phone": "9418952459",
//             "country": "AD",
//           },
//           "shipping_method": {
//             "106": "default"
//           },
//           "shipping_option": {
//             "106": "4"
//           }
//         });
//
//
//         TestModel response = await _myRepo.testApi(
//             body: body, headers: headers);
//
//         setApiResponse = ApiResponse.completed(response);
//         setLoading(false);
//       } catch (error) {
//         debugPrint(error.toString());
//         setApiResponse = ApiResponse.error(error.toString());
//         setLoading(false);
//       }
//     } else {
//       _alertServices.toastMessage("No Internet Connection is available");
//       setLoading(false);
//     }
//   }
// }
