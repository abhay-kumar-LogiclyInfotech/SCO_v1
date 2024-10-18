import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"applicationNumber":"36727","applicationData":null,"psApplicartion":null}
/// error : true

SaveAsDraftModel saveAsDraftModelFromJson(String str) => SaveAsDraftModel.fromJson(json.decode(str));
String saveAsDraftModelToJson(SaveAsDraftModel data) => json.encode(data.toJson());
class SaveAsDraftModel {
  SaveAsDraftModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  SaveAsDraftModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
SaveAsDraftModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => SaveAsDraftModel(  messageCode: messageCode ?? _messageCode,
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

/// applicationNumber : "36727"
/// applicationData : null
/// psApplicartion : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? applicationNumber, 
      dynamic applicationData, 
      dynamic psApplicartion,}){
    _applicationNumber = applicationNumber;
    _applicationData = applicationData;
    _psApplicartion = psApplicartion;
}

  Data.fromJson(dynamic json) {
    _applicationNumber = json['applicationNumber'];
    _applicationData = json['applicationData'];
    _psApplicartion = json['psApplicartion'];
  }
  String? _applicationNumber;
  dynamic _applicationData;
  dynamic _psApplicartion;
Data copyWith({  String? applicationNumber,
  dynamic applicationData,
  dynamic psApplicartion,
}) => Data(  applicationNumber: applicationNumber ?? _applicationNumber,
  applicationData: applicationData ?? _applicationData,
  psApplicartion: psApplicartion ?? _psApplicartion,
);
  String? get applicationNumber => _applicationNumber;
  dynamic get applicationData => _applicationData;
  dynamic get psApplicartion => _psApplicartion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationNumber'] = _applicationNumber;
    map['applicationData'] = _applicationData;
    map['psApplicartion'] = _psApplicartion;
    return map;
  }

}