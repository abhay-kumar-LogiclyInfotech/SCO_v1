class GetAppVersionModel {
  GetAppVersionModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,
  });

  GetAppVersionModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'] != null ? AppVersionData.fromJson(json['data']) : null;
    error = json['error'];
  }

  String? messageCode;
  String? message;
  AppVersionData? data;
  bool? error;
}

class AppVersionData {
  AppVersionData({
    this.clientId,
    this.clientName,
    this.providerName,
    this.versionNumber,
  });

  AppVersionData.fromJson(dynamic json) {
    clientId = json['clientId'];
    clientName = json['clientName'];
    providerName = json['providerName'];
    versionNumber = json['versionNumber'];
  }

  int? clientId;
  String? clientName;
  String? providerName;
  String? versionNumber;
}
