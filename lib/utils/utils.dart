import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:xml/xml.dart';

import '../resources/app_colors.dart';
import 'constants.dart';

mixin MediaQueryMixin<T extends StatefulWidget> on State<T> {
  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  Orientation get orientation => MediaQuery.of(context).orientation;

  EdgeInsets get padding => MediaQuery.of(context).padding;

  EdgeInsets get viewInsets => MediaQuery.of(context).viewInsets;

  double get horizontalPadding => MediaQuery.of(context).padding.horizontal;

  double get verticalPadding => MediaQuery.of(context).padding.vertical;

  double get kPadding => 20;

  Widget get kFormHeight => const SizedBox.square(
        dimension: 15,
      );

  // shrink box
  Widget get showVoid => const SizedBox.shrink();

  double get kCardRadius => 15;

  Widget get kSubmitButtonHeight => const SizedBox.square(
        dimension: 30,
      );
}

class Utils {
  // input borders start
  static InputBorder outlinedInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: AppColors.darkGrey));
  }

  static InputBorder underLinedInputBorder() {
    return const UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: AppColors.darkGrey));
  }

  // input borders end

  // focus request:
  static void requestFocus(
      {required FocusNode focusNode, required BuildContext context}) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  //*------Common Loading Indicators Start------*/

  //*-----Material Loading Indicator-----*/
  static Widget materialLoadingIndicator({dynamic color = Colors.white}) =>  Center(
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 1.5,
        ),
      );

//*-----Cupertino Loading Indicator-----*/
  static Widget cupertinoLoadingIndicator({dynamic color = AppColors.scoButtonColor}) =>  Center(
          child:   CupertinoActivityIndicator(
        color: color));


  //*----- page  Loading Indicator-----*/
  static Widget pageLoadingIndicator({dynamic color = AppColors.scoButtonColor}) =>  Center(
      child: Platform.isAndroid ? Utils.materialLoadingIndicator(color: color) : Utils.cupertinoLoadingIndicator(color: color));



  // *-----Show Loading more data from server-----*/

  static Widget spinkitThreeBounce() => const Center(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        child: SpinKitThreeBounce(
          color: Colors.black,
          size: 23,
        ),
      ));

//*------Common Loading Indicators End------*/

//*------Common Error Text Start------*/
  static Widget showOnError() => const Center(
        child: Text("Something went Wrong"),
      );

  static Widget showOnNone() => const Center(
        child: Text("Something went Wrong"),
      );

  static Widget showOnNull() => const Center(
        child: Text("Something went Wrong"),
      );

  static Widget showOnNoDataAvailable() => const Center(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 23,
        ),
      ));





  // model progress hud

  static Widget modelProgressHud(
      {bool processing = false, dynamic child}
      ){
   return  ModalProgressHUD(
       color: Colors.blueGrey,
       opacity: 0.3,
       blur: 0.1,
       dismissible: false,
       progressIndicator: Platform.isAndroid ? Utils.materialLoadingIndicator(color: AppColors.scoThemeColor) : Utils.cupertinoLoadingIndicator(color: AppColors.scoThemeColor),
    inAsyncCall: processing,
    child: child);
  }


}

//Get Text Direction Method:
TextDirection getTextDirection(LanguageChangeViewModel langProvider) {
  return langProvider.appLocale == const Locale('en') ||
          langProvider.appLocale == null
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
          Expanded(
            child: RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.fieldTitleDarkGrey),
                    children: <TextSpan>[
                  TextSpan(
                    text: title,
                  ),
                  important
                      ? const TextSpan(
                          text: " *", style: TextStyle(color: Colors.red))
                      : const TextSpan()
                ])),
          ),
        ],
      ),
    ),
  );
}

// populateCommonDataDropdown method with hide property:
List<dynamic> populateUniqueSimpleValuesFromLOV({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
  Color? textColor,
}) {

  List<String> uniqueKeys = [];

  List uniqueItemsList = [];

  for (var element in menuItemsList) {
    if (uniqueKeys.contains(element.code.toString())) {
      continue; // skip duplicate entries
    } else {
      if (element.hide == false) {
        uniqueKeys.add(element.code.toString());
        uniqueItemsList.add(element);
      }
    }
  }

  return uniqueItemsList;
}

// populateCommonDataDropdown method with hide property:
List<dynamic> populateSimpleValuesFromLOV({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
  Color? textColor,
}) {

  final List<dynamic> finalList = [];


  for (var element in menuItemsList) {

      if (element.hide == false) {
        finalList.add(element);
      }

  }

  return finalList;
}

// populateCommonDataDropdown method with hide property:
List<DropdownMenuItem> populateCommonDataDropdown({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
  Color? textColor,
})
{

  final textDirection = getTextDirection(provider);

  List<String> uniqueKeys = [];
  List uniqueMenuItemsList = [];

  // Filter out duplicates based on 'code'
  for (var element in menuItemsList) {
    if (!uniqueKeys.contains(element.code.toString())) {
      uniqueKeys.add(element.code.toString());
      uniqueMenuItemsList.add(element);
    }
  }

  // Add the constant "Select" option at the 0th index
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
      value: '',  // Empty value for the default option
      child: Text(
        textDirection == TextDirection.ltr ? 'Select' : 'اختر',  // 'Select' in both languages
        style: TextStyle(
          color: textColor ?? AppColors.hintDarkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ];

  // Add filtered and unique items (excluding hidden ones)
  dropdownItems.addAll(
    uniqueMenuItemsList
        .where((element) => element.hide == false)  // Filter out hidden elements
        .map((element) {
      return DropdownMenuItem(
        value: element.code.toString(),
        child: Text(
          textDirection == TextDirection.ltr
              ? element.value
              : element.valueArabic.toString(),
          style: TextStyle(
            color: textColor ?? AppColors.hintDarkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList(),
  );

  return dropdownItems;
}


// // populateNormalDropdownWithValue method with hide property:
List<DropdownMenuItem> populateNormalDropdownWithValue({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
})
{
  final textDirection = getTextDirection(provider);

  // Add a constant "Select" option at the 0th index
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
      value: '',  // Empty value
      child: Text(
        textDirection == TextDirection.ltr ? 'Select' : 'اختر',  // 'Select' in both languages
        style: const TextStyle(
          color: AppColors.scoButtonColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ];

  // Add the rest of the dropdown items from the menuItemsList
  dropdownItems.addAll(
    menuItemsList.map((element) {
      return DropdownMenuItem(
        value: element['code'].toString(),
        child: Text(
          textDirection == TextDirection.ltr
              ? element['value'].toString()
              : element['valueArabic'].toString(),
          style: const TextStyle(
            color: AppColors.scoButtonColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList(),
  );

  return dropdownItems;
}


//populateNormalDropdown with single elements method:
List<DropdownMenuItem> populateNormalDropdown({
  required List menuItemsList,
  required LanguageChangeViewModel provider,
})
{
  final textDirection = getTextDirection(provider);
  return menuItemsList.map((element) {
    return DropdownMenuItem(
      value: element.toString(),
      child: Text(
        textDirection == TextDirection.ltr
            ? element.toString()
            : element.toString(),
        style: const TextStyle(
          color: Colors.black,
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
  );
}

//creating the animated Route using page builder:
Route createRoute(dynamic page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
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


String cleanDraftXmlToJson(String xmlString) {
  // Parse the XML string
  final document = XmlDocument.parse(xmlString);

  // Create a map to hold the cleaned data
  Map<String, dynamic> cleanedData = {};

  // Helper function to extract values from the XML and clean keys
  dynamic extractData(XmlElement element) {
    Map<String, dynamic> data = {};

    for (var child in element.children) {
      if (child is XmlElement) {
        String key = child.name.local;

        // Recursively extract child data
        var childData = extractData(child);

        // Check if the child data has a nested key structure
        if (childData is Map<String, dynamic> && childData.keys.length == 1) {
          String nestedKey = childData.keys.first;
          // Flatten the structure by assigning nested data to the parent key
          data[key] = childData[nestedKey];
        } else {
          // Check if this child has multiple values (is a list)
          if (data.containsKey(key)) {
            if (data[key] is! List) {
              data[key] = [data[key]]; // Convert to list if not already
            }
            data[key].add(childData);
          } else {
            // Store child data
            data[key] = childData;
          }
        }
      }
    }

    // If there's only text content, return the text instead of a map
    return data.isEmpty ? element.text.trim() : data;
  }

  // Start processing from the root element
  cleanedData = extractData(document.rootElement);

  // Convert the map to JSON string
  String jsonString = jsonEncode(cleanedData);

  return jsonString;
}

bool isEighteenYearsOld(String dob) {
  DateTime birthDate;

  // Normalize the string to ISO 8601 format if it contains a timezone like 'UTC'
  if (dob.contains('UTC')) {
    // Replace 'UTC' with 'Z' to match the ISO 8601 format
    dob = dob.replaceFirst(' UTC', 'Z');
    birthDate = DateTime.parse(dob);
  } else {
    // Parse the string assuming it only contains the date or ISO standard datetime
    birthDate = DateTime.parse(dob);
  }

  // Get the current date
  DateTime today = DateTime.now();

  // Calculate the age
  int age = today.year - birthDate.year;

  // Adjust for cases where the person has not had their birthday this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  // Return true if the person is 18 or older
  return age >= 18;
}

String formatDateOnly(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return ''; // Handle null or empty input
  }

  try {
    // Preprocess to make it ISO 8601 compatible
    String processedDateString = dateString.replaceFirst(' ', 'T').replaceFirst(' UTC', 'Z');
    // Parse the input date string to DateTime
    DateTime parsedDate = DateTime.parse(processedDateString);
    // Format to date-only string
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    // Handle invalid date string format
    return '';
  }
}


// get full name from lov Code
String getFullNameFromLov({ String? lovCode, String? code,required langProvider}){

  if(lovCode == null || code == null || lovCode.isEmpty || code.isEmpty){
    return '';
  }

  List lovList = [];
  if (Constants.lovCodeMap[lovCode]?.values != null) {
    lovList = populateUniqueSimpleValuesFromLOV(
        menuItemsList: Constants.lovCodeMap[lovCode]!.values!,
        provider: langProvider,
        textColor: AppColors.scoButtonColor);
  }

  dynamic element = lovList.firstWhere((element){
    return element.code == code;
  });


  return getTextDirection(langProvider) == TextDirection.rtl ? element.valueArabic : element.value;
}





