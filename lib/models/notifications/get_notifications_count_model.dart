class GetNotificationsCountModel {
  GetNotificationsCountModel({
      this.messageCode, 
      this.message, 
      this.data, 
      this.error,});

  GetNotificationsCountModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }
  String? messageCode;
  String? message;
  int? data;
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