import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"data":null,"userInfoType":"PEOPLESOFT","userInfo":{"emplId":"240006","name":"أبهاي كومار أبهاي كومار أبهاي كومار أبهاي كومار","phoneNumbers":[{"countryCode":"+971","phoneNumber":"918218185432","phoneType":"CELL","prefered":true,"errorMessage":null,"existing":true},{"countryCode":"+971","phoneNumber":"809876666666","phoneType":"GRD","prefered":false,"errorMessage":null,"existing":true}],"addresses":[{"addressType":"HOME","addressLine1":"home","addressLine2":"","city":"hmr","state":"ALD","country":"ARE","postalCode":"177044","disableState":false,"errorMessage":null,"existing":true}],"scholarships":null,"emails":[{"emailType":"PERS","emailId":"test2@hotmail.com","prefferd":true,"existing":true}],"gender":"M","maritalStatus":"S","maritalStatusOn":"2024-11-07","highestEduLevel":"A","ftStudent":"N","ferpa":"N","languageId":null,"birthDate":null},"user":{"userId":976311,"firstName":"Abhay","lastName":"Abhay","middleName":"Abhay","middleName2":"Abhay","emailAddress":"test2@hotmail.com","lockout":false,"companyId":20099,"username":"784200514140480","role":null,"birthDate":"2002-08-01","gender":"M","phoneNumber":"918218185432","nationality":"ARE","emirateId":"784200514140480","uaePassUuid":""}}
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
/// userInfoType : "PEOPLESOFT"
/// userInfo : {"emplId":"240006","name":"أبهاي كومار أبهاي كومار أبهاي كومار أبهاي كومار","phoneNumbers":[{"countryCode":"+971","phoneNumber":"918218185432","phoneType":"CELL","prefered":true,"errorMessage":null,"existing":true},{"countryCode":"+971","phoneNumber":"809876666666","phoneType":"GRD","prefered":false,"errorMessage":null,"existing":true}],"addresses":[{"addressType":"HOME","addressLine1":"home","addressLine2":"","city":"hmr","state":"ALD","country":"ARE","postalCode":"177044","disableState":false,"errorMessage":null,"existing":true}],"scholarships":null,"emails":[{"emailType":"PERS","emailId":"test2@hotmail.com","prefferd":true,"existing":true}],"gender":"M","maritalStatus":"S","maritalStatusOn":"2024-11-07","highestEduLevel":"A","ftStudent":"N","ferpa":"N","languageId":null,"birthDate":null}
/// user : {"userId":976311,"firstName":"Abhay","lastName":"Abhay","middleName":"Abhay","middleName2":"Abhay","emailAddress":"test2@hotmail.com","lockout":false,"companyId":20099,"username":"784200514140480","role":null,"birthDate":"2002-08-01","gender":"M","phoneNumber":"918218185432","nationality":"ARE","emirateId":"784200514140480","uaePassUuid":""}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic data, 
      String? userInfoType, 
      UserInfo? userInfo, 
      User? user,}){
    _data = data;
    _userInfoType = userInfoType;
    _userInfo = userInfo;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _userInfoType = json['userInfoType'];
    _userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  dynamic _data;
  String? _userInfoType;
  UserInfo? _userInfo;
  User? _user;
Data copyWith({  dynamic data,
  String? userInfoType,
  UserInfo? userInfo,
  User? user,
}) => Data(  data: data ?? _data,
  userInfoType: userInfoType ?? _userInfoType,
  userInfo: userInfo ?? _userInfo,
  user: user ?? _user,
);
  dynamic get data => _data;
  String? get userInfoType => _userInfoType;
  UserInfo? get userInfo => _userInfo;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['userInfoType'] = _userInfoType;
    if (_userInfo != null) {
      map['userInfo'] = _userInfo?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// userId : 976311
/// firstName : "Abhay"
/// lastName : "Abhay"
/// middleName : "Abhay"
/// middleName2 : "Abhay"
/// emailAddress : "test2@hotmail.com"
/// lockout : false
/// companyId : 20099
/// username : "784200514140480"
/// role : null
/// birthDate : "2002-08-01"
/// gender : "M"
/// phoneNumber : "918218185432"
/// nationality : "ARE"
/// emirateId : "784200514140480"
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

/// emplId : "240006"
/// name : "أبهاي كومار أبهاي كومار أبهاي كومار أبهاي كومار"
/// phoneNumbers : [{"countryCode":"+971","phoneNumber":"918218185432","phoneType":"CELL","prefered":true,"errorMessage":null,"existing":true},{"countryCode":"+971","phoneNumber":"809876666666","phoneType":"GRD","prefered":false,"errorMessage":null,"existing":true}]
/// addresses : [{"addressType":"HOME","addressLine1":"home","addressLine2":"","city":"hmr","state":"ALD","country":"ARE","postalCode":"177044","disableState":false,"errorMessage":null,"existing":true}]
/// scholarships : null
/// emails : [{"emailType":"PERS","emailId":"test2@hotmail.com","prefferd":true,"existing":true}]
/// gender : "M"
/// maritalStatus : "S"
/// maritalStatusOn : "2024-11-07"
/// highestEduLevel : "A"
/// ftStudent : "N"
/// ferpa : "N"
/// languageId : null
/// birthDate : null

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));
String userInfoToJson(UserInfo data) => json.encode(data.toJson());
class UserInfo {
  UserInfo({
      String? emplId, 
      String? name, 
      List<PhoneNumbers>? phoneNumbers, 
      List<Addresses>? addresses, 
      dynamic scholarships, 
      List<Emails>? emails, 
      String? gender, 
      String? maritalStatus, 
      String? maritalStatusOn, 
      String? highestEduLevel, 
      String? ftStudent, 
      String? ferpa, 
      dynamic languageId, 
      dynamic birthDate,}){
    _emplId = emplId;
    _name = name;
    _phoneNumbers = phoneNumbers;
    _addresses = addresses;
    _scholarships = scholarships;
    _emails = emails;
    _gender = gender;
    _maritalStatus = maritalStatus;
    _maritalStatusOn = maritalStatusOn;
    _highestEduLevel = highestEduLevel;
    _ftStudent = ftStudent;
    _ferpa = ferpa;
    _languageId = languageId;
    _birthDate = birthDate;
}

  UserInfo.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _name = json['name'];
    if (json['phoneNumbers'] != null) {
      _phoneNumbers = [];
      json['phoneNumbers'].forEach((v) {
        _phoneNumbers?.add(PhoneNumbers.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      _addresses = [];
      json['addresses'].forEach((v) {
        _addresses?.add(Addresses.fromJson(v));
      });
    }
    _scholarships = json['scholarships'];
    if (json['emails'] != null) {
      _emails = [];
      json['emails'].forEach((v) {
        _emails?.add(Emails.fromJson(v));
      });
    }
    _gender = json['gender'];
    _maritalStatus = json['maritalStatus'];
    _maritalStatusOn = json['maritalStatusOn'];
    _highestEduLevel = json['highestEduLevel'];
    _ftStudent = json['ftStudent'];
    _ferpa = json['ferpa'];
    _languageId = json['languageId'];
    _birthDate = json['birthDate'];
  }
  String? _emplId;
  String? _name;
  List<PhoneNumbers>? _phoneNumbers;
  List<Addresses>? _addresses;
  dynamic _scholarships;
  List<Emails>? _emails;
  String? _gender;
  String? _maritalStatus;
  String? _maritalStatusOn;
  String? _highestEduLevel;
  String? _ftStudent;
  String? _ferpa;
  dynamic _languageId;
  dynamic _birthDate;
UserInfo copyWith({  String? emplId,
  String? name,
  List<PhoneNumbers>? phoneNumbers,
  List<Addresses>? addresses,
  dynamic scholarships,
  List<Emails>? emails,
  String? gender,
  String? maritalStatus,
  String? maritalStatusOn,
  String? highestEduLevel,
  String? ftStudent,
  String? ferpa,
  dynamic languageId,
  dynamic birthDate,
}) => UserInfo(  emplId: emplId ?? _emplId,
  name: name ?? _name,
  phoneNumbers: phoneNumbers ?? _phoneNumbers,
  addresses: addresses ?? _addresses,
  scholarships: scholarships ?? _scholarships,
  emails: emails ?? _emails,
  gender: gender ?? _gender,
  maritalStatus: maritalStatus ?? _maritalStatus,
  maritalStatusOn: maritalStatusOn ?? _maritalStatusOn,
  highestEduLevel: highestEduLevel ?? _highestEduLevel,
  ftStudent: ftStudent ?? _ftStudent,
  ferpa: ferpa ?? _ferpa,
  languageId: languageId ?? _languageId,
  birthDate: birthDate ?? _birthDate,
);
  String? get emplId => _emplId;
  String? get name => _name;
  List<PhoneNumbers>? get phoneNumbers => _phoneNumbers;
  List<Addresses>? get addresses => _addresses;
  dynamic get scholarships => _scholarships;
  List<Emails>? get emails => _emails;
  String? get gender => _gender;
  String? get maritalStatus => _maritalStatus;
  String? get maritalStatusOn => _maritalStatusOn;
  String? get highestEduLevel => _highestEduLevel;
  String? get ftStudent => _ftStudent;
  String? get ferpa => _ferpa;
  dynamic get languageId => _languageId;
  dynamic get birthDate => _birthDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['name'] = _name;
    if (_phoneNumbers != null) {
      map['phoneNumbers'] = _phoneNumbers?.map((v) => v.toJson()).toList();
    }
    if (_addresses != null) {
      map['addresses'] = _addresses?.map((v) => v.toJson()).toList();
    }
    map['scholarships'] = _scholarships;
    if (_emails != null) {
      map['emails'] = _emails?.map((v) => v.toJson()).toList();
    }
    map['gender'] = _gender;
    map['maritalStatus'] = _maritalStatus;
    map['maritalStatusOn'] = _maritalStatusOn;
    map['highestEduLevel'] = _highestEduLevel;
    map['ftStudent'] = _ftStudent;
    map['ferpa'] = _ferpa;
    map['languageId'] = _languageId;
    map['birthDate'] = _birthDate;
    return map;
  }

}

/// emailType : "PERS"
/// emailId : "test2@hotmail.com"
/// prefferd : true
/// existing : true

Emails emailsFromJson(String str) => Emails.fromJson(json.decode(str));
String emailsToJson(Emails data) => json.encode(data.toJson());
class Emails {
  Emails({
      String? emailType, 
      String? emailId, 
      bool? prefferd, 
      bool? existing,}){
    _emailType = emailType;
    _emailId = emailId;
    _prefferd = prefferd;
    _existing = existing;
}

  Emails.fromJson(dynamic json) {
    _emailType = json['emailType'];
    _emailId = json['emailId'];
    _prefferd = json['prefferd'];
    _existing = json['existing'];
  }
  String? _emailType;
  String? _emailId;
  bool? _prefferd;
  bool? _existing;
Emails copyWith({  String? emailType,
  String? emailId,
  bool? prefferd,
  bool? existing,
}) => Emails(  emailType: emailType ?? _emailType,
  emailId: emailId ?? _emailId,
  prefferd: prefferd ?? _prefferd,
  existing: existing ?? _existing,
);
  String? get emailType => _emailType;
  String? get emailId => _emailId;
  bool? get prefferd => _prefferd;
  bool? get existing => _existing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emailType'] = _emailType;
    map['emailId'] = _emailId;
    map['prefferd'] = _prefferd;
    map['existing'] = _existing;
    return map;
  }

}

/// addressType : "HOME"
/// addressLine1 : "home"
/// addressLine2 : ""
/// city : "hmr"
/// state : "ALD"
/// country : "ARE"
/// postalCode : "177044"
/// disableState : false
/// errorMessage : null
/// existing : true

Addresses addressesFromJson(String str) => Addresses.fromJson(json.decode(str));
String addressesToJson(Addresses data) => json.encode(data.toJson());
class Addresses {
  Addresses({
      String? addressType, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      String? state, 
      String? country, 
      String? postalCode, 
      bool? disableState, 
      dynamic errorMessage, 
      bool? existing,}){
    _addressType = addressType;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _country = country;
    _postalCode = postalCode;
    _disableState = disableState;
    _errorMessage = errorMessage;
    _existing = existing;
}

  Addresses.fromJson(dynamic json) {
    _addressType = json['addressType'];
    _addressLine1 = json['addressLine1'];
    _addressLine2 = json['addressLine2'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _postalCode = json['postalCode'];
    _disableState = json['disableState'];
    _errorMessage = json['errorMessage'];
    _existing = json['existing'];
  }
  String? _addressType;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  String? _country;
  String? _postalCode;
  bool? _disableState;
  dynamic _errorMessage;
  bool? _existing;
Addresses copyWith({  String? addressType,
  String? addressLine1,
  String? addressLine2,
  String? city,
  String? state,
  String? country,
  String? postalCode,
  bool? disableState,
  dynamic errorMessage,
  bool? existing,
}) => Addresses(  addressType: addressType ?? _addressType,
  addressLine1: addressLine1 ?? _addressLine1,
  addressLine2: addressLine2 ?? _addressLine2,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  postalCode: postalCode ?? _postalCode,
  disableState: disableState ?? _disableState,
  errorMessage: errorMessage ?? _errorMessage,
  existing: existing ?? _existing,
);
  String? get addressType => _addressType;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get postalCode => _postalCode;
  bool? get disableState => _disableState;
  dynamic get errorMessage => _errorMessage;
  bool? get existing => _existing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressType'] = _addressType;
    map['addressLine1'] = _addressLine1;
    map['addressLine2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['postalCode'] = _postalCode;
    map['disableState'] = _disableState;
    map['errorMessage'] = _errorMessage;
    map['existing'] = _existing;
    return map;
  }

}

/// countryCode : "+971"
/// phoneNumber : "918218185432"
/// phoneType : "CELL"
/// prefered : true
/// errorMessage : null
/// existing : true

PhoneNumbers phoneNumbersFromJson(String str) => PhoneNumbers.fromJson(json.decode(str));
String phoneNumbersToJson(PhoneNumbers data) => json.encode(data.toJson());
class PhoneNumbers {
  PhoneNumbers({
      String? countryCode, 
      String? phoneNumber, 
      String? phoneType, 
      bool? prefered, 
      dynamic errorMessage, 
      bool? existing,}){
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    _phoneType = phoneType;
    _prefered = prefered;
    _errorMessage = errorMessage;
    _existing = existing;
}

  PhoneNumbers.fromJson(dynamic json) {
    _countryCode = json['countryCode'];
    _phoneNumber = json['phoneNumber'];
    _phoneType = json['phoneType'];
    _prefered = json['prefered'];
    _errorMessage = json['errorMessage'];
    _existing = json['existing'];
  }
  String? _countryCode;
  String? _phoneNumber;
  String? _phoneType;
  bool? _prefered;
  dynamic _errorMessage;
  bool? _existing;
PhoneNumbers copyWith({  String? countryCode,
  String? phoneNumber,
  String? phoneType,
  bool? prefered,
  dynamic errorMessage,
  bool? existing,
}) => PhoneNumbers(  countryCode: countryCode ?? _countryCode,
  phoneNumber: phoneNumber ?? _phoneNumber,
  phoneType: phoneType ?? _phoneType,
  prefered: prefered ?? _prefered,
  errorMessage: errorMessage ?? _errorMessage,
  existing: existing ?? _existing,
);
  String? get countryCode => _countryCode;
  String? get phoneNumber => _phoneNumber;
  String? get phoneType => _phoneType;
  bool? get prefered => _prefered;
  dynamic get errorMessage => _errorMessage;
  bool? get existing => _existing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countryCode'] = _countryCode;
    map['phoneNumber'] = _phoneNumber;
    map['phoneType'] = _phoneType;
    map['prefered'] = _prefered;
    map['errorMessage'] = _errorMessage;
    map['existing'] = _existing;
    return map;
  }

}