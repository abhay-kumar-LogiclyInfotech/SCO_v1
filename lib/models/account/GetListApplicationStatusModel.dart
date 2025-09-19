class GetListApplicationStatusModel {
  final dynamic messageCode;
  final dynamic message;
  final dynamic error;
  final Data? data;

  GetListApplicationStatusModel({
    required this.messageCode,
    required this.message,
    required this.error,
    this.data,
  });

  factory GetListApplicationStatusModel.fromJson(Map<dynamic, dynamic> json) {
    return GetListApplicationStatusModel(
      messageCode: json['messageCode'],
      message: json['message'],
      error: json['error'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final List<ApplicationStatus> applicationStatus;

  Data({required this.applicationStatus});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    var list = json['applicationStatus'] as List;
    List<ApplicationStatus> applicationStatusList =
    list.map((i) => ApplicationStatus.fromJson(i)).toList();

    return Data(applicationStatus: applicationStatusList);
  }
}

class ApplicationStatus {
  final ApplicationStatusDetail applicationStatus;
  final dynamic submissionConfigurationKey;

  ApplicationStatus({
    required this.applicationStatus,
    required this.submissionConfigurationKey,
  });

  factory ApplicationStatus.fromJson(Map<dynamic, dynamic> json) {
    return ApplicationStatus(
      applicationStatus: ApplicationStatusDetail.fromJson(json['applicationStatus']),
      submissionConfigurationKey: json['submissionConfigurationKey'],
    );
  }
}

class ApplicationStatusDetail {
  final dynamic? acadCareer;
  final dynamic? acadmicProgram;
  final dynamic? studentCarNumberSr;
  final dynamic? admApplicationNumber;
  final dynamic applicationProgramNumber;
  final dynamic? institution;
  final dynamic programAction;
  final dynamic? programReason;
  final dynamic? description;
  final dynamic? description1;
  final dynamic? scholarshipType;
  final dynamic? admitType;
  final dynamic editAllowed;
  final dynamic attachmentAllowed;
  final dynamic? approvedAttachment;
  final dynamic? schoolEditAllowed;
  final dynamic? graduationEditAllowed;
  final dynamic? wishListEditAllowed;
  final dynamic? workExpEditAllowed;
  final dynamic? testEditAllowed;
  final Scholarship? scholarship;

  ApplicationStatusDetail({
    this.acadCareer,
    this.acadmicProgram,
    this.studentCarNumberSr,
    this.admApplicationNumber,
    required this.applicationProgramNumber,
    this.institution,
    required this.programAction,
    this.programReason,
    this.description,
    this.description1,
    this.scholarshipType,
    this.admitType,
    required this.editAllowed,
    required this.attachmentAllowed,
    this.approvedAttachment,
    this.schoolEditAllowed,
    this.graduationEditAllowed,
    this.wishListEditAllowed,
    this.workExpEditAllowed,
    this.testEditAllowed,
    this.scholarship,
  });

  factory ApplicationStatusDetail.fromJson(Map<dynamic, dynamic> json) {
    return ApplicationStatusDetail(
      acadCareer: json['acadCareer'],
      acadmicProgram: json['acadmicProgram'],
      studentCarNumberSr: json['studentCarNumberSr'],
      admApplicationNumber: json['admApplicationNumber'],
      applicationProgramNumber: json['applicationProgramNumber'],
      institution: json['institution'],
      programAction: json['programAction'],
      programReason: json['programReason'],
      description: json['description'],
      description1: json['description1'],
      scholarshipType: json['scholarshipType'],
      admitType: json['admitType'],
      editAllowed: json['editAllowed'],
      attachmentAllowed: json['attachmentAllowed'],
      approvedAttachment: json['approvedAttachment'],
      schoolEditAllowed: json['schoolEditAllowed'],
      graduationEditAllowed: json['graduationEditAllowed'],
      wishListEditAllowed: json['wishListEditAllowed'],
      workExpEditAllowed: json['workExpEditAllowed'],
      testEditAllowed: json['testEditAllowed'],
      scholarship: json['scholarship'] != null
          ? Scholarship.fromJson(json['scholarship'])
          : null,
    );
  }
}

class Scholarship {
  final dynamic? scholarshipType;
  final dynamic? acadmicProgram;
  final dynamic? country;
  final dynamic? university;
  final dynamic? scholarshipApprovedDate;
  final dynamic? studyStartDate;
  final dynamic? scholarshipEndDate;
  final dynamic? numberOfYears;
  final dynamic? academicCareer;
  final dynamic? applicationNo;
  final dynamic? admitType;
  final dynamic? academicPlan;
  final dynamic? programStatus;

  Scholarship({
    this.scholarshipType,
    this.acadmicProgram,
    this.country,
    this.university,
    this.scholarshipApprovedDate,
    this.studyStartDate,
    this.scholarshipEndDate,
    this.numberOfYears,
    this.academicCareer,
    this.applicationNo,
    this.admitType,
    this.academicPlan,
    this.programStatus,
  });

  factory Scholarship.fromJson(Map<dynamic, dynamic> json) {
    return Scholarship(
      scholarshipType: json['scholarshipType'],
      acadmicProgram: json['acadmicProgram'],
      country: json['country'],
      university: json['university'],
      scholarshipApprovedDate: json['scholarshipApprovedDate'],
      studyStartDate: json['studyStartDate'],
      scholarshipEndDate: json['scholarshipEndDate'],
      numberOfYears: json['numberOfYears'],
      academicCareer: json['academicCareer'],
      applicationNo: json['applicationNo'],
      admitType: json['admitType'],
      academicPlan: json['academicPlan'],
      programStatus: json['programStatus'],
    );
  }
}
