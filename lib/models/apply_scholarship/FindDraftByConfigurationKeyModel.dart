import 'dart:convert';
/// applicationData : "<com.mopa.sco.application.ApplicationData>\n  <acadCareer>PGRD</acadCareer>\n  <AdmApplicationNumber>00000000</AdmApplicationNumber>\n  <institution>SCO</institution>\n  <admApplCtr>AD</admApplCtr>\n  <admitType>ONL</admitType>\n  <admitTerm>2457</admitTerm>\n  <citizenship>ARE</citizenship>\n  <country>ARE</country>\n  <acadProgram>SCO-P</acadProgram>\n  <acadProgramDds></acadProgramDds>\n  <acadProgramPgrd>MSTRS</acadProgramPgrd>\n  <programStatus>AP</programStatus>\n  <programAction>APPL</programAction>\n  <acadLoadAppr>F</acadLoadAppr>\n  <campus>AD</campus>\n  <acadPlan>SCO-P</acadPlan>\n  <errorMessage></errorMessage>\n  <nameAsPasport>\n    <com.mopa.sco.application.NameAsPassport>\n      <nameType>PRI</nameType>\n      <studentName>شسبب</studentName>\n      <fatherName>شسبب</fatherName>\n      <grandFatherName>شسبب</grandFatherName>\n      <familyName>شسبب</familyName>\n    </com.mopa.sco.application.NameAsPassport>\n    <com.mopa.sco.application.NameAsPassport>\n      <nameType>ENG</nameType>\n      <studentName>Test</studentName>\n      <fatherName>Test</fatherName>\n      <grandFatherName>Test</grandFatherName>\n      <familyName>Test</familyName>\n    </com.mopa.sco.application.NameAsPassport>\n  </nameAsPasport>\n  <dateOfBirth>1997-10-20 00:00:00.0 UTC</dateOfBirth>\n  <placeOfBirth>add</placeOfBirth>\n  <gender>M</gender>\n  <maritalStatus>S</maritalStatus>\n  <emailId>test1@hotmail.com</emailId>\n  <passportId>123231323</passportId>\n  <passportExpiryDate>2024-10-30 00:00:00.0 UTC</passportExpiryDate>\n  <passportIssueDate>2024-10-20 00:00:00.0 UTC</passportIssueDate>\n  <passportIssuePlace>asdf</passportIssuePlace>\n  <unifiedNo>121212121212</unifiedNo>\n  <emirateId>784200479031062</emirateId>\n  <familyNo>7</familyNo>\n  <motherName>other</motherName>\n  <town>11</town>\n  <parentName>add</parentName>\n  <relationType>4</relationType>\n  <familyNumber>121212</familyNumber>\n  <relativeStudyinScholarship>false</relativeStudyinScholarship>\n  <uaeMother>false</uaeMother>\n  <scholarshipType>INT</scholarshipType>\n  <cohortId>2024</cohortId>\n  <scholarshipSubmissionCode>SCOPGRDINT</scholarshipSubmissionCode>\n  <highestQualification>UG</highestQualification>\n  <emirateIdExpiryDate>2024-10-20 00:00:00.0 UTC</emirateIdExpiryDate>\n  <maxCountUniversity>0</maxCountUniversity>\n  <maxCountMajors>0</maxCountMajors>\n  <militaryService>P</militaryService>\n  <reasonForMilitarty>Posponed Reason</reasonForMilitarty>\n  <phoneNunbers>\n    <com.mopa.sco.application.PhoneNumber>\n      <countryCode>91</countryCode>\n      <phoneNumber>121234123</phoneNumber>\n      <phoneType>CELL</phoneType>\n      <prefered>true</prefered>\n      <isExisting>false</isExisting>\n    </com.mopa.sco.application.PhoneNumber>\n    <com.mopa.sco.application.PhoneNumber>\n      <countryCode>91</countryCode>\n      <phoneNumber>923938293</phoneNumber>\n      <phoneType>GRD</phoneType>\n      <prefered>false</prefered>\n      <isExisting>false</isExisting>\n    </com.mopa.sco.application.PhoneNumber>\n  </phoneNunbers>\n  <graduationList>\n    <com.mopa.sco.application.GraduationBean>\n      <level>UG</level>\n      <country>ARM</country>\n      <university>OTH</university>\n      <otherUniversity>other university name</otherUniversity>\n      <major>Ajit</major>\n      <cgpa>4</cgpa>\n      <graduationStartDate>2024-10-20 20:00:00.0 UTC</graduationStartDate>\n      <isNew>true</isNew>\n      <sponsorShip>sponsorship</sponsorShip>\n      <errorMessage></errorMessage>\n      <currentlyStudying>true</currentlyStudying>\n      <highestQualification>false</highestQualification>\n      <lastTerm>2043</lastTerm>\n      <showCurrentlyStudying>true</showCurrentlyStudying>\n      <caseStudy>\n        <title></title>\n        <description></description>\n        <startYear></startYear>\n      </caseStudy>\n    </com.mopa.sco.application.GraduationBean>\n  </graduationList>\n  <universtiesPriorityList>\n    <com.mopa.sco.application.UniverstiesPriority>\n      <countryId>ARE</countryId>\n      <universityId>00003045</universityId>\n      <otherUniversityName></otherUniversityName>\n      <majors>MDE</majors>\n      <status>R</status>\n      <errorMessage></errorMessage>\n      <isNew>true</isNew>\n    </com.mopa.sco.application.UniverstiesPriority>\n  </universtiesPriorityList>\n  <requiredExaminationList>\n    <com.mopa.sco.application.RequiredExamination>\n      <examination>EMSAT</examination>\n      <examinationTypeId>ARABI</examinationTypeId>\n      <examinationGrade>65</examinationGrade>\n      <errorMessage></errorMessage>\n      <minScore>0</minScore>\n      <maxScore>2000</maxScore>\n      <isNew>true</isNew>\n      <examDate>2024-10-20 00:00:00.0 UTC</examDate>\n    </com.mopa.sco.application.RequiredExamination>\n  </requiredExaminationList>\n  <addressList>\n    <com.mopa.sco.application.Address>\n      <addressType>ABR</addressType>\n      <addressLine1>address </addressLine1>\n      <addressLine2>adds</addressLine2>\n      <city>add</city>\n      <state></state>\n      <country>ATA</country>\n      <postalCode>121212</postalCode>\n      <disableState>true</disableState>\n      <isExisting>false</isExisting>\n    </com.mopa.sco.application.Address>\n  </addressList>\n  <highSchoolList/>\n  <emplymentHistory>\n    <com.mopa.sco.application.EmployementHistory>\n      <employerName>Former Empl</employerName>\n      <startDate>2024-10-07 20:00:00.0 UTC</startDate>\n      <endDate>2024-10-20 20:00:00.0 UTC</endDate>\n      <occupation>occupation</occupation>\n      <title>designation</title>\n      <place>work place</place>\n      <reportingManager>reporting manager</reportingManager>\n      <contantNumber>121212121212</contantNumber>\n      <contactEmail>co@hotmail.com</contactEmail>\n      <isNew>true</isNew>\n    </com.mopa.sco.application.EmployementHistory>\n  </emplymentHistory>\n  <majorWishList>\n    <com.mopa.sco.application.MajorWishListItem>\n      <major>MDE</major>\n      <errorMessage></errorMessage>\n      <isNew>true</isNew>\n    </com.mopa.sco.application.MajorWishListItem>\n    <com.mopa.sco.application.MajorWishListItem>\n      <errorMessage></errorMessage>\n      <isNew>true</isNew>\n    </com.mopa.sco.application.MajorWishListItem>\n    <com.mopa.sco.application.MajorWishListItem>\n      <errorMessage></errorMessage>\n      <isNew>true</isNew>\n    </com.mopa.sco.application.MajorWishListItem>\n  </majorWishList>\n  <relativeDetails>\n    <com.mopa.sco.application.RelativeDetail/>\n  </relativeDetails>\n  <attachments>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL016</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL016</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file0</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL002</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL002</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file1</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL006</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.jpeg|.jpg|.JPEG|.JPG</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL006</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file2</fileId>\n      <fileType>1</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL019</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL019</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file3</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL084</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL084</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file4</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL033</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL033</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file5</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL054</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL054</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file6</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL055</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL055</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file7</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL001</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL001</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file8</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL053</documentCD>\n      <required>MRL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL053</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file9</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL029</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL029</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file10</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL063</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL063</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file11</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL064</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL064</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file12</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL065</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL065</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file13</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n    <com.mopa.sco.bean.AttachmentBean>\n      <processCD>PGUAE</processCD>\n      <documentCD>SEL061</documentCD>\n      <required>OPL</required>\n      <fileUploaded>false</fileUploaded>\n      <height>0</height>\n      <width>0</width>\n      <supportedFileType>.pdf|.PDF</supportedFileType>\n      <maxFileSize>5242880</maxFileSize>\n      <attachmentName>PGUAE:SEL061</attachmentName>\n      <applictionDetailId>36774</applictionDetailId>\n      <emiratesId>784200479031062</emiratesId>\n      <isApproved>false</isApproved>\n      <fileId>file14</fileId>\n      <fileType>2</fileType>\n      <newFile>true</newFile>\n    </com.mopa.sco.bean.AttachmentBean>\n  </attachments>\n  <studyCountry>true</studyCountry>\n  <employmentStatus>P</employmentStatus>\n</com.mopa.sco.application.ApplicationData>"
/// applicationId : "36774"
/// applicationNo : ""
/// appliedOn : null
/// assesmentYear : ""
/// companyId : "20099"
/// country : ""
/// createDate : 1729486786550
/// draftExtendedDate : null
/// emiratesId : "784200479031062"
/// groupId : "0"
/// modifiedDate : 1729486876014
/// motherUAE : ""
/// scholarshipConfId : "SCOPGRDINT"
/// scholarshipType : ""
/// serviceResponse : ""
/// status : "DRAFT"
/// url : "/web/sco/post-graduation-scholarship-in-uae"
/// uuid : "2755c236-40fc-a7fa-962f-b2477d9694ba"

FindDraftByConfigurationKeyModel findDraftByConfigurationKeyFromJson(String str) => FindDraftByConfigurationKeyModel.fromJson(json.decode(str));
String findDraftByConfigurationKeyToJson(FindDraftByConfigurationKeyModel data) => json.encode(data.toJson());
class FindDraftByConfigurationKeyModel {
  FindDraftByConfigurationKeyModel({
      dynamic applicationData, 
      dynamic applicationId, 
      dynamic applicationNo, 
      dynamic appliedOn, 
      dynamic assesmentYear, 
      dynamic companyId, 
      dynamic country, 
      num? createDate, 
      dynamic draftExtendedDate, 
      dynamic emiratesId, 
      dynamic groupId, 
      num? modifiedDate, 
      dynamic motherUAE, 
      dynamic scholarshipConfId, 
      dynamic scholarshipType, 
      dynamic serviceResponse, 
      dynamic status, 
      dynamic url, 
      dynamic uuid,}){
    _applicationData = applicationData;
    _applicationId = applicationId;
    _applicationNo = applicationNo;
    _appliedOn = appliedOn;
    _assesmentYear = assesmentYear;
    _companyId = companyId;
    _country = country;
    _createDate = createDate;
    _draftExtendedDate = draftExtendedDate;
    _emiratesId = emiratesId;
    _groupId = groupId;
    _modifiedDate = modifiedDate;
    _motherUAE = motherUAE;
    _scholarshipConfId = scholarshipConfId;
    _scholarshipType = scholarshipType;
    _serviceResponse = serviceResponse;
    _status = status;
    _url = url;
    _uuid = uuid;
}

  FindDraftByConfigurationKeyModel.fromJson(dynamic json) {
    _applicationData = json['applicationData'];
    _applicationId = json['applicationId'];
    _applicationNo = json['applicationNo'];
    _appliedOn = json['appliedOn'];
    _assesmentYear = json['assesmentYear'];
    _companyId = json['companyId'];
    _country = json['country'];
    _createDate = json['createDate'];
    _draftExtendedDate = json['draftExtendedDate'];
    _emiratesId = json['emiratesId'];
    _groupId = json['groupId'];
    _modifiedDate = json['modifiedDate'];
    _motherUAE = json['motherUAE'];
    _scholarshipConfId = json['scholarshipConfId'];
    _scholarshipType = json['scholarshipType'];
    _serviceResponse = json['serviceResponse'];
    _status = json['status'];
    _url = json['url'];
    _uuid = json['uuid'];
  }
  dynamic _applicationData;
  dynamic _applicationId;
  dynamic _applicationNo;
  dynamic _appliedOn;
  dynamic _assesmentYear;
  dynamic _companyId;
  dynamic _country;
  num? _createDate;
  dynamic _draftExtendedDate;
  dynamic _emiratesId;
  dynamic _groupId;
  num? _modifiedDate;
  dynamic _motherUAE;
  dynamic _scholarshipConfId;
  dynamic _scholarshipType;
  dynamic _serviceResponse;
  dynamic _status;
  dynamic _url;
  dynamic _uuid;
FindDraftByConfigurationKeyModel copyWith({  dynamic applicationData,
  dynamic applicationId,
  dynamic applicationNo,
  dynamic appliedOn,
  dynamic assesmentYear,
  dynamic companyId,
  dynamic country,
  num? createDate,
  dynamic draftExtendedDate,
  dynamic emiratesId,
  dynamic groupId,
  num? modifiedDate,
  dynamic motherUAE,
  dynamic scholarshipConfId,
  dynamic scholarshipType,
  dynamic serviceResponse,
  dynamic status,
  dynamic url,
  dynamic uuid,
}) => FindDraftByConfigurationKeyModel(  applicationData: applicationData ?? _applicationData,
  applicationId: applicationId ?? _applicationId,
  applicationNo: applicationNo ?? _applicationNo,
  appliedOn: appliedOn ?? _appliedOn,
  assesmentYear: assesmentYear ?? _assesmentYear,
  companyId: companyId ?? _companyId,
  country: country ?? _country,
  createDate: createDate ?? _createDate,
  draftExtendedDate: draftExtendedDate ?? _draftExtendedDate,
  emiratesId: emiratesId ?? _emiratesId,
  groupId: groupId ?? _groupId,
  modifiedDate: modifiedDate ?? _modifiedDate,
  motherUAE: motherUAE ?? _motherUAE,
  scholarshipConfId: scholarshipConfId ?? _scholarshipConfId,
  scholarshipType: scholarshipType ?? _scholarshipType,
  serviceResponse: serviceResponse ?? _serviceResponse,
  status: status ?? _status,
  url: url ?? _url,
  uuid: uuid ?? _uuid,
);
  dynamic get applicationData => _applicationData;
  dynamic get applicationId => _applicationId;
  dynamic get applicationNo => _applicationNo;
  dynamic get appliedOn => _appliedOn;
  dynamic get assesmentYear => _assesmentYear;
  dynamic get companyId => _companyId;
  dynamic get country => _country;
  num? get createDate => _createDate;
  dynamic get draftExtendedDate => _draftExtendedDate;
  dynamic get emiratesId => _emiratesId;
  dynamic get groupId => _groupId;
  num? get modifiedDate => _modifiedDate;
  dynamic get motherUAE => _motherUAE;
  dynamic get scholarshipConfId => _scholarshipConfId;
  dynamic get scholarshipType => _scholarshipType;
  dynamic get serviceResponse => _serviceResponse;
  dynamic get status => _status;
  dynamic get url => _url;
  dynamic get uuid => _uuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicationData'] = _applicationData;
    map['applicationId'] = _applicationId;
    map['applicationNo'] = _applicationNo;
    map['appliedOn'] = _appliedOn;
    map['assesmentYear'] = _assesmentYear;
    map['companyId'] = _companyId;
    map['country'] = _country;
    map['createDate'] = _createDate;
    map['draftExtendedDate'] = _draftExtendedDate;
    map['emiratesId'] = _emiratesId;
    map['groupId'] = _groupId;
    map['modifiedDate'] = _modifiedDate;
    map['motherUAE'] = _motherUAE;
    map['scholarshipConfId'] = _scholarshipConfId;
    map['scholarshipType'] = _scholarshipType;
    map['serviceResponse'] = _serviceResponse;
    map['status'] = _status;
    map['url'] = _url;
    map['uuid'] = _uuid;
    return map;
  }

}