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

// phone number
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
          TextEditingController(text: json['yearOfPassing'].toString()),
      hsTypeController: TextEditingController(text: json['hsType'].toString()),
      curriculumTypeController:
          TextEditingController(text: json['curriculumType'].toString()),
      curriculumAverageController:
          TextEditingController(text: json['curriculumAverage'].toString()),
      otherHsNameController:
          TextEditingController(text: json['otherHsName'].toString()),
      passingYearController:
          TextEditingController(text: json['passingYear'].toString()),
      maxDateController:
          TextEditingController(text: json['maxDate'].toString()),
      disableStateController:
          TextEditingController(text: json['disableState'].toString()),
      isNewController: TextEditingController(text: json['isNew'].toString()),
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
      hsDetails: (json['hsDetails'] as List)
          .map((e) => HSDetails.fromJson(e))
          .toList(),
      otherHSDetails: (json['otherHSDetails'] as List)
          .map((e) => HSDetails.fromJson(e))
          .toList(),
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
      'passingYear': passingYearController.text,
      'maxDate': maxDateController.text,
      'disableState': disableStateController.text,
      'isNew': isNewController.text,
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
  TextEditingController? otherSubjectNameController;

  FocusNode subjectTypeFocusNode;
  FocusNode gradeFocusNode;
  FocusNode? otherSubjectNameFocusNode;

  String? subjectTypeError;
  String? gradeError;
  String? otherSubjectNameError;

  HSDetails({
    required this.subjectTypeController,
    required this.gradeController,
    this.otherSubjectNameController,
    required this.subjectTypeFocusNode,
    required this.gradeFocusNode,
    this.otherSubjectNameFocusNode,
    this.subjectTypeError,
    this.gradeError,
    this.otherSubjectNameError,
  });

  // From JSON
  factory HSDetails.fromJson(Map<String, dynamic> json) {
    return HSDetails(
      subjectTypeController:
          TextEditingController(text: json['subjectType'].toString()),
      gradeController: TextEditingController(text: json['grade'].toString()),
      otherSubjectNameController: json['otherSubjectName'] != null
          ? TextEditingController(text: json['otherSubjectName'].toString())
          : null,
      subjectTypeFocusNode: FocusNode(),
      gradeFocusNode: FocusNode(),
      otherSubjectNameFocusNode:
          json['otherSubjectName'] != null ? FocusNode() : null,
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
          TextEditingController(text: json['countryUniversity']),
      relationTypeController: TextEditingController(text: json['relationType']),
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
      'countryUniversity': countryUniversityController.text,
      'relationType': relationTypeController.text,
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

  // New property
  bool currentlyStudying;


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
      graduationStartDateController: TextEditingController(text: json['graduationStartDate'] ?? ''),
      graduationEndDateController: TextEditingController(text: json['graduationEndDate'] ?? ''),
      lastTermController: TextEditingController(text: json['lastTerm'] ?? ''),
      caseStudyTitleController: TextEditingController(text: json['caseStudy']?['title'] ?? ''),
      caseStudyDescriptionController: TextEditingController(text: json['caseStudy']?['description'] ?? ''),
      caseStudyStartYearController: TextEditingController(text: json['caseStudy']?['startYear'] ?? ''),
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
      currentlyStudying: json['currentlyStudying'] == 'true',
      isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      sponsorShipController: TextEditingController(text: json['sponsorShip'] ?? 'no'),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      highestQualification: json['highestQualification'] == 'true',
      showCurrentlyStudying: json['showCurrentlyStudying'] == 'true',
      sponsorShipFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'level': levelController.text,
      'country': countryController.text,
      'university': universityController.text,
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
      examinationController: TextEditingController(text: json['examination'] ?? ''),
      examinationTypeIdController: TextEditingController(text: json['examinationTypeId'] ?? ''),
      examinationGradeController: TextEditingController(text: json['examinationGrade'] ?? ''),
      minScoreController: TextEditingController(text: json['minScore'] ?? ''),
      maxScoreController: TextEditingController(text: json['maxScore'] ?? ''),
      examDateController: TextEditingController(text: json['examDate'] ?? ''),
      isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
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
      'examDate': examDateController.text,
      'isNew': isNewController.text,
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
      startDateController: TextEditingController(text: json['startDate'] ?? ''),
      endDateController: TextEditingController(text: json['endDate'] ?? ''),
      occupationController: TextEditingController(text: json['occupation'] ?? ''),
      titleController: TextEditingController(text: json['title'] ?? ''),
      placeController: TextEditingController(text: json['place'] ?? ''),
      reportingManagerController: TextEditingController(text: json['reportingManager'] ?? ''),
      contactNumberController: TextEditingController(text: json['contactNumber'] ?? ''),
      contactEmailController: TextEditingController(text: json['contactEmail'] ?? ''),
      isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
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
      'contactNumber': contactNumberController.text,
      'contactEmail': contactEmailController.text,
      'isNew': isNewController.text,
      'errorMessage': errorMessageController.text,
    };
  }
}

// attachments
class MajorWishList {
  // TextEditingControllers for the major wishlist fields
  TextEditingController majorController;
  TextEditingController errorMessageController;
  TextEditingController isNewController;

  // Focus Nodes
  FocusNode majorFocusNode;
  FocusNode errorMessageFocusNode;
  FocusNode isNewFocusNode;

  // Error Text Variables
  String? majorError;
  String? errorMessageError;
  String? isNewError;

  MajorWishList({
    required this.majorController,
    required this.errorMessageController,
    required this.isNewController,
    required this.majorFocusNode,
    required this.errorMessageFocusNode,
    required this.isNewFocusNode,
    this.majorError,
    this.errorMessageError,
    this.isNewError,
  });

  // From JSON
  factory MajorWishList.fromJson(Map<String, dynamic> json) {
    return MajorWishList(
      majorController: TextEditingController(text: json['major'] ?? ''),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      majorFocusNode: FocusNode(),
      errorMessageFocusNode: FocusNode(),
      isNewFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'major': majorController.text,
      'errorMessage': errorMessageController.text,
      'isNew': isNewController.text,
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

  TextEditingController statusController;
  TextEditingController errorMessageController;
  TextEditingController isNewController;

  // Focus Nodes
  FocusNode countryIdFocusNode;
  FocusNode universityIdFocusNode;
  FocusNode otherUniversityNameFocusNode;
  FocusNode majorsFocusNode;
  FocusNode otherMajorsFocusNode;
  FocusNode statusFocusNode;

  // Error Text Variables
  String? countryIdError;
  String? universityIdError;
  String? otherUniversityNameError;
  String? majorsError;
  String? otherMajorsError;
  String? statusError;
  String? errorMessageError;


  List<DropdownMenuItem>? universityDropdown;


  UniversityPriority({
    required this.countryIdController,
    required this.universityIdController,
    required this.otherUniversityNameController,
    required this.majorsController,
    required this.otherMajorsController,
    required this.statusController,
    required this.errorMessageController,
    required this.isNewController,
    required this.countryIdFocusNode,
    required this.universityIdFocusNode,
    required this.otherUniversityNameFocusNode,
    required this.majorsFocusNode,
    required this.otherMajorsFocusNode,
    required this.statusFocusNode,
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
      otherMajorsController: TextEditingController(text: json['otherMajors'] ?? ''),
      statusController: TextEditingController(text: json['status'] ?? ''),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
      isNewController: TextEditingController(text: json['isNew']?.toString() ?? 'false'),
      countryIdFocusNode: FocusNode(),
      universityIdFocusNode: FocusNode(),
      otherUniversityNameFocusNode: FocusNode(),
      majorsFocusNode: FocusNode(),
      otherMajorsFocusNode: FocusNode(),
      statusFocusNode: FocusNode(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'countryId': countryIdController.text,
      'universityId': universityIdController.text,
      'otherUniversityName': otherUniversityNameController.text,
      'majors': majorsController.text,
      'otherMajors': otherMajorsController.text,
      'status': statusController.text,
      'errorMessage': errorMessageController.text,
      'isNew': isNewController.text,
    };
  }
}



class Attachment {
  // TextEditingControllers for the attachment fields
  TextEditingController processCDController;
  TextEditingController documentCDController;
  TextEditingController descriptionController;
  TextEditingController userFileNameController;
  TextEditingController commentController;
  TextEditingController base64StringController;
  TextEditingController errorMessageController;



  Attachment({
    required this.processCDController,
    required this.documentCDController,
    required this.descriptionController,
    required this.userFileNameController,
    required this.commentController,
    required this.base64StringController,
    required this.errorMessageController,

  });

  // From JSON
  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      processCDController: TextEditingController(text: json['processCD'] ?? ''),
      documentCDController: TextEditingController(text: json['documentCD'] ?? ''),
      descriptionController: TextEditingController(text: json['description'] ?? ''),
      userFileNameController: TextEditingController(text: json['userFileName'] ?? ''),
      commentController: TextEditingController(text: json['commnet'] ?? ''),  // Assuming typo in API
      base64StringController: TextEditingController(text: json['base64String'] ?? ''),
      errorMessageController: TextEditingController(text: json['errorMessage'] ?? ''),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'processCD': processCDController.text,
      'documentCD': documentCDController.text,
      'description': descriptionController.text,
      'userFileName': userFileNameController.text,
      'commnet': commentController.text,  // Keeping the typo in "commnet"
      'base64String': base64StringController.text,
      'errorMessage': errorMessageController.text,
    };
  }
}






Map<String, dynamic> highSchoolJsonList = {
  "highSchoolList": [
    {
      "hsLevel": "1",
      "hsName": "OTH",
      "hsCountry": "ARE",
      "hsState": "ALN",
      "yearOfPassing": "2024-09-27 00:00:00.0 UTC",
      "hsType": "PRI",
      "curriculumType": "GERM",
      "curriculumAverage": "12",
      "otherHsName": "asd",
      "disableState": "false",
      "hsDetails": [
        {"subjectType": "BIO", "grade": ""},
        {"subjectType": "CHEM", "grade": ""},
        {"subjectType": "ECO", "grade": ""},
        {"subjectType": "ENG", "grade": ""},
        {"subjectType": "GS", "grade": ""},
        {"subjectType": "HS", "grade": ""},
        {"subjectType": "MATH", "grade": ""},
        {"subjectType": "PHY", "grade": ""},
        {"subjectType": "SCI", "grade": ""}
      ],
      "otherHSDetails": [
        {"subjectType": "OTH1", "grade": ""},
        {"subjectType": "OTH2", "grade": ""},
        {"subjectType": "OTH3", "grade": ""},
        {"subjectType": "OTH4", "grade": ""},
        {"subjectType": "OTH5", "grade": ""}
      ],
      "isNew": "true",
      "highestQualification": "false",
      "passingYear": "2024-2025",
      "maxDate": "2025-09-27 12:02:48.20 UTC"
    },
    {
      "hsLevel": "3",
      "hsCountry": "ARE",
      "disableState": "false",
      "hsDetails": [
        {"subjectType": "BIO", "grade": ""},
        {"subjectType": "CHEM", "grade": ""},
        {"subjectType": "ECO", "grade": ""},
        {"subjectType": "ENG", "grade": ""},
        {"subjectType": "GS", "grade": ""},
        {"subjectType": "HS", "grade": ""},
        {"subjectType": "MATH", "grade": ""},
        {"subjectType": "PHY", "grade": ""},
        {"subjectType": "SCI", "grade": ""}
      ],
      "otherHSDetails": [
        {"subjectType": "OTH1", "grade": ""},
        {"subjectType": "OTH2", "grade": ""},
        {"subjectType": "OTH3", "grade": ""},
        {"subjectType": "OTH4", "grade": ""},
        {"subjectType": "OTH5", "grade": ""}
      ],
      "isNew": "true",
      "highestQualification": "false",
      "maxDate": "2025-09-27 12:02:48.21 UTC"
    }
  ]
};




 String draftString =   "<com.mopa.sco.application.ApplicationData>  <acadCareer>UGRD</acadCareer>  <AdmApplicationNumber>00000000</AdmApplicationNumber>  <institution>SCO</institution>  <admApplCtr>AD</admApplCtr>  <admitType>ONL</admitType>  <admitTerm>2457</admitTerm>  <citizenship>ARE</citizenship>  <country>ABW</country>  <acadProgram>SCO-U</acadProgram>  <acadProgramDds></acadProgramDds>  <acadProgramPgrd></acadProgramPgrd>  <programStatus>AP</programStatus>  <programAction>APPL</programAction>  <acadLoadAppr>F</acadLoadAppr>  <campus>AD</campus>  <acadPlan>SCO-U</acadPlan>  <errorMessage></errorMessage>  <nameAsPasport>    <com.mopa.sco.application.NameAsPassport>      <nameType>PRI</nameType>      <studentName>أبهاي</studentName>      <fatherName>أبهاي</fatherName>      <grandFatherName>أبهاي</grandFatherName>      <familyName>أبهاي</familyName>    </com.mopa.sco.application.NameAsPassport>    <com.mopa.sco.application.NameAsPassport>      <nameType>ENG</nameType>      <studentName>Test</studentName>      <fatherName>Test</fatherName>      <grandFatherName>Test</grandFatherName>      <familyName>Test</familyName>    </com.mopa.sco.application.NameAsPassport>  </nameAsPasport>  <dateOfBirth>2003-09-11 00:00:00.0 UTC</dateOfBirth>  <placeOfBirth>fsdfdsf</placeOfBirth>  <gender>M</gender>  <maritalStatus>M</maritalStatus>  <emailId>test1@hotmail.com</emailId>  <passportId>2342322</passportId>  <passportExpiryDate>2024-09-19 00:00:00.0 UTC</passportExpiryDate>  <passportIssueDate>2016-09-16 00:00:00.0 UTC</passportIssueDate>  <passportIssuePlace>fsdfdsf</passportIssuePlace>  <unifiedNo>24334243243243</unifiedNo>  <emirateId>784200479031062</emirateId>  <relativeStudyinScholarship>false</relativeStudyinScholarship>  <uaeMother>true</uaeMother>  <scholarshipType>INT</scholarshipType>  <cohortId>2024</cohortId>  <scholarshipSubmissionCode>SCOUGRDINT</scholarshipSubmissionCode>  <emirateIdExpiryDate>2024-09-11 00:00:00.0 UTC</emirateIdExpiryDate>  <maxCountUniversity>0</maxCountUniversity>  <maxCountMajors>0</maxCountMajors>  <militaryService>N</militaryService>  <phoneNunbers>    <com.mopa.sco.application.PhoneNumber>      <countryCode>971</countryCode>      <phoneNumber>12323456789</phoneNumber>      <phoneType>CELL</phoneType>      <prefered>true</prefered>      <isExisting>false</isExisting>    </com.mopa.sco.application.PhoneNumber>    <com.mopa.sco.application.PhoneNumber>      <countryCode>971</countryCode>      <phoneNumber>24343432423</phoneNumber>      <phoneType>GRD</phoneType>      <prefered>false</prefered>      <isExisting>false</isExisting>    </com.mopa.sco.application.PhoneNumber>  </phoneNunbers>  <graduationList>    <com.mopa.sco.application.GraduationBean>      <country>ARE</country>      <isNew>true</isNew>      <currentlyStudying>false</currentlyStudying>      <highestQualification>false</highestQualification>      <showCurrentlyStudying>true</showCurrentlyStudying>      <caseStudy/>    </com.mopa.sco.application.GraduationBean>  </graduationList>  <universtiesPriorityList>    <com.mopa.sco.application.UniverstiesPriority>      <countryId>ARE</countryId>      <isNew>true</isNew>    </com.mopa.sco.application.UniverstiesPriority>  </universtiesPriorityList>  <requiredExaminationList>    <com.mopa.sco.application.RequiredExamination>      <minScore>0</minScore>      <maxScore>0</maxScore>      <isNew>true</isNew>    </com.mopa.sco.application.RequiredExamination>  </requiredExaminationList>  <addressList>    <com.mopa.sco.application.Address>      <addressType>CAMP</addressType>      <addressLine1>sfsdfsd</addressLine1>      <addressLine2>fsdfdsf</addressLine2>      <city>fsdfsdf</city>      <country>ABW</country>      <postalCode>234234</postalCode>      <disableState>true</disableState>      <isExisting>false</isExisting>    </com.mopa.sco.application.Address>  </addressList>  <highSchoolList>    <com.mopa.sco.application.HighSchoolInfoBean>      <hsLevel>1</hsLevel>      <hsName>OTH</hsName>      <hsCountry>ARE</hsCountry>      <hsState>ALN</hsState>      <yearOfPassing>2024-09-27 00:00:00.0 UTC</yearOfPassing>      <hsType>PRI</hsType>      <curriculumType>GERM</curriculumType>      <curriculumAverage>12</curriculumAverage>      <otherHsName>asd</otherHsName>      <disableState>false</disableState>      <hsDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>BIO</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>CHEM</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>ECO</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>ENG</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>GS</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>HS</subjectType>          <grade>10</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>MATH</subjectType>          <grade>A+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>PHY</subjectType>          <grade>A+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>SCI</subjectType>          <grade>A+</grade>        </com.mopa.sco.application.HSDetails>      </hsDetails>      <otherHSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH1</subjectType>          <grade>10</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH2</subjectType>          <grade>10</grade>          <otherSubjectName>name 2</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH3</subjectType>          <grade>10</grade>          <otherSubjectName>name 3</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH4</subjectType>          <grade>10</grade>          <otherSubjectName>name 4</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH5</subjectType>          <grade></grade>          <otherSubjectName>name 5</otherSubjectName>        </com.mopa.sco.application.HSDetails>      </otherHSDetails>      <isNew>true</isNew>      <highestQualification>false</highestQualification>      <passignYear>2024-2025</passignYear>      <maxDate>2025-09-30 05:53:44.774 UTC</maxDate>    </com.mopa.sco.application.HighSchoolInfoBean>    <com.mopa.sco.application.HighSchoolInfoBean>      <hsLevel>3</hsLevel>      <hsCountry>AFG</hsCountry>      <disableState>false</disableState>      <hsDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>BIO</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>CHEM</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>ECO</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>ENG</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>GS</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>HS</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>MATH</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>PHY</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>SCI</subjectType>          <grade>B+</grade>        </com.mopa.sco.application.HSDetails>      </hsDetails>      <otherHSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH1</subjectType>          <grade>A+</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH2</subjectType>          <grade>A+</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH3</subjectType>          <grade>A+</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH4</subjectType>          <grade>A+</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>        <com.mopa.sco.application.HSDetails>          <subjectType>OTH5</subjectType>          <grade>A+</grade>          <otherSubjectName>name 1</otherSubjectName>        </com.mopa.sco.application.HSDetails>      </otherHSDetails>      <isNew>true</isNew>      <highestQualification>false</highestQualification>      <maxDate>2025-09-30 05:53:44.776 UTC</maxDate>    </com.mopa.sco.application.HighSchoolInfoBean>  </highSchoolList>  <emplymentHistory>    <com.mopa.sco.application.EmployementHistory>      <isNew>true</isNew>    </com.mopa.sco.application.EmployementHistory>  </emplymentHistory>  <majorWishList>    <com.mopa.sco.application.MajorWishListItem>      <isNew>true</isNew>    </com.mopa.sco.application.MajorWishListItem>    <com.mopa.sco.application.MajorWishListItem>      <isNew>true</isNew>    </com.mopa.sco.application.MajorWishListItem>    <com.mopa.sco.application.MajorWishListItem>      <isNew>true</isNew>    </com.mopa.sco.application.MajorWishListItem>  </majorWishList>  <relativeDetails>    <com.mopa.sco.application.RelativeDetail/>  </relativeDetails>  <attachments>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL073</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL073</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file23</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL074</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL074</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file24</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL002</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL002</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file25</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL006</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.jpeg|.jpg|.JPEG|.JPG</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL006</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file26</fileId>      <fileType>1</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL019</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL019</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file27</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL023</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL023</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file28</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL018</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL018</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file29</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL004</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL004</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file30</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL014</documentCD>      <required>XMRL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL014</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file31</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL015</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL015</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file32</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL047</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL047</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file33</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL082</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL082</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file34</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL001</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL001</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file35</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>UNVADM</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:UNVADM</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file36</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL009</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL009</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file37</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL058</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL058</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file38</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL053</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL053</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file39</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL063</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL063</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file40</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL030</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL030</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file41</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL064</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL064</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file42</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL065</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL065</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file43</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL075</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL075</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file44</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>    <com.mopa.sco.bean.AttachmentBean>      <processCD>UGUAE</processCD>      <documentCD>SEL043</documentCD>      <required>XOPL</required>      <fileUploaded>false</fileUploaded>      <height>0</height>      <width>0</width>      <supportedFileType>.pdf|.PDF</supportedFileType>      <maxFileSize>5242880</maxFileSize>      <attachmentName>UGUAE:SEL043</attachmentName>      <applictionDetailId>0</applictionDetailId>      <emiratesId>784200479031062</emiratesId>      <isApproved>false</isApproved>      <fileId>file64</fileId>      <fileType>2</fileType>      <newFile>true</newFile>    </com.mopa.sco.bean.AttachmentBean>  </attachments>  <studyCountry>true</studyCountry>  <employmentStatus>N</employmentStatus></com.mopa.sco.application.ApplicationData>";