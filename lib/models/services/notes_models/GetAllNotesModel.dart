class GetAllNotesModel {
  String? messageCode;
  String? message;
  Data? data;
  bool? error;

  GetAllNotesModel({this.messageCode, this.message, this.data, this.error});

  GetAllNotesModel.fromJson(Map<String, dynamic> json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageCode'] = this.messageCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? status;
  String? errorMessage;
  List<AdviseeNotes>? adviseeNotes;
  String? adviseeNote;
  String? emplId;
  String? noteId;
  String? institution;

  Data({
    this.status,
    this.errorMessage,
    this.adviseeNotes,
    this.adviseeNote,
    this.emplId,
    this.noteId,
    this.institution,
  });

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorMessage = json['errorMessage'];
    if (json['adviseeNotes'] != null) {
      adviseeNotes = <AdviseeNotes>[];
      json['adviseeNotes'].forEach((v) {
        adviseeNotes!.add(AdviseeNotes.fromJson(v));
      });
    }
    adviseeNote = json['adviseeNote'];
    emplId = json['emplId'];
    noteId = json['noteId'];
    institution = json['institution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['errorMessage'] = this.errorMessage;
    if (this.adviseeNotes != null) {
      data['adviseeNotes'] = this.adviseeNotes!.map((v) => v.toJson()).toList();
    }
    data['adviseeNote'] = this.adviseeNote;
    data['emplId'] = this.emplId;
    data['noteId'] = this.noteId;
    data['institution'] = this.institution;
    return data;
  }
}

class AdviseeNotes {
  String? emplId;
  String? institution;
  String? institutionName;
  String? noteId;
  String? itemSeqNumber;
  String? noteType;
  String? noteSubType;
  String? advisorId;
  String? advisorName;
  String? noteStatus;
  String? createdOrpid;
  String? createdBy;
  String? addDateTime;
  String? description;
  String? access;
  String? contactType;
  String? subject;
  dynamic? createdOn;
  dynamic? updatedOn;
  List<dynamic>? noteDetailList;
  List<dynamic>? actionList;
  List<dynamic>? listOfAttachments;

  AdviseeNotes({
    this.emplId,
    this.institution,
    this.institutionName,
    this.noteId,
    this.itemSeqNumber,
    this.noteType,
    this.noteSubType,
    this.advisorId,
    this.advisorName,
    this.noteStatus,
    this.createdOrpid,
    this.createdBy,
    this.addDateTime,
    this.description,
    this.access,
    this.contactType,
    this.subject,
    this.createdOn,
    this.updatedOn,
    this.noteDetailList,
    this.actionList,
    this.listOfAttachments,
  });

  AdviseeNotes.fromJson(Map<String, dynamic> json) {
    emplId = json['emplId'];
    institution = json['institution'];
    institutionName = json['institutionName'];
    noteId = json['noteId'];
    itemSeqNumber = json['itemSeqNumber'];
    noteType = json['noteType'];
    noteSubType = json['noteSubType'];
    advisorId = json['advisorId'];
    advisorName = json['advisorName'];
    noteStatus = json['noteStatus'];
    createdOrpid = json['createdOrpid'];
    createdBy = json['createdBy'];
    addDateTime = json['addDateTime'];
    description = json['description'];
    access = json['access'];
    contactType = json['contactType'];
    subject = json['subject'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];

    // Handling empty or null lists in JSON
    noteDetailList = json['noteDetailList'] != null ? List.from(json['noteDetailList']) : [];
    actionList = json['actionList'] != null ? List.from(json['actionList']) : [];
    listOfAttachments = json['listOfAttachments'] != null ? List.from(json['listOfAttachments']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emplId'] = this.emplId;
    data['institution'] = this.institution;
    data['institutionName'] = this.institutionName;
    data['noteId'] = this.noteId;
    data['itemSeqNumber'] = this.itemSeqNumber;
    data['noteType'] = this.noteType;
    data['noteSubType'] = this.noteSubType;
    data['advisorId'] = this.advisorId;
    data['advisorName'] = this.advisorName;
    data['noteStatus'] = this.noteStatus;
    data['createdOrpid'] = this.createdOrpid;
    data['createdBy'] = this.createdBy;
    data['addDateTime'] = this.addDateTime;
    data['description'] = this.description;
    data['access'] = this.access;
    data['contactType'] = this.contactType;
    data['subject'] = this.subject;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;

    // Handling lists for serialization
    data['noteDetailList'] = this.noteDetailList;
    data['actionList'] = this.actionList;
    data['listOfAttachments'] = this.listOfAttachments;

    return data;
  }
}
