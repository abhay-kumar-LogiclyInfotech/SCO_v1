

class VisionAndMissionModel {
  VisionAndMissionModel({
      String? companyId, 
      String? content, 
      String? contentCurrentValue, 
      String? coverImageCropRegion, 
      String? coverImageFileEntryId, 
      String? coverImageUrl, 
      num? createDate, 
      String? entryId, 
      String? groupId, 
      bool? isTitleOnly, 
      dynamic lastPublishDate, 
      num? modifiedDate, 
      String? pageUrl, 
      num? status, 
      String? statusByUserId, 
      String? statusByUserName, 
      num? statusDate, 
      String? title, 
      String? titleCurrentValue, 
      String? userId, 
      String? userName, 
      String? uuid,}){
    _companyId = companyId;
    _content = content;
    _contentCurrentValue = contentCurrentValue;
    _coverImageCropRegion = coverImageCropRegion;
    _coverImageFileEntryId = coverImageFileEntryId;
    _coverImageUrl = coverImageUrl;
    _createDate = createDate;
    _entryId = entryId;
    _groupId = groupId;
    _isTitleOnly = isTitleOnly;
    _lastPublishDate = lastPublishDate;
    _modifiedDate = modifiedDate;
    _pageUrl = pageUrl;
    _status = status;
    _statusByUserId = statusByUserId;
    _statusByUserName = statusByUserName;
    _statusDate = statusDate;
    _title = title;
    _titleCurrentValue = titleCurrentValue;
    _userId = userId;
    _userName = userName;
    _uuid = uuid;
}

  VisionAndMissionModel.fromJson(dynamic json) {
    _companyId = json['companyId'];
    _content = json['content'];
    _contentCurrentValue = json['contentCurrentValue'];
    _coverImageCropRegion = json['coverImageCropRegion'];
    _coverImageFileEntryId = json['coverImageFileEntryId'];
    _coverImageUrl = json['coverImageUrl'];
    _createDate = json['createDate'];
    _entryId = json['entryId'];
    _groupId = json['groupId'];
    _isTitleOnly = json['isTitleOnly'];
    _lastPublishDate = json['lastPublishDate'];
    _modifiedDate = json['modifiedDate'];
    _pageUrl = json['pageUrl'];
    _status = json['status'];
    _statusByUserId = json['statusByUserId'];
    _statusByUserName = json['statusByUserName'];
    _statusDate = json['statusDate'];
    _title = json['title'];
    _titleCurrentValue = json['titleCurrentValue'];
    _userId = json['userId'];
    _userName = json['userName'];
    _uuid = json['uuid'];
  }
  String? _companyId;
  String? _content;
  String? _contentCurrentValue;
  String? _coverImageCropRegion;
  String? _coverImageFileEntryId;
  String? _coverImageUrl;
  num? _createDate;
  String? _entryId;
  String? _groupId;
  bool? _isTitleOnly;
  dynamic _lastPublishDate;
  num? _modifiedDate;
  String? _pageUrl;
  num? _status;
  String? _statusByUserId;
  String? _statusByUserName;
  num? _statusDate;
  String? _title;
  String? _titleCurrentValue;
  String? _userId;
  String? _userName;
  String? _uuid;
VisionAndMissionModel copyWith({  String? companyId,
  String? content,
  String? contentCurrentValue,
  String? coverImageCropRegion,
  String? coverImageFileEntryId,
  String? coverImageUrl,
  num? createDate,
  String? entryId,
  String? groupId,
  bool? isTitleOnly,
  dynamic lastPublishDate,
  num? modifiedDate,
  String? pageUrl,
  num? status,
  String? statusByUserId,
  String? statusByUserName,
  num? statusDate,
  String? title,
  String? titleCurrentValue,
  String? userId,
  String? userName,
  String? uuid,
}) => VisionAndMissionModel(  companyId: companyId ?? _companyId,
  content: content ?? _content,
  contentCurrentValue: contentCurrentValue ?? _contentCurrentValue,
  coverImageCropRegion: coverImageCropRegion ?? _coverImageCropRegion,
  coverImageFileEntryId: coverImageFileEntryId ?? _coverImageFileEntryId,
  coverImageUrl: coverImageUrl ?? _coverImageUrl,
  createDate: createDate ?? _createDate,
  entryId: entryId ?? _entryId,
  groupId: groupId ?? _groupId,
  isTitleOnly: isTitleOnly ?? _isTitleOnly,
  lastPublishDate: lastPublishDate ?? _lastPublishDate,
  modifiedDate: modifiedDate ?? _modifiedDate,
  pageUrl: pageUrl ?? _pageUrl,
  status: status ?? _status,
  statusByUserId: statusByUserId ?? _statusByUserId,
  statusByUserName: statusByUserName ?? _statusByUserName,
  statusDate: statusDate ?? _statusDate,
  title: title ?? _title,
  titleCurrentValue: titleCurrentValue ?? _titleCurrentValue,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  uuid: uuid ?? _uuid,
);
  String? get companyId => _companyId;
  String? get content => _content;
  String? get contentCurrentValue => _contentCurrentValue;
  String? get coverImageCropRegion => _coverImageCropRegion;
  String? get coverImageFileEntryId => _coverImageFileEntryId;
  String? get coverImageUrl => _coverImageUrl;
  num? get createDate => _createDate;
  String? get entryId => _entryId;
  String? get groupId => _groupId;
  bool? get isTitleOnly => _isTitleOnly;
  dynamic get lastPublishDate => _lastPublishDate;
  num? get modifiedDate => _modifiedDate;
  String? get pageUrl => _pageUrl;
  num? get status => _status;
  String? get statusByUserId => _statusByUserId;
  String? get statusByUserName => _statusByUserName;
  num? get statusDate => _statusDate;
  String? get title => _title;
  String? get titleCurrentValue => _titleCurrentValue;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get uuid => _uuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyId'] = _companyId;
    map['content'] = _content;
    map['contentCurrentValue'] = _contentCurrentValue;
    map['coverImageCropRegion'] = _coverImageCropRegion;
    map['coverImageFileEntryId'] = _coverImageFileEntryId;
    map['coverImageUrl'] = _coverImageUrl;
    map['createDate'] = _createDate;
    map['entryId'] = _entryId;
    map['groupId'] = _groupId;
    map['isTitleOnly'] = _isTitleOnly;
    map['lastPublishDate'] = _lastPublishDate;
    map['modifiedDate'] = _modifiedDate;
    map['pageUrl'] = _pageUrl;
    map['status'] = _status;
    map['statusByUserId'] = _statusByUserId;
    map['statusByUserName'] = _statusByUserName;
    map['statusDate'] = _statusDate;
    map['title'] = _title;
    map['titleCurrentValue'] = _titleCurrentValue;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['uuid'] = _uuid;
    return map;
  }

}