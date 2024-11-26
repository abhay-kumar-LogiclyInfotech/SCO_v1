import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"listOfRequest":null,"request":null}
/// error : false

UploadAttachmentToNoteModel uploadAttachmentToNoteModelFromJson(String str) => UploadAttachmentToNoteModel.fromJson(json.decode(str));
String uploadAttachmentToNoteModelToJson(UploadAttachmentToNoteModel data) => json.encode(data.toJson());
class UploadAttachmentToNoteModel {
  UploadAttachmentToNoteModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  UploadAttachmentToNoteModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
UploadAttachmentToNoteModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => UploadAttachmentToNoteModel(  messageCode: messageCode ?? _messageCode,
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

/// listOfRequest : null
/// request : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic listOfRequest, 
      dynamic request,}){
    _listOfRequest = listOfRequest;
    _request = request;
}

  Data.fromJson(dynamic json) {
    _listOfRequest = json['listOfRequest'];
    _request = json['request'];
  }
  dynamic _listOfRequest;
  dynamic _request;
Data copyWith({  dynamic listOfRequest,
  dynamic request,
}) => Data(  listOfRequest: listOfRequest ?? _listOfRequest,
  request: request ?? _request,
);
  dynamic get listOfRequest => _listOfRequest;
  dynamic get request => _request;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['listOfRequest'] = _listOfRequest;
    map['request'] = _request;
    return map;
  }

}