


import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_text_styles.dart';

Widget showErrorText(String? text){
  if(text != null){
    return Text(text,style: AppTextStyles.errorTextStyle());
  }
  return const SizedBox.shrink();
}