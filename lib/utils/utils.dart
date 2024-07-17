import 'package:flutter/material.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../resources/app_colors.dart';



mixin MediaQueryMixin<T extends StatefulWidget> on State<T> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  Orientation get orientation => MediaQuery.of(context).orientation;
  EdgeInsets get padding => MediaQuery.of(context).padding;
  EdgeInsets get viewInsets => MediaQuery.of(context).viewInsets;

  double get horizontalPadding => MediaQuery.of(context).padding.horizontal;
  double get verticalPadding => MediaQuery.of(context).padding.vertical;
}

TextDirection getTextDirection(LanguageChangeViewModel provider) {
  return provider.appLocale == const Locale('en') || provider.appLocale == null
      ? TextDirection.ltr
      : TextDirection.rtl;
}

List<DropdownMenuItem> populateDropdown({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
}) {
  final textDirection = getTextDirection(provider);
  return menuItemsList
      .where((element) => element.hide == false) // filter out hidden elements
      .map((element) {
    return DropdownMenuItem(
      value: element.code.toString(),
      child: Text(
        textDirection == TextDirection.ltr
            ? element.value
            : element.valueArabic.toString(),
        style: const TextStyle(
          color: AppColors.darkGrey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }).toList();
}
