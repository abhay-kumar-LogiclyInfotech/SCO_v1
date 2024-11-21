import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"errorMessage":null,"status":"FAILED","employmentStatus":null}
/// error : false

CreateUpdateEmploymentStatusModel createUpdateEmploymentStatusModelFromJson(String str) => CreateUpdateEmploymentStatusModel.fromJson(json.decode(str));
String createUpdateEmploymentStatusModelToJson(CreateUpdateEmploymentStatusModel data) => json.encode(data.toJson());
class CreateUpdateEmploymentStatusModel {
  CreateUpdateEmploymentStatusModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  CreateUpdateEmploymentStatusModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
CreateUpdateEmploymentStatusModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => CreateUpdateEmploymentStatusModel(  messageCode: messageCode ?? _messageCode,
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
/// employmentStatus : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic errorMessage, 
      String? status, 
      dynamic employmentStatus,}){
    _errorMessage = errorMessage;
    _status = status;
    _employmentStatus = employmentStatus;
}

  Data.fromJson(dynamic json) {
    _errorMessage = json['errorMessage'];
    _status = json['status'];
    _employmentStatus = json['employmentStatus'];
  }
  dynamic _errorMessage;
  String? _status;
  dynamic _employmentStatus;
Data copyWith({  dynamic errorMessage,
  String? status,
  dynamic employmentStatus,
}) => Data(  errorMessage: errorMessage ?? _errorMessage,
  status: status ?? _status,
  employmentStatus: employmentStatus ?? _employmentStatus,
);
  dynamic get errorMessage => _errorMessage;
  String? get status => _status;
  dynamic get employmentStatus => _employmentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorMessage'] = _errorMessage;
    map['status'] = _status;
    map['employmentStatus'] = _employmentStatus;
    return map;
  }

}