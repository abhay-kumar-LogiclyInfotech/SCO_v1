import 'dart:convert';
/// requestCategory : "AA"
/// requestType : "AA"
/// requestSubType : "1"
/// fields : [{"title":"Suspension semester:","type":"text","required":true},{"title":"Reason for suspension:","type":"text","required":true},{"title":"GPA:","type":"number","required":true},{"title":"Attach the last academic record:","type":"file","required":true},null]
/// conditions : ["الحصول على موافقة مسبقة من المكتب","أن لا يؤثر الإيقاف بالانسحاب من مواد وسداد رسوم دراسية"]

RequestStructureModel requestStructureModelFromJson(String str) => RequestStructureModel.fromJson(json.decode(str));
String requestStructureModelToJson(RequestStructureModel data) => json.encode(data.toJson());
class RequestStructureModel {
  RequestStructureModel({
      String? requestCategory, 
      String? requestType, 
      String? requestSubType, 
      List<Fields>? fields, 
      List<String>? conditions,}){
    _requestCategory = requestCategory;
    _requestType = requestType;
    _requestSubType = requestSubType;
    _fields = fields;
    _conditions = conditions;
}

  RequestStructureModel.fromJson(dynamic json) {
    _requestCategory = json['requestCategory'];
    _requestType = json['requestType'];
    _requestSubType = json['requestSubType'];
    if (json['fields'] != null) {
      _fields = [];
      json['fields'].forEach((v) {
        _fields?.add(Fields.fromJson(v));
      });
    }
    _conditions = json['conditions'] != null ? json['conditions'].cast<String>() : [];
  }
  String? _requestCategory;
  String? _requestType;
  String? _requestSubType;
  List<Fields>? _fields;
  List<String>? _conditions;
RequestStructureModel copyWith({  String? requestCategory,
  String? requestType,
  String? requestSubType,
  List<Fields>? fields,
  List<String>? conditions,
}) => RequestStructureModel(  requestCategory: requestCategory ?? _requestCategory,
  requestType: requestType ?? _requestType,
  requestSubType: requestSubType ?? _requestSubType,
  fields: fields ?? _fields,
  conditions: conditions ?? _conditions,
);
  String? get requestCategory => _requestCategory;
  String? get requestType => _requestType;
  String? get requestSubType => _requestSubType;
  List<Fields>? get fields => _fields;
  List<String>? get conditions => _conditions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestCategory'] = _requestCategory;
    map['requestType'] = _requestType;
    map['requestSubType'] = _requestSubType;
    if (_fields != null) {
      map['fields'] = _fields?.map((v) => v.toJson()).toList();
    }
    map['conditions'] = _conditions;
    return map;
  }

}

/// title : "Suspension semester:"
/// type : "text"
/// required : true

Fields fieldsFromJson(String str) => Fields.fromJson(json.decode(str));
String fieldsToJson(Fields data) => json.encode(data.toJson());
class Fields {
  Fields({
      String? title, 
      String? type, 
      bool? required,}){
    _title = title;
    _type = type;
    _required = required;
}

  Fields.fromJson(dynamic json) {
    _title = json['title'];
    _type = json['type'];
    _required = json['required'];
  }
  String? _title;
  String? _type;
  bool? _required;
Fields copyWith({  String? title,
  String? type,
  bool? required,
}) => Fields(  title: title ?? _title,
  type: type ?? _type,
  required: required ?? _required,
);
  String? get title => _title;
  String? get type => _type;
  bool? get required => _required;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['type'] = _type;
    map['required'] = _required;
    return map;
  }

}