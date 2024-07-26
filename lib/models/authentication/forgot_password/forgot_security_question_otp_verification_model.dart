
class ForgotSecurityQuestionOtpVerificationModel {
  ForgotSecurityQuestionOtpVerificationModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  ForgotSecurityQuestionOtpVerificationModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
ForgotSecurityQuestionOtpVerificationModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => ForgotSecurityQuestionOtpVerificationModel(  messageCode: messageCode ?? _messageCode,
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

/// roles : null
/// verificationCode : "1299256"
/// redirectUrl : null
/// user : {"userId":962344,"firstName":"Abhay","lastName":"Kumar","middleName":null,"middleName2":null,"emailAddress":"abhay.kumar@logiclyinfotech.com","lockout":false,"companyId":20099,"username":"784200604163186","role":null,"birthDate":null,"gender":null,"phoneNumber":null,"nationality":null,"emirateId":null,"uaePassUuid":""}

class Data {
  Data({
      dynamic roles, 
      String? verificationCode, 
      dynamic redirectUrl, 
      User? user,}){
    _roles = roles;
    _verificationCode = verificationCode;
    _redirectUrl = redirectUrl;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _roles = json['roles'];
    _verificationCode = json['verificationCode'];
    _redirectUrl = json['redirectUrl'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  dynamic _roles;
  String? _verificationCode;
  dynamic _redirectUrl;
  User? _user;
Data copyWith({  dynamic roles,
  String? verificationCode,
  dynamic redirectUrl,
  User? user,
}) => Data(  roles: roles ?? _roles,
  verificationCode: verificationCode ?? _verificationCode,
  redirectUrl: redirectUrl ?? _redirectUrl,
  user: user ?? _user,
);
  dynamic get roles => _roles;
  String? get verificationCode => _verificationCode;
  dynamic get redirectUrl => _redirectUrl;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roles'] = _roles;
    map['verificationCode'] = _verificationCode;
    map['redirectUrl'] = _redirectUrl;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// userId : 962344
/// firstName : "Abhay"
/// lastName : "Kumar"
/// middleName : null
/// middleName2 : null
/// emailAddress : "abhay.kumar@logiclyinfotech.com"
/// lockout : false
/// companyId : 20099
/// username : "784200604163186"
/// role : null
/// birthDate : null
/// gender : null
/// phoneNumber : null
/// nationality : null
/// emirateId : null
/// uaePassUuid : ""

class User {
  User({
      num? userId, 
      String? firstName, 
      String? lastName, 
      dynamic middleName, 
      dynamic middleName2, 
      String? emailAddress, 
      bool? lockout, 
      num? companyId, 
      String? username, 
      dynamic role, 
      dynamic birthDate, 
      dynamic gender, 
      dynamic phoneNumber, 
      dynamic nationality, 
      dynamic emirateId, 
      String? uaePassUuid,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _middleName = middleName;
    _middleName2 = middleName2;
    _emailAddress = emailAddress;
    _lockout = lockout;
    _companyId = companyId;
    _username = username;
    _role = role;
    _birthDate = birthDate;
    _gender = gender;
    _phoneNumber = phoneNumber;
    _nationality = nationality;
    _emirateId = emirateId;
    _uaePassUuid = uaePassUuid;
}

  User.fromJson(dynamic json) {
    _userId = json['userId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _middleName = json['middleName'];
    _middleName2 = json['middleName2'];
    _emailAddress = json['emailAddress'];
    _lockout = json['lockout'];
    _companyId = json['companyId'];
    _username = json['username'];
    _role = json['role'];
    _birthDate = json['birthDate'];
    _gender = json['gender'];
    _phoneNumber = json['phoneNumber'];
    _nationality = json['nationality'];
    _emirateId = json['emirateId'];
    _uaePassUuid = json['uaePassUuid'];
  }
  num? _userId;
  String? _firstName;
  String? _lastName;
  dynamic _middleName;
  dynamic _middleName2;
  String? _emailAddress;
  bool? _lockout;
  num? _companyId;
  String? _username;
  dynamic _role;
  dynamic _birthDate;
  dynamic _gender;
  dynamic _phoneNumber;
  dynamic _nationality;
  dynamic _emirateId;
  String? _uaePassUuid;
User copyWith({  num? userId,
  String? firstName,
  String? lastName,
  dynamic middleName,
  dynamic middleName2,
  String? emailAddress,
  bool? lockout,
  num? companyId,
  String? username,
  dynamic role,
  dynamic birthDate,
  dynamic gender,
  dynamic phoneNumber,
  dynamic nationality,
  dynamic emirateId,
  String? uaePassUuid,
}) => User(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  middleName: middleName ?? _middleName,
  middleName2: middleName2 ?? _middleName2,
  emailAddress: emailAddress ?? _emailAddress,
  lockout: lockout ?? _lockout,
  companyId: companyId ?? _companyId,
  username: username ?? _username,
  role: role ?? _role,
  birthDate: birthDate ?? _birthDate,
  gender: gender ?? _gender,
  phoneNumber: phoneNumber ?? _phoneNumber,
  nationality: nationality ?? _nationality,
  emirateId: emirateId ?? _emirateId,
  uaePassUuid: uaePassUuid ?? _uaePassUuid,
);
  num? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  dynamic get middleName => _middleName;
  dynamic get middleName2 => _middleName2;
  String? get emailAddress => _emailAddress;
  bool? get lockout => _lockout;
  num? get companyId => _companyId;
  String? get username => _username;
  dynamic get role => _role;
  dynamic get birthDate => _birthDate;
  dynamic get gender => _gender;
  dynamic get phoneNumber => _phoneNumber;
  dynamic get nationality => _nationality;
  dynamic get emirateId => _emirateId;
  String? get uaePassUuid => _uaePassUuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['middleName'] = _middleName;
    map['middleName2'] = _middleName2;
    map['emailAddress'] = _emailAddress;
    map['lockout'] = _lockout;
    map['companyId'] = _companyId;
    map['username'] = _username;
    map['role'] = _role;
    map['birthDate'] = _birthDate;
    map['gender'] = _gender;
    map['phoneNumber'] = _phoneNumber;
    map['nationality'] = _nationality;
    map['emirateId'] = _emirateId;
    map['uaePassUuid'] = _uaePassUuid;
    return map;
  }

}