import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"status":"SUCCESS","errorMessage":null,"emplId":"000921","adviseeUserName":"784196207416171","adviseeFullName":"784196207416171","listOfAdvisor":[{"effectiveDate":1725307200000,"advisorSeqNumber":"2","advisorRole":"ADVR","advisorRoleDescription":"Academic Advisor","advisorId":"000681","advisorUsername":"DEVELOPER","advisorName":"Ajay Kumar Kumar1 Ajay","imageUrl":null,"email":"excellence.ever@gmail.com","phoneNo":""}]}
/// error : false

GetMyAdvisorModel getMyAdvisorModelFromJson(String str) => GetMyAdvisorModel.fromJson(json.decode(str));
String getMyAdvisorModelToJson(GetMyAdvisorModel data) => json.encode(data.toJson());
class GetMyAdvisorModel {
  GetMyAdvisorModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  GetMyAdvisorModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
GetMyAdvisorModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => GetMyAdvisorModel(  messageCode: messageCode ?? _messageCode,
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

/// status : "SUCCESS"
/// errorMessage : null
/// emplId : "000921"
/// adviseeUserName : "784196207416171"
/// adviseeFullName : "784196207416171"
/// listOfAdvisor : [{"effectiveDate":1725307200000,"advisorSeqNumber":"2","advisorRole":"ADVR","advisorRoleDescription":"Academic Advisor","advisorId":"000681","advisorUsername":"DEVELOPER","advisorName":"Ajay Kumar Kumar1 Ajay","imageUrl":null,"email":"excellence.ever@gmail.com","phoneNo":""}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? status, 
      dynamic errorMessage, 
      String? emplId, 
      String? adviseeUserName, 
      String? adviseeFullName, 
      List<ListOfAdvisor>? listOfAdvisor,}){
    _status = status;
    _errorMessage = errorMessage;
    _emplId = emplId;
    _adviseeUserName = adviseeUserName;
    _adviseeFullName = adviseeFullName;
    _listOfAdvisor = listOfAdvisor;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    _emplId = json['emplId'];
    _adviseeUserName = json['adviseeUserName'];
    _adviseeFullName = json['adviseeFullName'];
    if (json['listOfAdvisor'] != null) {
      _listOfAdvisor = [];
      json['listOfAdvisor'].forEach((v) {
        _listOfAdvisor?.add(ListOfAdvisor.fromJson(v));
      });
    }
  }
  String? _status;
  dynamic _errorMessage;
  String? _emplId;
  String? _adviseeUserName;
  String? _adviseeFullName;
  List<ListOfAdvisor>? _listOfAdvisor;
Data copyWith({  String? status,
  dynamic errorMessage,
  String? emplId,
  String? adviseeUserName,
  String? adviseeFullName,
  List<ListOfAdvisor>? listOfAdvisor,
}) => Data(  status: status ?? _status,
  errorMessage: errorMessage ?? _errorMessage,
  emplId: emplId ?? _emplId,
  adviseeUserName: adviseeUserName ?? _adviseeUserName,
  adviseeFullName: adviseeFullName ?? _adviseeFullName,
  listOfAdvisor: listOfAdvisor ?? _listOfAdvisor,
);
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  String? get emplId => _emplId;
  String? get adviseeUserName => _adviseeUserName;
  String? get adviseeFullName => _adviseeFullName;
  List<ListOfAdvisor>? get listOfAdvisor => _listOfAdvisor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    map['emplId'] = _emplId;
    map['adviseeUserName'] = _adviseeUserName;
    map['adviseeFullName'] = _adviseeFullName;
    if (_listOfAdvisor != null) {
      map['listOfAdvisor'] = _listOfAdvisor?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// effectiveDate : 1725307200000
/// advisorSeqNumber : "2"
/// advisorRole : "ADVR"
/// advisorRoleDescription : "Academic Advisor"
/// advisorId : "000681"
/// advisorUsername : "DEVELOPER"
/// advisorName : "Ajay Kumar Kumar1 Ajay"
/// imageUrl : null
/// email : "excellence.ever@gmail.com"
/// phoneNo : ""

ListOfAdvisor listOfAdvisorFromJson(String str) => ListOfAdvisor.fromJson(json.decode(str));
String listOfAdvisorToJson(ListOfAdvisor data) => json.encode(data.toJson());
class ListOfAdvisor {
  ListOfAdvisor({
      num? effectiveDate, 
      String? advisorSeqNumber, 
      String? advisorRole, 
      String? advisorRoleDescription, 
      String? advisorId, 
      String? advisorUsername, 
      String? advisorName, 
      dynamic imageUrl, 
      String? email, 
      String? phoneNo,}){
    _effectiveDate = effectiveDate;
    _advisorSeqNumber = advisorSeqNumber;
    _advisorRole = advisorRole;
    _advisorRoleDescription = advisorRoleDescription;
    _advisorId = advisorId;
    _advisorUsername = advisorUsername;
    _advisorName = advisorName;
    _imageUrl = imageUrl;
    _email = email;
    _phoneNo = phoneNo;
}

  ListOfAdvisor.fromJson(dynamic json) {
    _effectiveDate = json['effectiveDate'];
    _advisorSeqNumber = json['advisorSeqNumber'];
    _advisorRole = json['advisorRole'];
    _advisorRoleDescription = json['advisorRoleDescription'];
    _advisorId = json['advisorId'];
    _advisorUsername = json['advisorUsername'];
    _advisorName = json['advisorName'];
    _imageUrl = json['imageUrl'];
    _email = json['email'];
    _phoneNo = json['phoneNo'];
  }
  num? _effectiveDate;
  String? _advisorSeqNumber;
  String? _advisorRole;
  String? _advisorRoleDescription;
  String? _advisorId;
  String? _advisorUsername;
  String? _advisorName;
  dynamic _imageUrl;
  String? _email;
  String? _phoneNo;
ListOfAdvisor copyWith({  num? effectiveDate,
  String? advisorSeqNumber,
  String? advisorRole,
  String? advisorRoleDescription,
  String? advisorId,
  String? advisorUsername,
  String? advisorName,
  dynamic imageUrl,
  String? email,
  String? phoneNo,
}) => ListOfAdvisor(  effectiveDate: effectiveDate ?? _effectiveDate,
  advisorSeqNumber: advisorSeqNumber ?? _advisorSeqNumber,
  advisorRole: advisorRole ?? _advisorRole,
  advisorRoleDescription: advisorRoleDescription ?? _advisorRoleDescription,
  advisorId: advisorId ?? _advisorId,
  advisorUsername: advisorUsername ?? _advisorUsername,
  advisorName: advisorName ?? _advisorName,
  imageUrl: imageUrl ?? _imageUrl,
  email: email ?? _email,
  phoneNo: phoneNo ?? _phoneNo,
);
  num? get effectiveDate => _effectiveDate;
  String? get advisorSeqNumber => _advisorSeqNumber;
  String? get advisorRole => _advisorRole;
  String? get advisorRoleDescription => _advisorRoleDescription;
  String? get advisorId => _advisorId;
  String? get advisorUsername => _advisorUsername;
  String? get advisorName => _advisorName;
  dynamic get imageUrl => _imageUrl;
  String? get email => _email;
  String? get phoneNo => _phoneNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['effectiveDate'] = _effectiveDate;
    map['advisorSeqNumber'] = _advisorSeqNumber;
    map['advisorRole'] = _advisorRole;
    map['advisorRoleDescription'] = _advisorRoleDescription;
    map['advisorId'] = _advisorId;
    map['advisorUsername'] = _advisorUsername;
    map['advisorName'] = _advisorName;
    map['imageUrl'] = _imageUrl;
    map['email'] = _email;
    map['phoneNo'] = _phoneNo;
    return map;
  }

}