import 'dart:convert';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';


class PersonName {
  // TextEditingControllers for each field
  TextEditingController nameTypeController;
  TextEditingController studentNameController;
  TextEditingController fatherNameController;
  TextEditingController grandFatherNameController;
  TextEditingController familyNameController;

  // FocusNodes for each field
  FocusNode nameTypeFocusNode;
  FocusNode studentNameFocusNode;
  FocusNode fatherNameFocusNode;
  FocusNode grandFatherNameFocusNode;
  FocusNode familyNameFocusNode;

  // Error Text Variables for validation
  String? nameTypeError;
  String? studentNameError;
  String? fatherNameError;
  String? grandFatherNameError;
  String? familyNameError;

  PersonName({
    required this.nameTypeController,
    required this.studentNameController,
    required this.fatherNameController,
    required this.grandFatherNameController,
    required this.familyNameController,
    required this.nameTypeFocusNode,
    required this.studentNameFocusNode,
    required this.fatherNameFocusNode,
    required this.grandFatherNameFocusNode,
    required this.familyNameFocusNode,
    this.nameTypeError,
    this.studentNameError,
    this.fatherNameError,
    this.grandFatherNameError,
    this.familyNameError,
  });

  // Factory method to create an instance from JSON
  factory PersonName.fromJson(Map<String, dynamic> json) {
    return PersonName(
      nameTypeController: TextEditingController(text: json['nameType']),
      studentNameController: TextEditingController(text: json['studentName']),
      fatherNameController: TextEditingController(text: json['fatherName']),
      grandFatherNameController: TextEditingController(text: json['grandFatherName']),
      familyNameController: TextEditingController(text: json['familyName']),
      nameTypeFocusNode: FocusNode(),
      studentNameFocusNode: FocusNode(),
      fatherNameFocusNode: FocusNode(),
      grandFatherNameFocusNode: FocusNode(),
      familyNameFocusNode: FocusNode(),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'nameType': nameTypeController.text,
      'studentName': studentNameController.text,
      'fatherName': fatherNameController.text,
      'grandFatherName': grandFatherNameController.text,
      'familyName': familyNameController.text,
    };
  }
}

class PhoneNumber {
  TextEditingController countryCodeController;
  TextEditingController phoneNumberController;
  TextEditingController phoneTypeController;

  // Boolean values for preferred and isExisting
  bool preferred;
  bool isExisting;

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
    required this.isExisting,
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
      preferred: json['prefered'] == true || json['prefered'] == 'true' ? true : false,
      isExisting: json['isExisting'] == true || json['isExisting']  == 'true' || json['existing'] == true || json['existing']  == 'true' ? true : false,
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
      'prefered': preferred,
      'isExisting': isExisting,
      "existing":isExisting
    };
  }
}

// Email
class EmailDetail {
  // Controllers
  TextEditingController emailTypeController;
  TextEditingController emailIdController;

  // Boolean values for preferred and existing
  bool prefferd;
  bool existing;

  // Focus Nodes
  FocusNode emailTypeFocusNode;
  FocusNode emailIdFocusNode;

  // Error Text Variables
  String? emailTypeError;
  String? emailIdError;

  EmailDetail({
    required this.emailTypeController,
    required this.emailIdController,
    required this.prefferd,
    required this.existing,
    required this.emailTypeFocusNode,
    required this.emailIdFocusNode,
    this.emailTypeError,
    this.emailIdError,
  });

  // From JSON
  factory EmailDetail.fromJson(Map<String, dynamic> json) {
    return EmailDetail(
      emailTypeController: TextEditingController(text: json['emailType']),
      emailIdController: TextEditingController(text: json['emailId']),
      prefferd: json['prefferd'] == true || json['prefferd'] == 'true',
      existing: json['existing'] == true || json['existing'] == 'true',
      emailTypeFocusNode: FocusNode(),
      emailIdFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'emailType': emailTypeController.text,
      'emailId': emailIdController.text,
      'prefferd': prefferd,
      'existing': existing,
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

  // Additional Fields
  bool disableState;
  bool isExisting;

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
    this.disableState = false,
    this.isExisting = false,
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
      disableState: json['disableState'] == 'true' || json['disableState'] == true ? true :false,
      isExisting: json['isExisting'] == 'true' || json['isExisting'] == true || json['existing'] == true || json['existing'] == 'true'  ? true : false,
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
      'disableState': disableState.toString(),
      'isExisting': isExisting.toString(),
      'existing': isExisting.toString()
    };
  }
}


// HighSchool model
class HighSchool {
  // Existing fields...
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

  // New fields
  TextEditingController disableStateController;
  TextEditingController isNewController;
  TextEditingController highestQualificationController;

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
  List<DropdownMenuItem>? schoolCurriculumTypeDropdownMenuItems;

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
    required this.disableStateController,
    required this.isNewController,
    required this.highestQualificationController,
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
    this.schoolStateDropdownMenuItems,
    this.schoolNameDropdownMenuItems,
    this.schoolTypeDropdownMenuItems,
    this.schoolCurriculumTypeDropdownMenuItems,
  });

  // From JSON
  factory HighSchool.fromJson(Map<String, dynamic> json) {
    return HighSchool(
      hsLevelController:
          TextEditingController(text: json['hsLevel'].toString()),
      hsNameController: TextEditingController(text: json['hsName'].toString()),
      hsCountryController:
          TextEditingController(text: json['hsCountry'].toString()),
      hsStateController:
          TextEditingController(text: json['hsState'].toString()),
      yearOfPassingController:
          TextEditingController(text: formatDateOnly(json['yearOfPassing'].toString())),
      hsTypeController: TextEditingController(text: json['hsType'].toString()),
      curriculumTypeController:
          TextEditingController(text: json['curriculumType'].toString()),
      curriculumAverageController:
          TextEditingController(text: json['curriculumAverage'].toString()),
      otherHsNameController:
          TextEditingController(text: json['otherHsName'].toString()),
      passingYearController:
          TextEditingController(text:  json['passignYear'].toString()),
      maxDateController:
          TextEditingController(text: json['maxDate'].toString()),
      disableStateController:
          TextEditingController(text: json['disableState'].toString()),

      // isNewController: TextEditingController(text: json['isNew'].toString()),
      isNewController: TextEditingController(text: (json['isNew']?.toString() ?? json['new']?.toString() ?? 'false'),),


      highestQualificationController:
          TextEditingController(text: json['highestQualification'].toString()),
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
      // hsDetails: (json['hsDetails'] as List)
      //     .map((e) => HSDetails.fromJson(e))
      //     .toList(),
      // otherHSDetails: (json['otherHSDetails'] as List)
      //     .map((e) => HSDetails.fromJson(e))
      //     .toList(),

      hsDetails: (json['hsDetails'] is List
          ? (json['hsDetails'] as List)
          .map((e) => HSDetails.fromJson(e))
          .toList()
          : []), /// Provide an empty list if hsDetails is not a List

      otherHSDetails: (json['otherHSDetails'] is List
          ? (json['otherHSDetails'] as List)
          .map((e) => HSDetails.fromJson(e))
          .toList()
          : []), /// Provide an
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
      'disableState': disableStateController.text,
      'isNew': isNewController.text,
      'new': isNewController.text,
      'highestQualification': highestQualificationController.text,
      'hsDetails': hsDetails.map((e) => e.toJson()).toList(),
      'otherHSDetails': otherHSDetails.map((e) => e.toJson()).toList(),
    };
  }
}





// HSDetails model
class HSDetails {
  TextEditingController subjectTypeController;
  TextEditingController gradeController;
  TextEditingController otherSubjectNameController;

  FocusNode subjectTypeFocusNode;
  FocusNode gradeFocusNode;
  FocusNode otherSubjectNameFocusNode;

  String? subjectTypeError;
  String? gradeError;
  String? otherSubjectNameError;

  bool required = false;

  HSDetails({
    required this.subjectTypeController,
    required this.gradeController,
    required this.otherSubjectNameController,
    required this.subjectTypeFocusNode,
    required this.gradeFocusNode,
    required this.otherSubjectNameFocusNode,
    this.subjectTypeError,
    this.gradeError,
    this.otherSubjectNameError,
    this.required  = false,
  });

  // From JSON
  factory HSDetails.fromJson(Map<String, dynamic> json) {
    return HSDetails(
      subjectTypeController: TextEditingController(text: json['subjectType'].toString()),
      gradeController: TextEditingController(text: json['grade'].toString()),
      otherSubjectNameController: json['otherSubjectName'] != null ? TextEditingController(text: json['otherSubjectName'].toString()) : TextEditingController(),
      subjectTypeFocusNode: FocusNode(),
      gradeFocusNode: FocusNode(),
      otherSubjectNameFocusNode: json['otherSubjectName'] != null ? FocusNode() : FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final data = {
      'subjectType': subjectTypeController.text,
      'grade': gradeController.text,
    };

    // Only include otherSubjectName if it is not null and not empty
    if (otherSubjectNameController != null &&
        otherSubjectNameController!.text.isNotEmpty) {
      data['otherSubjectName'] = otherSubjectNameController!.text;
    }

    return data;
  }
}


// relative information
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
      countryUniversityController:
          TextEditingController(text: json['relativeUniversity']),
      relationTypeController: TextEditingController(text: json['relativeRelationType']),
      familyBookNumberController:
          TextEditingController(text: json['familyBookNumber']),
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
      'relativeUniversity': countryUniversityController.text,
      'relativeRelationType': relationTypeController.text,
    };
  }
}



// graduation information
class GraduationInfo {
  // TextEditingControllers
  TextEditingController levelController;
  TextEditingController countryController;
  TextEditingController universityController;
  TextEditingController otherUniversityController;
  TextEditingController majorController;
  TextEditingController cgpaController;
  TextEditingController graduationStartDateController;
  TextEditingController graduationEndDateController;
  TextEditingController lastTermController;
  TextEditingController caseStudyTitleController;
  TextEditingController caseStudyDescriptionController;
  TextEditingController caseStudyStartYearController;


  // New properties
  TextEditingController isNewController;
  TextEditingController sponsorShipController;
  TextEditingController errorMessageController;
  bool highestQualification;
  bool showCurrentlyStudying;
  // New property
  bool currentlyStudying;
  // Focus Nodes
  FocusNode levelFocusNode;
  FocusNode countryFocusNode;
  FocusNode universityFocusNode;
  FocusNode otherUniversityFocusNode;
  FocusNode majorFocusNode;
  FocusNode cgpaFocusNode;
  FocusNode graduationStartDateFocusNode;
  FocusNode graduationEndDateFocusNode;
  FocusNode lastTermFocusNode;
  FocusNode caseStudyTitleFocusNode;
  FocusNode caseStudyDescriptionFocusNode;
  FocusNode caseStudyStartYearFocusNode;
  FocusNode sponsorShipFocusNode;



  // Error Text Variables
  String? levelError;
  String? countryError;
  String? universityError;
  String? otherUniversityError;
  String? majorError;
  String? cgpaError;
  String? sponsorShipError;
  String? graduationStartDateError;
  String? graduationEndDateError;
  String? lastTermError;
  String? caseStudyTitleError;
  String? caseStudyDescriptionError;
  String? caseStudyStartYearError;




  List<DropdownMenuItem>? lastTerm;
  List<DropdownMenuItem>? graduationLevel;
  List<DropdownMenuItem>? university;



  GraduationInfo({
    required this.levelController,
    required this.countryController,
    required this.universityController,
    required this.otherUniversityController,
    required this.majorController,
    required this.cgpaController,
    required this.graduationStartDateController,
    required this.graduationEndDateController,
    required this.lastTermController,
    required this.caseStudyTitleController,
    required this.caseStudyDescriptionController,
    required this.caseStudyStartYearController,
    required this.levelFocusNode,
    required this.countryFocusNode,
    required this.universityFocusNode,
    required this.otherUniversityFocusNode,
    required this.majorFocusNode,
    required this.cgpaFocusNode,
    required this.graduationStartDateFocusNode,
    required this.graduationEndDateFocusNode,
    required this.lastTermFocusNode,
    required this.caseStudyTitleFocusNode,
    required this.caseStudyDescriptionFocusNode,
    required this.caseStudyStartYearFocusNode,
    required this.sponsorShipFocusNode,
    this.levelError,
    this.countryError,
    this.universityError,
    this.otherUniversityError,
    this.majorError,
    this.cgpaError,
    this.graduationStartDateError,
    this.graduationEndDateError,
    this.lastTermError,
    this.caseStudyTitleError,
    this.caseStudyDescriptionError,
    this.caseStudyStartYearError,
    this.sponsorShipError,
    required this.currentlyStudying,
    required this.isNewController,
    required this.sponsorShipController,
    required this.errorMessageController,
    required this.highestQualification,
    required this.showCurrentlyStudying,
    this.lastTerm,
    this.graduationLevel,
    this.university,
  });

  // From JSON (null-safe)
  factory GraduationInfo.fromJson(Map<String, dynamic> json) {
    return GraduationInfo(
      levelController: TextEditingController(text: json['level'] ?? ''),
      countryController: TextEditingController(text: json['country'] ?? ''),
      universityController: TextEditingController(text: json['university'] ?? ''),
      otherUniversityController: TextEditingController(text: json['otherUniversity'] ?? ''),
      majorController: TextEditingController(text: json['major'] ?? ''),
      cgpaController: TextEditingController(text: json['cgpa'] ?? ''),
      graduationStartDateController: TextEditingController(text: formatDateOnly(json['graduationStartDate']?.toString() ?? '')),
      graduationEndDateController: TextEditingController(text: formatDateOnly(json['graduationEndDate']?.toString() ?? '')),
      lastTermController: TextEditingController(text: json['lastTerm'] ?? ''),
      caseStudyTitleController: TextEditingController(
        text: (json['caseStudy'] != null && json['caseStudy'] is Map && json['caseStudy']['title'] != null)
            ? json['caseStudy']['title'].toString()
            : '',
      ),
      caseStudyDescriptionController: TextEditingController(
        text: (json['caseStudy'] is Map && json['caseStudy']['description'] != null)
            ? json['caseStudy']['description'].toString()
            : '',
      ),
      caseStudyStartYearController: TextEditingController(
        text: (json['caseStudy'] is Map && json['caseStudy']['startYear'] != null)
            ? json['caseStudy']['startYear'].toString()
            : '',
      ),


      levelFocusNode: FocusNode(),
      countryFocusNode: FocusNode(),
      universityFocusNode: FocusNode(),
      otherUniversityFocusNode: FocusNode(),
      majorFocusNode: FocusNode(),
      cgpaFocusNode: FocusNode(),
      graduationStartDateFocusNode: FocusNode(),
      graduationEndDateFocusNode: FocusNode(),
      lastTermFocusNode: FocusNode(),
      caseStudyTitleFocusNode: FocusNode(),
      caseStudyDescriptionFocusNode: FocusNode(),
      caseStudyStartYearFocusNode: FocusNode(),
      currentlyStudying: json['currentlyStudying'].toString() == 'true',
      // isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      isNewController: TextEditingController(text: (json['isNew']?.toString() ?? json['new']?.toString() ?? 'false'),),
      sponsorShipController: TextEditingController(text: json['sponsorShip'] ?? 'no'),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      highestQualification: json['highestQualification'].toString() == 'true',
      showCurrentlyStudying: json['showCurrentlyStudying'].toString() == 'true',
      sponsorShipFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'level': levelController.text,
      'country': countryController.text,
      'university': universityController.text,
      "otherUniversity":otherUniversityController.text,
      'major': majorController.text,
      'cgpa': cgpaController.text,
      'graduationStartDate': graduationStartDateController.text,
      'graduationEndDate': graduationEndDateController.text,
      'lastTerm': lastTermController.text,
      'caseStudy': {
        'title': caseStudyTitleController.text,
        'description': caseStudyDescriptionController.text,
        'startYear': caseStudyStartYearController.text,
      },
      'currentlyStudying': currentlyStudying.toString(),
      'isNew': isNewController.text,
      'new': isNewController.text,
      'sponsorShip': sponsorShipController.text,
      'errorMessage': errorMessageController.text,
      'highestQualification': highestQualification.toString(),
      'showCurrentlyStudying': showCurrentlyStudying.toString(),
    };
  }
}



// required Examinations
class RequiredExaminations {
  // TextEditingControllers for the examination fields
  TextEditingController examinationController;
  TextEditingController examinationTypeIdController;
  TextEditingController examinationGradeController;
  TextEditingController minScoreController;
  TextEditingController maxScoreController;
  TextEditingController examDateController;
  TextEditingController isNewController;
  TextEditingController errorMessageController;
  String? examResult; // Will hold "PASS" or "FAIL"


  // Focus Nodes
  FocusNode examinationFocusNode;
  FocusNode examinationTypeIdFocusNode;
  FocusNode examinationGradeFocusNode;
  FocusNode minScoreFocusNode;
  FocusNode maxScoreFocusNode;
  FocusNode examDateFocusNode;

  // Error Text Variables
  String? examinationError;
  String? examinationTypeIdError;
  String? examinationGradeError;
  String? minScoreError;
  String? maxScoreError;
  String? examDateError;
  String? errorMessageError;

  List<DropdownMenuItem>? examinationTypeDropdown;

  RequiredExaminations({
    required this.examinationController,
    required this.examinationTypeIdController,
    required this.examinationGradeController,
    required this.minScoreController,
    required this.maxScoreController,
    required this.examDateController,
    required this.isNewController,
    required this.errorMessageController,
    this.examResult,
    required this.examinationFocusNode,
    required this.examinationTypeIdFocusNode,
    required this.examinationGradeFocusNode,
    required this.minScoreFocusNode,
    required this.maxScoreFocusNode,
    required this.examDateFocusNode,
    this.examinationError,
    this.examinationTypeIdError,
    this.examinationGradeError,
    this.minScoreError,
    this.maxScoreError,
    this.examDateError,
    this.errorMessageError,
    this.examinationTypeDropdown,
  });

  // From JSON
  factory RequiredExaminations.fromJson(Map<String, dynamic> json) {
    return RequiredExaminations(
      examinationController: TextEditingController(text: json['examination']?.toString() ?? ''),
      examinationTypeIdController: TextEditingController(text: json['examinationTypeId']?.toString() ?? ''),
      examinationGradeController: TextEditingController(text: json['examinationGrade']?.toString() ?? ''),
      minScoreController: TextEditingController(text: json['minScore']?.toString() ?? ''),
      maxScoreController: TextEditingController(text: json['maxScore']?.toString() ?? ''),
      examDateController: TextEditingController(text: formatDateOnly(json['examDate']?.toString() ?? '')),
      // isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      isNewController: TextEditingController(
        text: (json['isNew']?.toString() ?? json['new']?.toString() ?? 'false'),
      ),
      examResult: json['examResult'],
      errorMessageController: TextEditingController(text: json['errorMessage']?.toString() ?? ''),
      examinationFocusNode: FocusNode(),
      examinationTypeIdFocusNode: FocusNode(),
      examinationGradeFocusNode: FocusNode(),
      minScoreFocusNode: FocusNode(),
      maxScoreFocusNode: FocusNode(),
      examDateFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'examination': examinationController.text,
      'examinationTypeId': examinationTypeIdController.text,
      'examinationGrade': examinationGradeController.text,
      'minScore': minScoreController.text,
      'maxScore': maxScoreController.text,
      'examResult': examResult ?? '',
      'examDate': examDateController.text,
      'isNew': isNewController.text,
      'new':isNewController.text,
      'errorMessage': errorMessageController.text,
    };
  }
}

// employment history
class EmploymentHistory {
  // TextEditingControllers for the employment history fields
  TextEditingController employerNameController;
  TextEditingController designationController;
  TextEditingController startDateController;
  TextEditingController endDateController;
  TextEditingController occupationController;
  TextEditingController titleController;
  TextEditingController placeController;
  TextEditingController reportingManagerController;
  TextEditingController contactNumberController;
  TextEditingController contactEmailController;
  TextEditingController isNewController;
  TextEditingController errorMessageController;

  // Focus Nodes
  FocusNode employerNameFocusNode;
  FocusNode designationFocusNode;
  FocusNode startDateFocusNode;
  FocusNode endDateFocusNode;
  FocusNode occupationFocusNode;
  FocusNode titleFocusNode;
  FocusNode placeFocusNode;
  FocusNode reportingManagerFocusNode;
  FocusNode contactNumberFocusNode;
  FocusNode contactEmailFocusNode;

  // Error Text Variables
  String? employerNameError;
  String? designationError;
  String? startDateError;
  String? endDateError;
  String? occupationError;
  String? titleError;
  String? placeError;
  String? reportingManagerError;
  String? contactNumberError;
  String? contactEmailError;
  String? errorMessageError;

  EmploymentHistory({
    required this.employerNameController,
    required this.designationController,
    required this.startDateController,
    required this.endDateController,
    required this.occupationController,
    required this.titleController,
    required this.placeController,
    required this.reportingManagerController,
    required this.contactNumberController,
    required this.contactEmailController,
    required this.isNewController,
    required this.errorMessageController,
    required this.employerNameFocusNode,
    required this.designationFocusNode,
    required this.startDateFocusNode,
    required this.endDateFocusNode,
    required this.occupationFocusNode,
    required this.titleFocusNode,
    required this.placeFocusNode,
    required this.reportingManagerFocusNode,
    required this.contactNumberFocusNode,
    required this.contactEmailFocusNode,
    this.employerNameError,
    this.designationError,
    this.startDateError,
    this.endDateError,
    this.occupationError,
    this.titleError,
    this.placeError,
    this.reportingManagerError,
    this.contactNumberError,
    this.contactEmailError,
    this.errorMessageError,
  });

  // From JSON
  factory EmploymentHistory.fromJson(Map<String, dynamic> json) {

    return EmploymentHistory(
      employerNameController: TextEditingController(text: json['employerName'] ?? ''),
      designationController: TextEditingController(text: json['designation'] ?? ''),
      startDateController: TextEditingController(text: formatDateOnly(json['startDate'].toString()) ?? ''),
      endDateController: TextEditingController(text: formatDateOnly(json['endDate'].toString()) ?? ''),
      occupationController: TextEditingController(text: json['occupation'] ?? ''),
      titleController: TextEditingController(text: json['title'] ?? ''),
      placeController: TextEditingController(text: json['place'] ?? ''),
      reportingManagerController: TextEditingController(text: json['reportingManager'] ?? ''),
      contactNumberController: TextEditingController(text: json['contantNumber'] ?? ''),
      contactEmailController: TextEditingController(text: json['contactEmail'] ?? ''),
      // isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      isNewController: TextEditingController(
        text: (json['isNew']?.toString() ?? json['new']?.toString() ?? 'false'),
      ),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      employerNameFocusNode: FocusNode(),
      designationFocusNode: FocusNode(),
      startDateFocusNode: FocusNode(),
      endDateFocusNode: FocusNode(),
      occupationFocusNode: FocusNode(),
      titleFocusNode: FocusNode(),
      placeFocusNode: FocusNode(),
      reportingManagerFocusNode: FocusNode(),
      contactNumberFocusNode: FocusNode(),
      contactEmailFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'employerName': employerNameController.text,
      'designation': designationController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'occupation': occupationController.text,
      'title': titleController.text,
      'place': placeController.text,
      'reportingManager': reportingManagerController.text,
      'contantNumber': contactNumberController.text,
      'contactEmail': contactEmailController.text,
      'isNew': isNewController.text,
      'new': isNewController.text,
      'errorMessage': errorMessageController.text,
    };
  }
}

// attachments
class MajorWishList {
  // TextEditingControllers for the major wishlist fields
  TextEditingController majorController;
  TextEditingController otherMajorController;
  TextEditingController errorMessageController;
  TextEditingController isNewController;
  TextEditingController? sequenceNumberController;

  // Focus Nodes
  FocusNode majorFocusNode;
  FocusNode otherMajorFocusNode;
  FocusNode errorMessageFocusNode;
  FocusNode isNewFocusNode;

  // Error Text Variables
  String? majorError;
  String? otherMajorError;
  String? errorMessageError;
  String? isNewError;

  MajorWishList({
    required this.majorController,
    required this.otherMajorController,
    required this.errorMessageController,
    required this.isNewController,
    required this.majorFocusNode,
    required this.otherMajorFocusNode,
    required this.errorMessageFocusNode,
    required this.isNewFocusNode,
    this.sequenceNumberController,
    this.majorError,
    this.otherMajorError,
    this.errorMessageError,
    this.isNewError,

  });

  // From JSON
  factory MajorWishList.fromJson(Map<String, dynamic> json) {
    return MajorWishList(
      majorController: TextEditingController(text: json['major'] ?? ''),
      otherMajorController: TextEditingController(text: json['otherMajor'] ?? ''),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      // isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      isNewController: TextEditingController(
        text: (json['isNew']?.toString()?.trim().isNotEmpty == true
            ? json['isNew'].toString()
            : json['new']?.toString()?.trim().isNotEmpty == true
            ? json['new'].toString()
            : 'false'),
      ),
      sequenceNumberController: TextEditingController(text: json['sequenceNumber'] ?? ''),
      majorFocusNode: FocusNode(),
      otherMajorFocusNode: FocusNode(),
      errorMessageFocusNode: FocusNode(),
      isNewFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'major': majorController.text,
      'otherMajor': otherMajorController.text,
      'errorMessage': errorMessageController.text,
      'isNew': isNewController.text,
      'new': isNewController.text,
    };
  }
  // To JSON
  Map<String, dynamic> editMajorsListToJson() {
    return {
      'major': majorController.text,
      'otherMajor': otherMajorController.text,
      'errorMessage': errorMessageController.text,
      'sequenceNumber': sequenceNumberController?.text ?? '',
      'new': isNewController.text,
    };
  }
}

// university priority list
class UniversityPriority {
  // TextEditingControllers for each field
  TextEditingController countryIdController;
  TextEditingController universityIdController;
  TextEditingController otherUniversityNameController;
  TextEditingController majorsController;
  TextEditingController otherMajorsController;
  TextEditingController? sequenceNumberController;



  TextEditingController statusController;
  TextEditingController errorMessageController;
  TextEditingController isNewController;


  TextEditingController startDateController;
  TextEditingController endDateController;

  // Focus Nodes
  FocusNode countryIdFocusNode;
  FocusNode universityIdFocusNode;
  FocusNode otherUniversityNameFocusNode;
  FocusNode majorsFocusNode;
  FocusNode otherMajorsFocusNode;
  FocusNode statusFocusNode;


  FocusNode startDateFocusNode;
  FocusNode endDateFocusNode;



  // Error Text Variables
  String? countryIdError;
  String? universityIdError;
  String? otherUniversityNameError;
  String? majorsError;
  String? otherMajorsError;
  String? statusError;
  String? errorMessageError;
  String? startDateError;
  String? endDateError;


  List<DropdownMenuItem>? universityDropdown;


  UniversityPriority({
    required this.countryIdController,
    required this.universityIdController,
    required this.otherUniversityNameController,
    required this.majorsController,
    required this.otherMajorsController,
    required this.statusController,
    required this.errorMessageController,
    required this.startDateController,
    required this.endDateController,
    required this.isNewController,
    required this.countryIdFocusNode,
    required this.universityIdFocusNode,
    required this.otherUniversityNameFocusNode,
    required this.majorsFocusNode,
    required this.otherMajorsFocusNode,
    required this.statusFocusNode,
    required this.startDateFocusNode,
    required this.endDateFocusNode,
    this.sequenceNumberController,
    this.countryIdError,
    this.universityIdError,
    this.otherUniversityNameError,
    this.majorsError,
    this.otherMajorsError,
    this.statusError,
    this.errorMessageError,
    this.universityDropdown,

  });

  // From JSON
  factory UniversityPriority.fromJson(Map<String, dynamic> json) {
    return UniversityPriority(
      countryIdController: TextEditingController(text: json['countryId'] ?? ''),
      universityIdController: TextEditingController(text: json['universityId'] ?? ''),
      otherUniversityNameController: TextEditingController(text: json['otherUniversityName'] ?? ''),
      majorsController: TextEditingController(text: json['majors'] ?? ''),
      otherMajorsController: TextEditingController(text: json['otherMajor'] ?? ''),
      statusController: TextEditingController(text: json['status'] ?? ''),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      // isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      isNewController: TextEditingController(text: (json['isNew']?.toString() ?? json['new']?.toString() ?? 'false'),),
      sequenceNumberController: TextEditingController(text: json['sequenceNumber'] ?? ''),


      startDateController: TextEditingController(text:  formatDateOnly(json['startDate'].toString()) ?? ''),
      endDateController: TextEditingController(text: formatDateOnly(json['endDate'].toString()) ?? ''),






      countryIdFocusNode: FocusNode(),
      universityIdFocusNode: FocusNode(),
      otherUniversityNameFocusNode: FocusNode(),
      majorsFocusNode: FocusNode(),
      otherMajorsFocusNode: FocusNode(),
      statusFocusNode: FocusNode(),
      startDateFocusNode: FocusNode(),
      endDateFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'countryId': countryIdController.text,
      'universityId': universityIdController.text,
      'otherUniversityName': otherUniversityNameController.text,
      'majors': majorsController.text,
      'otherMajor': otherMajorsController.text,
      'status': statusController.text,
      'errorMessage': errorMessageController.text,
      'isNew': isNewController.text,
      'new': isNewController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
    };
  }
  // To JSON
  Map<String, dynamic> editUniversityListToJson() {
    return {
      'countryId': countryIdController.text,
      'universityId': universityIdController.text,
      'otherUniversityName': otherUniversityNameController.text,
      'majors': majorsController.text,
      'otherMajor': otherMajorsController.text,
      'status': statusController.text,
      'errorMessage': errorMessageController.text,
      'sequenceNumber': sequenceNumberController?.text ?? '',
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'new': isNewController.text,
    };
  }
}






class Attachment {
  // TextEditingControllers for the attachment fields
  final TextEditingController processCdController;
  final TextEditingController documentCdController;
  final TextEditingController userFileNameController;
  final TextEditingController commentController;
  final TextEditingController requiredController;
  final TextEditingController fileUploadedController;
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController errorMessageController;
  final TextEditingController supportedFileTypeController;
  final TextEditingController maxFileSizeController;
  final TextEditingController attachmentNameController;
  final TextEditingController applicationDetailIdController;
  final TextEditingController emiratesIdController;
  final TextEditingController isApprovedController;
  final TextEditingController fileIdController;
  final TextEditingController fileTypeController;
  final TextEditingController newFileController;
  final TextEditingController applictantIdController;
  final TextEditingController descriptionController;
  final TextEditingController base64StringController;

   TextEditingController? emplIdController;
   TextEditingController? applicationNumberController;

  // Focus Nodes
  final FocusNode processCdFocusNode;
  final FocusNode documentCdFocusNode;
  final FocusNode userFileNameFocusNode;
  final FocusNode commentFocusNode;
  final FocusNode requiredFocusNode;
  final FocusNode fileUploadedFocusNode;
  final FocusNode heightFocusNode;
  final FocusNode widthFocusNode;
  final FocusNode errorMessageFocusNode;
  final FocusNode supportedFileTypeFocusNode;
  final FocusNode maxFileSizeFocusNode;
  final FocusNode attachmentNameFocusNode;
  final FocusNode applicationDetailIdFocusNode;
  final FocusNode emiratesIdFocusNode;
  final FocusNode isApprovedFocusNode;
  final FocusNode fileIdFocusNode;
  final FocusNode fileTypeFocusNode;
  final FocusNode newFileFocusNode;
  final FocusNode applictantIdFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode base64StringFocusNode;

  // Error Text Variables
  String? processCdError;
  String? documentCdError;
  String? userFileNameError;
  String? commentError;
  String? requiredError;
  String? fileUploadedError;
  String? heightError;
  String? widthError;
  String? errorMessageError;
  String? supportedFileTypeError;
  String? maxFileSizeError;
  String? attachmentNameError;
  String? applicationDetailIdError;
  String? emiratesIdError;
  String? isApprovedError;
  String? fileIdError;
  String? fileTypeError;
  String? newFileError;
  String? applictantIdError;
  String? descriptionError;
  String? base64StringError;

  bool toUpdateApprovedAttachment = false;
  bool toUploadApprovedAttachment = false;

  Attachment({
    required this.processCdController,
    required this.documentCdController,
    required this.userFileNameController,
    required this.commentController,
    required this.requiredController,
    required this.fileUploadedController,
    required this.heightController,
    required this.widthController,
    required this.errorMessageController,
    required this.supportedFileTypeController,
    required this.maxFileSizeController,
    required this.attachmentNameController,
    required this.applicationDetailIdController,
    required this.emiratesIdController,
    required this.isApprovedController,
    required this.fileIdController,
    required this.fileTypeController,
    required this.newFileController,
    required this.applictantIdController,
    required this.descriptionController,
    required this.base64StringController,
    required this.processCdFocusNode,
    required this.documentCdFocusNode,
    required this.userFileNameFocusNode,
    required this.commentFocusNode,
    required this.requiredFocusNode,
    required this.fileUploadedFocusNode,
    required this.heightFocusNode,
    required this.widthFocusNode,
    required this.errorMessageFocusNode,
    required this.supportedFileTypeFocusNode,
    required this.maxFileSizeFocusNode,
    required this.attachmentNameFocusNode,
    required this.applicationDetailIdFocusNode,
    required this.emiratesIdFocusNode,
    required this.isApprovedFocusNode,
    required this.fileIdFocusNode,
    required this.fileTypeFocusNode,
    required this.newFileFocusNode,
    required this.applictantIdFocusNode,
    required this.descriptionFocusNode,
    required this.base64StringFocusNode,
    this.processCdError,
    this.documentCdError,
    this.userFileNameError,
    this.commentError,
    this.requiredError,
    this.fileUploadedError,
    this.heightError,
    this.widthError,
    this.errorMessageError,
    this.supportedFileTypeError,
    this.maxFileSizeError,
    this.attachmentNameError,
    this.applicationDetailIdError,
    this.emiratesIdError,
    this.isApprovedError,
    this.fileIdError,
    this.fileTypeError,
    this.newFileError,
    this.applictantIdError,
    this.descriptionError,
    this.base64StringError,
    this.emplIdController,
    this.applicationNumberController,
  });

  // From JSON
  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      processCdController: TextEditingController(text: json['processCD'] ?? ''),
      documentCdController: TextEditingController(text: json['documentCD'] ?? ''),
      userFileNameController: TextEditingController(text: json['userFileName'] ?? ''),
      commentController: TextEditingController(text: json['comment'] ?? ''),
      requiredController: TextEditingController(text: json['required'] ?? ''),
      fileUploadedController: TextEditingController(text: json['fileUploaded']?.toString() ?? 'false'),
      heightController: TextEditingController(text: json['height']?.toString() ?? '0'),
      widthController: TextEditingController(text: json['width']?.toString() ?? '0'),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      supportedFileTypeController: TextEditingController(text: json['supportedFileType'] ?? ''),
      maxFileSizeController: TextEditingController(text: json['maxFileSize']?.toString() ?? '0'),
      // attachmentNameController: TextEditingController(text: json['attachmentName'] ?? "" ),
      attachmentNameController: TextEditingController(text: json['attachmentName'] ?? "${json['processCD'] ?? ''}:${json['documentCD'] ?? ''}"),
      applicationDetailIdController: TextEditingController(text: json['applicationDetailId'] ?? ''),
      emiratesIdController: TextEditingController(text: json['emiratesId'] ?? ''),
      isApprovedController: TextEditingController(text: json['isApproved']?.toString() ?? 'false'),
      fileIdController: TextEditingController(text: json['fileId'] ?? ''),
      fileTypeController: TextEditingController(text: json['fileType'] ?? ''),
      newFileController: TextEditingController(text: json['newFile']?.toString() ?? 'false'),
      applictantIdController: TextEditingController(text: json['applictantId'] ?? ''),
      descriptionController: TextEditingController(text: json['description'] ?? ''),
      base64StringController: TextEditingController(text: json['base64String'] ?? ''),
      processCdFocusNode: FocusNode(),
      documentCdFocusNode: FocusNode(),
      userFileNameFocusNode: FocusNode(),
      commentFocusNode: FocusNode(),
      requiredFocusNode: FocusNode(),
      fileUploadedFocusNode: FocusNode(),
      heightFocusNode: FocusNode(),
      widthFocusNode: FocusNode(),
      errorMessageFocusNode: FocusNode(),
      supportedFileTypeFocusNode: FocusNode(),
      maxFileSizeFocusNode: FocusNode(),
      attachmentNameFocusNode: FocusNode(),
      applicationDetailIdFocusNode: FocusNode(),
      emiratesIdFocusNode: FocusNode(),
      isApprovedFocusNode: FocusNode(),
      fileIdFocusNode: FocusNode(),
      fileTypeFocusNode: FocusNode(),
      newFileFocusNode: FocusNode(),
      applictantIdFocusNode: FocusNode(),
      descriptionFocusNode: FocusNode(),
      base64StringFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'processCD': processCdController.text,
      'documentCD': documentCdController.text,
      'userFileName': userFileNameController.text,
      'comment': commentController.text,
      'required': requiredController.text,
      'fileUploaded': fileUploadedController.text,
      'height': heightController.text,
      'width': widthController.text,
      'errorMessage': errorMessageController.text,
      'supportedFileType': supportedFileTypeController.text,
      'maxFileSize': maxFileSizeController.text,
      'attachmentName': attachmentNameController.text,
      'applicationDetailId': applicationDetailIdController.text,
      'emiratesId': emiratesIdController.text,
      'isApproved': isApprovedController.text,
      'fileId': fileIdController.text,
      'fileType': fileTypeController.text,
      'newFile': newFileController.text,
      'applictantId': applictantIdController.text,
      'description': descriptionController.text,
      'base64String': base64StringController.text,
    };
  }
  // To update attachment
  Map<String, dynamic> updateAttachmentToJson() {
    return {
      "processCD": processCdController.text,
      "documentCD": documentCdController.text,
      "description": descriptionController.text,
      "userFileName": userFileNameController.text,
      "comment": commentController.text,
      "emplId": emplIdController?.text ?? '',
      "applicationNo":applicationNumberController?.text ?? '',
      "base64String": base64StringController.text
    };
  }

  // To upload attachment
  Map<String, dynamic> uploadAttachmentToJson() {
    return {
      "processCD": processCdController.text,
      "documentCD": documentCdController.text,
      "description": descriptionController.text,
      "userFileName": userFileNameController.text,
      "comment": commentController.text,
      "base64String": base64StringController.text
    };
  }



}



