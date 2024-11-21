import 'dart:convert';
/// url : "https://stg.sco.ae/image/user_female_portrait?img_id=976356&img_id_token=qRaonsVfKRpDVxTb%2BGbQVJS5myA%3D&t=1732177080672"

GetProfilePictureUrlModel getProfilePictureUrlModelFromJson(String str) => GetProfilePictureUrlModel.fromJson(json.decode(str));
String getProfilePictureUrlModelToJson(GetProfilePictureUrlModel data) => json.encode(data.toJson());
class GetProfilePictureUrlModel {
  GetProfilePictureUrlModel({
      String? url,}){
    _url = url;
}

  GetProfilePictureUrlModel.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
GetProfilePictureUrlModel copyWith({  String? url,
}) => GetProfilePictureUrlModel(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}