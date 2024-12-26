import 'dart:convert';

class GetApplicationSectionsModel {
  final String messageCode;
  final String message;
  final Data data;
  final bool error;

  GetApplicationSectionsModel({
    required this.messageCode,
    required this.message,
    required this.data,
    required this.error,
  });

  factory GetApplicationSectionsModel.fromJson(Map<String, dynamic> json) => GetApplicationSectionsModel(
    messageCode: json['messageCode'],
    message: json['message'],
    data: Data.fromJson(json['data']),
    error: json['error'],
  );

  Map<String, dynamic> toJson() => {
    'messageCode': messageCode,
    'message': message,
    'data': data.toJson(),
    'error': error,
  };
}

class Data {
  final String applicationNumber;
  final dynamic applicationData;
  final PsApplication psApplication;

  Data({
    required this.applicationNumber,
    required this.applicationData,
    required this.psApplication,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    applicationNumber: json['applicationNumber'],
    applicationData: json['applicationData'],
    psApplication: PsApplication.fromJson(json['psApplicartion']),
  );

  Map<String, dynamic> toJson() => {
    'applicationNumber': applicationNumber,
    'applicationData': applicationData,
    'psApplicartion': psApplication.toJson(),
  };
}

class PsApplication {
  final List<Graduation> graduationList;
  final List<UniversityPriority> universtiesPriorityList;
  final List<RequiredExamination> requiredExaminationList;
  final List<dynamic> addressList;
  final List<dynamic> highSchoolList;
  final List<EmploymentHistory> emplymentHistory;
  final List<MajorWish> majorWishList;
  final String name;
  final String emplId;
  final String applicationNo;
  final String forigenEducation;
  final String highSchool;
  final String graduation;
  final dynamic requiredExam;
  final String universityWishList;
  final String workExp;
  final int maxCountUniversity;
  final int maxCountMajors;
  final dynamic acadCareer;
  final dynamic institution;
  final dynamic highestQualification;

  PsApplication({
    required this.graduationList,
    required this.universtiesPriorityList,
    required this.requiredExaminationList,
    required this.addressList,
    required this.highSchoolList,
    required this.emplymentHistory,
    required this.majorWishList,
    required this.name,
    required this.emplId,
    required this.applicationNo,
    required this.forigenEducation,
    required this.highSchool,
    required this.graduation,
    required this.requiredExam,
    required this.universityWishList,
    required this.workExp,
    required this.maxCountUniversity,
    required this.maxCountMajors,
    required this.acadCareer,
    required this.institution,
    required this.highestQualification,
  });

  factory PsApplication.fromJson(Map<String, dynamic> json) => PsApplication(
    graduationList: (json['graduationList'] as List)
        .map((e) => Graduation.fromJson(e))
        .toList(),
    universtiesPriorityList: (json['universtiesPriorityList'] as List)
        .map((e) => UniversityPriority.fromJson(e))
        .toList(),
    requiredExaminationList: (json['requiredExaminationList'] as List)
        .map((e) => RequiredExamination.fromJson(e))
        .toList(),
    addressList: List<dynamic>.from(json['addressList'] ?? []),
    highSchoolList: List<dynamic>.from(json['highSchoolList'] ?? []),
    emplymentHistory: (json['emplymentHistory'] as List)
        .map((e) => EmploymentHistory.fromJson(e))
        .toList(),
    majorWishList: (json['majorWishList'] as List)
        .map((e) => MajorWish.fromJson(e))
        .toList(),
    name: json['name'],
    emplId: json['emplId'],
    applicationNo: json['applicationNo'],
    forigenEducation: json['forigenEducation'],
    highSchool: json['highSchool'],
    graduation: json['graduation'],
    requiredExam: json['requiredExam'],
    universityWishList: json['universityWishList'],
    workExp: json['workExp'],
    maxCountUniversity: json['maxCountUniversity'],
    maxCountMajors: json['maxCountMajors'],
    acadCareer: json['acadCareer'],
    institution: json['institution'],
    highestQualification: json['highestQualification'],
  );

  Map<String, dynamic> toJson() => {
    'graduationList': graduationList.map((e) => e.toJson()).toList(),
    'universtiesPriorityList':
    universtiesPriorityList.map((e) => e.toJson()).toList(),
    'requiredExaminationList':
    requiredExaminationList.map((e) => e.toJson()).toList(),
    'addressList': addressList,
    'highSchoolList': highSchoolList,
    'emplymentHistory': emplymentHistory.map((e) => e.toJson()).toList(),
    'majorWishList': majorWishList.map((e) => e.toJson()).toList(),
    'name': name,
    'emplId': emplId,
    'applicationNo': applicationNo,
    'forigenEducation': forigenEducation,
    'highSchool': highSchool,
    'graduation': graduation,
    'requiredExam': requiredExam,
    'universityWishList': universityWishList,
    'workExp': workExp,
    'maxCountUniversity': maxCountUniversity,
    'maxCountMajors': maxCountMajors,
    'acadCareer': acadCareer,
    'institution': institution,
    'highestQualification': highestQualification,
  };
}

class Graduation {
  final String level;
  final String country;
  final String university;
  final String? otherUniversity;
  final String major;
  final String? otherMajor;
  final String cgpa;
  final int graduationStartDate;
  final dynamic graduationEndDate;
  final String sponsorShip;
  final dynamic errorMessage;
  final bool currentlyStudying;
  final bool highestQualification;
  final String lastTerm;
  final bool showCurrentlyStudying;
  final CaseStudy caseStudy;
  final bool newField;

  Graduation({
    required this.level,
    required this.country,
    required this.university,
    this.otherUniversity,
    required this.major,
    this.otherMajor,
    required this.cgpa,
    required this.graduationStartDate,
    this.graduationEndDate,
    required this.sponsorShip,
    this.errorMessage,
    required this.currentlyStudying,
    required this.highestQualification,
    required this.lastTerm,
    required this.showCurrentlyStudying,
    required this.caseStudy,
    required this.newField,
  });

  factory Graduation.fromJson(Map<String, dynamic> json) => Graduation(
    level: json['level'],
    country: json['country'],
    university: json['university'],
    otherUniversity: json['otherUniversity'],
    major: json['major'],
    otherMajor: json['otherMajor'],
    cgpa: json['cgpa'],
    graduationStartDate: json['graduationStartDate'],
    graduationEndDate: json['graduationEndDate'],
    sponsorShip: json['sponsorShip'],
    errorMessage: json['errorMessage'],
    currentlyStudying: json['currentlyStudying'],
    highestQualification: json['highestQualification'],
    lastTerm: json['lastTerm'],
    showCurrentlyStudying: json['showCurrentlyStudying'],
    caseStudy: CaseStudy.fromJson(json['caseStudy']),
    newField: json['new'],
  );

  Map<String, dynamic> toJson() => {
    'level': level,
    'country': country,
    'university': university,
    'otherUniversity': otherUniversity,
    'major': major,
    'otherMajor': otherMajor,
    'cgpa': cgpa,
    'graduationStartDate': graduationStartDate,
    'graduationEndDate': graduationEndDate,
    'sponsorShip': sponsorShip,
    'errorMessage': errorMessage,
    'currentlyStudying': currentlyStudying,
    'highestQualification': highestQualification,
    'lastTerm': lastTerm,
    'showCurrentlyStudying': showCurrentlyStudying,
    'caseStudy': caseStudy.toJson(),
    'new': newField,
  };
}

class CaseStudy {
  final String title;
  final String description;
  final String startYear;

  CaseStudy({
    required this.title,
    required this.description,
    required this.startYear,
  });

  factory CaseStudy.fromJson(Map<String, dynamic> json) => CaseStudy(
    title: json['title'],
    description: json['description'],
    startYear: json['startYear'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'startYear': startYear,
  };
}

class UniversityPriority {
  final String countryId;
  final String universityId;
  final String otherUniversityName;
  final String majors;
  final String status;
  final String otherMajor;
  final String rank;
  final String type;
  final dynamic errorMessage;
  final String sequenceNumber;
  final String universityStatus;
  final bool newField;

  UniversityPriority({
    required this.countryId,
    required this.universityId,
    required this.otherUniversityName,
    required this.majors,
    required this.status,
    required this.otherMajor,
    required this.rank,
    required this.type,
    this.errorMessage,
    required this.sequenceNumber,
    required this.universityStatus,
    required this.newField,
  });

  factory UniversityPriority.fromJson(Map<String, dynamic> json) =>
      UniversityPriority(
        countryId: json['countryId'],
        universityId: json['universityId'],
        otherUniversityName: json['otherUniversityName'],
        majors: json['majors'],
        status: json['status'],
        otherMajor: json['otherMajor'],
        rank: json['rank'],
        type: json['type'],
        errorMessage: json['errorMessage'],
        sequenceNumber: json['sequenceNumber'],
        universityStatus: json['universityStatus'],
        newField: json['new'],
      );

  Map<String, dynamic> toJson() => {
    'countryId': countryId,
    'universityId': universityId,
    'otherUniversityName': otherUniversityName,
    'majors': majors,
    'status': status,
    'otherMajor': otherMajor,
    'rank': rank,
    'type': type,
    'errorMessage': errorMessage,
    'sequenceNumber': sequenceNumber,
    'universityStatus': universityStatus,
    'new': newField,
  };
}

class RequiredExamination {
  final String examination;
  final String examinationTypeId;
  final int examinationGrade;
  final dynamic errorMessage;
  final int minScore;
  final int maxScore;
  final int examDate;
  final dynamic minDateAllowed;
  final bool newField;

  RequiredExamination({
    required this.examination,
    required this.examinationTypeId,
    required this.examinationGrade,
    this.errorMessage,
    required this.minScore,
    required this.maxScore,
    required this.examDate,
    this.minDateAllowed,
    required this.newField,
  });

  factory RequiredExamination.fromJson(Map<String, dynamic> json) =>
      RequiredExamination(
        examination: json['examination'],
        examinationTypeId: json['examinationTypeId'],
        examinationGrade: json['examinationGrade'],
        errorMessage: json['errorMessage'],
        minScore: json['minScore'],
        maxScore: json['maxScore'],
        examDate: json['examDate'],
        minDateAllowed: json['minDateAllowed'],
        newField: json['new'],
      );

  Map<String, dynamic> toJson() => {
    'examination': examination,
    'examinationTypeId': examinationTypeId,
    'examinationGrade': examinationGrade,
    'errorMessage': errorMessage,
    'minScore': minScore,
    'maxScore': maxScore,
    'examDate': examDate,
    'minDateAllowed': minDateAllowed,
    'new': newField,
  };
}

class EmploymentHistory {
  final String employerName;
  final int startDate;
  final int endDate;
  final String occupation;
  final String title;
  final String place;
  final String reportingManager;
  final String contantNumber;
  final String contactEmail;
  final bool newField;

  EmploymentHistory({
    required this.employerName,
    required this.startDate,
    required this.endDate,
    required this.occupation,
    required this.title,
    required this.place,
    required this.reportingManager,
    required this.contantNumber,
    required this.contactEmail,
    required this.newField,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) =>
      EmploymentHistory(
        employerName: json['employerName'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        occupation: json['occupation'],
        title: json['title'],
        place: json['place'],
        reportingManager: json['reportingManager'],
        contantNumber: json['contantNumber'],
        contactEmail: json['contactEmail'],
        newField: json['new'],
      );

  Map<String, dynamic> toJson() => {
    'employerName': employerName,
    'startDate': startDate,
    'endDate': endDate,
    'occupation': occupation,
    'title': title,
    'place': place,
    'reportingManager': reportingManager,
    'contantNumber': contantNumber,
    'contactEmail': contactEmail,
    'new': newField,
  };
}

class MajorWish {
  final String major;
  final String otherMajor;
  final String type;
  final dynamic errorMessage;
  final String sequenceNumber;
  final bool newField;

  MajorWish({
    required this.major,
    required this.otherMajor,
    required this.type,
    this.errorMessage,
    required this.sequenceNumber,
    required this.newField,
  });

  factory MajorWish.fromJson(Map<String, dynamic> json) => MajorWish(
    major: json['major'],
    otherMajor: json['otherMajor'],
    type: json['type'],
    errorMessage: json['errorMessage'],
    sequenceNumber: json['sequenceNumber'],
    newField: json['new'],
  );

  Map<String, dynamic> toJson() => {
    'major': major,
    'otherMajor': otherMajor,
    'type': type,
    'errorMessage': errorMessage,
    'sequenceNumber': sequenceNumber,
    'new': newField,
  };
}
