//
// class ContactUsModel {
//   ContactUsModel({
//       String? comments,
//       String? companyId,
//       String? contactUsStatus,
//       String? contactUsType,
//       num? createDate,
//       String? email,
//       String? entryId,
//       String? fullname,
//       String? groupId,
//       dynamic lastPublishDate,
//       String? modifiedBy,
//       num? modifiedDate,
//       String? phoneNumber,
//       String? reply,
//       String? replyBy,
//       dynamic replyOn,
//       bool? spam,
//       num? status,
//       String? statusByUserId,
//       String? statusByUserName,
//       dynamic statusDate,
//       String? subject,
//       String? userId,
//       String? userName,
//       String? uuid,
//       String? year,}){
//     _comments = comments;
//     _companyId = companyId;
//     _contactUsStatus = contactUsStatus;
//     _contactUsType = contactUsType;
//     _createDate = createDate;
//     _email = email;
//     _entryId = entryId;
//     _fullname = fullname;
//     _groupId = groupId;
//     _lastPublishDate = lastPublishDate;
//     _modifiedBy = modifiedBy;
//     _modifiedDate = modifiedDate;
//     _phoneNumber = phoneNumber;
//     _reply = reply;
//     _replyBy = replyBy;
//     _replyOn = replyOn;
//     _spam = spam;
//     _status = status;
//     _statusByUserId = statusByUserId;
//     _statusByUserName = statusByUserName;
//     _statusDate = statusDate;
//     _subject = subject;
//     _userId = userId;
//     _userName = userName;
//     _uuid = uuid;
//     _year = year;
// }
//
//   ContactUsModel.fromJson(dynamic json) {
//     _comments = json['comments'];
//     _companyId = json['companyId'];
//     _contactUsStatus = json['contactUsStatus'];
//     _contactUsType = json['contactUsType'];
//     _createDate = json['createDate'];
//     _email = json['email'];
//     _entryId = json['entryId'];
//     _fullname = json['fullname'];
//     _groupId = json['groupId'];
//     _lastPublishDate = json['lastPublishDate'];
//     _modifiedBy = json['modifiedBy'];
//     _modifiedDate = json['modifiedDate'];
//     _phoneNumber = json['phoneNumber'];
//     _reply = json['reply'];
//     _replyBy = json['replyBy'];
//     _replyOn = json['replyOn'];
//     _spam = json['spam'];
//     _status = json['status'];
//     _statusByUserId = json['statusByUserId'];
//     _statusByUserName = json['statusByUserName'];
//     _statusDate = json['statusDate'];
//     _subject = json['subject'];
//     _userId = json['userId'];
//     _userName = json['userName'];
//     _uuid = json['uuid'];
//     _year = json['year'];
//   }
//   String? _comments;
//   String? _companyId;
//   String? _contactUsStatus;
//   String? _contactUsType;
//   num? _createDate;
//   String? _email;
//   String? _entryId;
//   String? _fullname;
//   String? _groupId;
//   dynamic _lastPublishDate;
//   String? _modifiedBy;
//   num? _modifiedDate;
//   String? _phoneNumber;
//   String? _reply;
//   String? _replyBy;
//   dynamic _replyOn;
//   bool? _spam;
//   num? _status;
//   String? _statusByUserId;
//   String? _statusByUserName;
//   dynamic _statusDate;
//   String? _subject;
//   String? _userId;
//   String? _userName;
//   String? _uuid;
//   String? _year;
// ContactUsModel copyWith({  String? comments,
//   String? companyId,
//   String? contactUsStatus,
//   String? contactUsType,
//   num? createDate,
//   String? email,
//   String? entryId,
//   String? fullname,
//   String? groupId,
//   dynamic lastPublishDate,
//   String? modifiedBy,
//   num? modifiedDate,
//   String? phoneNumber,
//   String? reply,
//   String? replyBy,
//   dynamic replyOn,
//   bool? spam,
//   num? status,
//   String? statusByUserId,
//   String? statusByUserName,
//   dynamic statusDate,
//   String? subject,
//   String? userId,
//   String? userName,
//   String? uuid,
//   String? year,
// }) => ContactUsModel(  comments: comments ?? _comments,
//   companyId: companyId ?? _companyId,
//   contactUsStatus: contactUsStatus ?? _contactUsStatus,
//   contactUsType: contactUsType ?? _contactUsType,
//   createDate: createDate ?? _createDate,
//   email: email ?? _email,
//   entryId: entryId ?? _entryId,
//   fullname: fullname ?? _fullname,
//   groupId: groupId ?? _groupId,
//   lastPublishDate: lastPublishDate ?? _lastPublishDate,
//   modifiedBy: modifiedBy ?? _modifiedBy,
//   modifiedDate: modifiedDate ?? _modifiedDate,
//   phoneNumber: phoneNumber ?? _phoneNumber,
//   reply: reply ?? _reply,
//   replyBy: replyBy ?? _replyBy,
//   replyOn: replyOn ?? _replyOn,
//   spam: spam ?? _spam,
//   status: status ?? _status,
//   statusByUserId: statusByUserId ?? _statusByUserId,
//   statusByUserName: statusByUserName ?? _statusByUserName,
//   statusDate: statusDate ?? _statusDate,
//   subject: subject ?? _subject,
//   userId: userId ?? _userId,
//   userName: userName ?? _userName,
//   uuid: uuid ?? _uuid,
//   year: year ?? _year,
// );
//   String? get comments => _comments;
//   String? get companyId => _companyId;
//   String? get contactUsStatus => _contactUsStatus;
//   String? get contactUsType => _contactUsType;
//   num? get createDate => _createDate;
//   String? get email => _email;
//   String? get entryId => _entryId;
//   String? get fullname => _fullname;
//   String? get groupId => _groupId;
//   dynamic get lastPublishDate => _lastPublishDate;
//   String? get modifiedBy => _modifiedBy;
//   num? get modifiedDate => _modifiedDate;
//   String? get phoneNumber => _phoneNumber;
//   String? get reply => _reply;
//   String? get replyBy => _replyBy;
//   dynamic get replyOn => _replyOn;
//   bool? get spam => _spam;
//   num? get status => _status;
//   String? get statusByUserId => _statusByUserId;
//   String? get statusByUserName => _statusByUserName;
//   dynamic get statusDate => _statusDate;
//   String? get subject => _subject;
//   String? get userId => _userId;
//   String? get userName => _userName;
//   String? get uuid => _uuid;
//   String? get year => _year;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['comments'] = _comments;
//     map['companyId'] = _companyId;
//     map['contactUsStatus'] = _contactUsStatus;
//     map['contactUsType'] = _contactUsType;
//     map['createDate'] = _createDate;
//     map['email'] = _email;
//     map['entryId'] = _entryId;
//     map['fullname'] = _fullname;
//     map['groupId'] = _groupId;
//     map['lastPublishDate'] = _lastPublishDate;
//     map['modifiedBy'] = _modifiedBy;
//     map['modifiedDate'] = _modifiedDate;
//     map['phoneNumber'] = _phoneNumber;
//     map['reply'] = _reply;
//     map['replyBy'] = _replyBy;
//     map['replyOn'] = _replyOn;
//     map['spam'] = _spam;
//     map['status'] = _status;
//     map['statusByUserId'] = _statusByUserId;
//     map['statusByUserName'] = _statusByUserName;
//     map['statusDate'] = _statusDate;
//     map['subject'] = _subject;
//     map['userId'] = _userId;
//     map['userName'] = _userName;
//     map['uuid'] = _uuid;
//     map['year'] = _year;
//     return map;
//   }
//
// }

class ContactUsModel {
  ContactUsModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,});

  ContactUsModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }
  String? messageCode;
  String? message;
  dynamic data;
  bool? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = messageCode;
    map['message'] = message;
    map['data'] = data;
    map['error'] = error;
    return map;
  }

}