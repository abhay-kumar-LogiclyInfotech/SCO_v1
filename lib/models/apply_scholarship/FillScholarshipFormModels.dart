import 'dart:convert';
import 'package:flutter/material.dart';

// Generalized PersonName model for names (Arabic, English, etc.)
class PersonName {
  final String nameType;
  final String studentName;
  final String fatherName;
  final String grandFatherName;
  final String familyName;

  PersonName({
    required this.nameType,
    required this.studentName,
    required this.fatherName,
    required this.grandFatherName,
    required this.familyName,
  });

  // Factory method to create an instance from JSON
  factory PersonName.fromJson(Map<String, dynamic> json) {
    return PersonName(
      nameType: json['nameType'] ?? '',
      studentName: json['studentName'] ?? '',
      fatherName: json['fatherName'] ?? '',
      grandFatherName: json['grandFatherName'] ?? '',
      familyName: json['familyName'] ?? '',
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'nameType': nameType,
      'studentName': studentName,
      'fatherName': fatherName,
      'grandFatherName': grandFatherName,
      'familyName': familyName,
    };
  }
}


class PhoneNumber {
  TextEditingController countryCodeController;
  TextEditingController phoneNumberController;
  TextEditingController phoneTypeController;

  // Boolean value for preferred
  bool preferred;

  // Focus Nodes
  FocusNode countryCodeFocusNode;
  FocusNode phoneNumberFocusNode;
  FocusNode phoneTypeFocusNode;

  // Error Text Variables
  String? countryCodeError;
  String? phoneNumberError;
  String? phoneTypeError;

  PhoneNumber({
    required this.countryCodeController,
    required this.phoneNumberController,
    required this.phoneTypeController,
    required this.preferred,
    required this.countryCodeFocusNode,
    required this.phoneNumberFocusNode,
    required this.phoneTypeFocusNode,
    this.countryCodeError,
    this.phoneNumberError,
    this.phoneTypeError,
  });

  // From JSON
  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      countryCodeController: TextEditingController(text: json['countryCode']),
      phoneNumberController: TextEditingController(text: json['phoneNumber']),
      phoneTypeController: TextEditingController(text: json['phoneType']),
      preferred: json['preferred'] ?? false,
      countryCodeFocusNode: FocusNode(),
      phoneNumberFocusNode: FocusNode(),
      phoneTypeFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'countryCode': countryCodeController.text,
      'phoneNumber': phoneNumberController.text,
      'phoneType': phoneTypeController.text,
      'preferred': preferred,
    };
  }
}


// Address inFormation
class Address {
  // Text Editing Controllers for form fields
  TextEditingController addressTypeController;
  TextEditingController addressLine1Controller;
  TextEditingController addressLine2Controller;
  TextEditingController cityController;
  TextEditingController countryController;
  TextEditingController postalCodeController;
  TextEditingController stateController;

  // Focus Nodes
  FocusNode addressTypeFocusNode;
  FocusNode addressLine1FocusNode;
  FocusNode addressLine2FocusNode;
  FocusNode cityFocusNode;
  FocusNode countryFocusNode;
  FocusNode postalCodeFocusNode;
  FocusNode stateFocusNode;

  // Error Text Variables
  String? addressTypeError;
  String? addressLine1Error;
  String? addressLine2Error;
  String? cityError;
  String? countryError;
  String? postalCodeError;
  String? stateError;

  List<DropdownMenuItem>? countryDropdownMenuItems;
  List<DropdownMenuItem>? stateDropdownMenuItems;


  Address({
    required this.addressTypeController,
    required this.addressLine1Controller,
    required this.addressLine2Controller,
    required this.cityController,
    required this.countryController,
    required this.postalCodeController,
    required this.stateController,
    required this.addressTypeFocusNode,
    required this.addressLine1FocusNode,
    required this.addressLine2FocusNode,
    required this.cityFocusNode,
    required this.countryFocusNode,
    required this.postalCodeFocusNode,
    required this.stateFocusNode,
    this.addressTypeError,
    this.addressLine1Error,
    this.addressLine2Error,
    this.cityError,
    this.countryError,
    this.postalCodeError,
    this.stateError,
    this.countryDropdownMenuItems,
    this.stateDropdownMenuItems,
  });

  // From JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressTypeController: TextEditingController(text: json['addressType']),
      addressLine1Controller: TextEditingController(text: json['addressLine1']),
      addressLine2Controller: TextEditingController(text: json['addressLine2']),
      cityController: TextEditingController(text: json['city']),
      countryController: TextEditingController(text: json['country']),
      postalCodeController: TextEditingController(text: json['postalCode']),
      stateController: TextEditingController(text: json['state']),
      addressTypeFocusNode: FocusNode(),
      addressLine1FocusNode: FocusNode(),
      addressLine2FocusNode: FocusNode(),
      cityFocusNode: FocusNode(),
      countryFocusNode: FocusNode(),
      postalCodeFocusNode: FocusNode(),
      stateFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'addressType': addressTypeController.text,
      'addressLine1': addressLine1Controller.text,
      'addressLine2': addressLine2Controller.text,
      'city': cityController.text,
      'country': countryController.text,
      'postalCode': postalCodeController.text,
      'state': stateController.text,
    };
  }
}

// HighSchool model
class HighSchool {
  // Text Editing Controllers for form fields
  TextEditingController hsLevelController;
  TextEditingController hsNameController;
  TextEditingController hsCountryController;
  TextEditingController hsStateController;
  TextEditingController yearOfPassingController;
  TextEditingController hsTypeController;
  TextEditingController curriculumTypeController;
  TextEditingController curriculumAverageController;
  TextEditingController otherHsNameController;
  TextEditingController passingYearController;
  TextEditingController maxDateController;

  // Focus Nodes
  FocusNode hsLevelFocusNode;
  FocusNode hsNameFocusNode;
  FocusNode hsCountryFocusNode;
  FocusNode hsStateFocusNode;
  FocusNode yearOfPassingFocusNode;
  FocusNode hsTypeFocusNode;
  FocusNode curriculumTypeFocusNode;
  FocusNode curriculumAverageFocusNode;
  FocusNode otherHsNameFocusNode;
  FocusNode passingYearFocusNode;
  FocusNode maxDateFocusNode;

  // Error Text Variables
  String? hsLevelError;
  String? hsNameError;
  String? hsCountryError;
  String? hsStateError;
  String? yearOfPassingError;
  String? hsTypeError;
  String? curriculumTypeError;
  String? curriculumAverageError;
  String? otherHsNameError;
  String? passingYearError;
  String? maxDateError;

  List<DropdownMenuItem>? schoolStateDropdownMenuItems;
  List<DropdownMenuItem>? schoolNameDropdownMenuItems;
  List<DropdownMenuItem>? schoolTypeDropdownMenuItems;
  List<DropdownMenuItem>? curriculumTypeDropdownMenuItems;





  List<HSDetails> hsDetails;
  List<HSDetails> otherHSDetails;

  HighSchool({
    required this.hsLevelController,
    required this.hsNameController,
    required this.hsCountryController,
    required this.hsStateController,
    required this.yearOfPassingController,
    required this.hsTypeController,
    required this.curriculumTypeController,
    required this.curriculumAverageController,
    required this.otherHsNameController,
    required this.passingYearController,
    required this.maxDateController,
    required this.hsLevelFocusNode,
    required this.hsNameFocusNode,
    required this.hsCountryFocusNode,
    required this.hsStateFocusNode,
    required this.yearOfPassingFocusNode,
    required this.hsTypeFocusNode,
    required this.curriculumTypeFocusNode,
    required this.curriculumAverageFocusNode,
    required this.otherHsNameFocusNode,
    required this.passingYearFocusNode,
    required this.maxDateFocusNode,
    this.hsLevelError,
    this.hsNameError,
    this.hsCountryError,
    this.hsStateError,
    this.yearOfPassingError,
    this.hsTypeError,
    this.curriculumTypeError,
    this.curriculumAverageError,
    this.otherHsNameError,
    this.passingYearError,
    this.maxDateError,
    required this.hsDetails,
    required this.otherHSDetails,
  });

  // From JSON
  factory HighSchool.fromJson(Map<String, dynamic> json) {
    return HighSchool(
      hsLevelController: TextEditingController(text: json['hsLevel']),
      hsNameController: TextEditingController(text: json['hsName']),
      hsCountryController: TextEditingController(text: json['hsCountry']),
      hsStateController: TextEditingController(text: json['hsState']),
      yearOfPassingController: TextEditingController(text: json['yearOfPassing']),
      hsTypeController: TextEditingController(text: json['hsType']),
      curriculumTypeController: TextEditingController(text: json['curriculumType']),
      curriculumAverageController: TextEditingController(text: json['curriculumAverage']),
      otherHsNameController: TextEditingController(text: json['otherHsName']),
      passingYearController: TextEditingController(text: json['passignYear']),
      maxDateController: TextEditingController(text: json['maxDate']),
      hsLevelFocusNode: FocusNode(),
      hsNameFocusNode: FocusNode(),
      hsCountryFocusNode: FocusNode(),
      hsStateFocusNode: FocusNode(),
      yearOfPassingFocusNode: FocusNode(),
      hsTypeFocusNode: FocusNode(),
      curriculumTypeFocusNode: FocusNode(),
      curriculumAverageFocusNode: FocusNode(),
      otherHsNameFocusNode: FocusNode(),
      passingYearFocusNode: FocusNode(),
      maxDateFocusNode: FocusNode(),
      hsDetails: (json['hsDetails']['com.mopa.sco.application.HSDetails'] as List).map((e) => HSDetails.fromJson(e)).toList(),
      otherHSDetails: (json['otherHSDetails']['com.mopa.sco.application.HSDetails'] as List).map((e) => HSDetails.fromJson(e)).toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'hsLevel': hsLevelController.text,
      'hsName': hsNameController.text,
      'hsCountry': hsCountryController.text,
      'hsState': hsStateController.text,
      'yearOfPassing': yearOfPassingController.text,
      'hsType': hsTypeController.text,
      'curriculumType': curriculumTypeController.text,
      'curriculumAverage': curriculumAverageController.text,
      'otherHsName': otherHsNameController.text,
      'passignYear': passingYearController.text,
      'maxDate': maxDateController.text,
      'hsDetails': hsDetails.map((e) => e.toJson()).toList(),
      'otherHSDetails': otherHSDetails.map((e) => e.toJson()).toList(),
    };
  }
}

// HSDetails model
class HSDetails {
  TextEditingController subjectTypeController;
  TextEditingController gradeController;
  TextEditingController? otherSubjectNameController;

  FocusNode subjectTypeFocusNode;
  FocusNode gradeFocusNode;
  FocusNode? otherSubjectNameFocusNode;

  HSDetails({
    required this.subjectTypeController,
    required this.gradeController,
    this.otherSubjectNameController,
    required this.subjectTypeFocusNode,
    required this.gradeFocusNode,
    this.otherSubjectNameFocusNode,
  });

  factory HSDetails.fromJson(Map<String, dynamic> json) {
    return HSDetails(
      subjectTypeController: TextEditingController(text: json['subjectType']),
      gradeController: TextEditingController(text: json['grade']),
      otherSubjectNameController: json['otherSubjectName'] != null
          ? TextEditingController(text: json['otherSubjectName'])
          : null,
      subjectTypeFocusNode: FocusNode(),
      gradeFocusNode: FocusNode(),
      otherSubjectNameFocusNode: json['otherSubjectName'] != null ? FocusNode() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectType': subjectTypeController.text,
      'grade': gradeController.text,
      'otherSubjectName': otherSubjectNameController?.text,
    };
  }
}



class EmploymentHistory {
  final String employerName;
  final String fromMonth;
  final String fromYear;
  final String toMonth;
  final String toYear;
  final String occupation;
  final String title;
  final String place;
  final String reportingManager;
  final String contactNumber;

  EmploymentHistory({
    required this.employerName,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    required this.occupation,
    required this.title,
    required this.place,
    required this.reportingManager,
    required this.contactNumber,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {
    return EmploymentHistory(
      employerName: json['employerName'] ?? '',
      fromMonth: json['fromMonth']?.toString() ?? '',
      fromYear: json['fromYear']?.toString() ?? '',
      toMonth: json['toMonth']?.toString() ?? '',
      toYear: json['toYear']?.toString() ?? '',
      occupation: json['occupation'] ?? '',
      title: json['title'] ?? '',
      place: json['place'] ?? '',
      reportingManager: json['reportingManager'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employerName': employerName,
      'fromMonth': fromMonth,
      'fromYear': fromYear,
      'toMonth': toMonth,
      'toYear': toYear,
      'occupation': occupation,
      'title': title,
      'place': place,
      'reportingManager': reportingManager,
      'contactNumber': contactNumber,
    };
  }
}


// *------------------------------------------------------------------------------------------------ Relative Information ------------------------------------------------------------------------------------------------

class RelativeInfo {
  TextEditingController relativeNameController;
  TextEditingController countryUniversityController;
  TextEditingController relationTypeController;
  TextEditingController familyBookNumberController;


  // Focus Nodes
  FocusNode relativeNameFocusNode;
  FocusNode countryUniversityFocusNode;
  FocusNode relationTypeFocusNode;
  FocusNode familyBookNumberFocusNode;

  // Error Text Variables
  String? relativeNameError;
  String? countryUniversityError;
  String? relationTypeError;
  String? familyBookNumberError;

  RelativeInfo({
    required this.relativeNameController,
    required this.countryUniversityController,
    required this.relationTypeController,
    required this.familyBookNumberController,
    required this.relativeNameFocusNode,
    required this.countryUniversityFocusNode,
    required this.relationTypeFocusNode,
    required this.familyBookNumberFocusNode,
    this.relativeNameError,
    this.countryUniversityError,
    this.relationTypeError,
    this.familyBookNumberError,
  });

  // From JSON
  factory RelativeInfo.fromJson(Map<String, dynamic> json) {
    return RelativeInfo(
      relativeNameController: TextEditingController(text: json['relativeName']),
      countryUniversityController: TextEditingController(text: json['countryUniversity']),
      relationTypeController: TextEditingController(text: json['relationType']),
      familyBookNumberController: TextEditingController(text: json['familyBookNumber']),
      relativeNameFocusNode: FocusNode(),
      countryUniversityFocusNode: FocusNode(),
      relationTypeFocusNode: FocusNode(),
      familyBookNumberFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'relativeName': relativeNameController.text,
      'countryUniversity': countryUniversityController.text,
      'relationType': relationTypeController.text,
    };
  }
}


