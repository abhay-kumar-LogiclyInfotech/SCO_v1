import 'package:flutter/material.dart';
import 'package:sco_v1/view/main_view/home_view.dart';
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

fieldHeading({required String title, required bool important,required LanguageChangeViewModel langProvider}) {
  return Directionality(
    textDirection: getTextDirection(langProvider),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff093B59)),
                  children: <TextSpan>[
                TextSpan(
                  text: title,
                ),
                important
                    ? const TextSpan(
                        text: " *", style: TextStyle(color: Colors.red))
                    : const TextSpan()
              ])),
        ],
      ),
    ),
  );
}

List<DropdownMenuItem> populateCommonDataDropdown({
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
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }).toList();
}

List<DropdownMenuItem> populateNormalDropdown({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
}) {
  final textDirection = getTextDirection(provider);
  return menuItemsList
      .map((element) {
    return DropdownMenuItem(
      value: element.toString(),
      child: Text(
        textDirection == TextDirection.ltr
            ? element.toString()
            : element.toString(),
        style: const TextStyle(
          color: AppColors.darkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }).toList();
}
