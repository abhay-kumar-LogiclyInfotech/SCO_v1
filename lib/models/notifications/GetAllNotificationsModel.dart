import 'dart:convert';

/// Converts JSON string to model
GetAllNotificationsModel getAllNotificationsModelFromJson(String str) =>
    GetAllNotificationsModel.fromJson(json.decode(str));

/// Converts model to JSON string
String getAllNotificationsModelToJson(GetAllNotificationsModel data) =>
    json.encode(data.toJson());

class GetAllNotificationsModel {
  final String? cc;
  final String? companyId;
  final int? createDate; // Timestamp
  final int? created; // Timestamp
  final String? emplId;
  final String? from;
  final String? groupId;
  final String? importance;
  final bool? isNew;
  final String? messageText;
  final int? modifiedDate; // Timestamp
  final String? notificationId;
  final String? notificationKey;
  final String? notificationType;
  final String? status;
  final String? subject;
  final String? to;
  final String? userId;
  final String? userName;
  final String? uuid;

  /// Constructor with named parameters
  GetAllNotificationsModel({
    this.cc,
    this.companyId,
    this.createDate,
    this.created,
    this.emplId,
    this.from,
    this.groupId,
    this.importance,
    this.isNew,
    this.messageText,
    this.modifiedDate,
    this.notificationId,
    this.notificationKey,
    this.notificationType,
    this.status,
    this.subject,
    this.to,
    this.userId,
    this.userName,
    this.uuid,
  });

  /// Factory constructor for JSON parsing
  factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsModel(
      cc: json['cc'] as String?,
      companyId: json['companyId'] as String?,
      createDate: json['createDate'] as int?,
      created: json['created'] as int?,
      emplId: json['emplId'] as String?,
      from: json['from'] as String?,
      groupId: json['groupId'] as String?,
      importance: json['importance'] as String?,
      isNew: json['isNew'] as bool?,
      messageText: json['messageText'] as String?,
      modifiedDate: json['modifiedDate'] as int?,
      notificationId: json['notificationId'] as String?,
      notificationKey: json['notificationKey'] as String?,
      notificationType: json['notificationType'] as String?,
      status: json['status'] as String?,
      subject: json['subject'] as String?,
      to: json['to'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      uuid: json['uuid'] as String?,
    );
  }

  /// Converts model to JSON map
  Map<String, dynamic> toJson() => {
    'cc': cc,
    'companyId': companyId,
    'createDate': createDate,
    'created': created,
    'emplId': emplId,
    'from': from,
    'groupId': groupId,
    'importance': importance,
    'isNew': isNew,
    'messageText': messageText,
    'modifiedDate': modifiedDate,
    'notificationId': notificationId,
    'notificationKey': notificationKey,
    'notificationType': notificationType,
    'status': status,
    'subject': subject,
    'to': to,
    'userId': userId,
    'userName': userName,
    'uuid': uuid,
  };
}
