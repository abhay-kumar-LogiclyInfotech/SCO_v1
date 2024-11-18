import 'dart:convert';

import 'package:flutter/material.dart';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"errorMessage":null,"status":"FAILED","employmentStatus":{"emplId":"000921","sequanceNumber":"1","employmentStatus":"NWR","university":"00016148","currentFlag":"Y","comment":"%COMMENTS%","listOfFiles":[{"attachmentSeqNumber":"1","description":"","date":1731906293813,"attachSysfileName":"20230110172609443_IRCTC Next Generation eTicketing System.pdf","attachUserFile":"IRCTC Next Generation eTicketing System.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"Aera","date":1731906293813,"attachSysfileName":"20231215144549577_Screenshot_20231215_150820.jpg","attachUserFile":"Screenshot_20231215_150820.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"3","description":"Tested","date":1731906293813,"attachSysfileName":"20240425104159035_IMG-20240425-WA0035.jpg","attachUserFile":"IMG-20240425-WA0035.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"4","description":"Tested 1234","date":1731906293813,"attachSysfileName":"20240425105159106_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"5","description":"Tesds cdswaa vddsa fddsa","date":1731906293813,"attachSysfileName":"20240425105528591_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"7","description":"Now testwd","date":1731906293813,"attachSysfileName":"20240425113756450_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"8","description":"Tested1","date":1731906293813,"attachSysfileName":"20240425114346399_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"9","description":"Tested12222","date":1731906293813,"attachSysfileName":"20240425114444900_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"10","description":"Tested","date":1731906293813,"attachSysfileName":"20240425173601050_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"11","description":"Cx","date":1731906293813,"attachSysfileName":"20240425174214532_IMG-20240425-WA0103.jpg","attachUserFile":"IMG-20240425-WA0103.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"12","description":"Xx dddsdew dsqq","date":1731906293813,"attachSysfileName":"20240425174340104_IMG-20240425-WA0110.jpg","attachUserFile":"IMG-20240425-WA0110.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"13","description":"Bhupendra","date":1731906293813,"attachSysfileName":"20240425174436744_Bhupendra_Biodata4.pdf","attachUserFile":"Bhupendra_Biodata4.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"14","description":"","date":1731906293813,"attachSysfileName":"20240425174531628_Vaibhav Patil.pdf","attachUserFile":"Vaibhav Patil.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"15","description":"Ghg bjjj","date":1731906293813,"attachSysfileName":"20240425174624937_Hemant Bio Data-1.PDF","attachUserFile":"Hemant Bio Data-1.PDF","base64String":null,"newRecord":false},{"attachmentSeqNumber":"16","description":"tested","date":1731906293813,"attachSysfileName":"20240425113657793_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"19","description":"","date":1731906293813,"attachSysfileName":"20240425181012278_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"20","description":"Testerdd","date":1731906293813,"attachSysfileName":"20240425181104016_biodata_Komal1.pdf","attachUserFile":"biodata_Komal1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"21","description":"Teddd","date":1731906293813,"attachSysfileName":"20240425181148787_Prajakta V Patil Biodata-1.pdf","attachUserFile":"Prajakta V Patil Biodata-1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"22","description":"You","date":1731906293813,"attachSysfileName":"20240425181238977_E_Pension_Rule_1953.pdf","attachUserFile":"E_Pension_Rule_1953.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"23","description":"Vipul","date":1731906293813,"attachSysfileName":"20240425181401628_Vipul Shinde.pdf","attachUserFile":"Vipul Shinde.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"31","description":"tested","date":1731906293813,"attachSysfileName":"20240425180232472_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"33","description":"","date":1731906293813,"attachSysfileName":"20240425180440394_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"35","description":"tttt","date":1731906293813,"attachSysfileName":"20240425180526161_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false}]}}
/// error : false

GetEmploymentStatusModel getEmploymentStatusModelFromJson(String str) => GetEmploymentStatusModel.fromJson(json.decode(str));
String getEmploymentStatusModelToJson(GetEmploymentStatusModel data) => json.encode(data.toJson());
class GetEmploymentStatusModel {
  GetEmploymentStatusModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  GetEmploymentStatusModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
GetEmploymentStatusModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => GetEmploymentStatusModel(  messageCode: messageCode ?? _messageCode,
  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  String? get messageCode => _messageCode;
  String? get message => _message;
  Data? get data => _data;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = _messageCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// errorMessage : null
/// status : "FAILED"
/// employmentStatus : {"emplId":"000921","sequanceNumber":"1","employmentStatus":"NWR","university":"00016148","currentFlag":"Y","comment":"%COMMENTS%","listOfFiles":[{"attachmentSeqNumber":"1","description":"","date":1731906293813,"attachSysfileName":"20230110172609443_IRCTC Next Generation eTicketing System.pdf","attachUserFile":"IRCTC Next Generation eTicketing System.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"Aera","date":1731906293813,"attachSysfileName":"20231215144549577_Screenshot_20231215_150820.jpg","attachUserFile":"Screenshot_20231215_150820.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"3","description":"Tested","date":1731906293813,"attachSysfileName":"20240425104159035_IMG-20240425-WA0035.jpg","attachUserFile":"IMG-20240425-WA0035.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"4","description":"Tested 1234","date":1731906293813,"attachSysfileName":"20240425105159106_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"5","description":"Tesds cdswaa vddsa fddsa","date":1731906293813,"attachSysfileName":"20240425105528591_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"7","description":"Now testwd","date":1731906293813,"attachSysfileName":"20240425113756450_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"8","description":"Tested1","date":1731906293813,"attachSysfileName":"20240425114346399_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"9","description":"Tested12222","date":1731906293813,"attachSysfileName":"20240425114444900_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"10","description":"Tested","date":1731906293813,"attachSysfileName":"20240425173601050_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"11","description":"Cx","date":1731906293813,"attachSysfileName":"20240425174214532_IMG-20240425-WA0103.jpg","attachUserFile":"IMG-20240425-WA0103.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"12","description":"Xx dddsdew dsqq","date":1731906293813,"attachSysfileName":"20240425174340104_IMG-20240425-WA0110.jpg","attachUserFile":"IMG-20240425-WA0110.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"13","description":"Bhupendra","date":1731906293813,"attachSysfileName":"20240425174436744_Bhupendra_Biodata4.pdf","attachUserFile":"Bhupendra_Biodata4.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"14","description":"","date":1731906293813,"attachSysfileName":"20240425174531628_Vaibhav Patil.pdf","attachUserFile":"Vaibhav Patil.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"15","description":"Ghg bjjj","date":1731906293813,"attachSysfileName":"20240425174624937_Hemant Bio Data-1.PDF","attachUserFile":"Hemant Bio Data-1.PDF","base64String":null,"newRecord":false},{"attachmentSeqNumber":"16","description":"tested","date":1731906293813,"attachSysfileName":"20240425113657793_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"19","description":"","date":1731906293813,"attachSysfileName":"20240425181012278_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"20","description":"Testerdd","date":1731906293813,"attachSysfileName":"20240425181104016_biodata_Komal1.pdf","attachUserFile":"biodata_Komal1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"21","description":"Teddd","date":1731906293813,"attachSysfileName":"20240425181148787_Prajakta V Patil Biodata-1.pdf","attachUserFile":"Prajakta V Patil Biodata-1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"22","description":"You","date":1731906293813,"attachSysfileName":"20240425181238977_E_Pension_Rule_1953.pdf","attachUserFile":"E_Pension_Rule_1953.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"23","description":"Vipul","date":1731906293813,"attachSysfileName":"20240425181401628_Vipul Shinde.pdf","attachUserFile":"Vipul Shinde.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"31","description":"tested","date":1731906293813,"attachSysfileName":"20240425180232472_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"33","description":"","date":1731906293813,"attachSysfileName":"20240425180440394_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"35","description":"tttt","date":1731906293813,"attachSysfileName":"20240425180526161_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false}]}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic errorMessage, 
      String? status, 
      EmploymentStatus? employmentStatus,}){
    _errorMessage = errorMessage;
    _status = status;
    _employmentStatus = employmentStatus;
}

  Data.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _status = json['status'];
    _employmentStatus = json['employmentStatus'] != null ? EmploymentStatus.fromJson(json['employmentStatus']) : null;
  }
  dynamic _errorMessage;
  String? _status;
  EmploymentStatus? _employmentStatus;
Data copyWith({  dynamic errorMessage,
  String? status,
  EmploymentStatus? employmentStatus,
}) => Data(  errorMessage: errorMessage ?? _errorMessage,
  status: status ?? _status,
  employmentStatus: employmentStatus ?? _employmentStatus,
);
  dynamic get errorMessage => _errorMessage;
  String? get status => _status;
  EmploymentStatus? get employmentStatus => _employmentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorMessage'] = _errorMessage;
    map['status'] = _status;
    if (_employmentStatus != null) {
      map['employmentStatus'] = _employmentStatus?.toJson();
    }
    return map;
  }

}

/// emplId : "000921"
/// sequanceNumber : "1"
/// employmentStatus : "NWR"
/// university : "00016148"
/// currentFlag : "Y"
/// comment : "%COMMENTS%"
/// listOfFiles : [{"attachmentSeqNumber":"1","description":"","date":1731906293813,"attachSysfileName":"20230110172609443_IRCTC Next Generation eTicketing System.pdf","attachUserFile":"IRCTC Next Generation eTicketing System.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"Aera","date":1731906293813,"attachSysfileName":"20231215144549577_Screenshot_20231215_150820.jpg","attachUserFile":"Screenshot_20231215_150820.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"3","description":"Tested","date":1731906293813,"attachSysfileName":"20240425104159035_IMG-20240425-WA0035.jpg","attachUserFile":"IMG-20240425-WA0035.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"4","description":"Tested 1234","date":1731906293813,"attachSysfileName":"20240425105159106_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"5","description":"Tesds cdswaa vddsa fddsa","date":1731906293813,"attachSysfileName":"20240425105528591_IMG-20240425-WA0038.jpg","attachUserFile":"IMG-20240425-WA0038.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"7","description":"Now testwd","date":1731906293813,"attachSysfileName":"20240425113756450_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"8","description":"Tested1","date":1731906293813,"attachSysfileName":"20240425114346399_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"9","description":"Tested12222","date":1731906293813,"attachSysfileName":"20240425114444900_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"10","description":"Tested","date":1731906293813,"attachSysfileName":"20240425173601050_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"11","description":"Cx","date":1731906293813,"attachSysfileName":"20240425174214532_IMG-20240425-WA0103.jpg","attachUserFile":"IMG-20240425-WA0103.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"12","description":"Xx dddsdew dsqq","date":1731906293813,"attachSysfileName":"20240425174340104_IMG-20240425-WA0110.jpg","attachUserFile":"IMG-20240425-WA0110.jpg","base64String":null,"newRecord":false},{"attachmentSeqNumber":"13","description":"Bhupendra","date":1731906293813,"attachSysfileName":"20240425174436744_Bhupendra_Biodata4.pdf","attachUserFile":"Bhupendra_Biodata4.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"14","description":"","date":1731906293813,"attachSysfileName":"20240425174531628_Vaibhav Patil.pdf","attachUserFile":"Vaibhav Patil.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"15","description":"Ghg bjjj","date":1731906293813,"attachSysfileName":"20240425174624937_Hemant Bio Data-1.PDF","attachUserFile":"Hemant Bio Data-1.PDF","base64String":null,"newRecord":false},{"attachmentSeqNumber":"16","description":"tested","date":1731906293813,"attachSysfileName":"20240425113657793_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"19","description":"","date":1731906293813,"attachSysfileName":"20240425181012278_sc2024.pdf","attachUserFile":"sc2024.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"20","description":"Testerdd","date":1731906293813,"attachSysfileName":"20240425181104016_biodata_Komal1.pdf","attachUserFile":"biodata_Komal1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"21","description":"Teddd","date":1731906293813,"attachSysfileName":"20240425181148787_Prajakta V Patil Biodata-1.pdf","attachUserFile":"Prajakta V Patil Biodata-1.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"22","description":"You","date":1731906293813,"attachSysfileName":"20240425181238977_E_Pension_Rule_1953.pdf","attachUserFile":"E_Pension_Rule_1953.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"23","description":"Vipul","date":1731906293813,"attachSysfileName":"20240425181401628_Vipul Shinde.pdf","attachUserFile":"Vipul Shinde.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"31","description":"tested","date":1731906293813,"attachSysfileName":"20240425180232472_All Selenium Locators Strategies.pdf","attachUserFile":"All Selenium Locators Strategies.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"33","description":"","date":1731906293813,"attachSysfileName":"20240425180440394_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false},{"attachmentSeqNumber":"35","description":"tttt","date":1731906293813,"attachSysfileName":"20240425180526161_dummy.pdf","attachUserFile":"dummy.pdf","base64String":null,"newRecord":false}]

EmploymentStatus employmentStatusFromJson(String str) => EmploymentStatus.fromJson(json.decode(str));
String employmentStatusToJson(EmploymentStatus data) => json.encode(data.toJson());
class EmploymentStatus {
  EmploymentStatus({
      String? emplId, 
      String? sequanceNumber, 
      String? employmentStatus, 
      String? university, 
      String? currentFlag, 
      String? comment, 
      List<ListOfFiles>? listOfFiles,}){
    _emplId = emplId;
    _sequanceNumber = sequanceNumber;
    _employmentStatus = employmentStatus;
    _university = university;
    _currentFlag = currentFlag;
    _comment = comment;
    _listOfFiles = listOfFiles;
}

  EmploymentStatus.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _sequanceNumber = json['sequanceNumber'];
    _employmentStatus = json['employmentStatus'];
    _university = json['university'];
    _currentFlag = json['currentFlag'];
    _comment = json['comment'];
    if (json['listOfFiles'] != null) {
      _listOfFiles = [];
      json['listOfFiles'].forEach((v) {
        _listOfFiles?.add(ListOfFiles.fromJson(v));
      });
    }
  }
  String? _emplId;
  String? _sequanceNumber;
  String? _employmentStatus;
  String? _university;
  String? _currentFlag;
  String? _comment;
  List<ListOfFiles>? _listOfFiles;
EmploymentStatus copyWith({  String? emplId,
  String? sequanceNumber,
  String? employmentStatus,
  String? university,
  String? currentFlag,
  String? comment,
  List<ListOfFiles>? listOfFiles,
}) => EmploymentStatus(  emplId: emplId ?? _emplId,
  sequanceNumber: sequanceNumber ?? _sequanceNumber,
  employmentStatus: employmentStatus ?? _employmentStatus,
  university: university ?? _university,
  currentFlag: currentFlag ?? _currentFlag,
  comment: comment ?? _comment,
  listOfFiles: listOfFiles ?? _listOfFiles,
);
  String? get emplId => _emplId;
  String? get sequanceNumber => _sequanceNumber;
  String? get employmentStatus => _employmentStatus;
  String? get university => _university;
  String? get currentFlag => _currentFlag;
  String? get comment => _comment;
  List<ListOfFiles>? get listOfFiles => _listOfFiles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['sequanceNumber'] = _sequanceNumber;
    map['employmentStatus'] = _employmentStatus;
    map['university'] = _university;
    map['currentFlag'] = _currentFlag;
    map['comment'] = _comment;
    if (_listOfFiles != null) {
      map['listOfFiles'] = _listOfFiles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// attachmentSeqNumber : "1"
/// description : ""
/// date : 1731906293813
/// attachSysfileName : "20230110172609443_IRCTC Next Generation eTicketing System.pdf"
/// attachUserFile : "IRCTC Next Generation eTicketing System.pdf"
/// base64String : null
/// newRecord : false

class ListOfFiles {
  // Controllers
  TextEditingController attachmentSeqNumberController;
  TextEditingController descriptionController;
  TextEditingController dateController;
  TextEditingController attachSysfileNameController;
  TextEditingController attachUserFileController;

  // Boolean value for new record
  bool newRecord;

  // Focus Nodes
  FocusNode attachmentSeqNumberFocusNode;
  FocusNode descriptionFocusNode;
  FocusNode dateFocusNode;
  FocusNode attachSysfileNameFocusNode;
  FocusNode attachUserFileFocusNode;

  // Error Text Variables
  String? attachmentSeqNumberError;
  String? descriptionError;
  String? dateError;
  String? attachSysfileNameError;
  String? attachUserFileError;

  // Additional field
  dynamic base64String;

  ListOfFiles({
    required this.attachmentSeqNumberController,
    required this.descriptionController,
    required this.dateController,
    required this.attachSysfileNameController,
    required this.attachUserFileController,
    required this.newRecord,
    required this.attachmentSeqNumberFocusNode,
    required this.descriptionFocusNode,
    required this.dateFocusNode,
    required this.attachSysfileNameFocusNode,
    required this.attachUserFileFocusNode,
    this.attachmentSeqNumberError,
    this.descriptionError,
    this.dateError,
    this.attachSysfileNameError,
    this.attachUserFileError,
    this.base64String,
  });

  // From JSON
  factory ListOfFiles.fromJson(Map<String, dynamic> json) {
    return ListOfFiles(
      attachmentSeqNumberController: TextEditingController(text: json['attachmentSeqNumber']),
      descriptionController: TextEditingController(text: json['description']),
      dateController: TextEditingController(text: json['date']?.toString()),
      attachSysfileNameController: TextEditingController(text: json['attachSysfileName']),
      attachUserFileController: TextEditingController(text: json['attachUserFile']),
      newRecord: json['newRecord'] == true || json['newRecord'] == 'true',
      attachmentSeqNumberFocusNode: FocusNode(),
      descriptionFocusNode: FocusNode(),
      dateFocusNode: FocusNode(),
      attachSysfileNameFocusNode: FocusNode(),
      attachUserFileFocusNode: FocusNode(),
      base64String: json['base64String'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'attachmentSeqNumber': attachmentSeqNumberController.text,
      'description': descriptionController.text,
      'date': dateController.text,
      'attachSysfileName': attachSysfileNameController.text,
      'attachUserFile': attachUserFileController.text,
      'newRecord': newRecord,
      'base64String': base64String,
    };
  }
}
