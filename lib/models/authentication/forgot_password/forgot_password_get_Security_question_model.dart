

class ForgotPasswordGetSecurityQuestionModel {
  ForgotPasswordGetSecurityQuestionModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  ForgotPasswordGetSecurityQuestionModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
ForgotPasswordGetSecurityQuestionModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => ForgotPasswordGetSecurityQuestionModel(  messageCode: messageCode ?? _messageCode,
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

/// securityQuestion : {"securityQuestion":"what-was-your-first-teacher's-name","securityAnswer":"Abhay","userId":962344,"emailAddress":"abhay.kumar@logiclyinfotech.com"}
/// securityQuestions : null

class Data {
  Data({
      SecurityQuestion? securityQuestion, 
      dynamic securityQuestions,}){
    _securityQuestion = securityQuestion;
    _securityQuestions = securityQuestions;
}

  Data.fromJson(dynamic json) {
    _securityQuestion = json['securityQuestion'] != null ? SecurityQuestion.fromJson(json['securityQuestion']) : null;
    _securityQuestions = json['securityQuestions'];
  }
  SecurityQuestion? _securityQuestion;
  dynamic _securityQuestions;
Data copyWith({  SecurityQuestion? securityQuestion,
  dynamic securityQuestions,
}) => Data(  securityQuestion: securityQuestion ?? _securityQuestion,
  securityQuestions: securityQuestions ?? _securityQuestions,
);
  SecurityQuestion? get securityQuestion => _securityQuestion;
  dynamic get securityQuestions => _securityQuestions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_securityQuestion != null) {
      map['securityQuestion'] = _securityQuestion?.toJson();
    }
    map['securityQuestions'] = _securityQuestions;
    return map;
  }

}

/// securityQuestion : "what-was-your-first-teacher's-name"
/// securityAnswer : "Abhay"
/// userId : 962344
/// emailAddress : "abhay.kumar@logiclyinfotech.com"

class SecurityQuestion {
  SecurityQuestion({
      String? securityQuestion, 
      String? securityAnswer, 
      num? userId, 
      String? emailAddress,}){
    _securityQuestion = securityQuestion;
    _securityAnswer = securityAnswer;
    _userId = userId;
    _emailAddress = emailAddress;
}

  SecurityQuestion.fromJson(dynamic json) {
    _securityQuestion = json['securityQuestion'];
    _securityAnswer = json['securityAnswer'];
    _userId = json['userId'];
    _emailAddress = json['emailAddress'];
  }
  String? _securityQuestion;
  String? _securityAnswer;
  num? _userId;
  String? _emailAddress;
SecurityQuestion copyWith({  String? securityQuestion,
  String? securityAnswer,
  num? userId,
  String? emailAddress,
}) => SecurityQuestion(  securityQuestion: securityQuestion ?? _securityQuestion,
  securityAnswer: securityAnswer ?? _securityAnswer,
  userId: userId ?? _userId,
  emailAddress: emailAddress ?? _emailAddress,
);
  String? get securityQuestion => _securityQuestion;
  String? get securityAnswer => _securityAnswer;
  num? get userId => _userId;
  String? get emailAddress => _emailAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['securityQuestion'] = _securityQuestion;
    map['securityAnswer'] = _securityAnswer;
    map['userId'] = _userId;
    map['emailAddress'] = _emailAddress;
    return map;
  }

}