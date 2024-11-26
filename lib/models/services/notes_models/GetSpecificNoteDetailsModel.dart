import 'dart:convert';

import 'package:flutter/cupertino.dart';
/// messageCode : "1001"
/// message : "User not found."
/// data : {"status":"FAILED","errorMessage":null,"adviseeNotes":null,"adviseeNote":{"emplId":"000921","institution":"SCO","institutationName":null,"noteId":"00002","itemSeqNumber":null,"noteType":"AA DEPT","noteType2":null,"noteSubType":"ACAD","noteSubType2":null,"advisorId":"000681","advisorName":null,"noteStatus":"OP","createdOrpid":null,"createdBy":null,"addDateTime":null,"description":null,"access":"Y","contactType":"PHONE","subject":"GPA issue","createdOn":1732609184841,"updatedOn":1732609184841,"noteDetailList":[{"itemSeq":"1","noteItemLongText":"Please imporove your GPA in the current Year","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"2","noteItemLongText":"Academic session 2024-25","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"3","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false},{"itemSeq":"4","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false}],"actionList":[{"itemSeq":"1","itemDate":1732564800000,"desc":"Improve GPA","status":"I","dueDate":1732910400000,"newRecord":false}],"listOfAttachments":[{"attachmentSeqNumber":"1","description":"sponsors_report.docx","date":1732564800000,"attachSysfileName":"2024-11-26-10.37.32.000000sponsors_report.docx","attachUserFile":"sponsors_report.docx","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"test_upload","date":1732564800000,"attachSysfileName":"2024-11-26-11.24.21.000000WhatsApp Image 2024-10-01 at 12.00.21.jpeg","attachUserFile":"WhatsApp Image 2024-10-01 at 12.00.21.jpeg","base64String":null,"newRecord":false}]},"emplId":null,"noteId":null,"institution":null}
/// error : false

GetSpecificNoteDetailsModel getSpecificNoteDetailsModelFromJson(String str) => GetSpecificNoteDetailsModel.fromJson(json.decode(str));
String getSpecificNoteDetailsModelToJson(GetSpecificNoteDetailsModel data) => json.encode(data.toJson());
class GetSpecificNoteDetailsModel {
  GetSpecificNoteDetailsModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  GetSpecificNoteDetailsModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
GetSpecificNoteDetailsModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => GetSpecificNoteDetailsModel(  messageCode: messageCode ?? _messageCode,
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
/// adviseeNote : {"emplId":"000921","institution":"SCO","institutationName":null,"noteId":"00002","itemSeqNumber":null,"noteType":"AA DEPT","noteType2":null,"noteSubType":"ACAD","noteSubType2":null,"advisorId":"000681","advisorName":null,"noteStatus":"OP","createdOrpid":null,"createdBy":null,"addDateTime":null,"description":null,"access":"Y","contactType":"PHONE","subject":"GPA issue","createdOn":1732609184841,"updatedOn":1732609184841,"noteDetailList":[{"itemSeq":"1","noteItemLongText":"Please imporove your GPA in the current Year","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"2","noteItemLongText":"Academic session 2024-25","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"3","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false},{"itemSeq":"4","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false}],"actionList":[{"itemSeq":"1","itemDate":1732564800000,"desc":"Improve GPA","status":"I","dueDate":1732910400000,"newRecord":false}],"listOfAttachments":[{"attachmentSeqNumber":"1","description":"sponsors_report.docx","date":1732564800000,"attachSysfileName":"2024-11-26-10.37.32.000000sponsors_report.docx","attachUserFile":"sponsors_report.docx","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"test_upload","date":1732564800000,"attachSysfileName":"2024-11-26-11.24.21.000000WhatsApp Image 2024-10-01 at 12.00.21.jpeg","attachUserFile":"WhatsApp Image 2024-10-01 at 12.00.21.jpeg","base64String":null,"newRecord":false}]}
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
      AdviseeNote? adviseeNote, 
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
    _adviseeNote = json['adviseeNote'] != null ? AdviseeNote.fromJson(json['adviseeNote']) : null;
    _emplId = json['emplId'];
    _noteId = json['noteId'];
    _institution = json['institution'];
  }
  String? _status;
  dynamic _errorMessage;
  dynamic _adviseeNotes;
  AdviseeNote? _adviseeNote;
  dynamic _emplId;
  dynamic _noteId;
  dynamic _institution;
Data copyWith({  String? status,
  dynamic errorMessage,
  dynamic adviseeNotes,
  AdviseeNote? adviseeNote,
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
  AdviseeNote? get adviseeNote => _adviseeNote;
  dynamic get emplId => _emplId;
  dynamic get noteId => _noteId;
  dynamic get institution => _institution;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    map['adviseeNotes'] = _adviseeNotes;
    if (_adviseeNote != null) {
      map['adviseeNote'] = _adviseeNote?.toJson();
    }
    map['emplId'] = _emplId;
    map['noteId'] = _noteId;
    map['institution'] = _institution;
    return map;
  }

}

/// emplId : "000921"
/// institution : "SCO"
/// institutationName : null
/// noteId : "00002"
/// itemSeqNumber : null
/// noteType : "AA DEPT"
/// noteType2 : null
/// noteSubType : "ACAD"
/// noteSubType2 : null
/// advisorId : "000681"
/// advisorName : null
/// noteStatus : "OP"
/// createdOrpid : null
/// createdBy : null
/// addDateTime : null
/// description : null
/// access : "Y"
/// contactType : "PHONE"
/// subject : "GPA issue"
/// createdOn : 1732609184841
/// updatedOn : 1732609184841
/// noteDetailList : [{"itemSeq":"1","noteItemLongText":"Please imporove your GPA in the current Year","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"2","noteItemLongText":"Academic session 2024-25","craetedOn":1732564800000,"desc2":"Kumar1,Ajay Kumar","newRecord":false},{"itemSeq":"3","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false},{"itemSeq":"4","noteItemLongText":"Test comment by abhay.","craetedOn":1732564800000,"desc2":"شسشس شسشس شسشس","newRecord":false}]
/// actionList : [{"itemSeq":"1","itemDate":1732564800000,"desc":"Improve GPA","status":"I","dueDate":1732910400000,"newRecord":false}]
/// listOfAttachments : [{"attachmentSeqNumber":"1","description":"sponsors_report.docx","date":1732564800000,"attachSysfileName":"2024-11-26-10.37.32.000000sponsors_report.docx","attachUserFile":"sponsors_report.docx","base64String":null,"newRecord":false},{"attachmentSeqNumber":"2","description":"test_upload","date":1732564800000,"attachSysfileName":"2024-11-26-11.24.21.000000WhatsApp Image 2024-10-01 at 12.00.21.jpeg","attachUserFile":"WhatsApp Image 2024-10-01 at 12.00.21.jpeg","base64String":null,"newRecord":false}]

AdviseeNote adviseeNoteFromJson(String str) => AdviseeNote.fromJson(json.decode(str));
String adviseeNoteToJson(AdviseeNote data) => json.encode(data.toJson());
class AdviseeNote {
  AdviseeNote({
      String? emplId, 
      String? institution, 
      dynamic institutationName, 
      String? noteId, 
      dynamic itemSeqNumber, 
      String? noteType, 
      dynamic noteType2, 
      String? noteSubType, 
      dynamic noteSubType2, 
      String? advisorId, 
      dynamic advisorName, 
      String? noteStatus, 
      dynamic createdOrpid, 
      dynamic createdBy, 
      dynamic addDateTime, 
      dynamic description, 
      String? access, 
      String? contactType, 
      String? subject, 
      num? createdOn, 
      num? updatedOn, 
      List<NoteDetailList>? noteDetailList, 
      List<ActionList>? actionList, 
      List<ListOfAttachments>? listOfAttachments,}){
    _emplId = emplId;
    _institution = institution;
    _institutationName = institutationName;
    _noteId = noteId;
    _itemSeqNumber = itemSeqNumber;
    _noteType = noteType;
    _noteType2 = noteType2;
    _noteSubType = noteSubType;
    _noteSubType2 = noteSubType2;
    _advisorId = advisorId;
    _advisorName = advisorName;
    _noteStatus = noteStatus;
    _createdOrpid = createdOrpid;
    _createdBy = createdBy;
    _addDateTime = addDateTime;
    _description = description;
    _access = access;
    _contactType = contactType;
    _subject = subject;
    _createdOn = createdOn;
    _updatedOn = updatedOn;
    _noteDetailList = noteDetailList;
    _actionList = actionList;
    _listOfAttachments = listOfAttachments;
}

  AdviseeNote.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _institution = json['institution'];
    _institutationName = json['institutationName'];
    _noteId = json['noteId'];
    _itemSeqNumber = json['itemSeqNumber'];
    _noteType = json['noteType'];
    _noteType2 = json['noteType2'];
    _noteSubType = json['noteSubType'];
    _noteSubType2 = json['noteSubType2'];
    _advisorId = json['advisorId'];
    _advisorName = json['advisorName'];
    _noteStatus = json['noteStatus'];
    _createdOrpid = json['createdOrpid'];
    _createdBy = json['createdBy'];
    _addDateTime = json['addDateTime'];
    _description = json['description'];
    _access = json['access'];
    _contactType = json['contactType'];
    _subject = json['subject'];
    _createdOn = json['createdOn'];
    _updatedOn = json['updatedOn'];
    if (json['noteDetailList'] != null) {
      _noteDetailList = [];
      json['noteDetailList'].forEach((v) {
        _noteDetailList?.add(NoteDetailList.fromJson(v));
      });
    }
    if (json['actionList'] != null) {
      _actionList = [];
      json['actionList'].forEach((v) {
        _actionList?.add(ActionList.fromJson(v));
      });
    }
    if (json['listOfAttachments'] != null) {
      _listOfAttachments = [];
      json['listOfAttachments'].forEach((v) {
        _listOfAttachments?.add(ListOfAttachments.fromJson(v));
      });
    }
  }
  String? _emplId;
  String? _institution;
  dynamic _institutationName;
  String? _noteId;
  dynamic _itemSeqNumber;
  String? _noteType;
  dynamic _noteType2;
  String? _noteSubType;
  dynamic _noteSubType2;
  String? _advisorId;
  dynamic _advisorName;
  String? _noteStatus;
  dynamic _createdOrpid;
  dynamic _createdBy;
  dynamic _addDateTime;
  dynamic _description;
  String? _access;
  String? _contactType;
  String? _subject;
  num? _createdOn;
  num? _updatedOn;
  List<NoteDetailList>? _noteDetailList;
  List<ActionList>? _actionList;
  List<ListOfAttachments>? _listOfAttachments;
AdviseeNote copyWith({  String? emplId,
  String? institution,
  dynamic institutationName,
  String? noteId,
  dynamic itemSeqNumber,
  String? noteType,
  dynamic noteType2,
  String? noteSubType,
  dynamic noteSubType2,
  String? advisorId,
  dynamic advisorName,
  String? noteStatus,
  dynamic createdOrpid,
  dynamic createdBy,
  dynamic addDateTime,
  dynamic description,
  String? access,
  String? contactType,
  String? subject,
  num? createdOn,
  num? updatedOn,
  List<NoteDetailList>? noteDetailList,
  List<ActionList>? actionList,
  List<ListOfAttachments>? listOfAttachments,
}) => AdviseeNote(  emplId: emplId ?? _emplId,
  institution: institution ?? _institution,
  institutationName: institutationName ?? _institutationName,
  noteId: noteId ?? _noteId,
  itemSeqNumber: itemSeqNumber ?? _itemSeqNumber,
  noteType: noteType ?? _noteType,
  noteType2: noteType2 ?? _noteType2,
  noteSubType: noteSubType ?? _noteSubType,
  noteSubType2: noteSubType2 ?? _noteSubType2,
  advisorId: advisorId ?? _advisorId,
  advisorName: advisorName ?? _advisorName,
  noteStatus: noteStatus ?? _noteStatus,
  createdOrpid: createdOrpid ?? _createdOrpid,
  createdBy: createdBy ?? _createdBy,
  addDateTime: addDateTime ?? _addDateTime,
  description: description ?? _description,
  access: access ?? _access,
  contactType: contactType ?? _contactType,
  subject: subject ?? _subject,
  createdOn: createdOn ?? _createdOn,
  updatedOn: updatedOn ?? _updatedOn,
  noteDetailList: noteDetailList ?? _noteDetailList,
  actionList: actionList ?? _actionList,
  listOfAttachments: listOfAttachments ?? _listOfAttachments,
);
  String? get emplId => _emplId;
  String? get institution => _institution;
  dynamic get institutationName => _institutationName;
  String? get noteId => _noteId;
  dynamic get itemSeqNumber => _itemSeqNumber;
  String? get noteType => _noteType;
  dynamic get noteType2 => _noteType2;
  String? get noteSubType => _noteSubType;
  dynamic get noteSubType2 => _noteSubType2;
  String? get advisorId => _advisorId;
  dynamic get advisorName => _advisorName;
  String? get noteStatus => _noteStatus;
  dynamic get createdOrpid => _createdOrpid;
  dynamic get createdBy => _createdBy;
  dynamic get addDateTime => _addDateTime;
  dynamic get description => _description;
  String? get access => _access;
  String? get contactType => _contactType;
  String? get subject => _subject;
  num? get createdOn => _createdOn;
  num? get updatedOn => _updatedOn;
  List<NoteDetailList>? get noteDetailList => _noteDetailList;
  List<ActionList>? get actionList => _actionList;
  List<ListOfAttachments>? get listOfAttachments => _listOfAttachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['institution'] = _institution;
    map['institutationName'] = _institutationName;
    map['noteId'] = _noteId;
    map['itemSeqNumber'] = _itemSeqNumber;
    map['noteType'] = _noteType;
    map['noteType2'] = _noteType2;
    map['noteSubType'] = _noteSubType;
    map['noteSubType2'] = _noteSubType2;
    map['advisorId'] = _advisorId;
    map['advisorName'] = _advisorName;
    map['noteStatus'] = _noteStatus;
    map['createdOrpid'] = _createdOrpid;
    map['createdBy'] = _createdBy;
    map['addDateTime'] = _addDateTime;
    map['description'] = _description;
    map['access'] = _access;
    map['contactType'] = _contactType;
    map['subject'] = _subject;
    map['createdOn'] = _createdOn;
    map['updatedOn'] = _updatedOn;
    if (_noteDetailList != null) {
      map['noteDetailList'] = _noteDetailList?.map((v) => v.toJson()).toList();
    }
    if (_actionList != null) {
      map['actionList'] = _actionList?.map((v) => v.toJson()).toList();
    }
    if (_listOfAttachments != null) {
      map['listOfAttachments'] = _listOfAttachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// attachmentSeqNumber : "1"
/// description : "sponsors_report.docx"
/// date : 1732564800000
/// attachSysfileName : "2024-11-26-10.37.32.000000sponsors_report.docx"
/// attachUserFile : "sponsors_report.docx"
/// base64String : null
/// newRecord : false

ListOfAttachments listOfAttachmentsFromJson(String str) => ListOfAttachments.fromJson(json.decode(str));
String listOfAttachmentsToJson(ListOfAttachments data) => json.encode(data.toJson());
class ListOfAttachments {
  ListOfAttachments({
      String? attachmentSeqNumber, 
      String? description, 
      num? date, 
      String? attachSysfileName, 
      String? attachUserFile, 
      dynamic base64String, 
      bool? newRecord,}){
    _attachmentSeqNumber = attachmentSeqNumber;
    _description = description;
    _date = date;
    _attachSysfileName = attachSysfileName;
    _attachUserFile = attachUserFile;
    _base64String = base64String;
    _newRecord = newRecord;
}

  ListOfAttachments.fromJson(dynamic json) {
    _attachmentSeqNumber = json['attachmentSeqNumber'];
    _description = json['description'];
    _date = json['date'];
    _attachSysfileName = json['attachSysfileName'];
    _attachUserFile = json['attachUserFile'];
    _base64String = json['base64String'];
    _newRecord = json['newRecord'];
  }
  String? _attachmentSeqNumber;
  String? _description;
  num? _date;
  String? _attachSysfileName;
  String? _attachUserFile;
  dynamic _base64String;
  bool? _newRecord;
ListOfAttachments copyWith({  String? attachmentSeqNumber,
  String? description,
  num? date,
  String? attachSysfileName,
  String? attachUserFile,
  dynamic base64String,
  bool? newRecord,
}) => ListOfAttachments(  attachmentSeqNumber: attachmentSeqNumber ?? _attachmentSeqNumber,
  description: description ?? _description,
  date: date ?? _date,
  attachSysfileName: attachSysfileName ?? _attachSysfileName,
  attachUserFile: attachUserFile ?? _attachUserFile,
  base64String: base64String ?? _base64String,
  newRecord: newRecord ?? _newRecord,
);
  String? get attachmentSeqNumber => _attachmentSeqNumber;
  String? get description => _description;
  num? get date => _date;
  String? get attachSysfileName => _attachSysfileName;
  String? get attachUserFile => _attachUserFile;
  dynamic get base64String => _base64String;
  bool? get newRecord => _newRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attachmentSeqNumber'] = _attachmentSeqNumber;
    map['description'] = _description;
    map['date'] = _date;
    map['attachSysfileName'] = _attachSysfileName;
    map['attachUserFile'] = _attachUserFile;
    map['base64String'] = _base64String;
    map['newRecord'] = _newRecord;
    return map;
  }

}

/// itemSeq : "1"
/// itemDate : 1732564800000
/// desc : "Improve GPA"
/// status : "I"
/// dueDate : 1732910400000
/// newRecord : false

ActionList actionListFromJson(String str) => ActionList.fromJson(json.decode(str));
String actionListToJson(ActionList data) => json.encode(data.toJson());
class ActionList {
  ActionList({
      String? itemSeq, 
      num? itemDate, 
      String? desc, 
      String? status, 
      num? dueDate, 
      bool? newRecord,}){
    _itemSeq = itemSeq;
    _itemDate = itemDate;
    _desc = desc;
    _status = status;
    _dueDate = dueDate;
    _newRecord = newRecord;
}

  ActionList.fromJson(dynamic json) {
    _itemSeq = json['itemSeq'];
    _itemDate = json['itemDate'];
    _desc = json['desc'];
    _status = json['status'];
    _dueDate = json['dueDate'];
    _newRecord = json['newRecord'];
  }
  String? _itemSeq;
  num? _itemDate;
  String? _desc;
  String? _status;
  num? _dueDate;
  bool? _newRecord;
ActionList copyWith({  String? itemSeq,
  num? itemDate,
  String? desc,
  String? status,
  num? dueDate,
  bool? newRecord,
}) => ActionList(  itemSeq: itemSeq ?? _itemSeq,
  itemDate: itemDate ?? _itemDate,
  desc: desc ?? _desc,
  status: status ?? _status,
  dueDate: dueDate ?? _dueDate,
  newRecord: newRecord ?? _newRecord,
);
  String? get itemSeq => _itemSeq;
  num? get itemDate => _itemDate;
  String? get desc => _desc;
  String? get status => _status;
  num? get dueDate => _dueDate;
  bool? get newRecord => _newRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemSeq'] = _itemSeq;
    map['itemDate'] = _itemDate;
    map['desc'] = _desc;
    map['status'] = _status;
    map['dueDate'] = _dueDate;
    map['newRecord'] = _newRecord;
    return map;
  }

}

/// itemSeq : "1"
/// noteItemLongText : "Please imporove your GPA in the current Year"
/// craetedOn : 1732564800000
/// desc2 : "Kumar1,Ajay Kumar"
/// newRecord : false

class NoteDetailList {
  // Text Editing Controllers for form fields
  TextEditingController itemSeqController;
  TextEditingController noteItemLongTextController;
  TextEditingController craetedOnController;
  TextEditingController desc2Controller;

  // Focus Nodes
  FocusNode itemSeqFocusNode;
  FocusNode noteItemLongTextFocusNode;
  FocusNode craetedOnFocusNode;
  FocusNode desc2FocusNode;

  // Error Text Variables
  String? itemSeqError;
  String? noteItemLongTextError;
  String? craetedOnError;
  String? desc2Error;

  // Additional Fields
  bool newRecord;
  bool isLoading;

  NoteDetailList({
    required this.itemSeqController,
    required this.noteItemLongTextController,
    required this.craetedOnController,
    required this.desc2Controller,
    required this.itemSeqFocusNode,
    required this.noteItemLongTextFocusNode,
    required this.craetedOnFocusNode,
    required this.desc2FocusNode,
    this.itemSeqError,
    this.noteItemLongTextError,
    this.craetedOnError,
    this.desc2Error,
    this.newRecord = false,
    this.isLoading = false,
  });

  // From JSON
  factory NoteDetailList.fromJson(Map<String, dynamic> json) {
    return NoteDetailList(
      itemSeqController: TextEditingController(text: json['itemSeq']),
      noteItemLongTextController: TextEditingController(text: json['noteItemLongText']),
      craetedOnController: TextEditingController(text: json['craetedOn']?.toString() ?? ''),
      desc2Controller: TextEditingController(text: json['desc2']),
      itemSeqFocusNode: FocusNode(),
      noteItemLongTextFocusNode: FocusNode(),
      craetedOnFocusNode: FocusNode(),
      desc2FocusNode: FocusNode(),
      newRecord: json['newRecord'] == true,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'itemSeq': itemSeqController.text,
      'noteItemLongText': noteItemLongTextController.text,
      'craetedOn': craetedOnController.text,
      'desc2': desc2Controller.text,
      'newRecord': newRecord,
    };
  }

  // Copy with method
  NoteDetailList copyWith({
    String? itemSeq,
    String? noteItemLongText,
    String? craetedOn,
    String? desc2,
    bool? newRecord,
  }) {
    return NoteDetailList(
      itemSeqController: TextEditingController(text: itemSeq ?? itemSeqController.text),
      noteItemLongTextController: TextEditingController(
          text: noteItemLongText ?? noteItemLongTextController.text),
      craetedOnController: TextEditingController(text: craetedOn ?? craetedOnController.text),
      desc2Controller: TextEditingController(text: desc2 ?? desc2Controller.text),
      itemSeqFocusNode: itemSeqFocusNode,
      noteItemLongTextFocusNode: noteItemLongTextFocusNode,
      craetedOnFocusNode: craetedOnFocusNode,
      desc2FocusNode: desc2FocusNode,
      newRecord: newRecord ?? this.newRecord,
    );
  }
}
