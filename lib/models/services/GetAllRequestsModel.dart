import 'package:flutter/cupertino.dart';

class GetAllRequestsModel {
  String? messageCode;
  String? message;
  Data? data;
  bool? error;

  GetAllRequestsModel({this.messageCode, this.message, this.data, this.error});

  GetAllRequestsModel.fromJson(Map<String, dynamic> json) {
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
  List<ListOfRequest>? listOfRequest;
  Null? request;

  Data({this.listOfRequest, this.request});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listOfRequest'] != null) {
      listOfRequest = <ListOfRequest>[];
      json['listOfRequest'].forEach((v) {
        listOfRequest!.add(new ListOfRequest.fromJson(v));
      });
    }
    request = json['request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOfRequest != null) {
      data['listOfRequest'] =
          this.listOfRequest!.map((v) => v.toJson()).toList();
    }
    data['request'] = this.request;
    return data;
  }
}

class ListOfRequest {
  String? requestCategory;
  String? requestType;
  String? requestSubType;
  int? ssrRsReqSeqHeader;
  int? serviceRequestId;
  Null? seqNumber;
  Null? requestDate;
  String? status;
  List<Details>? details;
  List<ListAttachment>? listAttachment;

  ListOfRequest(
      {this.requestCategory,
        this.requestType,
        this.requestSubType,
        this.ssrRsReqSeqHeader,
        this.serviceRequestId,
        this.seqNumber,
        this.requestDate,
        this.status,
        this.details,
        this.listAttachment});

  ListOfRequest.fromJson(Map<String, dynamic> json) {
    requestCategory = json['requestCategory'];
    requestType = json['requestType'];
    requestSubType = json['requestSubType'];
    ssrRsReqSeqHeader = json['ssrRsReqSeqHeader'];
    serviceRequestId = json['serviceRequestId'];
    seqNumber = json['seqNumber'];
    requestDate = json['requestDate'];
    status = json['status'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    if (json['listAttachment'] != null) {
      listAttachment = <ListAttachment>[];
      json['listAttachment'].forEach((v) {
        listAttachment!.add(new ListAttachment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestCategory'] = this.requestCategory;
    data['requestType'] = this.requestType;
    data['requestSubType'] = this.requestSubType;
    data['ssrRsReqSeqHeader'] = this.ssrRsReqSeqHeader;
    data['serviceRequestId'] = this.serviceRequestId;
    data['seqNumber'] = this.seqNumber;
    data['requestDate'] = this.requestDate;
    data['status'] = this.status;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.listAttachment != null) {
      data['listAttachment'] =
          this.listAttachment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? ssrRsReqSeq;
  String? ssrRsDescription;
  String? displayToUser;
  bool? newlyAded;

  Details(
      {this.ssrRsReqSeq,
        this.ssrRsDescription,
        this.displayToUser,
        this.newlyAded});

  Details.fromJson(Map<String, dynamic> json) {
    ssrRsReqSeq = json['ssrRsReqSeq'];
    ssrRsDescription = json['ssrRsDescription'];
    displayToUser = json['displayToUser'];
    newlyAded = json['newlyAded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssrRsReqSeq'] = this.ssrRsReqSeq;
    data['ssrRsDescription'] = this.ssrRsDescription;
    data['displayToUser'] = this.displayToUser;
    data['newlyAded'] = this.newlyAded;
    return data;
  }
}

// class ListAttachment {
//   // Text Editing Controllers for form fields
//   TextEditingController attachmentSeqNumberController;
//   TextEditingController fileDescriptionController;
//   TextEditingController userAttachmentFileController;
//   TextEditingController attachmentSysFileNameController;
//   TextEditingController base64StringController;
//   TextEditingController viewByAdviseeController;
//
//   // Focus Nodes
//   FocusNode attachmentSeqNumberFocusNode;
//   FocusNode fileDescriptionFocusNode;
//   FocusNode userAttachmentFileFocusNode;
//   FocusNode attachmentSysFileNameFocusNode;
//   FocusNode base64StringFocusNode;
//   FocusNode viewByAdviseeFocusNode;
//
//   // Error Text Variables
//   String? attachmentSeqNumberError;
//   String? fileDescriptionError;
//   String? userAttachmentFileError;
//   String? attachmentSysFileNameError;
//   String? base64StringError;
//   String? viewByAdviseeError;
//
//   // Additional Fields
//   bool newlyAded;
//   bool newRecord;
//   bool isLoading;
//
//   ListAttachment({
//     required this.attachmentSeqNumberController,
//     required this.fileDescriptionController,
//     required this.userAttachmentFileController,
//     required this.attachmentSysFileNameController,
//     required this.base64StringController,
//     required this.viewByAdviseeController,
//     required this.attachmentSeqNumberFocusNode,
//     required this.fileDescriptionFocusNode,
//     required this.userAttachmentFileFocusNode,
//     required this.attachmentSysFileNameFocusNode,
//     required this.base64StringFocusNode,
//     required this.viewByAdviseeFocusNode,
//     this.attachmentSeqNumberError,
//     this.fileDescriptionError,
//     this.userAttachmentFileError,
//     this.attachmentSysFileNameError,
//     this.base64StringError,
//     this.viewByAdviseeError,
//     this.newlyAded = false,
//     this.isLoading = false,
//     this.newRecord = false,
//   });
//
//   // From JSON
//   factory ListAttachment.fromJson(Map<String, dynamic> json) => ListAttachment(
//     attachmentSeqNumberController: TextEditingController(text: json['attachmentSeqNumber']),
//     fileDescriptionController: TextEditingController(text: json['fileDescription']),
//     userAttachmentFileController: TextEditingController(text: json['userAttachmentFile']),
//     attachmentSysFileNameController: TextEditingController(text: json['attachmentSysFileName']),
//     base64StringController: TextEditingController(text: json['base64String'] ?? ''),
//     viewByAdviseeController: TextEditingController(text: json['viewByAdvisee']),
//     attachmentSeqNumberFocusNode: FocusNode(),
//     fileDescriptionFocusNode: FocusNode(),
//     userAttachmentFileFocusNode: FocusNode(),
//     attachmentSysFileNameFocusNode: FocusNode(),
//     base64StringFocusNode: FocusNode(),
//     viewByAdviseeFocusNode: FocusNode(),
//     newlyAded: json['newlyAded'] ?? false,
//   );
//
//   // To JSON
//   Map<String, dynamic> toJson() => {
//     'attachmentSeqNumber': attachmentSeqNumberController.text,
//     'fileDescription': fileDescriptionController.text,
//     'userAttachmentFile': userAttachmentFileController.text,
//     'attachmentSysFileName': attachmentSysFileNameController.text,
//     'base64String': base64StringController.text.isEmpty ? "" : base64StringController.text,
//     'viewByAdvisee': viewByAdviseeController.text,
//     'newlyAded': newlyAded,
//   };
//
//
//
//   // Copy With
//   ListAttachment copyWith({
//     TextEditingController? attachmentSeqNumberController,
//     TextEditingController? fileDescriptionController,
//     TextEditingController? userAttachmentFileController,
//     TextEditingController? attachmentSysFileNameController,
//     TextEditingController? base64StringController,
//     TextEditingController? viewByAdviseeController,
//     FocusNode? attachmentSeqNumberFocusNode,
//     FocusNode? fileDescriptionFocusNode,
//     FocusNode? userAttachmentFileFocusNode,
//     FocusNode? attachmentSysFileNameFocusNode,
//     FocusNode? base64StringFocusNode,
//     FocusNode? viewByAdviseeFocusNode,
//     String? attachmentSeqNumberError,
//     String? fileDescriptionError,
//     String? userAttachmentFileError,
//     String? attachmentSysFileNameError,
//     String? base64StringError,
//     String? viewByAdviseeError,
//     bool? newlyAded,
//     bool? isLoading,
//   }) =>
//       ListAttachment(
//         attachmentSeqNumberController: attachmentSeqNumberController ?? this.attachmentSeqNumberController,
//         fileDescriptionController: fileDescriptionController ?? this.fileDescriptionController,
//         userAttachmentFileController: userAttachmentFileController ?? this.userAttachmentFileController,
//         attachmentSysFileNameController: attachmentSysFileNameController ?? this.attachmentSysFileNameController,
//         base64StringController: base64StringController ?? this.base64StringController,
//         viewByAdviseeController: viewByAdviseeController ?? this.viewByAdviseeController,
//         attachmentSeqNumberFocusNode: attachmentSeqNumberFocusNode ?? this.attachmentSeqNumberFocusNode,
//         fileDescriptionFocusNode: fileDescriptionFocusNode ?? this.fileDescriptionFocusNode,
//         userAttachmentFileFocusNode: userAttachmentFileFocusNode ?? this.userAttachmentFileFocusNode,
//         attachmentSysFileNameFocusNode: attachmentSysFileNameFocusNode ?? this.attachmentSysFileNameFocusNode,
//         base64StringFocusNode: base64StringFocusNode ?? this.base64StringFocusNode,
//         viewByAdviseeFocusNode: viewByAdviseeFocusNode ?? this.viewByAdviseeFocusNode,
//         attachmentSeqNumberError: attachmentSeqNumberError ?? this.attachmentSeqNumberError,
//         fileDescriptionError: fileDescriptionError ?? this.fileDescriptionError,
//         userAttachmentFileError: userAttachmentFileError ?? this.userAttachmentFileError,
//         attachmentSysFileNameError: attachmentSysFileNameError ?? this.attachmentSysFileNameError,
//         base64StringError: base64StringError ?? this.base64StringError,
//         viewByAdviseeError: viewByAdviseeError ?? this.viewByAdviseeError,
//         newlyAded: newlyAded ?? this.newlyAded,
//         isLoading: isLoading ?? this.isLoading,
//       );
// }

class ListAttachment {
  // Text Editing Controllers for form fields
  TextEditingController attachmentSeqNumberController;
  TextEditingController fileDescriptionController;
  TextEditingController userAttachmentFileController;
  TextEditingController attachmentSysFileNameController;
  TextEditingController base64StringController;
  TextEditingController viewByAdviseeController;

  // Focus Nodes
  FocusNode attachmentSeqNumberFocusNode;
  FocusNode fileDescriptionFocusNode;
  FocusNode userAttachmentFileFocusNode;
  FocusNode attachmentSysFileNameFocusNode;
  FocusNode base64StringFocusNode;
  FocusNode viewByAdviseeFocusNode;

  // Error Text Variables
  String? attachmentSeqNumberError;
  String? fileDescriptionError;
  String? userAttachmentFileError;
  String? attachmentSysFileNameError;
  String? base64StringError;
  String? viewByAdviseeError;

  // Additional Fields
  bool newlyAded;
  bool newRecord;
  bool isLoading;

  ListAttachment({
    required this.attachmentSeqNumberController,
    required this.fileDescriptionController,
    required this.userAttachmentFileController,
    required this.attachmentSysFileNameController,
    required this.base64StringController,
    required this.viewByAdviseeController,
    required this.attachmentSeqNumberFocusNode,
    required this.fileDescriptionFocusNode,
    required this.userAttachmentFileFocusNode,
    required this.attachmentSysFileNameFocusNode,
    required this.base64StringFocusNode,
    required this.viewByAdviseeFocusNode,
    this.attachmentSeqNumberError,
    this.fileDescriptionError,
    this.userAttachmentFileError,
    this.attachmentSysFileNameError,
    this.base64StringError,
    this.viewByAdviseeError,
    this.newlyAded = false,
    this.isLoading = false,
    this.newRecord = false,
  });

  // From JSON
  factory ListAttachment.fromJson(Map<String, dynamic> json) => ListAttachment(
    attachmentSeqNumberController:
    TextEditingController(text: json['attachmentSeqNumber']),
    fileDescriptionController:
    TextEditingController(text: json['fileDescription']),
    userAttachmentFileController:
    TextEditingController(text: json['userAttachmentFile']),
    attachmentSysFileNameController:
    TextEditingController(text: json['attachmentSysFileName']),
    base64StringController:
    TextEditingController(text: json['base64String'] ?? ''),
    viewByAdviseeController:
    TextEditingController(text: json['viewByAdvisee']),
    attachmentSeqNumberFocusNode: FocusNode(),
    fileDescriptionFocusNode: FocusNode(),
    userAttachmentFileFocusNode: FocusNode(),
    attachmentSysFileNameFocusNode: FocusNode(),
    base64StringFocusNode: FocusNode(),
    viewByAdviseeFocusNode: FocusNode(),
    newlyAded: json['newlyAded'] ?? false,
  );

  // To JSON
  Map<String, dynamic> toJson() => {
    'attachmentSeqNumber': attachmentSeqNumberController.text,
    'fileDescription': fileDescriptionController.text,
    'userAttachmentFile': userAttachmentFileController.text,
    'attachmentSysFileName': attachmentSysFileNameController.text,
    'base64String':
    base64StringController.text.isEmpty ? "" : base64StringController.text,
    'viewByAdvisee': viewByAdviseeController.text,
    'newlyAded': newlyAded,
  };
}
