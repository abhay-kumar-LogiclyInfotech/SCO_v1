import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle appBarTitleStyle() {
    return const TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subTitleTextStyle() {
    return const TextStyle(
      color: Color(0xff8491A8),
      fontSize: 12,
    );
  }

  static TextStyle titleTextStyle() {
    return const TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle titleBoldTextStyle() {
    return const TextStyle(
      color: AppColors.scoButtonColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }







}
