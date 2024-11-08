class MyScholarshipModel {
  final String? messageCode;
  final String? message;
  final bool? error;
  final Data? data;

  MyScholarshipModel({
    this.messageCode,
    this.message,
    this.error,
    this.data,
  });

  factory MyScholarshipModel.fromJson(Map<String, dynamic> json) {
    return MyScholarshipModel(
      messageCode: json['messageCode'] as String?,
      message: json['message'] as String?,
      error: json['error'] as bool?,
      data: json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class Data {
  final DataDetails? dataDetails;
  final String? userInfoType;
  final dynamic userInfo;
  final dynamic user;

  Data({
    this.dataDetails,
    this.userInfoType,
    this.userInfo,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      dataDetails: json['data'] != null && json['data'] is Map<String, dynamic>
          ? DataDetails.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      userInfoType: json['userInfoType'] as String?,
      userInfo: json['userInfo'],
      user: json['user'],
    );
  }
}

class DataDetails {
  final String? emplId;
  final String? name;
  final List<PhoneNumber>? phoneNumbers;
  final List<Address>? addresses;
  final List<Scholarship>? scholarships;
  final List<Email>? emails;

  DataDetails({
    this.emplId,
    this.name,
    this.phoneNumbers,
    this.addresses,
    this.scholarships,
    this.emails,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    return DataDetails(
      emplId: json['emplId'] as String?,
      name: json['name'] as String?,
      phoneNumbers: (json['phoneNumbers'] as List<dynamic>?)
          ?.map((item) => item != null ? PhoneNumber.fromJson(item as Map<String, dynamic>) : null)
          .whereType<PhoneNumber>()
          .toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((item) => item != null ? Address.fromJson(item as Map<String, dynamic>) : null)
          .whereType<Address>()
          .toList(),
      scholarships: (json['scholarships'] as List<dynamic>?)
          ?.map((item) => item != null ? Scholarship.fromJson(item as Map<String, dynamic>) : null)
          .whereType<Scholarship>()
          .toList(),
      emails: (json['emails'] as List<dynamic>?)
          ?.map((item) => item != null ? Email.fromJson(item as Map<String, dynamic>) : null)
          .whereType<Email>()
          .toList(),
    );
  }
}

class PhoneNumber {
  final String? countryCode;
  final String? phoneNumber;
  final String? phoneType;
  final bool? preferred;
  final String? errorMessage;
  final bool? existing;

  PhoneNumber({
    this.countryCode,
    this.phoneNumber,
    this.phoneType,
    this.preferred,
    this.errorMessage,
    this.existing,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneType: json['phoneType'] as String?,
      preferred: json['preferred'] as bool?,
      errorMessage: json['errorMessage'] as String?,
      existing: json['existing'] as bool?,
    );
  }
}

class Address {
  final String? addressType;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final bool? disableState;
  final String? errorMessage;
  final bool? existing;

  Address({
    this.addressType,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.disableState,
    this.errorMessage,
    this.existing,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressType: json['addressType'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      disableState: json['disableState'] as bool?,
      errorMessage: json['errorMessage'] as String?,
      existing: json['existing'] as bool?,
    );
  }
}

class Scholarship {
  final String? scholarshipType;
  final String? country;
  final String? university;
  final String? scholarshipApprovedDate;
  final String? studyStartDate;
  final String? scholarshipEndDate;
  final String? numberOfYears;
  final String? academicCareer;
  final String? applicationNo;
  final String? admitType;
  final String? academicPlan;
  final String? programStatus;

  Scholarship({
    this.scholarshipType,
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

  factory Scholarship.fromJson(Map<String, dynamic> json) {
    return Scholarship(
      scholarshipType: json['scholarshipType'] as String?,
      country: json['country'] as String?,
      university: json['university'] as String?,
      scholarshipApprovedDate: json['scholarshipApprovedDate'] as String?,
      studyStartDate: json['studyStartDate'] as String?,
      scholarshipEndDate: json['scholarshipEndDate'] as String?,
      numberOfYears: json['numberOfYears'] as String?,
      academicCareer: json['academicCareer'] as String?,
      applicationNo: json['applicationNo'] as String?,
      admitType: json['admitType'] as String?,
      academicPlan: json['academicPlan'] as String?,
      programStatus: json['programStatus'] as String?,
    );
  }
}

class Email {
  final String? emailType;
  final String? emailId;
  final bool? preferred;
  final bool? existing;

  Email({
    this.emailType,
    this.emailId,
    this.preferred,
    this.existing,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      emailType: json['emailType'] as String?,
      emailId: json['emailId'] as String?,
      preferred: json['preferred'] as bool?,
      existing: json['existing'] as bool?,
    );
  }
}
