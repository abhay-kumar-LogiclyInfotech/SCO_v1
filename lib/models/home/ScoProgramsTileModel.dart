import 'package:flutter/material.dart';

class ScoProgramTileModel {
  final String? imagePath;
  final String? title;
  final String? subTitle;
  final Widget? content;
  final void Function()? onTap;

  ScoProgramTileModel({
    this.imagePath,
    this.title,
    this.subTitle,
    this.content,
    this.onTap,
  });

  // Factory constructor to create a `ScoProgramTileModel` from a JSON-like map
  factory ScoProgramTileModel.fromJson(Map<String, dynamic> json) {
    return ScoProgramTileModel(
      imagePath: json['imagePath'] as String?,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      content: json['content'] as Widget?,
      onTap: json['onTap'] as void Function()?, // Ensure the function is correctly cast
    );
  }

  // Method to convert `ScoProgramTileModel` to a JSON-like map
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'title': title,
      'subTitle': subTitle,
      'content': content,
      'onTap': onTap, // Functions are not directly serializable
    };
  }
}
