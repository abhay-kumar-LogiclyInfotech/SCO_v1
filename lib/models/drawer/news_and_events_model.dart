import 'dart:ui';

import 'package:intl/intl.dart' hide TextDirection;
import 'package:xml/xml.dart' as xml;

import '../../resources/validations_and_errorText.dart';
import '../../utils/utils.dart';


// class NewsAndEventsModel {
//   String? bookingId;
//   String? companyId;
//   String? content;
//   String? contentCurrentValue;
//   String? coverImageCropRegion;
//   String? coverImageFileEntryId;
//   int? createDate;
//   String? description;
//   String? descriptionCurrentValue;
//   int? entryDate;
//   String? entryId;
//   String? entryUrl;
//   String? groupId;
//   bool? isArchived;
//   bool? isEvent;
//   bool? isPublished;
//   Null? lastPublishDate;
//   String? location;
//   String? locationCurrentValue;
//   int? modifiedDate;
//   String? newsTilesImageFileEntryId;
//   int? publishDate;
//   int? status;
//   String? statusByUserId;
//   String? statusByUserName;
//   int? statusDate;
//   String? title;
//   String? titleCurrentValue;
//   String? userId;
//   String? userName;
//   String? uuid;
//
//   NewsAndEventsModel(
//       {this.bookingId,
//         this.companyId,
//         this.content,
//         this.contentCurrentValue,
//         this.coverImageCropRegion,
//         this.coverImageFileEntryId,
//         this.createDate,
//         this.description,
//         this.descriptionCurrentValue,
//         this.entryDate,
//         this.entryId,
//         this.entryUrl,
//         this.groupId,
//         this.isArchived,
//         this.isEvent,
//         this.isPublished,
//         this.lastPublishDate,
//         this.location,
//         this.locationCurrentValue,
//         this.modifiedDate,
//         this.newsTilesImageFileEntryId,
//         this.publishDate,
//         this.status,
//         this.statusByUserId,
//         this.statusByUserName,
//         this.statusDate,
//         this.title,
//         this.titleCurrentValue,
//         this.userId,
//         this.userName,
//         this.uuid});
//
//   NewsAndEventsModel.fromJson(Map<String, dynamic> json) {
//     bookingId = json['bookingId'];
//     companyId = json['companyId'];
//     content = json['content'];
//     contentCurrentValue = json['contentCurrentValue'];
//     coverImageCropRegion = json['coverImageCropRegion'];
//     coverImageFileEntryId = json['coverImageFileEntryId'];
//     createDate = json['createDate'];
//     description = json['description'];
//     descriptionCurrentValue = json['descriptionCurrentValue'];
//     entryDate = json['entryDate'];
//     entryId = json['entryId'];
//     entryUrl = json['entryUrl'];
//     groupId = json['groupId'];
//     isArchived = json['isArchived'];
//     isEvent = json['isEvent'];
//     isPublished = json['isPublished'];
//     lastPublishDate = json['lastPublishDate'];
//     location = json['location'];
//     locationCurrentValue = json['locationCurrentValue'];
//     modifiedDate = json['modifiedDate'];
//     newsTilesImageFileEntryId = json['newsTilesImageFileEntryId'];
//     publishDate = json['publishDate'];
//     status = json['status'];
//     statusByUserId = json['statusByUserId'];
//     statusByUserName = json['statusByUserName'];
//     statusDate = json['statusDate'];
//     title = json['title'];
//     titleCurrentValue = json['titleCurrentValue'];
//     userId = json['userId'];
//     userName = json['userName'];
//     uuid = json['uuid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bookingId'] = this.bookingId;
//     data['companyId'] = this.companyId;
//     data['content'] = this.content;
//     data['contentCurrentValue'] = this.contentCurrentValue;
//     data['coverImageCropRegion'] = this.coverImageCropRegion;
//     data['coverImageFileEntryId'] = this.coverImageFileEntryId;
//     data['createDate'] = this.createDate;
//     data['description'] = this.description;
//     data['descriptionCurrentValue'] = this.descriptionCurrentValue;
//     data['entryDate'] = this.entryDate;
//     data['entryId'] = this.entryId;
//     data['entryUrl'] = this.entryUrl;
//     data['groupId'] = this.groupId;
//     data['isArchived'] = this.isArchived;
//     data['isEvent'] = this.isEvent;
//     data['isPublished'] = this.isPublished;
//     data['lastPublishDate'] = this.lastPublishDate;
//     data['location'] = this.location;
//     data['locationCurrentValue'] = this.locationCurrentValue;
//     data['modifiedDate'] = this.modifiedDate;
//     data['newsTilesImageFileEntryId'] = this.newsTilesImageFileEntryId;
//     data['publishDate'] = this.publishDate;
//     data['status'] = this.status;
//     data['statusByUserId'] = this.statusByUserId;
//     data['statusByUserName'] = this.statusByUserName;
//     data['statusDate'] = this.statusDate;
//     data['title'] = this.title;
//     data['titleCurrentValue'] = this.titleCurrentValue;
//     data['userId'] = this.userId;
//     data['userName'] = this.userName;
//     data['uuid'] = this.uuid;
//     return data;
//   }
// }


class NewsAndEventsModel {
  NewsAndEventsModel({
    this.messageCode,
    this.message,
    this.data,
    this.error,});

  NewsAndEventsModel.fromJson(dynamic json) {
    messageCode = json['messageCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NewsData.fromJson(v));
      });
    }
    error = json['error'];
  }
  String? messageCode;
  String? message;
  List<NewsData>? data;
  bool? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageCode'] = messageCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['error'] = error;
    return map;
  }

}

class NewsData {
  NewsData({
    this.entryId,
    this.groupId,
    this.companyId,
    this.userId,
    this.userName,
    this.createDate,
    this.modifiedDate,
    this.lastPublishedDate,
    this.status,
    this.statusByUserId,
    this.statusByUserName,
    this.statusDate,
    this.title,
    this.description,
    this.content,
    this.entryDate,
    this.coverImageFileEntryId,
    this.coverImageCropRegion,
    this.location,
    this.newsTilesImageFileEntryId,
    this.publishedDate,
    this.bookingId,
    this.entryUrl,
    this.event,
    this.archived,
    this.published,});

  NewsData.fromJson(dynamic json) {
    entryId = json['entryId'];
    groupId = json['groupId'];
    companyId = json['companyId'];
    userId = json['userId'];
    userName = json['userName'];
    createDate = json['createDate'];
    modifiedDate = json['modifiedDate'];
    lastPublishedDate = json['lastPublishedDate'];
    status = json['status'];
    statusByUserId = json['statusByUserId'];
    statusByUserName = json['statusByUserName'];
    statusDate = json['statusDate'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    entryDate = json['entryDate'];
    coverImageFileEntryId = json['coverImageFileEntryId'];
    coverImageCropRegion = json['coverImageCropRegion'];
    location = json['location'];
    newsTilesImageFileEntryId = json['newsTilesImageFileEntryId'];
    publishedDate = json['publishedDate'];
    bookingId = json['bookingId'];
    entryUrl = json['entryUrl'];
    event = json['event'];
    archived = json['archived'];
    published = json['published'];
  }
  int? entryId;
  int? groupId;
  int? companyId;
  int? userId;
  String? userName;
  int? createDate;
  int? modifiedDate;
  dynamic lastPublishedDate;
  int? status;
  int? statusByUserId;
  String? statusByUserName;
  int? statusDate;
  String? title;
  String? description;
  String? content;
  int? entryDate;
  int? coverImageFileEntryId;
  String? coverImageCropRegion;
  String? location;
  int? newsTilesImageFileEntryId;
  int? publishedDate;
  int? bookingId;
  String? entryUrl;
  bool? event;
  bool? archived;
  bool? published;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['entryId'] = entryId;
    map['groupId'] = groupId;
    map['companyId'] = companyId;
    map['userId'] = userId;
    map['userName'] = userName;
    map['createDate'] = createDate;
    map['modifiedDate'] = modifiedDate;
    map['lastPublishedDate'] = lastPublishedDate;
    map['status'] = status;
    map['statusByUserId'] = statusByUserId;
    map['statusByUserName'] = statusByUserName;
    map['statusDate'] = statusDate;
    map['title'] = title;
    map['description'] = description;
    map['content'] = content;
    map['entryDate'] = entryDate;
    map['coverImageFileEntryId'] = coverImageFileEntryId;
    map['coverImageCropRegion'] = coverImageCropRegion;
    map['location'] = location;
    map['newsTilesImageFileEntryId'] = newsTilesImageFileEntryId;
    map['publishedDate'] = publishedDate;
    map['bookingId'] = bookingId;
    map['entryUrl'] = entryUrl;
    map['event'] = event;
    map['archived'] = archived;
    map['published'] = published;
    return map;
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
