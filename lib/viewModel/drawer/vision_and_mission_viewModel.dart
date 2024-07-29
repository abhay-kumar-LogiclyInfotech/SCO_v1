import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/drawer/vision_and_mission_model.dart';
import 'package:xml/xml.dart' as xml;
import 'package:html_unescape/html_unescape.dart';
import 'package:html/parser.dart' as htmlParser;





import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
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

  //*---common for all methods-----*/
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
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuthWithUsernamePassword
      };
      //*-----Create Body-----*
      final body = <String, String>{
        "pageUrl": "/web/sco/about-sco/vision-mission-values-goals"
      };

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.visionAndMission(
          headers: headers, body: body);

      //*-----Calling Api End-----*

      final htmlContent = response.contentCurrentValue.toString() ?? "";
      final selectedLanguage = langProvider.appLocale == const Locale('en')
          ? 'en_US'
          : 'ar_SA'; // Assuming you have a way to get the selected language code


       _content = parseHtmlContent(htmlContent);

      // Print extracted data
      // print('Vision Title: ${content.visionMission.visionTitle}');
      // print('Vision Text: ${content.visionMission.visionText}');
      // print('Mission Title: ${content.visionMission.missionTitle}');
      // print('Mission Text: ${content.visionMission.missionText}');
      // print('Values:');
      // print(content.values.valuesTitle);
      // content.values.valueItems.forEach((value) {
      //   print('Title: ${value.title}, Text: ${value.text}');
      // });
      // print('Goals Title: ${content.goals.goalsTitle}');
      // content.goals.goals.forEach((goal) {
      //   print('Goal: $goal');
      // });
      _setVisionAndMissionResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setVisionAndMissionResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.toastMessage(error.toString());

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
  final Values values;
  final Goals goals;

  Content({
    required this.languageId,
    required this.visionMission,
    required this.values,
    required this.goals,
  });
}

Content parseHtmlContent(String htmlString) {
  // Parse HTML
  final document = htmlParser.parse(htmlString);

  // Extract Vision and Mission
  final visionMissionElement = document.querySelector('.sco-vision-mission');
  final visionElement = visionMissionElement?.querySelector('.sco-vision .flex-text-wrapper');
  final visionTitle = visionElement?.querySelector('.the-vm-title')?.text.trim() ?? '';
  final visionText = visionElement?.querySelector('.the-vm-text')?.text.trim() ?? '';

  final missionElement = visionMissionElement?.querySelector('.sco-mission .flex-text-wrapper');
  final missionTitle = missionElement?.querySelector('.the-vm-title')?.text.trim() ?? '';
  final missionText = missionElement?.querySelector('.the-vm-text')?.text.trim() ?? '';

  // Extract Values
  final valuesElement = visionMissionElement?.querySelector('.sco-values .the-vls-content');
  final valuesTitle = valuesElement?.querySelector('.the-vls-title')?.text.trim() ?? ''; // Extract values title
  final valueItems = valuesElement?.querySelectorAll('.sco-value').map((element) {
    final title = element.querySelector('.sco-val-title')?.text.trim() ?? '';
    final text = element.querySelector('.sco-val-text')?.text.trim() ?? '';
    return ValueItem(title: title, text: text);
  }).toList() ?? [];

  // Extract Goals
  final goalsElement = visionMissionElement?.querySelector('.sco-goals .sco-goals-wrapper');
  final goalsTitle = goalsElement?.querySelector('.the-goal-title')?.text.trim() ?? '';
  final goals = goalsElement?.querySelectorAll('.sco-goal').map((element) => element.text.trim()).toList() ?? [];

  return Content(
    languageId: 'ar_SA', // Change as necessary
    visionMission: VisionMission(
      visionTitle: visionTitle,
      visionText: visionText,
      missionTitle: missionTitle,
      missionText: missionText,
    ),
    values: Values(
        valuesTitle: valuesTitle, // Include values title
        valueItems: valueItems
    ),
    goals: Goals(goalsTitle: goalsTitle, goals: goals),
  );
}

