import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle appBarTitleStyle() {
    return  TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      
    );
  }

  static TextStyle subTitleTextStyle() {
    return  TextStyle(
      color: Color(0xff8491A8),
      fontSize: 12,
        

    );
  }

  static TextStyle titleTextStyle() {
    return  TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,      

    );
  }

  static TextStyle titleBoldTextStyle() {
    return  TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,      

    );
  }

  static TextStyle titleBoldThemeColorTextStyle() {
    return  TextStyle(
      color: Color(0xffCDB383),
      fontSize: 16,
      fontWeight: FontWeight.bold,      

    );
  }
  static TextStyle normalThemeColorTextStyle() {
    return  TextStyle(
      color: Color(0xffCDB383),
      fontSize: 14,      

    );
  }

  static TextStyle normalTextStyle() {
    return  TextStyle(
      color: Colors.black,
      fontSize: 14,      

    );
  }

  static TextStyle bold15ScoButtonColorTextStyle() {
    return  TextStyle(
      color: AppColors.scoButtonColor,
      fontWeight: FontWeight.bold,
      fontSize: 15,
      height: 1.5,      

    );
  }
  static TextStyle myApplicationsEditButton() {
    return  TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.w500,      

    );
  }
  static TextStyle drawerButtonsStyle() {
    return  TextStyle(
        color: Colors.white,
        fontSize: 14,      
    );
  }






}
