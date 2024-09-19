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
  final String countryCode;
  final String phoneNumber;
  final String phoneType;
  final String preferred; // Boolean value as a string ('true'/'false')

  PhoneNumber({
    required this.countryCode,
    required this.phoneNumber,
    required this.phoneType,
    required this.preferred,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      countryCode: json['countryCode'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      phoneType: json['phoneType'] ?? '',
      preferred: json['preferred']?.toString() ?? 'false',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'phoneType': phoneType,
      'preferred': preferred,
    };
  }
}

class Address {
  final String addressType;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String postalCode;

  Address({
    required this.addressType,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressType: json['addressType'] ?? '',
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressType': addressType,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'country': country,
      'postalCode': postalCode,
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