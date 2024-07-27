import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/data/response/ApiResponse.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/repositories/auth_repo/auth_repository.dart';
import 'package:sco_v1/view/authentication/signup/signup_otp_verification_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../models/authentication/signup_model.dart';
import '../../utils/constants.dart';
import '../services/navigation_services.dart';

class SignupViewModel with ChangeNotifier {
  late AlertServices _alertServices;
  late NavigationServices _navigationServices;

  SignupViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _navigationServices = getIt.get<NavigationServices>();
  }

  String? _firstName;
  String? _middleName;
  String? _middleName2;
  String? _lastName;
  String? _emailAddress;
  String? _confirmEmailAddress;
  String? _day;
  String? _month;
  String? _year;
  String? _emirateId;
  String? _isMale;
  String? _country;
  String? _phoneNo;
  String? _password;
  String? _confirmPassword;

  // Setters
  void setFirstName(String firstName) {
    _firstName = firstName;
  }

  void setMiddleName(String middleName) {
    _middleName = middleName;
  }

  void setMiddleName2(String middleName2) {
    _middleName2 = middleName2;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setEmailAddress(String emailAddress) {
    _emailAddress = emailAddress;
  }

  void setConfirmEmailAddress(String confirmEmailAddress) {
    _confirmEmailAddress = confirmEmailAddress;
  }

  void setDay(String day) {
    _day = day;
  }

  void setMonth(String month) {
    _month = month;
  }

  void setYear(String year) {
    _year = year;
  }

  void setEmirateId(String emirateId) {
    _emirateId = emirateId;
  }

  void setIsMale(String isMale) {
    _isMale = isMale;
  }

  void setCountry(String country) {
    _country = country;
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ApiResponse<SignupModel> _apiResponse = ApiResponse.none();

  ApiResponse<SignupModel> get apiResponse => _apiResponse;

  set setResponse(ApiResponse<SignupModel> response) {
    _apiResponse = response;
    notifyListeners();
  }

  //signup Function
  Future<bool> signup(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      setResponse = ApiResponse.loading();

      //*-----Create Headers Start-----*

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create Headers End-----*


      //*-----Create Body Start----*
      final body = {
        "firstName": _firstName,
        "middleName": _middleName,
        "middleName2": _middleName2,
        "lastName": _lastName,
        "emailAddress": _emailAddress,
        "confirmEmailAddress": _confirmEmailAddress,
        "day": _day,
        "month": _month,
        "year": _year,
        "emirateId": _emirateId,
        "isMale": _isMale,
        "country": _country,
        "phoneNo": _phoneNo,
        "password": _password,
        "confirmPassword": _confirmPassword
      };
      // *-----Create Body End-----*

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.signup(
        headers: headers,
        body: body,
      );
      //*-----Calling Api End-----*

      setResponse = ApiResponse.completed(response);
      HiveManager.storeUserId(response.data!.user!.userId.toString());

      _alertServices.flushBarErrorMessages(
          message: response.message.toString(),
          context: context,
          provider: langProvider);

      //*---------Navigating to Otp Verification View---------*
      return true;
    } catch (error) {
      setResponse = ApiResponse.error(error.toString());
      _alertServices.flushBarErrorMessages(
          message: error.toString(), context: context, provider: langProvider);
      return false;
    }
  }
}
