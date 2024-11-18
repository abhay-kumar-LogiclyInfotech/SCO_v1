import 'dart:convert';

// Main Model
GetAllRequestsModel getAllRequestsModelFromJson(String str) =>
    GetAllRequestsModel.fromJson(json.decode(str));

String getAllRequestsModelToJson(GetAllRequestsModel data) =>
    json.encode(data.toJson());

class GetAllRequestsModel {
  GetAllRequestsModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,
  });

  String? messageCode;
  String? message;
  Data? data;
  bool? error;

  factory GetAllRequestsModel.fromJson(Map<String, dynamic> json) => GetAllRequestsModel(
    messageCode: json['messageCode'],
    message: json['message'],
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
    error: json['error'],
  );

  Map<String, dynamic> toJson() => {
    'messageCode': messageCode,
    'message': message,
    'data': data?.toJson(),
    'error': error,
  };

  GetAllRequestsModel copyWith({
    String? messageCode,
    String? message,
    Data? data,
    bool? error,
  }) =>
      GetAllRequestsModel(
        messageCode: messageCode ?? this.messageCode,
        message: message ?? this.message,
        data: data ?? this.data,
        error: error ?? this.error,
      );
}

// Data Model
class Data {
  Data({
    this.listOfRequest,
    this.request,
  });

  List<ListOfRequest>? listOfRequest;
  dynamic request;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    listOfRequest: json['listOfRequest'] != null
        ? List<ListOfRequest>.from(
        json['listOfRequest'].map((x) => ListOfRequest.fromJson(x)))
        : null,
    request: json['request'],
  );

  Map<String, dynamic> toJson() => {
    'listOfRequest': listOfRequest?.map((x) => x.toJson()).toList(),
    'request': request,
  };

  Data copyWith({
    List<ListOfRequest>? listOfRequest,
    dynamic request,
  }) =>
      Data(
        listOfRequest: listOfRequest ?? this.listOfRequest,
        request: request ?? this.request,
      );
}

// ListOfRequest Model
class ListOfRequest {
  ListOfRequest({
    this.requestCategory,
    this.requestType,
    this.requestSubType,
    this.ssrRsReqSeqHeader,
    this.serviceRequestId,
    this.seqNumber,
    this.requestDate,
    this.status,
    this.details,
    this.listAttachment,
  });

  String? requestCategory;
  String? requestType;
  String? requestSubType;
  num? ssrRsReqSeqHeader;
  num? serviceRequestId;
  dynamic seqNumber;
  dynamic requestDate;
  String? status;
  List<Details>? details;
  List<dynamic>? listAttachment;

  factory ListOfRequest.fromJson(Map<String, dynamic> json) => ListOfRequest(
    requestCategory: json['requestCategory'],
    requestType: json['requestType'],
    requestSubType: json['requestSubType'],
    ssrRsReqSeqHeader: json['ssrRsReqSeqHeader'],
    serviceRequestId: json['serviceRequestId'],
    seqNumber: json['seqNumber'],
    requestDate: json['requestDate'],
    status: json['status'],
    details: json['details'] != null
        ? List<Details>.from(json['details'].map((x) => Details.fromJson(x)))
        : null,
    listAttachment: json['listAttachment'] ?? [],
  );

  Map<String, dynamic> toJson() => {
    'requestCategory': requestCategory,
    'requestType': requestType,
    'requestSubType': requestSubType,
    'ssrRsReqSeqHeader': ssrRsReqSeqHeader,
    'serviceRequestId': serviceRequestId,
    'seqNumber': seqNumber,
    'requestDate': requestDate,
    'status': status,
    'details': details?.map((x) => x.toJson()).toList(),
    'listAttachment': listAttachment,
  };

  ListOfRequest copyWith({
    String? requestCategory,
    String? requestType,
    String? requestSubType,
    num? ssrRsReqSeqHeader,
    num? serviceRequestId,
    dynamic seqNumber,
    dynamic requestDate,
    String? status,
    List<Details>? details,
    List<dynamic>? listAttachment,
  }) =>
      ListOfRequest(
        requestCategory: requestCategory ?? this.requestCategory,
        requestType: requestType ?? this.requestType,
        requestSubType: requestSubType ?? this.requestSubType,
        ssrRsReqSeqHeader: ssrRsReqSeqHeader ?? this.ssrRsReqSeqHeader,
        serviceRequestId: serviceRequestId ?? this.serviceRequestId,
        seqNumber: seqNumber ?? this.seqNumber,
        requestDate: requestDate ?? this.requestDate,
        status: status ?? this.status,
        details: details ?? this.details,
        listAttachment: listAttachment ?? this.listAttachment,
      );
}

// Details Model
class Details {
  Details({
    this.ssrRsReqSeq,
    this.ssrRsDescription,
    this.displayToUser,
    this.newlyAdded,
  });

  String? ssrRsReqSeq;
  String? ssrRsDescription;
  String? displayToUser;
  bool? newlyAdded;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    ssrRsReqSeq: json['ssrRsReqSeq'],
    ssrRsDescription: json['ssrRsDescription'],
    displayToUser: json['displayToUser'],
    newlyAdded: json['newlyAdded'],
  );

  Map<String, dynamic> toJson() => {
    'ssrRsReqSeq': ssrRsReqSeq,
    'ssrRsDescription': ssrRsDescription,
    'displayToUser': displayToUser,
    'newlyAdded': newlyAdded,
  };

  Details copyWith({
    String? ssrRsReqSeq,
    String? ssrRsDescription,
    String? displayToUser,
    bool? newlyAdded,
  }) =>
      Details(
        ssrRsReqSeq: ssrRsReqSeq ?? this.ssrRsReqSeq,
        ssrRsDescription: ssrRsDescription ?? this.ssrRsDescription,
        displayToUser: displayToUser ?? this.displayToUser,
        newlyAdded: newlyAdded ?? this.newlyAdded,
      );
}
