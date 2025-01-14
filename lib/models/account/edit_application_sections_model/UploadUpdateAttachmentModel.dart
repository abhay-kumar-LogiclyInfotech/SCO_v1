import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"fileList":null,"fileData":null}
/// error : false

UploadUpdateAttachmentModel uploadUpdateAttachmentModelFromJson(String str) => UploadUpdateAttachmentModel.fromJson(json.decode(str));
String uploadUpdateAttachmentModelToJson(UploadUpdateAttachmentModel data) => json.encode(data.toJson());
class UploadUpdateAttachmentModel {
  UploadUpdateAttachmentModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  UploadUpdateAttachmentModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
UploadUpdateAttachmentModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => UploadUpdateAttachmentModel(  messageCode: messageCode ?? _messageCode,
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

/// fileList : null
/// fileData : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic fileList, 
      dynamic fileData,}){
    _fileList = fileList;
    _fileData = fileData;
}

  Data.fromJson(dynamic json) {
    _fileList = json['fileList'];
    _fileData = json['fileData'];
  }
  dynamic _fileList;
  dynamic _fileData;
Data copyWith({  dynamic fileList,
  dynamic fileData,
}) => Data(  fileList: fileList ?? _fileList,
  fileData: fileData ?? _fileData,
);
  dynamic get fileList => _fileList;
  dynamic get fileData => _fileData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileList'] = _fileList;
    map['fileData'] = _fileData;
    return map;
  }

}