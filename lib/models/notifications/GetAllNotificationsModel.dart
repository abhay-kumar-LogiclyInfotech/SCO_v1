import 'dart:convert';
/// cc : ""
/// companyId : "20099"
/// createDate : 1579489245203
/// created : 1579461339000
/// emplId : "000798"
/// from : " mopa_app@sco.ae"
/// groupId : "0"
/// importance : "3"
/// isNew : false
/// messageText : "<div>Advising Note: <a href=\"https://stg.sco.ae/web/sco/advisor-notes/-/advisee-note/note-details/00000\"><font color=\"#0066cc\">aaaaa</font></a>  Category: Academic Advisement Department               Sub Category: AcademicNote Status: Open Additional Message: test for email notification</div>"
/// modifiedDate : 1586916149896
/// notificationId : "1255"
/// notificationKey : "000798-2020-01-19T23:15:39.000+0000"
/// notificationType : "EML"
/// status : "U"
/// subject : "aaaaa"
/// to : "priya123@yopmail.com"
/// userId : "327478"
/// userName : "784199068696840"
/// uuid : "1d71d71e-5877-1776-4dab-68fbb05e9109"

GetAllNotificationsModel getAllNotificationsModelFromJson(String str) => GetAllNotificationsModel.fromJson(json.decode(str));
String getAllNotificationsModelToJson(GetAllNotificationsModel data) => json.encode(data.toJson());
class GetAllNotificationsModel {
  GetAllNotificationsModel({
      String? cc, 
      String? companyId, 
      num? createDate, 
      num? created, 
      String? emplId, 
      String? from, 
      String? groupId, 
      String? importance, 
      bool? isNew, 
      String? messageText, 
      num? modifiedDate, 
      String? notificationId, 
      String? notificationKey, 
      String? notificationType, 
      String? status, 
      String? subject, 
      String? to, 
      String? userId, 
      String? userName, 
      String? uuid,}){
    _cc = cc;
    _companyId = companyId;
    _createDate = createDate;
    _created = created;
    _emplId = emplId;
    _from = from;
    _groupId = groupId;
    _importance = importance;
    _isNew = isNew;
    _messageText = messageText;
    _modifiedDate = modifiedDate;
    _notificationId = notificationId;
    _notificationKey = notificationKey;
    _notificationType = notificationType;
    _status = status;
    _subject = subject;
    _to = to;
    _userId = userId;
    _userName = userName;
    _uuid = uuid;
}

  GetAllNotificationsModel.fromJson(dynamic json) {
    _cc = json['cc'];
    _companyId = json['companyId'];
    _createDate = json['createDate'];
    _created = json['created'];
    _emplId = json['emplId'];
    _from = json['from'];
    _groupId = json['groupId'];
    _importance = json['importance'];
    _isNew = json['isNew'];
    _messageText = json['messageText'];
    _modifiedDate = json['modifiedDate'];
    _notificationId = json['notificationId'];
    _notificationKey = json['notificationKey'];
    _notificationType = json['notificationType'];
    _status = json['status'];
    _subject = json['subject'];
    _to = json['to'];
    _userId = json['userId'];
    _userName = json['userName'];
    _uuid = json['uuid'];
  }
  String? _cc;
  String? _companyId;
  num? _createDate;
  num? _created;
  String? _emplId;
  String? _from;
  String? _groupId;
  String? _importance;
  bool? _isNew;
  String? _messageText;
  num? _modifiedDate;
  String? _notificationId;
  String? _notificationKey;
  String? _notificationType;
  String? _status;
  String? _subject;
  String? _to;
  String? _userId;
  String? _userName;
  String? _uuid;
GetAllNotificationsModel copyWith({  String? cc,
  String? companyId,
  num? createDate,
  num? created,
  String? emplId,
  String? from,
  String? groupId,
  String? importance,
  bool? isNew,
  String? messageText,
  num? modifiedDate,
  String? notificationId,
  String? notificationKey,
  String? notificationType,
  String? status,
  String? subject,
  String? to,
  String? userId,
  String? userName,
  String? uuid,
}) => GetAllNotificationsModel(  cc: cc ?? _cc,
  companyId: companyId ?? _companyId,
  createDate: createDate ?? _createDate,
  created: created ?? _created,
  emplId: emplId ?? _emplId,
  from: from ?? _from,
  groupId: groupId ?? _groupId,
  importance: importance ?? _importance,
  isNew: isNew ?? _isNew,
  messageText: messageText ?? _messageText,
  modifiedDate: modifiedDate ?? _modifiedDate,
  notificationId: notificationId ?? _notificationId,
  notificationKey: notificationKey ?? _notificationKey,
  notificationType: notificationType ?? _notificationType,
  status: status ?? _status,
  subject: subject ?? _subject,
  to: to ?? _to,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  uuid: uuid ?? _uuid,
);
  String? get cc => _cc;
  String? get companyId => _companyId;
  num? get createDate => _createDate;
  num? get created => _created;
  String? get emplId => _emplId;
  String? get from => _from;
  String? get groupId => _groupId;
  String? get importance => _importance;
  bool? get isNew => _isNew;
  String? get messageText => _messageText;
  num? get modifiedDate => _modifiedDate;
  String? get notificationId => _notificationId;
  String? get notificationKey => _notificationKey;
  String? get notificationType => _notificationType;
  String? get status => _status;
  String? get subject => _subject;
  String? get to => _to;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get uuid => _uuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cc'] = _cc;
    map['companyId'] = _companyId;
    map['createDate'] = _createDate;
    map['created'] = _created;
    map['emplId'] = _emplId;
    map['from'] = _from;
    map['groupId'] = _groupId;
    map['importance'] = _importance;
    map['isNew'] = _isNew;
    map['messageText'] = _messageText;
    map['modifiedDate'] = _modifiedDate;
    map['notificationId'] = _notificationId;
    map['notificationKey'] = _notificationKey;
    map['notificationType'] = _notificationType;
    map['status'] = _status;
    map['subject'] = _subject;
    map['to'] = _to;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['uuid'] = _uuid;
    return map;
  }

}