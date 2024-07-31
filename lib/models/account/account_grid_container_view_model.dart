import 'package:flutter/material.dart';

class AccountGridContainerModel {
  final String? title;
  final String? assetAddress;
  final void Function()? routeBuilder;

  AccountGridContainerModel({
    this.title,
    this.assetAddress,
    this.routeBuilder,
  });

  // Create from a JSON-like map
  factory AccountGridContainerModel.fromJson(Map<String, dynamic> json) {
    return AccountGridContainerModel(
      title: json['title'],
      assetAddress: json['assetAddress'],
      routeBuilder: json['routeBuilder'] as Function()?, // Correctly handle function
    );
  }
}
