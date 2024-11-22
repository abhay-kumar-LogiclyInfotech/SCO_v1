import 'dart:convert';
/// messageCode : "1000"
/// message : "Unable to completed request"
/// data : null
/// error : true

UpdateRequestModel updateRequestModelFromJson(String str) => UpdateRequestModel.fromJson(json.decode(str));
String updateRequestModelToJson(UpdateRequestModel data) => json.encode(data.toJson());
class UpdateRequestModel {
  UpdateRequestModel({
      String? messageCode, 
      String? message, 
      dynamic data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  UpdateRequestModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'];
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  dynamic _data;
  bool? _error;
UpdateRequestModel copyWith({  String? messageCode,
  String? message,
  dynamic data,
  bool? error,
}) => UpdateRequestModel(  messageCode: messageCode ?? _messageCode,
  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  String? get messageCode => _messageCode;
  String? get message => _message;
  dynamic get data => _data;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = _messageCode;
    map['message'] = _message;
    map['data'] = _data;
    map['error'] = _error;
    return map;
  }

}