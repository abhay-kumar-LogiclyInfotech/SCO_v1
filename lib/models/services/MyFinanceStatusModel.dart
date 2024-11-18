import 'dart:convert';
/// messageCode : "0000"
/// message : "Operation Completed Successfully"
/// data : {"emplId":"000921","username":"784196207416171","status":null,"errorMessage":null,"listSalaryDetials":[{"name":"قشققشق قشعق قشق قشعش","bankName":"","salaryMonth":"April 2020","currency":"","status":"","bankBeneficiary":"","amount":0}],"listBonus":[{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Book/ Bachelor for Arab Count","amount":100,"currencyCode":"AED","periodIdCode":"APR20","periodIdDescription":"April 2020"}],"listDeduction":[{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","totalDeduction":200,"totalDeducted":0,"deductionPending":200,"currencyCode":"AED"}],"listWarnings":[{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Fall  2019","warningCertificate":"WAR1"},{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Fall  2020","warningCertificate":"WAR1"},{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Winter  2020","warningCertificate":"WAR1"}]}
/// error : false

MyFinanceStatusModel myFinanceStatusModelFromJson(String str) => MyFinanceStatusModel.fromJson(json.decode(str));
String myFinanceStatusModelToJson(MyFinanceStatusModel data) => json.encode(data.toJson());
class MyFinanceStatusModel {
  MyFinanceStatusModel({
      String? messageCode, 
      String? message, 
      Data? data, 
      bool? error,}){
    _messageCode = messageCode;
    _message = message;
    _data = data;
    _error = error;
}

  MyFinanceStatusModel.fromJson(dynamic json) {
    _messageCode = json['messageCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _messageCode;
  String? _message;
  Data? _data;
  bool? _error;
MyFinanceStatusModel copyWith({  String? messageCode,
  String? message,
  Data? data,
  bool? error,
}) => MyFinanceStatusModel(  messageCode: messageCode ?? _messageCode,
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

/// emplId : "000921"
/// username : "784196207416171"
/// status : null
/// errorMessage : null
/// listSalaryDetials : [{"name":"قشققشق قشعق قشق قشعش","bankName":"","salaryMonth":"April 2020","currency":"","status":"","bankBeneficiary":"","amount":0}]
/// listBonus : [{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Book/ Bachelor for Arab Count","amount":100,"currencyCode":"AED","periodIdCode":"APR20","periodIdDescription":"April 2020"}]
/// listDeduction : [{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","totalDeduction":200,"totalDeducted":0,"deductionPending":200,"currencyCode":"AED"}]
/// listWarnings : [{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Fall  2019","warningCertificate":"WAR1"},{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Fall  2020","warningCertificate":"WAR1"},{"emplId":"000921","name":"قشققشق قشعق قشق قشعش","termDescription":"Winter  2020","warningCertificate":"WAR1"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? emplId, 
      String? username, 
      dynamic status, 
      dynamic errorMessage, 
      List<ListSalaryDetials>? listSalaryDetials, 
      List<ListBonus>? listBonus, 
      List<ListDeduction>? listDeduction, 
      List<ListWarnings>? listWarnings,}){
    _emplId = emplId;
    _username = username;
    _status = status;
    _errorMessage = errorMessage;
    _listSalaryDetials = listSalaryDetials;
    _listBonus = listBonus;
    _listDeduction = listDeduction;
    _listWarnings = listWarnings;
}

  Data.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _username = json['username'];
    _status = json['status'];
    _errorMessage = json['errorMessage'];
    if (json['listSalaryDetials'] != null) {
      _listSalaryDetials = [];
      json['listSalaryDetials'].forEach((v) {
        _listSalaryDetials?.add(ListSalaryDetials.fromJson(v));
      });
    }
    if (json['listBonus'] != null) {
      _listBonus = [];
      json['listBonus'].forEach((v) {
        _listBonus?.add(ListBonus.fromJson(v));
      });
    }
    if (json['listDeduction'] != null) {
      _listDeduction = [];
      json['listDeduction'].forEach((v) {
        _listDeduction?.add(ListDeduction.fromJson(v));
      });
    }
    if (json['listWarnings'] != null) {
      _listWarnings = [];
      json['listWarnings'].forEach((v) {
        _listWarnings?.add(ListWarnings.fromJson(v));
      });
    }
  }
  String? _emplId;
  String? _username;
  dynamic _status;
  dynamic _errorMessage;
  List<ListSalaryDetials>? _listSalaryDetials;
  List<ListBonus>? _listBonus;
  List<ListDeduction>? _listDeduction;
  List<ListWarnings>? _listWarnings;
Data copyWith({  String? emplId,
  String? username,
  dynamic status,
  dynamic errorMessage,
  List<ListSalaryDetials>? listSalaryDetials,
  List<ListBonus>? listBonus,
  List<ListDeduction>? listDeduction,
  List<ListWarnings>? listWarnings,
}) => Data(  emplId: emplId ?? _emplId,
  username: username ?? _username,
  status: status ?? _status,
  errorMessage: errorMessage ?? _errorMessage,
  listSalaryDetials: listSalaryDetials ?? _listSalaryDetials,
  listBonus: listBonus ?? _listBonus,
  listDeduction: listDeduction ?? _listDeduction,
  listWarnings: listWarnings ?? _listWarnings,
);
  String? get emplId => _emplId;
  String? get username => _username;
  dynamic get status => _status;
  dynamic get errorMessage => _errorMessage;
  List<ListSalaryDetials>? get listSalaryDetials => _listSalaryDetials;
  List<ListBonus>? get listBonus => _listBonus;
  List<ListDeduction>? get listDeduction => _listDeduction;
  List<ListWarnings>? get listWarnings => _listWarnings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['username'] = _username;
    map['status'] = _status;
    map['errorMessage'] = _errorMessage;
    if (_listSalaryDetials != null) {
      map['listSalaryDetials'] = _listSalaryDetials?.map((v) => v.toJson()).toList();
    }
    if (_listBonus != null) {
      map['listBonus'] = _listBonus?.map((v) => v.toJson()).toList();
    }
    if (_listDeduction != null) {
      map['listDeduction'] = _listDeduction?.map((v) => v.toJson()).toList();
    }
    if (_listWarnings != null) {
      map['listWarnings'] = _listWarnings?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// emplId : "000921"
/// name : "قشققشق قشعق قشق قشعش"
/// termDescription : "Fall  2019"
/// warningCertificate : "WAR1"

ListWarnings listWarningsFromJson(String str) => ListWarnings.fromJson(json.decode(str));
String listWarningsToJson(ListWarnings data) => json.encode(data.toJson());
class ListWarnings {
  ListWarnings({
      String? emplId, 
      String? name, 
      String? termDescription, 
      String? warningCertificate,}){
    _emplId = emplId;
    _name = name;
    _termDescription = termDescription;
    _warningCertificate = warningCertificate;
}

  ListWarnings.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _name = json['name'];
    _termDescription = json['termDescription'];
    _warningCertificate = json['warningCertificate'];
  }
  String? _emplId;
  String? _name;
  String? _termDescription;
  String? _warningCertificate;
ListWarnings copyWith({  String? emplId,
  String? name,
  String? termDescription,
  String? warningCertificate,
}) => ListWarnings(  emplId: emplId ?? _emplId,
  name: name ?? _name,
  termDescription: termDescription ?? _termDescription,
  warningCertificate: warningCertificate ?? _warningCertificate,
);
  String? get emplId => _emplId;
  String? get name => _name;
  String? get termDescription => _termDescription;
  String? get warningCertificate => _warningCertificate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['name'] = _name;
    map['termDescription'] = _termDescription;
    map['warningCertificate'] = _warningCertificate;
    return map;
  }

}

/// emplId : "000921"
/// name : "قشققشق قشعق قشق قشعش"
/// totalDeduction : 200
/// totalDeducted : 0
/// deductionPending : 200
/// currencyCode : "AED"

ListDeduction listDeductionFromJson(String str) => ListDeduction.fromJson(json.decode(str));
String listDeductionToJson(ListDeduction data) => json.encode(data.toJson());
class ListDeduction {
  ListDeduction({
      String? emplId, 
      String? name, 
      num? totalDeduction, 
      num? totalDeducted, 
      num? deductionPending, 
      String? currencyCode,}){
    _emplId = emplId;
    _name = name;
    _totalDeduction = totalDeduction;
    _totalDeducted = totalDeducted;
    _deductionPending = deductionPending;
    _currencyCode = currencyCode;
}

  ListDeduction.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _name = json['name'];
    _totalDeduction = json['totalDeduction'];
    _totalDeducted = json['totalDeducted'];
    _deductionPending = json['deductionPending'];
    _currencyCode = json['currencyCode'];
  }
  String? _emplId;
  String? _name;
  num? _totalDeduction;
  num? _totalDeducted;
  num? _deductionPending;
  String? _currencyCode;
ListDeduction copyWith({  String? emplId,
  String? name,
  num? totalDeduction,
  num? totalDeducted,
  num? deductionPending,
  String? currencyCode,
}) => ListDeduction(  emplId: emplId ?? _emplId,
  name: name ?? _name,
  totalDeduction: totalDeduction ?? _totalDeduction,
  totalDeducted: totalDeducted ?? _totalDeducted,
  deductionPending: deductionPending ?? _deductionPending,
  currencyCode: currencyCode ?? _currencyCode,
);
  String? get emplId => _emplId;
  String? get name => _name;
  num? get totalDeduction => _totalDeduction;
  num? get totalDeducted => _totalDeducted;
  num? get deductionPending => _deductionPending;
  String? get currencyCode => _currencyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['name'] = _name;
    map['totalDeduction'] = _totalDeduction;
    map['totalDeducted'] = _totalDeducted;
    map['deductionPending'] = _deductionPending;
    map['currencyCode'] = _currencyCode;
    return map;
  }

}

/// emplId : "000921"
/// name : "قشققشق قشعق قشق قشعش"
/// termDescription : "Book/ Bachelor for Arab Count"
/// amount : 100
/// currencyCode : "AED"
/// periodIdCode : "APR20"
/// periodIdDescription : "April 2020"

ListBonus listBonusFromJson(String str) => ListBonus.fromJson(json.decode(str));
String listBonusToJson(ListBonus data) => json.encode(data.toJson());
class ListBonus {
  ListBonus({
      String? emplId, 
      String? name, 
      String? termDescription, 
      num? amount, 
      String? currencyCode, 
      String? periodIdCode, 
      String? periodIdDescription,}){
    _emplId = emplId;
    _name = name;
    _termDescription = termDescription;
    _amount = amount;
    _currencyCode = currencyCode;
    _periodIdCode = periodIdCode;
    _periodIdDescription = periodIdDescription;
}

  ListBonus.fromJson(dynamic json) {
    _emplId = json['emplId'];
    _name = json['name'];
    _termDescription = json['termDescription'];
    _amount = json['amount'];
    _currencyCode = json['currencyCode'];
    _periodIdCode = json['periodIdCode'];
    _periodIdDescription = json['periodIdDescription'];
  }
  String? _emplId;
  String? _name;
  String? _termDescription;
  num? _amount;
  String? _currencyCode;
  String? _periodIdCode;
  String? _periodIdDescription;
ListBonus copyWith({  String? emplId,
  String? name,
  String? termDescription,
  num? amount,
  String? currencyCode,
  String? periodIdCode,
  String? periodIdDescription,
}) => ListBonus(  emplId: emplId ?? _emplId,
  name: name ?? _name,
  termDescription: termDescription ?? _termDescription,
  amount: amount ?? _amount,
  currencyCode: currencyCode ?? _currencyCode,
  periodIdCode: periodIdCode ?? _periodIdCode,
  periodIdDescription: periodIdDescription ?? _periodIdDescription,
);
  String? get emplId => _emplId;
  String? get name => _name;
  String? get termDescription => _termDescription;
  num? get amount => _amount;
  String? get currencyCode => _currencyCode;
  String? get periodIdCode => _periodIdCode;
  String? get periodIdDescription => _periodIdDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emplId'] = _emplId;
    map['name'] = _name;
    map['termDescription'] = _termDescription;
    map['amount'] = _amount;
    map['currencyCode'] = _currencyCode;
    map['periodIdCode'] = _periodIdCode;
    map['periodIdDescription'] = _periodIdDescription;
    return map;
  }

}

/// name : "قشققشق قشعق قشق قشعش"
/// bankName : ""
/// salaryMonth : "April 2020"
/// currency : ""
/// status : ""
/// bankBeneficiary : ""
/// amount : 0

ListSalaryDetials listSalaryDetialsFromJson(String str) => ListSalaryDetials.fromJson(json.decode(str));
String listSalaryDetialsToJson(ListSalaryDetials data) => json.encode(data.toJson());
class ListSalaryDetials {
  ListSalaryDetials({
      String? name, 
      String? bankName, 
      String? salaryMonth, 
      String? currency, 
      String? status, 
      String? bankBeneficiary, 
      num? amount,}){
    _name = name;
    _bankName = bankName;
    _salaryMonth = salaryMonth;
    _currency = currency;
    _status = status;
    _bankBeneficiary = bankBeneficiary;
    _amount = amount;
}

  ListSalaryDetials.fromJson(dynamic json) {
    _name = json['name'];
    _bankName = json['bankName'];
    _salaryMonth = json['salaryMonth'];
    _currency = json['currency'];
    _status = json['status'];
    _bankBeneficiary = json['bankBeneficiary'];
    _amount = json['amount'];
  }
  String? _name;
  String? _bankName;
  String? _salaryMonth;
  String? _currency;
  String? _status;
  String? _bankBeneficiary;
  num? _amount;
ListSalaryDetials copyWith({  String? name,
  String? bankName,
  String? salaryMonth,
  String? currency,
  String? status,
  String? bankBeneficiary,
  num? amount,
}) => ListSalaryDetials(  name: name ?? _name,
  bankName: bankName ?? _bankName,
  salaryMonth: salaryMonth ?? _salaryMonth,
  currency: currency ?? _currency,
  status: status ?? _status,
  bankBeneficiary: bankBeneficiary ?? _bankBeneficiary,
  amount: amount ?? _amount,
);
  String? get name => _name;
  String? get bankName => _bankName;
  String? get salaryMonth => _salaryMonth;
  String? get currency => _currency;
  String? get status => _status;
  String? get bankBeneficiary => _bankBeneficiary;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['bankName'] = _bankName;
    map['salaryMonth'] = _salaryMonth;
    map['currency'] = _currency;
    map['status'] = _status;
    map['bankBeneficiary'] = _bankBeneficiary;
    map['amount'] = _amount;
    return map;
  }

}