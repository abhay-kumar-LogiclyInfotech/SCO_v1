/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : null
/// error : false

class UpdateSecurityQuestionModel {
  UpdateSecurityQuestionModel({
      String? messageCode, 
      String? message, 
      dynamic data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  UpdateSecurityQuestionModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'];
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  dynamic _data;
  bool? _error;
UpdateSecurityQuestionModel copyWith({  String? messageCode,
  String? message,
  dynamic data,
  bool? error,
}) => UpdateSecurityQuestionModel(  messageCode: messageCode ?? _messageCode,
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