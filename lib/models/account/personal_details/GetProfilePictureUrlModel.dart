// import 'dart:convert';
// /// url : "https://stg.sco.ae/image/user_female_portrait?img_id=976356&img_id_token=qRaonsVfKRpDVxTb%2BGbQVJS5myA%3D&t=1732177080672"
//
// GetProfilePictureUrlModel getProfilePictureUrlModelFromJson(String str) => GetProfilePictureUrlModel.fromJson(json.decode(str));
// String getProfilePictureUrlModelToJson(GetProfilePictureUrlModel data) => json.encode(data.toJson());
// class GetProfilePictureUrlModel {
//   GetProfilePictureUrlModel({
//       String? url,}){
//     _url = url;
// }
//
//   GetProfilePictureUrlModel.fromJson(dynamic json) {
//     _url = json['url'];
//   }
//   String? _url;
// GetProfilePictureUrlModel copyWith({  String? url,
// }) => GetProfilePictureUrlModel(  url: url ?? _url,
// );
//   String? get url => _url;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['url'] = _url;
//     return map;
//   }
//
// }

class GetProfilePictureUrlModel {
  GetProfilePictureUrlModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,});

  GetProfilePictureUrlModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
  String? messageCode;
  String? message;
  Data? data;
  bool? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = messageCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error'] = error;
    return map;
  }

}

class Data {
  Data({
    this.url,});

  Data.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}