class HomeSliderModel {
  HomeSliderModel({
      String? dDMStructureKey, 
      String? dDMTemplateKey, 
      String? articleId, 
      String? classNameId, 
      String? classPK, 
      String? companyId, 
      String? content, 
      num? createDate, 
      String? defaultLanguageId, 
      num? displayDate, 
      dynamic expirationDate, 
      String? folderId, 
      String? groupId, 
      String? id, 
      bool? indexable, 
      dynamic lastPublishDate, 
      String? layoutUuid, 
      num? modifiedDate, 
      String? resourcePrimKey, 
      dynamic reviewDate, 
      bool? smallImage, 
      String? smallImageId, 
      String? smallImageURL, 
      num? status, 
      String? statusByUserId, 
      String? statusByUserName, 
      num? statusDate, 
      String? treePath, 
      String? urlTitle, 
      String? userId, 
      String? userName, 
      String? uuid, 
      num? version,}){
    _dDMStructureKey = dDMStructureKey;
    _dDMTemplateKey = dDMTemplateKey;
    _articleId = articleId;
    _classNameId = classNameId;
    _classPK = classPK;
    _companyId = companyId;
    _content = content;
    _createDate = createDate;
    _defaultLanguageId = defaultLanguageId;
    _displayDate = displayDate;
    _expirationDate = expirationDate;
    _folderId = folderId;
    _groupId = groupId;
    _id = id;
    _indexable = indexable;
    _lastPublishDate = lastPublishDate;
    _layoutUuid = layoutUuid;
    _modifiedDate = modifiedDate;
    _resourcePrimKey = resourcePrimKey;
    _reviewDate = reviewDate;
    _smallImage = smallImage;
    _smallImageId = smallImageId;
    _smallImageURL = smallImageURL;
    _status = status;
    _statusByUserId = statusByUserId;
    _statusByUserName = statusByUserName;
    _statusDate = statusDate;
    _treePath = treePath;
    _urlTitle = urlTitle;
    _userId = userId;
    _userName = userName;
    _uuid = uuid;
    _version = version;
}

  HomeSliderModel.fromJson(dynamic json) {
    _dDMStructureKey = json['DDMStructureKey'];
    _dDMTemplateKey = json['DDMTemplateKey'];
    _articleId = json['articleId'];
    _classNameId = json['classNameId'];
    _classPK = json['classPK'];
    _companyId = json['companyId'];
    _content = json['content'];
    _createDate = json['createDate'];
    _defaultLanguageId = json['defaultLanguageId'];
    _displayDate = json['displayDate'];
    _expirationDate = json['expirationDate'];
    _folderId = json['folderId'];
    _groupId = json['groupId'];
    _id = json['id'];
    _indexable = json['indexable'];
    _lastPublishDate = json['lastPublishDate'];
    _layoutUuid = json['layoutUuid'];
    _modifiedDate = json['modifiedDate'];
    _resourcePrimKey = json['resourcePrimKey'];
    _reviewDate = json['reviewDate'];
    _smallImage = json['smallImage'];
    _smallImageId = json['smallImageId'];
    _smallImageURL = json['smallImageURL'];
    _status = json['status'];
    _statusByUserId = json['statusByUserId'];
    _statusByUserName = json['statusByUserName'];
    _statusDate = json['statusDate'];
    _treePath = json['treePath'];
    _urlTitle = json['urlTitle'];
    _userId = json['userId'];
    _userName = json['userName'];
    _uuid = json['uuid'];
    _version = json['version'];
  }
  String? _dDMStructureKey;
  String? _dDMTemplateKey;
  String? _articleId;
  String? _classNameId;
  String? _classPK;
  String? _companyId;
  String? _content;
  num? _createDate;
  String? _defaultLanguageId;
  num? _displayDate;
  dynamic _expirationDate;
  String? _folderId;
  String? _groupId;
  String? _id;
  bool? _indexable;
  dynamic _lastPublishDate;
  String? _layoutUuid;
  num? _modifiedDate;
  String? _resourcePrimKey;
  dynamic _reviewDate;
  bool? _smallImage;
  String? _smallImageId;
  String? _smallImageURL;
  num? _status;
  String? _statusByUserId;
  String? _statusByUserName;
  num? _statusDate;
  String? _treePath;
  String? _urlTitle;
  String? _userId;
  String? _userName;
  String? _uuid;
  num? _version;
HomeSliderModel copyWith({  String? dDMStructureKey,
  String? dDMTemplateKey,
  String? articleId,
  String? classNameId,
  String? classPK,
  String? companyId,
  String? content,
  num? createDate,
  String? defaultLanguageId,
  num? displayDate,
  dynamic expirationDate,
  String? folderId,
  String? groupId,
  String? id,
  bool? indexable,
  dynamic lastPublishDate,
  String? layoutUuid,
  num? modifiedDate,
  String? resourcePrimKey,
  dynamic reviewDate,
  bool? smallImage,
  String? smallImageId,
  String? smallImageURL,
  num? status,
  String? statusByUserId,
  String? statusByUserName,
  num? statusDate,
  String? treePath,
  String? urlTitle,
  String? userId,
  String? userName,
  String? uuid,
  num? version,
}) => HomeSliderModel(  dDMStructureKey: dDMStructureKey ?? _dDMStructureKey,
  dDMTemplateKey: dDMTemplateKey ?? _dDMTemplateKey,
  articleId: articleId ?? _articleId,
  classNameId: classNameId ?? _classNameId,
  classPK: classPK ?? _classPK,
  companyId: companyId ?? _companyId,
  content: content ?? _content,
  createDate: createDate ?? _createDate,
  defaultLanguageId: defaultLanguageId ?? _defaultLanguageId,
  displayDate: displayDate ?? _displayDate,
  expirationDate: expirationDate ?? _expirationDate,
  folderId: folderId ?? _folderId,
  groupId: groupId ?? _groupId,
  id: id ?? _id,
  indexable: indexable ?? _indexable,
  lastPublishDate: lastPublishDate ?? _lastPublishDate,
  layoutUuid: layoutUuid ?? _layoutUuid,
  modifiedDate: modifiedDate ?? _modifiedDate,
  resourcePrimKey: resourcePrimKey ?? _resourcePrimKey,
  reviewDate: reviewDate ?? _reviewDate,
  smallImage: smallImage ?? _smallImage,
  smallImageId: smallImageId ?? _smallImageId,
  smallImageURL: smallImageURL ?? _smallImageURL,
  status: status ?? _status,
  statusByUserId: statusByUserId ?? _statusByUserId,
  statusByUserName: statusByUserName ?? _statusByUserName,
  statusDate: statusDate ?? _statusDate,
  treePath: treePath ?? _treePath,
  urlTitle: urlTitle ?? _urlTitle,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  uuid: uuid ?? _uuid,
  version: version ?? _version,
);
  String? get dDMStructureKey => _dDMStructureKey;
  String? get dDMTemplateKey => _dDMTemplateKey;
  String? get articleId => _articleId;
  String? get classNameId => _classNameId;
  String? get classPK => _classPK;
  String? get companyId => _companyId;
  String? get content => _content;
  num? get createDate => _createDate;
  String? get defaultLanguageId => _defaultLanguageId;
  num? get displayDate => _displayDate;
  dynamic get expirationDate => _expirationDate;
  String? get folderId => _folderId;
  String? get groupId => _groupId;
  String? get id => _id;
  bool? get indexable => _indexable;
  dynamic get lastPublishDate => _lastPublishDate;
  String? get layoutUuid => _layoutUuid;
  num? get modifiedDate => _modifiedDate;
  String? get resourcePrimKey => _resourcePrimKey;
  dynamic get reviewDate => _reviewDate;
  bool? get smallImage => _smallImage;
  String? get smallImageId => _smallImageId;
  String? get smallImageURL => _smallImageURL;
  num? get status => _status;
  String? get statusByUserId => _statusByUserId;
  String? get statusByUserName => _statusByUserName;
  num? get statusDate => _statusDate;
  String? get treePath => _treePath;
  String? get urlTitle => _urlTitle;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get uuid => _uuid;
  num? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DDMStructureKey'] = _dDMStructureKey;
    map['DDMTemplateKey'] = _dDMTemplateKey;
    map['articleId'] = _articleId;
    map['classNameId'] = _classNameId;
    map['classPK'] = _classPK;
    map['companyId'] = _companyId;
    map['content'] = _content;
    map['createDate'] = _createDate;
    map['defaultLanguageId'] = _defaultLanguageId;
    map['displayDate'] = _displayDate;
    map['expirationDate'] = _expirationDate;
    map['folderId'] = _folderId;
    map['groupId'] = _groupId;
    map['id'] = _id;
    map['indexable'] = _indexable;
    map['lastPublishDate'] = _lastPublishDate;
    map['layoutUuid'] = _layoutUuid;
    map['modifiedDate'] = _modifiedDate;
    map['resourcePrimKey'] = _resourcePrimKey;
    map['reviewDate'] = _reviewDate;
    map['smallImage'] = _smallImage;
    map['smallImageId'] = _smallImageId;
    map['smallImageURL'] = _smallImageURL;
    map['status'] = _status;
    map['statusByUserId'] = _statusByUserId;
    map['statusByUserName'] = _statusByUserName;
    map['statusDate'] = _statusDate;
    map['treePath'] = _treePath;
    map['urlTitle'] = _urlTitle;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['uuid'] = _uuid;
    map['version'] = _version;
    return map;
  }

}