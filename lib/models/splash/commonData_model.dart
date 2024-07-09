class CommonDataModel {
  String? messageCode;
  String? message;
  Data? data;
  bool? error;

  CommonDataModel({this.messageCode, this.message, this.data, this.error});

  CommonDataModel.fromJson(Map<String, dynamic> json) {
    messageCode = json['messageCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageCode'] = this.messageCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  Null? message;
  List<Response>? response;

  Data({this.message, this.response});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? lovCode;
  List<Values>? values;

  Response({this.lovCode, this.values});

  Response.fromJson(Map<String, dynamic> json) {
    lovCode = json['lovCode'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lovCode'] = this.lovCode;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? code;
  String? value;
  String? valueArabic;
  String? required;
  bool? hide;
  int? order;

  Values(
      {this.code,
        this.value,
        this.valueArabic,
        this.required,
        this.hide,
        this.order});

  Values.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    valueArabic = json['valueArabic'];
    required = json['required'];
    hide = json['hide'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    data['valueArabic'] = this.valueArabic;
    data['required'] = this.required;
    data['hide'] = this.hide;
    data['order'] = this.order;
    return data;
  }
}
