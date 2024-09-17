import 'dart:convert';
import 'package:flutter/material.dart';

// 1. NameAsPassport model for list
class NameAsPassport {
  final String nameType;
  final TextEditingController studentNameController;
  final TextEditingController fatherNameController;
  final TextEditingController grandFatherNameController;
  final TextEditingController familyNameController;

  NameAsPassport({
    required this.nameType,
    required this.studentNameController,
    required this.fatherNameController,
    required this.grandFatherNameController,
    required this.familyNameController,
  });

  factory NameAsPassport.fromJson(Map<String, dynamic> json) {
    return NameAsPassport(
      nameType: json['nameType'] ?? '',
      studentNameController: TextEditingController(text: json['studentName'] ?? ''),
      fatherNameController: TextEditingController(text: json['fatherName'] ?? ''),
      grandFatherNameController: TextEditingController(text: json['grandFatherName'] ?? ''),
      familyNameController: TextEditingController(text: json['familyName'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameType': nameType,
      'studentName': studentNameController.text,
      'fatherName': fatherNameController.text,
      'grandFatherName': grandFatherNameController.text,
      'familyName': familyNameController.text,
    };
  }
}

// 2. Single EnglishName and ArabicName models
class EnglishArabicName {
  final String nameType;
  final TextEditingController studentNameController;
  final TextEditingController fatherNameController;
  final TextEditingController grandFatherNameController;
  final TextEditingController familyNameController;

  EnglishArabicName({
    required this.nameType,
    required this.studentNameController,
    required this.fatherNameController,
    required this.grandFatherNameController,
    required this.familyNameController,
  });

  factory EnglishArabicName.fromJson(Map<String, dynamic> json) {
    return EnglishArabicName(
      nameType: json['nameType'] ?? '',
      studentNameController: TextEditingController(text: json['studentName'] ?? ''),
      fatherNameController: TextEditingController(text: json['fatherName'] ?? ''),
      grandFatherNameController: TextEditingController(text: json['grandFatherName'] ?? ''),
      familyNameController: TextEditingController(text: json['familyName'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameType': nameType,
      'studentName': studentNameController.text,
      'fatherName': fatherNameController.text,
      'grandFatherName': grandFatherNameController.text,
      'familyName': familyNameController.text,
    };
  }
}

// 3. PhoneNumber model remains the same
class PhoneNumber {
  final TextEditingController countryCodeController;
  final TextEditingController phoneNumberController;
  final TextEditingController phoneTypeController;
  final TextEditingController preferredController;

  PhoneNumber({
    required this.countryCodeController,
    required this.phoneNumberController,
    required this.phoneTypeController,
    required this.preferredController,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      countryCodeController: TextEditingController(text: json['countryCode'] ?? ''),
      phoneNumberController: TextEditingController(text: json['phoneNumber'] ?? ''),
      phoneTypeController: TextEditingController(text: json['phoneType'] ?? ''),
      preferredController: TextEditingController(text: json['preferred']?.toString() ?? 'false'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryCode': countryCodeController.text,
      'phoneNumber': phoneNumberController.text,
      'phoneType': phoneTypeController.text,
      'preferred': preferredController.text == 'true',
    };
  }
}

// 4. Address model remains the same
class Address {
  final TextEditingController addressTypeController;
  final TextEditingController addressLine1Controller;
  final TextEditingController addressLine2Controller;
  final TextEditingController cityController;
  final TextEditingController countryController;
  final TextEditingController postalCodeController;

  Address({
    required this.addressTypeController,
    required this.addressLine1Controller,
    required this.addressLine2Controller,
    required this.cityController,
    required this.countryController,
    required this.postalCodeController,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressTypeController: TextEditingController(text: json['addressType'] ?? ''),
      addressLine1Controller: TextEditingController(text: json['addressLine1'] ?? ''),
      addressLine2Controller: TextEditingController(text: json['addressLine2'] ?? ''),
      cityController: TextEditingController(text: json['city'] ?? ''),
      countryController: TextEditingController(text: json['country'] ?? ''),
      postalCodeController: TextEditingController(text: json['postalCode'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressType': addressTypeController.text,
      'addressLine1': addressLine1Controller.text,
      'addressLine2': addressLine2Controller.text,
      'city': cityController.text,
      'country': countryController.text,
      'postalCode': postalCodeController.text,
    };
  }
}

// 5. EmploymentHistory model remains the same
class EmploymentHistory {
  final TextEditingController employerNameController;
  final TextEditingController fromMonthController;
  final TextEditingController fromYearController;
  final TextEditingController toMonthController;
  final TextEditingController toYearController;
  final TextEditingController occupationController;
  final TextEditingController titleController;
  final TextEditingController placeController;
  final TextEditingController reportingManagerController;
  final TextEditingController contactNumberController;

  EmploymentHistory({
    required this.employerNameController,
    required this.fromMonthController,
    required this.fromYearController,
    required this.toMonthController,
    required this.toYearController,
    required this.occupationController,
    required this.titleController,
    required this.placeController,
    required this.reportingManagerController,
    required this.contactNumberController,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {
    return EmploymentHistory(
      employerNameController: TextEditingController(text: json['employerName'] ?? ''),
      fromMonthController: TextEditingController(text: json['fromMonth']?.toString() ?? ''),
      fromYearController: TextEditingController(text: json['fromYear']?.toString() ?? ''),
      toMonthController: TextEditingController(text: json['toMonth']?.toString() ?? ''),
      toYearController: TextEditingController(text: json['toYear']?.toString() ?? ''),
      occupationController: TextEditingController(text: json['occupation'] ?? ''),
      titleController: TextEditingController(text: json['title'] ?? ''),
      placeController: TextEditingController(text: json['place'] ?? ''),
      reportingManagerController: TextEditingController(text: json['reportingManager'] ?? ''),
      contactNumberController: TextEditingController(text: json['contactNumber'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employerName': employerNameController.text,
      'fromMonth': fromMonthController.text,
      'fromYear': fromYearController.text,
      'toMonth': toMonthController.text,
      'toYear': toYearController.text,
      'occupation': occupationController.text,
      'title': titleController.text,
      'place': placeController.text,
      'reportingManager': reportingManagerController.text,
      'contactNumber': contactNumberController.text,
    };
  }
}

