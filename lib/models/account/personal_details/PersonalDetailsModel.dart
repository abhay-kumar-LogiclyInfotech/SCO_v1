import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"data":null,"userInfoType":"LIFERAY","userInfo":null,"user":{"userId":969375,"firstName":"Test","lastName":"Test","middleName":"Test","middleName2":"Test","emailAddress":"test1@hotmail.com","lockout":false,"companyId":20099,"username":"784200479031062","role":null,"birthDate":"2012-09-19","gender":"F","phoneNumber":"0123456789","nationality":"","emirateId":"784200479031062","uaePassUuid":""}}
/// error : false

PersonalDetailsModel personalDetailsModelFromJson(String str) => PersonalDetailsModel.fromJson(json.decode(str));
String personalDetailsModelToJson(PersonalDetailsModel data) => json.encode(data.toJson());
class PersonalDetailsModel {
  PersonalDetailsModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  PersonalDetailsModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
PersonalDetailsModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => PersonalDetailsModel(  messageCode: messageCode ?? _messageCode,
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

/// data : null
/// userInfoType : "LIFERAY"
/// userInfo : null
/// user : {"userId":969375,"firstName":"Test","lastName":"Test","middleName":"Test","middleName2":"Test","emailAddress":"test1@hotmail.com","lockout":false,"companyId":20099,"username":"784200479031062","role":null,"birthDate":"2012-09-19","gender":"F","phoneNumber":"0123456789","nationality":"","emirateId":"784200479031062","uaePassUuid":""}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic data, 
      String? userInfoType, 
      dynamic userInfo, 
      User? user,}){
    _data = data;
    _userInfoType = userInfoType;
    _userInfo = userInfo;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _userInfoType = json['userInfoType'];
    _userInfo = json['userInfo'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  dynamic _data;
  String? _userInfoType;
  dynamic _userInfo;
  User? _user;
Data copyWith({  dynamic data,
  String? userInfoType,
  dynamic userInfo,
  User? user,
}) => Data(  data: data ?? _data,
  userInfoType: userInfoType ?? _userInfoType,
  userInfo: userInfo ?? _userInfo,
  user: user ?? _user,
);
  dynamic get data => _data;
  String? get userInfoType => _userInfoType;
  dynamic get userInfo => _userInfo;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['userInfoType'] = _userInfoType;
    map['userInfo'] = _userInfo;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// userId : 969375
/// firstName : "Test"
/// lastName : "Test"
/// middleName : "Test"
/// middleName2 : "Test"
/// emailAddress : "test1@hotmail.com"
/// lockout : false
/// companyId : 20099
/// username : "784200479031062"
/// role : null
/// birthDate : "2012-09-19"
/// gender : "F"
/// phoneNumber : "0123456789"
/// nationality : ""
/// emirateId : "784200479031062"
/// uaePassUuid : ""

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? userId, 
      String? firstName, 
      String? lastName, 
      String? middleName, 
      String? middleName2, 
      String? emailAddress, 
      bool? lockout, 
      num? companyId, 
      String? username, 
      dynamic role, 
      String? birthDate, 
      String? gender, 
      String? phoneNumber, 
      String? nationality, 
      String? emirateId, 
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
  String? _middleName;
  String? _middleName2;
  String? _emailAddress;
  bool? _lockout;
  num? _companyId;
  String? _username;
  dynamic _role;
  String? _birthDate;
  String? _gender;
  String? _phoneNumber;
  String? _nationality;
  String? _emirateId;
  String? _uaePassUuid;
User copyWith({  num? userId,
  String? firstName,
  String? lastName,
  String? middleName,
  String? middleName2,
  String? emailAddress,
  bool? lockout,
  num? companyId,
  String? username,
  dynamic role,
  String? birthDate,
  String? gender,
  String? phoneNumber,
  String? nationality,
  String? emirateId,
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
  String? get middleName => _middleName;
  String? get middleName2 => _middleName2;
  String? get emailAddress => _emailAddress;
  bool? get lockout => _lockout;
  num? get companyId => _companyId;
  String? get username => _username;
  dynamic get role => _role;
  String? get birthDate => _birthDate;
  String? get gender => _gender;
  String? get phoneNumber => _phoneNumber;
  String? get nationality => _nationality;
  String? get emirateId => _emirateId;
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