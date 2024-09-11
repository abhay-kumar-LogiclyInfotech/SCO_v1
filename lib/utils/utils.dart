import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:xml/xml.dart';

import '../resources/app_colors.dart';

mixin MediaQueryMixin<T extends StatefulWidget> on State<T> {
  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  Orientation get orientation => MediaQuery.of(context).orientation;

  EdgeInsets get padding => MediaQuery.of(context).padding;

  EdgeInsets get viewInsets => MediaQuery.of(context).viewInsets;

  double get horizontalPadding => MediaQuery.of(context).padding.horizontal;

  double get verticalPadding => MediaQuery.of(context).padding.vertical;

  double get kPadding => 20;

  Widget get kFormHeight => const  SizedBox.square(dimension: 15,);

  double get kCardRadius => 15;
}



//Get Text Direction Method:
TextDirection getTextDirection(LanguageChangeViewModel langProvider) {
  return langProvider.appLocale == const Locale('en') || langProvider.appLocale == null
      ? TextDirection.ltr
      : TextDirection.rtl;
}




//TextField Heading Text with importance indicator:
fieldHeading(
    {required String title,
    required bool important,
    required LanguageChangeViewModel langProvider}) {
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


// populateCommonDataDropdown method with hide property:
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
          color: AppColors.hintDarkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }).toList();
}



//populateNormalDropdown method:
List<DropdownMenuItem> populateNormalDropdown({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
}) {
  final textDirection = getTextDirection(provider);
  return menuItemsList.map((element) {
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



//Terms and conditions text with bullet design
Widget bulletTermsText({required String text, Color? textColor}) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0, left: 10, right: 10),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0, top: 7.0, left: 8.0),
          height: 7.0,
          width: 7.0,
          decoration: BoxDecoration(
            color: textColor ?? AppColors.scoButtonColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              // height: 1.4,
              fontSize: 14.0,
              color: textColor ?? AppColors.scoButtonColor,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );
}


//Normal Terms and conditions text:
Widget normalTermsText({required String text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0),
    child: Text(
      text,
      style: const TextStyle(
        height: 1.4,
        fontSize: 14.0,
        color: Colors.black,
      ),
      textAlign: TextAlign.justify,
    ),
  );
}


//background static picture:
Widget bgSecurityLogo() {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: SvgPicture.asset(
      "assets/security_question_bg.svg",
      // fit: BoxFit.fill,
    ),
  );}




//creating the animated Route using page builder:
Route createRoute(dynamic page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(0.0, 1), end: const Offset(0, 0))
            .chain(CurveTween(curve: Curves.ease));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

String extractXmlValue(String xmlString, String languageId, String tagName) {
  final document = XmlDocument.parse(xmlString);
  final rootElement = document.rootElement;
  final elements = rootElement.findElements(tagName);
  for (var element in elements) {
    final langId = element.getAttribute('language-id');
    if (langId == languageId) {
      return element.text.trim();
    }
  }
  return '';
}








