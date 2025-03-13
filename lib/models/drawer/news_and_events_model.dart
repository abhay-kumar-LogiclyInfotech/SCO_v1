import 'dart:ui';

import 'package:intl/intl.dart' hide TextDirection;
import 'package:xml/xml.dart' as xml;

import '../../resources/validations_and_errorText.dart';
import '../../utils/utils.dart';


class NewsAndEventsModel {
  String? bookingId;
  String? companyId;
  String? content;
  String? contentCurrentValue;
  String? coverImageCropRegion;
  String? coverImageFileEntryId;
  int? createDate;
  String? description;
  String? descriptionCurrentValue;
  int? entryDate;
  String? entryId;
  String? entryUrl;
  String? groupId;
  bool? isArchived;
  bool? isEvent;
  bool? isPublished;
  Null? lastPublishDate;
  String? location;
  String? locationCurrentValue;
  int? modifiedDate;
  String? newsTilesImageFileEntryId;
  int? publishDate;
  int? status;
  String? statusByUserId;
  String? statusByUserName;
  int? statusDate;
  String? title;
  String? titleCurrentValue;
  String? userId;
  String? userName;
  String? uuid;

  NewsAndEventsModel(
      {this.bookingId,
        this.companyId,
        this.content,
        this.contentCurrentValue,
        this.coverImageCropRegion,
        this.coverImageFileEntryId,
        this.createDate,
        this.description,
        this.descriptionCurrentValue,
        this.entryDate,
        this.entryId,
        this.entryUrl,
        this.groupId,
        this.isArchived,
        this.isEvent,
        this.isPublished,
        this.lastPublishDate,
        this.location,
        this.locationCurrentValue,
        this.modifiedDate,
        this.newsTilesImageFileEntryId,
        this.publishDate,
        this.status,
        this.statusByUserId,
        this.statusByUserName,
        this.statusDate,
        this.title,
        this.titleCurrentValue,
        this.userId,
        this.userName,
        this.uuid});

  NewsAndEventsModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    companyId = json['companyId'];
    content = json['content'];
    contentCurrentValue = json['contentCurrentValue'];
    coverImageCropRegion = json['coverImageCropRegion'];
    coverImageFileEntryId = json['coverImageFileEntryId'];
    createDate = json['createDate'];
    description = json['description'];
    descriptionCurrentValue = json['descriptionCurrentValue'];
    entryDate = json['entryDate'];
    entryId = json['entryId'];
    entryUrl = json['entryUrl'];
    groupId = json['groupId'];
    isArchived = json['isArchived'];
    isEvent = json['isEvent'];
    isPublished = json['isPublished'];
    lastPublishDate = json['lastPublishDate'];
    location = json['location'];
    locationCurrentValue = json['locationCurrentValue'];
    modifiedDate = json['modifiedDate'];
    newsTilesImageFileEntryId = json['newsTilesImageFileEntryId'];
    publishDate = json['publishDate'];
    status = json['status'];
    statusByUserId = json['statusByUserId'];
    statusByUserName = json['statusByUserName'];
    statusDate = json['statusDate'];
    title = json['title'];
    titleCurrentValue = json['titleCurrentValue'];
    userId = json['userId'];
    userName = json['userName'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['companyId'] = this.companyId;
    data['content'] = this.content;
    data['contentCurrentValue'] = this.contentCurrentValue;
    data['coverImageCropRegion'] = this.coverImageCropRegion;
    data['coverImageFileEntryId'] = this.coverImageFileEntryId;
    data['createDate'] = this.createDate;
    data['description'] = this.description;
    data['descriptionCurrentValue'] = this.descriptionCurrentValue;
    data['entryDate'] = this.entryDate;
    data['entryId'] = this.entryId;
    data['entryUrl'] = this.entryUrl;
    data['groupId'] = this.groupId;
    data['isArchived'] = this.isArchived;
    data['isEvent'] = this.isEvent;
    data['isPublished'] = this.isPublished;
    data['lastPublishDate'] = this.lastPublishDate;
    data['location'] = this.location;
    data['locationCurrentValue'] = this.locationCurrentValue;
    data['modifiedDate'] = this.modifiedDate;
    data['newsTilesImageFileEntryId'] = this.newsTilesImageFileEntryId;
    data['publishDate'] = this.publishDate;
    data['status'] = this.status;
    data['statusByUserId'] = this.statusByUserId;
    data['statusByUserName'] = this.statusByUserName;
    data['statusDate'] = this.statusDate;
    data['title'] = this.title;
    data['titleCurrentValue'] = this.titleCurrentValue;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['uuid'] = this.uuid;
    return data;
  }
}



class ParseNewsAndEventsModel {
  final String content;
  final String description;
  final String title;
  final dynamic publishDate;
  final String coverImageFileEntryId;
  final String entryUrl;

  ParseNewsAndEventsModel({
    required this.content,
    required this.description,
    required this.title,
    required this.publishDate,
    required this.coverImageFileEntryId,
    required this.entryUrl,
  });



  String getContent(String languageId) {
    final rawContent = extractXmlValue(content, languageId, 'content');
    return Validations.stripHtml(rawContent);
  }

  String getDescription(String languageId) {
    final rawDescription = extractXmlValue(description, languageId, 'description');
    return Validations.stripHtml(rawDescription);
  }

  String getTitle(String languageId) {
    final rawTitle = extractXmlValue(title, languageId, 'title');
    return Validations.stripHtml(rawTitle);
  }




  String getFormattedDate(langProvider) {

    final textDirection = getTextDirection(langProvider);
    final bool isLtr = textDirection == TextDirection.ltr;
    final date = DateTime.fromMillisecondsSinceEpoch(publishDate);

    // Separate formatters to control the output
    final yearFormatter = DateFormat('yyyy', 'en'); // English year
    final monthFormatter = DateFormat('MMMM', isLtr ? 'en' : 'ar'); // Arabic month
    final dayFormatter = DateFormat('d', 'en'); // English day

    String year = yearFormatter.format(date); // 2019
    String arabicMonth = monthFormatter.format(date); // سبتمبر
    String day = dayFormatter.format(date); // 15

    return '$day $arabicMonth $year';
  }
}
