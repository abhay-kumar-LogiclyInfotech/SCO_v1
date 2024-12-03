import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/drawer/contact_us_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

class ContactUsViewModel with ChangeNotifier {
  //*------Necessary Services------*/
  late AlertServices _alertServices;

  ContactUsViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  // Private fields
  String _fullName = '';
  String _email = '';
  String _subject = '';
  String _comment = '';
  String _contactUsType = '';
  String _phoneNumber = '';

  // Getters
  String get fullName => _fullName;
  String get email => _email;
  String get subject => _subject;
  String get comment => _comment;
  String get contactUsType => _contactUsType;
  String get phoneNumber => _phoneNumber;

  // Setters
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set subject(String value) {
    _subject = value;
    notifyListeners();
  }

  set comment(String value) {
    _comment = value;
    notifyListeners();
  }

  set contactUsType(String value) {
    _contactUsType = value;
    notifyListeners();
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  // Debug print method
  void debugPrintFields() {
    debugPrint('Full Name: $_fullName');
    debugPrint('Email: $_email');
    debugPrint('Subject: $_subject');
    debugPrint('Comment: $_comment');
    debugPrint('Contact Us Type: $_contactUsType');
    debugPrint('Phone Number: $_phoneNumber');
  }

  //*------Accessing Api Services------*

  final DrawerRepository _drawerRepository = DrawerRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<ContactUsModel> _contactUsResponse = ApiResponse.none();

  ApiResponse<ContactUsModel> get contactUsResponse => _contactUsResponse;

  set _setContactUsResponse(ApiResponse<ContactUsModel> response) {
    _contactUsResponse = response;
    notifyListeners();
  }

  Future<bool> contactUS(
      {required BuildContext context,
        required LanguageChangeViewModel langProvider}) async {
    try {
      _setContactUsResponse = ApiResponse.loading();

      //*-----printing the values:
      debugPrintFields();

      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create fields-----*
      final fields = <String, String>{
        'fullName': _fullName,
        'email': _email,
        'subject': _subject,
        'comment': _comment,
        'contactUsType': _contactUsType,
        'phoneNumber': _phoneNumber
      };

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.contactUs(headers: headers, fields: fields);

      //*-----Calling Api End-----*

      _setContactUsResponse = ApiResponse.completed(response);
      _alertServices.toastMessage("Request Submitted Successfully");

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setContactUsResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.showErrorSnackBar(error.toString());

      return false;
    }
  }
}

