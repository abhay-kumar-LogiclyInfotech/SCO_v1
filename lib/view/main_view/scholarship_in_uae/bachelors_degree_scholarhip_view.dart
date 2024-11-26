import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart' as html_dom hide Text; // Add a prefix here
// import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:xml/xml.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../viewModel/get_page_content_by_urls_viewModels/Internal/get_page_content_by_url_viewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
// import 'dart:convert';
// import 'package:xml/xml.dart' as xml ;
import 'package:html/parser.dart' as html ;

class BachelorsDegreeScholarshipView extends StatefulWidget {
  const BachelorsDegreeScholarshipView({super.key});

  @override
  State<BachelorsDegreeScholarshipView> createState() => _BachelorsDegreeScholarshipViewState();
}

class _BachelorsDegreeScholarshipViewState extends State<BachelorsDegreeScholarshipView> {

  late NavigationServices _navigationServices;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();


    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// pinging the api for get page content by url testing
      final provider = Provider.of<GetPageContentByUrlViewModel>(context, listen: false);
      await provider.getPageContentByUrl();
      // log(decodeHtmlEntities(jsonDecode(xmlToJson(provider.apiResponse.data?.content ??'').toString()).toString()));

    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: "Bachelors in UAE"),
      body: Consumer<GetPageContentByUrlViewModel>(
        builder: (context, provider, _) {
          // Parse the XML response
          final document = XmlDocument.parse(provider.apiResponse.data?.content ?? '');

          // Access the root element and find content elements
          final rootElement = document.rootElement;
          final contentElements = rootElement.findElements('content');

          // Prepare a list to store the widgets that will be displayed in the ListView
          List<Widget> elementWidgets = [];

          for (var contentElement in contentElements) {
            // Get language ID (if needed)
            String languageId = contentElement.getAttribute('language-id') ?? '';
            // print(languageId);

            // Parse the content of the element (HTML content inside <content>)
            html_dom.Document myDocument = html.parse(contentElement.innerText);

            // Iterate through each tag and process them accordingly
            for (var element in myDocument.body!.children) {
              switch (element.localName) {
                case 'p':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Paragraph: ${element.innerHtml}', style: TextStyle(fontSize: 16)),
                  ));
                  break;
                case 'h1':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Heading 1: ${element.innerHtml}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ));
                  break;
                case 'h2':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Heading 2: ${element.innerHtml}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ));
                  break;
                case 'h3':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Heading 3: ${element.innerHtml}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ));
                  break;
                case 'ul':
                  elementWidgets.add(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: element.children.map((li) {
                          return Text('List Item: ${li.innerHtml}', style: TextStyle(fontSize: 16));
                        }).toList(),
                      ),
                    ),
                  );
                  break;
                case 'ol':
                  elementWidgets.add(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: element.children.map((li) {
                          return Text('Ordered Item: ${li.innerHtml}', style: TextStyle(fontSize: 16));
                        }).toList(),
                      ),
                    ),
                  );
                  break;
                case 'img':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(element.attributes['src'] ?? ''),
                  ));
                  break;
                case 'a':
                  elementWidgets.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Handle onTap (e.g., open the link)
                        print('Link: ${element.attributes['href']}');
                      },
                      child: Text('Link: ${element.innerHtml}', style: TextStyle(color: Colors.blue)),
                    ),
                  ));
                  break;
                default:
                // Handle other tags (if any)
                  break;
              }
            }
          }

          // Return the ListView wrapped in a SingleChildScrollView
          return SingleChildScrollView(
            child: Column(
              children: elementWidgets, // Dynamically rendered widgets
            ),
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: AppColors.bgColor,
  //     appBar: CustomSimpleAppBar(titleAsString: "Bachelors in UAE",),
  //     body: Consumer<GetPageContentByUrlViewModel>(builder: (context,provider,_){
  //       // html_dom.Document newDocument = html.parse(provider.apiResponse.data?.content ??'');
  //
  //
  //       // Parse the XML
  //       final document = XmlDocument.parse(provider.apiResponse.data?.content ??'');
  //
  //       // Access root element
  //       final rootElement = document.rootElement;
  //
  //       // Find content elements
  //       final contentElements = rootElement.findElements('content');
  //
  //
  //
  //       return SingleChildScrollView(
  //         child: Column(
  //           children: [
  //
  //             // Text(newDocument.body!.text!.toString())
  //           ],
  //         ),
  //       );
  //     })
  //
  //   );
  // }


}
