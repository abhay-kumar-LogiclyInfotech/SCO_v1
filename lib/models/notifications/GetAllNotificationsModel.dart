// import 'dart:convert';
//
// /// Converts JSON string to model
// GetAllNotificationsModel getAllNotificationsModelFromJson(String str) =>
//     GetAllNotificationsModel.fromJson(json.decode(str));
//
// /// Converts model to JSON string
// String getAllNotificationsModelToJson(GetAllNotificationsModel data) =>
//     json.encode(data.toJson());
//
// class GetAllNotificationsModel {
//   final String? cc;
//   final String? companyId;
//   final int? createDate; // Timestamp
//   final int? created; // Timestamp
//   final String? emplId;
//   final String? from;
//   final String? groupId;
//   final String? importance;
//   final bool? isNew;
//   final String? messageText;
//   final int? modifiedDate; // Timestamp
//   final String? notificationId;
//   final String? notificationKey;
//   final String? notificationType;
//   final String? status;
//   final String? subject;
//   final String? to;
//   final String? userId;
//   final String? userName;
//   final String? uuid;
//
//   /// Constructor with named parameters
//   GetAllNotificationsModel({
//     this.cc,
//     this.companyId,
//     this.createDate,
//     this.created,
//     this.emplId,
//     this.from,
//     this.groupId,
//     this.importance,
//     this.isNew,
//     this.messageText,
//     this.modifiedDate,
//     this.notificationId,
//     this.notificationKey,
//     this.notificationType,
//     this.status,
//     this.subject,
//     this.to,
//     this.userId,
//     this.userName,
//     this.uuid,
//   });
//
//   /// Factory constructor for JSON parsing
//   factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
//     return GetAllNotificationsModel(
//       cc: json['cc'] as String?,
//       companyId: json['companyId'] as String?,
//       createDate: json['createDate'] as int?,
//       created: json['created'] as int?,
//       emplId: json['emplId'] as String?,
//       from: json['from'] as String?,
//       groupId: json['groupId'] as String?,
//       importance: json['importance'] as String?,
//       isNew: json['isNew'] as bool?,
//       messageText: json['messageText'] as String?,
//       modifiedDate: json['modifiedDate'] as int?,
//       notificationId: json['notificationId'] as String?,
//       notificationKey: json['notificationKey'] as String?,
//       notificationType: json['notificationType'] as String?,
//       status: json['status'] as String?,
//       subject: json['subject'] as String?,
//       to: json['to'] as String?,
//       userId: json['userId'] as String?,
//       userName: json['userName'] as String?,
//       uuid: json['uuid'] as String?,
//     );
//   }
//
//   /// Converts model to JSON map
//   Map<String, dynamic> toJson() => {
//     'cc': cc,
//     'companyId': companyId,
//     'createDate': createDate,
//     'created': created,
//     'emplId': emplId,
//     'from': from,
//     'groupId': groupId,
//     'importance': importance,
//     'isNew': isNew,
//     'messageText': messageText,
//     'modifiedDate': modifiedDate,
//     'notificationId': notificationId,
//     'notificationKey': notificationKey,
//     'notificationType': notificationType,
//     'status': status,
//     'subject': subject,
//     'to': to,
//     'userId': userId,
//     'userName': userName,
//     'uuid': uuid,
//   };
// }

class GetAllNotificationsModel {
  GetAllNotificationsModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,});

  GetAllNotificationsModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
    error = json['error'];
  }
  String? messageCode;
  String? message;
  List<NotificationData>? data;
  bool? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = messageCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['error'] = error;
    return map;
  }

}

class NotificationData {
  NotificationData({
    this.notificationId,
    this.companyId,
    this.userId,
    this.userName,
    this.createDate,
    this.modifiedDate,
    this.notificationKey,
    this.notificationType,
    this.created,
    this.from,
    this.subject,
    this.status,
    this.to,
    this.cc,
    this.messageText,
    this.emplId,
    this.isNew,});

  NotificationData.fromJson(dynamic json) {
    notificationId = json['notificationId'];
    companyId = json['companyId'];
    userId = json['userId'];
    userName = json['userName'];
    createDate = json['createDate'];
    modifiedDate = json['modifiedDate'];
    notificationKey = json['notificationKey'];
    notificationType = json['notificationType'];
    created = json['created'];
    from = json['from'];
    subject = json['subject'];
    status = json['status'];
    to = json['to'];
    cc = json['cc'];
    messageText = json['messageText'];
    emplId = json['emplId'];
    isNew = json['isNew'];
  }
  int? notificationId;
  int? companyId;
  int? userId;
  String? userName;
  int? createDate;
  int? modifiedDate;
  String? notificationKey;
  String? notificationType;
  int? created;
  String? from;
  String? subject;
  String? status;
  String? to;
  String? cc;
  String? messageText;
  String? emplId;
  bool? isNew;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notificationId'] = notificationId;
    map['companyId'] = companyId;
    map['userId'] = userId;
    map['userName'] = userName;
    map['createDate'] = createDate;
    map['modifiedDate'] = modifiedDate;
    map['notificationKey'] = notificationKey;
    map['notificationType'] = notificationType;
    map['created'] = created;
    map['from'] = from;
    map['subject'] = subject;
    map['status'] = status;
    map['to'] = to;
    map['cc'] = cc;
    map['messageText'] = messageText;
    map['emplId'] = emplId;
    map['isNew'] = isNew;
    return map;
  }

}