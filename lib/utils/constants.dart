import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';

class Constants {
  static const String username = "liferay_access@sco.ae";
  static const String password = "India@1234";
  static String basicAuthWithUsernamePassword = 'Basic ${base64Encode(utf8.encode('${Constants.username}:${Constants.password}'))}';
  static const String basicAuth = 'Basic bGlmZXJheV9hY2Nlc3NAc2NvLmFlOkluZGlhQDEyMzQ=';

  static Map<String, Response> lovCodeMap = {};

  static RegExp get emiratesIdRegex =>
      RegExp(r'\b784-[0-9]{4}-[0-9]{7}-[0-9]{1}\b');

  static PinTheme defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]));


  static const String newsImageUrl = "https://lh3.googleusercontent.com/NCE_l5_GJBa2YT_XNhAUf0aAH7-T5gWc15JfQKZ9YINax0698zDeFK64OnPbun9XDVGd=s142";


  static const dynamic scholarshipRequestType= [

    {
      "code":"INT",
      "value":"Scholarships In UAE",
      "valueArabic":"المنح الدراسية في الإمارات العربية المتحدة"
    },
    {
      "code":"EXT",
      "value":"Scholarships Abroad",
      "valueArabic":"المنح الدراسية في الخارج"
    }

  ];



}

enum MilitaryStatus { yes, no, postponed, exemption }
enum ScholarshipStatus{applyScholarship,appliedScholarship,approvedScholarship}

