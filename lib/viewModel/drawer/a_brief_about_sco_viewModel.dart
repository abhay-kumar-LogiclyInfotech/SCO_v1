
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:sco_v1/models/drawer/a_brief_about_sco_model.dart';
import 'package:xml/xml.dart' as xml;

import '../../data/response/ApiResponse.dart';
import '../../repositories/drawer_repo/drawer_repository.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../language_change_ViewModel.dart';

class ContentSection {
  final String heading;
  final String paragraph;

  ContentSection({required this.heading, required this.paragraph});
}

class ABriefAboutScoViewModel with ChangeNotifier {
  //*------Accessing Api Services------*

  final DrawerRepository _drawerRepository = DrawerRepository();

  ApiResponse<ABriefAboutScoModel> _aBriefAboutScoResponse = ApiResponse.none();

  ApiResponse<ABriefAboutScoModel> get aBriefAboutScoResponse =>
      _aBriefAboutScoResponse;

  set _setABriefAboutScoResponse(ApiResponse<ABriefAboutScoModel> response) {
    _aBriefAboutScoResponse = response;
    notifyListeners();
  }


  //Getting List of Heading and Response for About ACO View:

  List<ContentSection> _contentSectionsList = [];
  List<ContentSection> get contentSectionsList => _contentSectionsList;

  Future<bool> aBriefAboutSco(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    try {
      _setABriefAboutScoResponse = ApiResponse.loading();

      //*-----Create Headers-----*
      final headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };

      //*------Create Body------*
      final body = <String, String>{"pageUrl": "/web/sco/privacy-policy"};

      //*-----Calling Api Start-----*
      final response =
          await _drawerRepository.aBriefAboutSco(headers: headers, body: body);
      //*-----Calling Api End-----*

      //*-----Parse the Content from response-----*
      final xmlContent = response.content ?? '';

      // Function to extract and parse content based on language-id
      String extractContent(String languageId) {
        final document = xml.XmlDocument.parse(xmlContent);
        final content = document
            .findAllElements('Content')
            .where(
                (element) => element.getAttribute('language-id') == languageId)
            .single
            .text;

        // Decode HTML entities
        final decodedContent =
            content.replaceAll('&lt;', '<').replaceAll('&gt;', '>');

        return decodedContent;
      }

      // Function to extract headings and paragraphs from HTML
      List<ContentSection> extractHeadingsAndParagraphs(String htmlContent) {
        final document = html_parser.parse(htmlContent);
        final sections = <ContentSection>[];

        // Iterate through headings and paragraphs
        final headings = document.querySelectorAll('h1, h2, h3, h4, h5, h6');
        final paragraphs = document.querySelectorAll('p');

        int headingIndex = 0;

        for (final paragraph in paragraphs) {
          final heading =
              headingIndex < headings.length ? headings[headingIndex].text : '';
          final section = ContentSection(
            heading: heading,
            paragraph: paragraph.text,
          );
          sections.add(section);
          headingIndex++;
        }

        return sections;
      }

      final languageId = getTextDirection(langProvider) == TextDirection.rtl
          ? 'ar_SA'
          : 'en_US'; // Use the current language ID from the provider
      final content = extractContent(languageId);
      _contentSectionsList = extractHeadingsAndParagraphs(content);


      _setABriefAboutScoResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setABriefAboutScoResponse = ApiResponse.error(error.toString());
      return false;
    }
  }
}
