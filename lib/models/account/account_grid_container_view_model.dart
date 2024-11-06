import 'package:flutter/material.dart';

class SimpleTileModel {
  final String? title;
  final String? assetAddress;
  final void Function()? routeBuilder;

  SimpleTileModel({
    this.title,
    this.assetAddress,
    this.routeBuilder,
  });

  // Create from a JSON-like map
  factory SimpleTileModel.fromJson(Map<String, dynamic> json) {
    return SimpleTileModel(
      title: json['title'],
      assetAddress: json['assetAddress'],
      routeBuilder: json['routeBuilder'] as Function()?, // Correctly handle function
    );
  }
}
