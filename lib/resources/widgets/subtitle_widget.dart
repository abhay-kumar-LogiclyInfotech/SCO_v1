

import 'package:flutter/cupertino.dart';

import '../app_colors.dart';

Widget subTitle(text,[Color color = AppColors.scoThemeColor]){
  return  Text(text,style:  TextStyle(color: color,fontWeight: FontWeight.w500),);
}

