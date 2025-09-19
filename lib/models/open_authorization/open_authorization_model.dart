class OpenAuthorizationModel {
  OpenAuthorizationModel({
      this.accessToken, 
      this.expireIn, 
      this.refreshToken, 
      this.tokenType,});

  OpenAuthorizationModel.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    expireIn = json['expireIn'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
  }
  String? accessToken;
  int? expireIn;
  String? refreshToken;
  String? tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['expireIn'] = expireIn;
    map['refreshToken'] = refreshToken;
    map['tokenType'] = tokenType;
    return map;
  }

}