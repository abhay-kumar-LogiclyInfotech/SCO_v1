import 'dart:convert';
/// acadLoadAppr : "F"
/// acadmicCareer : "DDS"
/// acadmicPlan : "SCO-D"
/// acadmicProgram : "SCO-D"
/// admApplicationCenter : "AD"
/// admitTerm : "2257"
/// admitType : "ONL"
/// approvedChecklistCode : "ATTACH_EXDDAP_Y_N"
/// campus : "AD"
/// checklistCode : "ATTACH_DDS_Y_N"
/// cohort : "2023"
/// companyId : "20099"
/// configurationId : "17"
/// configurationKey : "SCODDSEXT"
/// configurationName : "بعثة صاحب السمو رئيس الدولة للأطباء المتميّزين"
/// configurationNameEng : "DDS External"
/// createDate : 1664859297380
/// draftEndDate : null
/// endDate : 1964390400000
/// groupId : "20126"
/// institution : "SCO"
/// is12ThRequired : false
/// isActive : true
/// isDraftSubmission : false
/// isRemoved : false
/// isSpecialCase : false
/// lastPublishDate : null
/// modifiedDate : 1664859297380
/// programAction : "APPL"
/// programStatus : "AP"
/// scholarshipType : "EXT"
/// startDate : 1577822400000
/// status : 0
/// statusByUserId : "76333"
/// statusByUserName : "Amit Sharma"
/// statusDate : 1609998082000
/// successMessageArabic : ""
/// successMessageEnglish : ""
/// userId : "1007210"
/// userName : "Amr . Adel"
/// uuid : "be4d8b4a-c9f7-b69e-6af1-d565de64ae0b"

GetAllActiveScholarshipsModel getAllActiveScholarshipsModelFromJson(dynamic str) => GetAllActiveScholarshipsModel.fromJson(json.decode(str));
dynamic getAllActiveScholarshipsModelToJson(GetAllActiveScholarshipsModel data) => json.encode(data.toJson());
class GetAllActiveScholarshipsModel {
  GetAllActiveScholarshipsModel({
      dynamic? acadLoadAppr, 
      dynamic? acadmicCareer, 
      dynamic? acadmicPlan, 
      dynamic? acadmicProgram, 
      dynamic? admApplicationCenter, 
      dynamic? admitTerm, 
      dynamic? admitType, 
      dynamic? approvedChecklistCode, 
      dynamic? campus, 
      dynamic? checklistCode, 
      dynamic? cohort, 
      dynamic? companyId, 
      dynamic? configurationId, 
      dynamic? configurationKey, 
      dynamic? configurationName, 
      dynamic? configurationNameEng, 
      dynamic? createDate, 
      dynamic draftEndDate, 
      dynamic? endDate, 
      dynamic? groupId, 
      dynamic? institution, 
      bool? is12ThRequired, 
      bool? isActive, 
      bool? isDraftSubmission, 
      bool? isRemoved, 
      bool? isSpecialCase, 
      dynamic lastPublishDate, 
      dynamic? modifiedDate, 
      dynamic? programAction, 
      dynamic? programStatus, 
      dynamic? scholarshipType, 
      dynamic? startDate, 
      dynamic? status, 
      dynamic? statusByUserId, 
      dynamic? statusByUserName, 
      dynamic? statusDate, 
      dynamic? successMessageArabic, 
      dynamic? successMessageEnglish, 
      dynamic? userId, 
      dynamic? userName, 
      dynamic? uuid,}){
    _acadLoadAppr = acadLoadAppr;
    _acadmicCareer = acadmicCareer;
    _acadmicPlan = acadmicPlan;
    _acadmicProgram = acadmicProgram;
    _admApplicationCenter = admApplicationCenter;
    _admitTerm = admitTerm;
    _admitType = admitType;
    _approvedChecklistCode = approvedChecklistCode;
    _campus = campus;
    _checklistCode = checklistCode;
    _cohort = cohort;
    _companyId = companyId;
    _configurationId = configurationId;
    _configurationKey = configurationKey;
    _configurationName = configurationName;
    _configurationNameEng = configurationNameEng;
    _createDate = createDate;
    _draftEndDate = draftEndDate;
    _endDate = endDate;
    _groupId = groupId;
    _institution = institution;
    _is12ThRequired = is12ThRequired;
    _isActive = isActive;
    _isDraftSubmission = isDraftSubmission;
    _isRemoved = isRemoved;
    _isSpecialCase = isSpecialCase;
    _lastPublishDate = lastPublishDate;
    _modifiedDate = modifiedDate;
    _programAction = programAction;
    _programStatus = programStatus;
    _scholarshipType = scholarshipType;
    _startDate = startDate;
    _status = status;
    _statusByUserId = statusByUserId;
    _statusByUserName = statusByUserName;
    _statusDate = statusDate;
    _successMessageArabic = successMessageArabic;
    _successMessageEnglish = successMessageEnglish;
    _userId = userId;
    _userName = userName;
    _uuid = uuid;
}

  GetAllActiveScholarshipsModel.fromJson(dynamic json) {
    _acadLoadAppr = json['acadLoadAppr'];
    _acadmicCareer = json['acadmicCareer'];
    _acadmicPlan = json['acadmicPlan'];
    _acadmicProgram = json['acadmicProgram'];
    _admApplicationCenter = json['admApplicationCenter'];
    _admitTerm = json['admitTerm'];
    _admitType = json['admitType'];
    _approvedChecklistCode = json['approvedChecklistCode'];
    _campus = json['campus'];
    _checklistCode = json['checklistCode'];
    _cohort = json['cohort'];
    _companyId = json['companyId'];
    _configurationId = json['configurationId'];
    _configurationKey = json['configurationKey'];
    _configurationName = json['configurationName'];
    _configurationNameEng = json['configurationNameEng'];
    _createDate = json['createDate'];
    _draftEndDate = json['draftEndDate'];
    _endDate = json['endDate'];
    _groupId = json['groupId'];
    _institution = json['institution'];
    _is12ThRequired = json['is12ThRequired'];
    _isActive = json['isActive'];
    _isDraftSubmission = json['isDraftSubmission'];
    _isRemoved = json['isRemoved'];
    _isSpecialCase = json['isSpecialCase'];
    _lastPublishDate = json['lastPublishDate'];
    _modifiedDate = json['modifiedDate'];
    _programAction = json['programAction'];
    _programStatus = json['programStatus'];
    _scholarshipType = json['scholarshipType'];
    _startDate = json['startDate'];
    _status = json['status'];
    _statusByUserId = json['statusByUserId'];
    _statusByUserName = json['statusByUserName'];
    _statusDate = json['statusDate'];
    _successMessageArabic = json['successMessageArabic'];
    _successMessageEnglish = json['successMessageEnglish'];
    _userId = json['userId'];
    _userName = json['userName'];
    _uuid = json['uuid'];
  }
  dynamic? _acadLoadAppr;
  dynamic? _acadmicCareer;
  dynamic? _acadmicPlan;
  dynamic? _acadmicProgram;
  dynamic? _admApplicationCenter;
  dynamic? _admitTerm;
  dynamic? _admitType;
  dynamic? _approvedChecklistCode;
  dynamic? _campus;
  dynamic? _checklistCode;
  dynamic? _cohort;
  dynamic? _companyId;
  dynamic? _configurationId;
  dynamic? _configurationKey;
  dynamic? _configurationName;
  dynamic? _configurationNameEng;
  dynamic? _createDate;
  dynamic _draftEndDate;
  dynamic? _endDate;
  dynamic? _groupId;
  dynamic? _institution;
  bool? _is12ThRequired;
  bool? _isActive;
  bool? _isDraftSubmission;
  bool? _isRemoved;
  bool? _isSpecialCase;
  dynamic _lastPublishDate;
  dynamic? _modifiedDate;
  dynamic? _programAction;
  dynamic? _programStatus;
  dynamic? _scholarshipType;
  dynamic? _startDate;
  dynamic? _status;
  dynamic? _statusByUserId;
  dynamic? _statusByUserName;
  dynamic? _statusDate;
  dynamic? _successMessageArabic;
  dynamic? _successMessageEnglish;
  dynamic? _userId;
  dynamic? _userName;
  dynamic? _uuid;
GetAllActiveScholarshipsModel copyWith({  dynamic? acadLoadAppr,
  dynamic? acadmicCareer,
  dynamic? acadmicPlan,
  dynamic? acadmicProgram,
  dynamic? admApplicationCenter,
  dynamic? admitTerm,
  dynamic? admitType,
  dynamic? approvedChecklistCode,
  dynamic? campus,
  dynamic? checklistCode,
  dynamic? cohort,
  dynamic? companyId,
  dynamic? configurationId,
  dynamic? configurationKey,
  dynamic? configurationName,
  dynamic? configurationNameEng,
  dynamic? createDate,
  dynamic draftEndDate,
  dynamic? endDate,
  dynamic? groupId,
  dynamic? institution,
  bool? is12ThRequired,
  bool? isActive,
  bool? isDraftSubmission,
  bool? isRemoved,
  bool? isSpecialCase,
  dynamic lastPublishDate,
  dynamic? modifiedDate,
  dynamic? programAction,
  dynamic? programStatus,
  dynamic? scholarshipType,
  dynamic? startDate,
  dynamic? status,
  dynamic? statusByUserId,
  dynamic? statusByUserName,
  dynamic? statusDate,
  dynamic? successMessageArabic,
  dynamic? successMessageEnglish,
  dynamic? userId,
  dynamic? userName,
  dynamic? uuid,
}) => GetAllActiveScholarshipsModel(  acadLoadAppr: acadLoadAppr ?? _acadLoadAppr,
  acadmicCareer: acadmicCareer ?? _acadmicCareer,
  acadmicPlan: acadmicPlan ?? _acadmicPlan,
  acadmicProgram: acadmicProgram ?? _acadmicProgram,
  admApplicationCenter: admApplicationCenter ?? _admApplicationCenter,
  admitTerm: admitTerm ?? _admitTerm,
  admitType: admitType ?? _admitType,
  approvedChecklistCode: approvedChecklistCode ?? _approvedChecklistCode,
  campus: campus ?? _campus,
  checklistCode: checklistCode ?? _checklistCode,
  cohort: cohort ?? _cohort,
  companyId: companyId ?? _companyId,
  configurationId: configurationId ?? _configurationId,
  configurationKey: configurationKey ?? _configurationKey,
  configurationName: configurationName ?? _configurationName,
  configurationNameEng: configurationNameEng ?? _configurationNameEng,
  createDate: createDate ?? _createDate,
  draftEndDate: draftEndDate ?? _draftEndDate,
  endDate: endDate ?? _endDate,
  groupId: groupId ?? _groupId,
  institution: institution ?? _institution,
  is12ThRequired: is12ThRequired ?? _is12ThRequired,
  isActive: isActive ?? _isActive,
  isDraftSubmission: isDraftSubmission ?? _isDraftSubmission,
  isRemoved: isRemoved ?? _isRemoved,
  isSpecialCase: isSpecialCase ?? _isSpecialCase,
  lastPublishDate: lastPublishDate ?? _lastPublishDate,
  modifiedDate: modifiedDate ?? _modifiedDate,
  programAction: programAction ?? _programAction,
  programStatus: programStatus ?? _programStatus,
  scholarshipType: scholarshipType ?? _scholarshipType,
  startDate: startDate ?? _startDate,
  status: status ?? _status,
  statusByUserId: statusByUserId ?? _statusByUserId,
  statusByUserName: statusByUserName ?? _statusByUserName,
  statusDate: statusDate ?? _statusDate,
  successMessageArabic: successMessageArabic ?? _successMessageArabic,
  successMessageEnglish: successMessageEnglish ?? _successMessageEnglish,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  uuid: uuid ?? _uuid,
);
  dynamic? get acadLoadAppr => _acadLoadAppr;
  dynamic? get acadmicCareer => _acadmicCareer;
  dynamic? get acadmicPlan => _acadmicPlan;
  dynamic? get acadmicProgram => _acadmicProgram;
  dynamic? get admApplicationCenter => _admApplicationCenter;
  dynamic? get admitTerm => _admitTerm;
  dynamic? get admitType => _admitType;
  dynamic? get approvedChecklistCode => _approvedChecklistCode;
  dynamic? get campus => _campus;
  dynamic? get checklistCode => _checklistCode;
  dynamic? get cohort => _cohort;
  dynamic? get companyId => _companyId;
  dynamic? get configurationId => _configurationId;
  dynamic? get configurationKey => _configurationKey;
  dynamic? get configurationName => _configurationName;
  dynamic? get configurationNameEng => _configurationNameEng;
  dynamic? get createDate => _createDate;
  dynamic get draftEndDate => _draftEndDate;
  dynamic? get endDate => _endDate;
  dynamic? get groupId => _groupId;
  dynamic? get institution => _institution;
  bool? get is12ThRequired => _is12ThRequired;
  bool? get isActive => _isActive;
  bool? get isDraftSubmission => _isDraftSubmission;
  bool? get isRemoved => _isRemoved;
  bool? get isSpecialCase => _isSpecialCase;
  dynamic get lastPublishDate => _lastPublishDate;
  dynamic? get modifiedDate => _modifiedDate;
  dynamic? get programAction => _programAction;
  dynamic? get programStatus => _programStatus;
  dynamic? get scholarshipType => _scholarshipType;
  dynamic? get startDate => _startDate;
  dynamic? get status => _status;
  dynamic? get statusByUserId => _statusByUserId;
  dynamic? get statusByUserName => _statusByUserName;
  dynamic? get statusDate => _statusDate;
  dynamic? get successMessageArabic => _successMessageArabic;
  dynamic? get successMessageEnglish => _successMessageEnglish;
  dynamic? get userId => _userId;
  dynamic? get userName => _userName;
  dynamic? get uuid => _uuid;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['acadLoadAppr'] = _acadLoadAppr;
    map['acadmicCareer'] = _acadmicCareer;
    map['acadmicPlan'] = _acadmicPlan;
    map['acadmicProgram'] = _acadmicProgram;
    map['admApplicationCenter'] = _admApplicationCenter;
    map['admitTerm'] = _admitTerm;
    map['admitType'] = _admitType;
    map['approvedChecklistCode'] = _approvedChecklistCode;
    map['campus'] = _campus;
    map['checklistCode'] = _checklistCode;
    map['cohort'] = _cohort;
    map['companyId'] = _companyId;
    map['configurationId'] = _configurationId;
    map['configurationKey'] = _configurationKey;
    map['configurationName'] = _configurationName;
    map['configurationNameEng'] = _configurationNameEng;
    map['createDate'] = _createDate;
    map['draftEndDate'] = _draftEndDate;
    map['endDate'] = _endDate;
    map['groupId'] = _groupId;
    map['institution'] = _institution;
    map['is12ThRequired'] = _is12ThRequired;
    map['isActive'] = _isActive;
    map['isDraftSubmission'] = _isDraftSubmission;
    map['isRemoved'] = _isRemoved;
    map['isSpecialCase'] = _isSpecialCase;
    map['lastPublishDate'] = _lastPublishDate;
    map['modifiedDate'] = _modifiedDate;
    map['programAction'] = _programAction;
    map['programStatus'] = _programStatus;
    map['scholarshipType'] = _scholarshipType;
    map['startDate'] = _startDate;
    map['status'] = _status;
    map['statusByUserId'] = _statusByUserId;
    map['statusByUserName'] = _statusByUserName;
    map['statusDate'] = _statusDate;
    map['successMessageArabic'] = _successMessageArabic;
    map['successMessageEnglish'] = _successMessageEnglish;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['uuid'] = _uuid;
    return map;
  }

}