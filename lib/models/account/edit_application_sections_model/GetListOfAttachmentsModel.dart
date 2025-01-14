import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"fileList":[{"processCD":"PGUAE","documentCD":"SEL002","attachmentStatus":"IV","uniqueFileName":"784200193283452-20250114100721990_1590251","description":"","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL016","attachmentStatus":"IV","uniqueFileName":"784200193283452-20250110111735111_1174063","description":"TEST UPLOAD","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL019","attachmentStatus":"N","uniqueFileName":"784200193283452-20250114100723370_1766088","description":"INVALID MARKER","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL084","attachmentStatus":"N","uniqueFileName":"784200193283452-20250114100724598_1404990","description":"INVALID MARKER","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false}],"fileData":null}
/// error : false

GetListOfAttachmentsModel getListOfAttachmentsModelFromJson(String str) => GetListOfAttachmentsModel.fromJson(json.decode(str));
String getListOfAttachmentsModelToJson(GetListOfAttachmentsModel data) => json.encode(data.toJson());
class GetListOfAttachmentsModel {
  GetListOfAttachmentsModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  GetListOfAttachmentsModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
GetListOfAttachmentsModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => GetListOfAttachmentsModel(  messageCode: messageCode ?? _messageCode,
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

/// fileList : [{"processCD":"PGUAE","documentCD":"SEL002","attachmentStatus":"IV","uniqueFileName":"784200193283452-20250114100721990_1590251","description":"","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL016","attachmentStatus":"IV","uniqueFileName":"784200193283452-20250110111735111_1174063","description":"TEST UPLOAD","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL019","attachmentStatus":"N","uniqueFileName":"784200193283452-20250114100723370_1766088","description":"INVALID MARKER","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false},{"processCD":"PGUAE","documentCD":"SEL084","attachmentStatus":"N","uniqueFileName":"784200193283452-20250114100724598_1404990","description":"INVALID MARKER","applictantId":"240018","userFileName":"test.pdf","base64String":"","comment":null,"required":null,"emplId":null,"applicationNo":null,"fileUploaded":false}]
/// fileData : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<FileList>? fileList, 
      dynamic fileData,}){
    _fileList = fileList;
    _fileData = fileData;
}

  Data.fromJson(dynamic json) {
    if (json['fileList'] != null) {
      _fileList = [];
      json['fileList'].forEach((v) {
        _fileList?.add(FileList.fromJson(v));
      });
    }
    _fileData = json['fileData'];
  }
  List<FileList>? _fileList;
  dynamic _fileData;
Data copyWith({  List<FileList>? fileList,
  dynamic fileData,
}) => Data(  fileList: fileList ?? _fileList,
  fileData: fileData ?? _fileData,
);
  List<FileList>? get fileList => _fileList;
  dynamic get fileData => _fileData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fileList != null) {
      map['fileList'] = _fileList?.map((v) => v.toJson()).toList();
    }
    map['fileData'] = _fileData;
    return map;
  }

}

/// processCD : "PGUAE"
/// documentCD : "SEL002"
/// attachmentStatus : "IV"
/// uniqueFileName : "784200193283452-20250114100721990_1590251"
/// description : ""
/// applictantId : "240018"
/// userFileName : "test.pdf"
/// base64String : ""
/// comment : null
/// required : null
/// emplId : null
/// applicationNo : null
/// fileUploaded : false

FileList fileListFromJson(String str) => FileList.fromJson(json.decode(str));
String fileListToJson(FileList data) => json.encode(data.toJson());
class FileList {
  FileList({
      String? processCD, 
      String? documentCD, 
      String? attachmentStatus, 
      String? uniqueFileName, 
      String? description, 
      String? applictantId, 
      String? userFileName, 
      String? base64String, 
      dynamic comment, 
      dynamic required, 
      dynamic emplId, 
      dynamic applicationNo, 
      bool? fileUploaded,}){
    _processCD = processCD;
    _documentCD = documentCD;
    _attachmentStatus = attachmentStatus;
    _uniqueFileName = uniqueFileName;
    _description = description;
    _applictantId = applictantId;
    _userFileName = userFileName;
    _base64String = base64String;
    _comment = comment;
    _required = required;
    _emplId = emplId;
    _applicationNo = applicationNo;
    _fileUploaded = fileUploaded;
}

  FileList.fromJson(dynamic json) {
    _processCD = json['processCD'];
    _documentCD = json['documentCD'];
    _attachmentStatus = json['attachmentStatus'];
    _uniqueFileName = json['uniqueFileName'];
    _description = json['description'];
    _applictantId = json['applictantId'];
    _userFileName = json['userFileName'];
    _base64String = json['base64String'];
    _comment = json['comment'];
    _required = json['required'];
    _emplId = json['emplId'];
    _applicationNo = json['applicationNo'];
    _fileUploaded = json['fileUploaded'];
  }
  String? _processCD;
  String? _documentCD;
  String? _attachmentStatus;
  String? _uniqueFileName;
  String? _description;
  String? _applictantId;
  String? _userFileName;
  String? _base64String;
  dynamic _comment;
  dynamic _required;
  dynamic _emplId;
  dynamic _applicationNo;
  bool? _fileUploaded;
FileList copyWith({  String? processCD,
  String? documentCD,
  String? attachmentStatus,
  String? uniqueFileName,
  String? description,
  String? applictantId,
  String? userFileName,
  String? base64String,
  dynamic comment,
  dynamic required,
  dynamic emplId,
  dynamic applicationNo,
  bool? fileUploaded,
}) => FileList(  processCD: processCD ?? _processCD,
  documentCD: documentCD ?? _documentCD,
  attachmentStatus: attachmentStatus ?? _attachmentStatus,
  uniqueFileName: uniqueFileName ?? _uniqueFileName,
  description: description ?? _description,
  applictantId: applictantId ?? _applictantId,
  userFileName: userFileName ?? _userFileName,
  base64String: base64String ?? _base64String,
  comment: comment ?? _comment,
  required: required ?? _required,
  emplId: emplId ?? _emplId,
  applicationNo: applicationNo ?? _applicationNo,
  fileUploaded: fileUploaded ?? _fileUploaded,
);
  String? get processCD => _processCD;
  String? get documentCD => _documentCD;
  String? get attachmentStatus => _attachmentStatus;
  String? get uniqueFileName => _uniqueFileName;
  String? get description => _description;
  String? get applictantId => _applictantId;
  String? get userFileName => _userFileName;
  String? get base64String => _base64String;
  dynamic get comment => _comment;
  dynamic get required => _required;
  dynamic get emplId => _emplId;
  dynamic get applicationNo => _applicationNo;
  bool? get fileUploaded => _fileUploaded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['processCD'] = _processCD;
    map['documentCD'] = _documentCD;
    map['attachmentStatus'] = _attachmentStatus;
    map['uniqueFileName'] = _uniqueFileName;
    map['description'] = _description;
    map['applictantId'] = _applictantId;
    map['userFileName'] = _userFileName;
    map['base64String'] = _base64String;
    map['comment'] = _comment;
    map['required'] = _required;
    map['emplId'] = _emplId;
    map['applicationNo'] = _applicationNo;
    map['fileUploaded'] = _fileUploaded;
    return map;
  }

}