import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/drawer/faq_model.dart';
import 'package:sco_v1/repositories/drawer_repo/drawer_repository.dart';
import 'package:xml/xml.dart' as xml;

import '../../data/response/ApiResponse.dart';
import '../../resources/validations_and_errorText.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';
import '../../resources/app_urls.dart';

class FaqViewModel with ChangeNotifier {
//*------Necessary Services------*/
  late AlertServices _alertServices;

  FaqViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  //*------Accessing Api Services------*

  //*---common for all methods-----*/
  final DrawerRepository _drawerRepository = DrawerRepository();

  //*------Get Security Question Method Start------*/
  ApiResponse<FaqModel> _faqResponse = ApiResponse.none();

  ApiResponse<FaqModel> get faqResponse => _faqResponse;

  set _setFaqResponse(ApiResponse<FaqModel> response) {
    _faqResponse = response;
    notifyListeners();
  }

  List<QuestionAnswer> _questionAnswers = [];

  List<QuestionAnswer> get questionAnswers => _questionAnswers;

  Future<bool> getFaq(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      _setFaqResponse = ApiResponse.loading();

      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        // 'authorization': AppUrls.basicAuthWithUsernamePassword
      };
      //*-----Create Body-----*
      final body = <String, String>{
        "articleId": "71109",
        "groupId": "20126",
        "status": "0"
      };

      //*-----Calling Api Start-----*
      final response = await _drawerRepository.faq(headers: headers, body: body);

      //*-----Calling Api End-----*


      final contentXml = response.data?.content ?? '';
      final selectedLanguage = langProvider.appLocale == const Locale('en')
          ? 'en_US'
          : 'ar_SA'; // Assuming you have a way to get the selected language code

      _questionAnswers = parseXmlContent(contentXml, selectedLanguage);

      _setFaqResponse = ApiResponse.completed(response);

      return true;
    } catch (error,stackTrace) {
      // debugPrint('Printing Error: $error');
      _setFaqResponse = ApiResponse.error(error.toString());
      // Message to show status of the operation:
      _alertServices.showErrorSnackBar(error.toString());
      print(stackTrace);
      print(error.toString());

      return false;
    }
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}

List<QuestionAnswer> parseXmlContent(String xmlContent, String languageCode) {
  final document = xml.XmlDocument.parse(xmlContent);
  final questionAnswerList = <QuestionAnswer>[];

  // Find all dynamic-elements that contain questions and answers
  final dynamicElements = document.findAllElements('dynamic-element');

  for (var element in dynamicElements) {
    // Check if the element is a question and has a corresponding answer
    final name = element.getAttribute('name');
    if (name == 'Question') {
      final questionElement =
          element.findElements('dynamic-content').firstWhere(
                (e) => e.getAttribute('language-id') == languageCode,
                orElse: () => xml.XmlElement(xml.XmlName('dynamic-content')),
              );
      final answerElement = element
          .findElements('dynamic-element')
          .firstWhere(
            (e) => e.getAttribute('name') == 'Answer',
            orElse: () => xml.XmlElement(xml.XmlName('dynamic-element')),
          )
          .findElements('dynamic-content')
          .firstWhere(
            (e) => e.getAttribute('language-id') == languageCode,
            orElse: () => xml.XmlElement(xml.XmlName('dynamic-content')),
          );

      final question = Validations.stripHtml(questionElement.text.trim());
      final answer = Validations.stripHtml(answerElement.text.trim());

      if (question.isNotEmpty && answer.isNotEmpty) {
        questionAnswerList
            .add(QuestionAnswer(question: question, answer: answer));
      }
    }
  }

  return questionAnswerList;
}


