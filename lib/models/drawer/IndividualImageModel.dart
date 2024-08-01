/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"imageUrl":"https://stg.sco.ae/documents/20126/78354/%D8%A8%D8%B9%D8%AB%D8%A9+%D8%B1%D8%A6%D9%8A%D8%B3+%D8%A7%D9%84%D8%AF%D9%88%D9%84%D8%A9+%D9%84%D9%84%D8%AF%D8%B1%D8%A7%D8%B3%D8%A9+%D9%81%D9%8A+%D8%A7%D9%84%D8%AE%D8%A7%D8%B1%D8%AC+2019.jpg/7088bdd2-d11a-9d28-8edc-e90c78f9f0c1?version=1.0&t=1568607918785&imagePreview=1"}
/// error : false

class IndividualImageModel {
  IndividualImageModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  IndividualImageModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
IndividualImageModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => IndividualImageModel(  messageCode: messageCode ?? _messageCode,
  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  String? get messageCode => _messageCode;
  String? get message => _message;
  Data? get data => _data;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = _messageCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// imageUrl : "https://stg.sco.ae/documents/20126/78354/%D8%A8%D8%B9%D8%AB%D8%A9+%D8%B1%D8%A6%D9%8A%D8%B3+%D8%A7%D9%84%D8%AF%D9%88%D9%84%D8%A9+%D9%84%D9%84%D8%AF%D8%B1%D8%A7%D8%B3%D8%A9+%D9%81%D9%8A+%D8%A7%D9%84%D8%AE%D8%A7%D8%B1%D8%AC+2019.jpg/7088bdd2-d11a-9d28-8edc-e90c78f9f0c1?version=1.0&t=1568607918785&imagePreview=1"

class Data {
  Data({
      String? imageUrl,}){
    _imageUrl = imageUrl;
}

  Data.fromJson(dynamic json) {
    _imageUrl = json['imageUrl'];
  }
  String? _imageUrl;
Data copyWith({  String? imageUrl,
}) => Data(  imageUrl: imageUrl ?? _imageUrl,
);
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = _imageUrl;
    return map;
  }

}