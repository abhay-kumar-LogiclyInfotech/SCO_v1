//Annotated Hive Common Data Model:
import 'package:hive/hive.dart';

part 'commonData_model.g.dart';

@HiveType(typeId: 0)
class CommonDataModel extends HiveObject {
  @HiveField(0)
  String? messageCode;

  @HiveField(1)
  String? message;

  @HiveField(2)
  Data? data;

  @HiveField(3)
  bool? error;

  CommonDataModel({this.messageCode, this.message, this.data, this.error});

  factory CommonDataModel.fromJson(Map<String, dynamic> json) {
    return CommonDataModel(
      messageCode: json['messageCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageCode': messageCode,
      'message': message,
      'data': data?.toJson(),
      'error': error,
    };
  }
}

@HiveType(typeId: 1)
class Data extends HiveObject {
  @HiveField(0)
  String? message;

  @HiveField(1)
  List<Response>? response;

  Data({this.message, this.response});

  factory Data.fromJson(Map<String, dynamic> json) {
    var responseList = json['response'] as List?;
    List<Response> response = responseList != null
        ? responseList.map((i) => Response.fromJson(i)).toList()
        : [];
    return Data(
      message: json['message'],
      response: response,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'response': response?.map((e) => e.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 2)
class Response extends HiveObject {
  @HiveField(0)
  String? lovCode;

  @HiveField(1)
  List<Values>? values;

  Response({this.lovCode, this.values});

  factory Response.fromJson(Map<String, dynamic> json) {
    var valuesList = json['values'] as List?;
    List<Values> values = valuesList != null
        ? valuesList.map((i) => Values.fromJson(i)).toList()
        : [];
    return Response(
      lovCode: json['lovCode'],
      values: values,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lovCode': lovCode,
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 3)
class Values extends HiveObject {
  @HiveField(0)
  String? code;

  @HiveField(1)
  String? value;

  @HiveField(2)
  String? valueArabic;

  @HiveField(3)
  String? required;

  @HiveField(4)
  bool? hide;

  @HiveField(5)
  int? order;

  Values({
    this.code,
    this.value,
    this.valueArabic,
    this.required,
    this.hide,
    this.order,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      code: json['code'],
      value: json['value'],
      valueArabic: json['valueArabic'],
      required: json['required'],
      hide: json['hide'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'value': value,
      'valueArabic': valueArabic,
      'required': required,
      'hide': hide,
      'order': order,
    };
  }
}
