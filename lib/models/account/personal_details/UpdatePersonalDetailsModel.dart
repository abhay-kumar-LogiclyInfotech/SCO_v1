import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"data":null,"userInfoType":"LIFERAY","userInfo":null,"user":null}
/// error : false

UpdatePersonalDetailsModel updatePersonalDetailsModelFromJson(String str) => UpdatePersonalDetailsModel.fromJson(json.decode(str));
String updatePersonalDetailsModelToJson(UpdatePersonalDetailsModel data) => json.encode(data.toJson());
class UpdatePersonalDetailsModel {
  UpdatePersonalDetailsModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  UpdatePersonalDetailsModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
UpdatePersonalDetailsModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => UpdatePersonalDetailsModel(  messageCode: messageCode ?? _messageCode,
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
/// user : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic data, 
      String? userInfoType, 
      dynamic userInfo, 
      dynamic user,}){
    _data = data;
    _userInfoType = userInfoType;
    _userInfo = userInfo;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _userInfoType = json['userInfoType'];
    _userInfo = json['userInfo'];
    _user = json['user'];
  }
  dynamic _data;
  String? _userInfoType;
  dynamic _userInfo;
  dynamic _user;
Data copyWith({  dynamic data,
  String? userInfoType,
  dynamic userInfo,
  dynamic user,
}) => Data(  data: data ?? _data,
  userInfoType: userInfoType ?? _userInfoType,
  userInfo: userInfo ?? _userInfo,
  user: user ?? _user,
);
  dynamic get data => _data;
  String? get userInfoType => _userInfoType;
  dynamic get userInfo => _userInfo;
  dynamic get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['userInfoType'] = _userInfoType;
    map['userInfo'] = _userInfo;
    map['user'] = _user;
    return map;
  }

}