import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html_unescape/html_unescape.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

class VisionAndMissionViewModel with ChangeNotifier {
//*------Necessary Services------*/
  late AlertServices _alertServices;

  VisionAndMissionViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*------Accessing Api Services------*

  final DrawerRepository _drawerRepository = DrawerRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<VisionAndMissionModel> _visionAndMissionResponse =
      ApiResponse.none();

  ApiResponse<VisionAndMissionModel> get visionAndMissionResponse =>
      _visionAndMissionResponse;

  set _setVisionAndMissionResponse(
      ApiResponse<VisionAndMissionModel> response) {
    _visionAndMissionResponse = response;
    notifyListeners();
  }

  Content? _content;

  Content? get content => _content;

  Future<bool> getVisionAndMission(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      _setVisionAndMissionResponse = ApiResponse.loading();

      //*-----Create Headers-----*
      final headers = <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        // 'authorization': AppUrls.basicAuthWithUsernamePassword
      };
      //*-----Create Body-----*
      final body = jsonEncode(<String, String>{
        "pageURL": "/web/sco/about-sco/vision-mission-values-goals"
      });

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.visionAndMission(
          headers: headers, body: body);

      log(jsonEncode(response.data!.content));

      //*-----Calling Api End-----*

      final htmlContent = response.data?.contentCurrentValue.toString() ?? "";
      final selectedLanguage = langProvider.appLocale == const Locale('en')
          ? 'en_US'
          : 'ar_SA'; // Assuming you have a way to get the selected language code

      log('Test ==> ' + htmlContent);

      _content = parseHtmlContent(htmlContent, selectedLanguage);

      _setVisionAndMissionResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      _setVisionAndMissionResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.showErrorSnackBar(error.toString());

      return false;
    }
  }
}

class VisionMission {
  final String visionTitle;
  final String visionText;
  final String missionTitle;
  final String missionText;

  VisionMission({
    required this.visionTitle,
    required this.visionText,
    required this.missionTitle,
    required this.missionText,
  });
}

class ValueItem {
  final String title;
  final String text;

  ValueItem({
    required this.title,
    required this.text,
  });
}

class Values {
  final String valuesTitle;
  final List<ValueItem> valueItems;

  Values({
    required this.valuesTitle,
    required this.valueItems,
  });
}

class Goals {
  final String goalsTitle;
  final List<String> goals;

  Goals({required this.goalsTitle, required this.goals});
}

class Content {
  final String languageId;
  final VisionMission visionMission;
  // final Values values;
  final List<Values> values;
  final Goals goals;

  Content({
    required this.languageId,
    required this.visionMission,
    required this.values,
    required this.goals,
  });
}

Content parseHtmlContent(String htmlString, String selectedLanguage) {
  // 1) Decode any &lt;div&gt; etc.
  final unescape = HtmlUnescape();
  final decodedHtml = unescape.convert(htmlString);

  // 2) Parse once
  final document = htmlParser.parse(decodedHtml);

  // 3) Try to find a <content> block for the selected language
  // NOTE: If the response didn't include <content> wrappers, this will be null.
  var contentBlock =
      document.querySelector('content[language-id="$selectedLanguage"]');

  debugPrint("print: $contentBlock");

  // 4) Fallback to default-locale from <root> if selected language block not found
  if (contentBlock == null) {
    final defaultLocale =
        document.querySelector('root')?.attributes['default-locale'];
    if (defaultLocale != null) {
      contentBlock =
          document.querySelector('content[language-id="$defaultLocale"]');
    }
  }

  // 5) Final scope to query inside:
  //    - If a <content> block exists, use it
  //    - Otherwise, use the whole document (means API returned plain HTML without <content>)
  final scope = contentBlock ?? document;

  // ---------- Extract Vision ----------
  final visionEl = scope.querySelector('.sco-vision .flex-text-wrapper');
  final visionTitle =
      visionEl?.querySelector('.the-vm-title')?.text.trim() ?? '';
  final visionText = visionEl?.querySelector('.the-vm-text')?.text.trim() ?? '';

  // ---------- Extract Mission ----------
  final missionEl = scope.querySelector('.sco-mission .flex-text-wrapper');
  final missionTitle =
      missionEl?.querySelector('.the-vm-title')?.text.trim() ?? '';
  final missionText =
      missionEl?.querySelector('.the-vm-text')?.text.trim() ?? '';

  // ---------- Extract Values ----------
  /*final valuesSections = scope.querySelectorAll('.sco-values');
  final valuesTitle = scope.querySelector('.the-vls-title')?.text.trim() ?? '';
  final List<ValueItem> allValueItems = [];
  for (final section in valuesSections) {
    final items = section.querySelectorAll('.sco-value').map((el) {
      final title = el.querySelector('.sco-val-title')?.text.trim() ?? '';
      final text = el.querySelector('.sco-val-text')?.text.trim() ?? '';
      return ValueItem(title: title, text: text);
    }).toList();
    allValueItems.addAll(items);
  }*/

  // ---------- Extract Values (separate sections) ----------
  final valuesSections = scope.querySelectorAll('.sco-values');
  final List<Values> allValuesSections = [];

  for (final section in valuesSections) {
    final sectionTitle = section.querySelector('.the-vls-title')?.text.trim() ?? '';

    final items = section.querySelectorAll('.sco-value').map((el) {
      final title = el.querySelector('.sco-val-title')?.text.trim().replaceAll('\u00A0', ' ') ?? '';
      final text = el.querySelector('.sco-val-text')?.text.trim().replaceAll('\u00A0', ' ') ?? '';
      return ValueItem(title: title, text: text);
    }).toList();

    allValuesSections.add(
      Values(valuesTitle: sectionTitle, valueItems: items),
    );
  }



  // ---------- Extract Goals ----------
  final goalsWrapper = scope.querySelector('.sco-goals .sco-goals-wrapper');
  final goalsTitle =
      goalsWrapper?.querySelector('.the-goal-title')?.text.trim() ?? '';
  final goals = goalsWrapper
          ?.querySelectorAll('.sco-goal')
          .map((el) => el.text.trim())
          .toList() ??
      <String>[];

  // Always return non-null Content
  return Content(
    languageId: selectedLanguage,
    visionMission: VisionMission(
      visionTitle: visionTitle,
      visionText: visionText,
      missionTitle: missionTitle,
      missionText: missionText,
    ),
    values: allValuesSections,
    // values: Values(
    //   valuesTitle: valuesTitle,
    //   valueItems: allValueItems,
    // ),
    goals: Goals(
      goalsTitle: goalsTitle,
      goals: goals,
    ),
  );
}

// Content parseHtmlContent(String htmlString, String selectedLanguage) {
//   // Ensure we decode HTML entities (&lt;div> → <div>)
//   final unescape = HtmlUnescape();
//   final decodedHtml = unescape.convert(htmlString);
//
//   final document = htmlParser.parse(decodedHtml);
//
//   // Extract Vision
//   final visionElement = document.querySelector('.sco-vision .flex-text-wrapper');
//   final visionTitle = visionElement?.querySelector('.the-vm-title')?.text.trim() ?? '';
//   final visionText = visionElement?.querySelector('.the-vm-text')?.text.trim() ?? '';
//
//   // Extract Mission
//   final missionElement = document.querySelector('.sco-mission .flex-text-wrapper');
//   final missionTitle = missionElement?.querySelector('.the-vm-title')?.text.trim() ?? '';
//   final missionText = missionElement?.querySelector('.the-vm-text')?.text.trim() ?? '';
//
//   // Extract Values (handle multiple sections)
//   final valuesSections = document.querySelectorAll('.sco-values');
//   final List<ValueItem> allValueItems = [];
//
//   final valuesTitle = document.querySelector('.the-vls-title')?.text ?? '';
//
//   for (var section in valuesSections) {
//     final items = section.querySelectorAll('.sco-value').map((element) {
//       final title = element.querySelector('.sco-val-title')?.text.trim() ?? '';
//       final text = element.querySelector('.sco-val-text')?.text.trim() ?? '';
//       return ValueItem(title: title, text: text);
//     }).toList();
//     allValueItems.addAll(items);
//   }
//
//   // Extract Goals
//   final goalsElement = document.querySelector('.sco-goals .sco-goals-wrapper');
//   final goalsTitle = goalsElement?.querySelector('.the-goal-title')?.text.trim() ?? '';
//   final goals = goalsElement
//       ?.querySelectorAll('.sco-goal')
//       .map((element) => element.text.trim())
//       .toList() ??
//       [];
//
//   return Content(
//     languageId: selectedLanguage,
//     visionMission: VisionMission(
//       visionTitle: visionTitle,
//       visionText: visionText,
//       missionTitle: missionTitle,
//       missionText: missionText,
//     ),
//     values: Values(
//       valuesTitle: valuesTitle, // Optional: Or leave empty
//       valueItems: allValueItems,
//     ),
//     goals: Goals(goalsTitle: goalsTitle, goals: goals),
//   );
// }
