/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"securityQuestion":null,"securityQuestions":["what-is-your-father's-middle-name","what-is-your-library-card-number","what-is-your-primary-frequent-flyer-number","what-was-your-first-phone-number","what-was-your-first-teacher's-name"]}
/// error : false

class GetSecurityQuestionsModel {
  GetSecurityQuestionsModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  GetSecurityQuestionsModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
GetSecurityQuestionsModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => GetSecurityQuestionsModel(  messageCode: messageCode ?? _messageCode,
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

/// securityQuestion : null
/// securityQuestions : ["what-is-your-father's-middle-name","what-is-your-library-card-number","what-is-your-primary-frequent-flyer-number","what-was-your-first-phone-number","what-was-your-first-teacher's-name"]

class Data {
  Data({
      dynamic securityQuestion, 
      List<String>? securityQuestions,}){
    _securityQuestion = securityQuestion;
    _securityQuestions = securityQuestions;
}

  Data.fromJson(dynamic json) {
    _securityQuestion = json['securityQuestion'];
    _securityQuestions = json['securityQuestions'] != null ? json['securityQuestions'].cast<String>() : [];
  }
  dynamic _securityQuestion;
  List<String>? _securityQuestions;
Data copyWith({  dynamic securityQuestion,
  List<String>? securityQuestions,
}) => Data(  securityQuestion: securityQuestion ?? _securityQuestion,
  securityQuestions: securityQuestions ?? _securityQuestions,
);
  dynamic get securityQuestion => _securityQuestion;
  List<String>? get securityQuestions => _securityQuestions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['securityQuestion'] = _securityQuestion;
    map['securityQuestions'] = _securityQuestions;
    return map;
  }

}