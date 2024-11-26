import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"status":"FAILED","errorMessage":null,"adviseeNotes":null,"adviseeNote":null,"emplId":null,"noteId":null,"institution":null}
/// error : false

AddCommentToNoteModel addCommentToNoteModelFromJson(String str) => AddCommentToNoteModel.fromJson(json.decode(str));
String addCommentToNoteModelToJson(AddCommentToNoteModel data) => json.encode(data.toJson());
class AddCommentToNoteModel {
  AddCommentToNoteModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  AddCommentToNoteModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
AddCommentToNoteModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => AddCommentToNoteModel(  messageCode: messageCode ?? _messageCode,
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

/// status : "FAILED"
/// errorMessage : null
/// adviseeNotes : null
/// adviseeNote : null
/// emplId : null
/// noteId : null
/// institution : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? status, 
      dynamic errorMessage, 
      dynamic adviseeNotes, 
      dynamic adviseeNote, 
      dynamic emplId, 
      dynamic noteId, 
      dynamic institution,}){
    _status = status;
    _errorMessage = errorMessage;
    _adviseeNotes = adviseeNotes;
    _adviseeNote = adviseeNote;
    _emplId = emplId;
    _noteId = noteId;
    _institution = institution;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    _adviseeNotes = json['adviseeNotes'];
    _adviseeNote = json['adviseeNote'];
    _emplId = json['emplId'];
    _noteId = json['noteId'];
    _institution = json['institution'];
  }
  String? _status;
  dynamic _errorMessage;
  dynamic _adviseeNotes;
  dynamic _adviseeNote;
  dynamic _emplId;
  dynamic _noteId;
  dynamic _institution;
Data copyWith({  String? status,
  dynamic errorMessage,
  dynamic adviseeNotes,
  dynamic adviseeNote,
  dynamic emplId,
  dynamic noteId,
  dynamic institution,
}) => Data(  status: status ?? _status,
  errorMessage: errorMessage ?? _errorMessage,
  adviseeNotes: adviseeNotes ?? _adviseeNotes,
  adviseeNote: adviseeNote ?? _adviseeNote,
  emplId: emplId ?? _emplId,
  noteId: noteId ?? _noteId,
  institution: institution ?? _institution,
);
  String? get status => _status;
  dynamic get errorMessage => _errorMessage;
  dynamic get adviseeNotes => _adviseeNotes;
  dynamic get adviseeNote => _adviseeNote;
  dynamic get emplId => _emplId;
  dynamic get noteId => _noteId;
  dynamic get institution => _institution;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    map['adviseeNotes'] = _adviseeNotes;
    map['adviseeNote'] = _adviseeNote;
    map['emplId'] = _emplId;
    map['noteId'] = _noteId;
    map['institution'] = _institution;
    return map;
  }

}