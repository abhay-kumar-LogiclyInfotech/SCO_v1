

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';


class ApplicationSubmissionConfirmationCard extends StatefulWidget {
  final String applicationNumber;
  final String arabicName;
  final String englishName;
  final GetAllActiveScholarshipsModel? selectedScholarship;

  const ApplicationSubmissionConfirmationCard({
    super.key,
    required this.applicationNumber,
    required this.arabicName,
    required this.englishName,
    required this.selectedScholarship,
  });

  @override
  State<ApplicationSubmissionConfirmationCard> createState() =>
      _ApplicationSubmissionConfirmationCardState();
}

class _ApplicationSubmissionConfirmationCardState extends State<ApplicationSubmissionConfirmationCard> with MediaQueryMixin {

  String sanitizeHtml(String rawHtml) {
    return rawHtml
    // Remove <o:p> tags
        .replaceAll(RegExp(r'<o:p>.*?</o:p>', dotAll: true), '')
    // Remove MsoNormal and other MS Word classes
        .replaceAll(RegExp(r'class="Mso[^"]*"', caseSensitive: false), '')
    // Remove dir and align attributes
        .replaceAll(RegExp(r'(dir|align)="[^"]*"', caseSensitive: false), '')
    // Remove spans without removing their styles
        .replaceAll(RegExp(r'<span[^>]*>', caseSensitive: false), '')
        .replaceAll('</span>', '')
    // Remove excessive inline margins (keep style attributes but remove specific parts)
        .replaceAllMapped(
      RegExp(r'style="([^"]*)"', caseSensitive: false),
          (match) {
        String cleanedStyle = match.group(1)!
            .replaceAll(RegExp(r'margin[^;]*;?', caseSensitive: false), '')
            .replaceAll(RegExp(r'direction[^;]*;?', caseSensitive: false), '')
            .replaceAll(RegExp(r'text-align:[^;]*;?', caseSensitive: false), '');

        return 'style="$cleanedStyle"';
      },
    )
    // Clean up multiple empty divs or empty paragraphs
        .replaceAll(RegExp(r'<(div|p)>\s*</\1>'), '')
        .replaceAll(RegExp(r'<br[^>]*>', caseSensitive: false), '<br>');
  }


  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider =
    Provider.of<LanguageChangeViewModel>(context, listen: false);

    final name = getTextDirection(langProvider) == TextDirection.ltr
        ? widget.englishName
        : widget.arabicName;

    final successMessage = getTextDirection(langProvider) == TextDirection.rtl
        ? widget.selectedScholarship?.successMessageArabic
        : widget.selectedScholarship?.successMessageEnglish;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInformationContainer(
              title: localization.applicationSubmission,
              expandedContent: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          kFormHeight,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                    "assets/application_submitted.svg"),
                              ),
                              kFormHeight,
                              Text(
                                name,
                                style: AppTextStyles.titleTextStyle().copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              kFormHeight,
                              Html(
                                data: sanitizeHtml(successMessage?.replaceAll('%APPLICATION_NO%', widget.applicationNumber) ?? ''),
                                style: {
                                  'body': Style(
                                    direction: TextDirection.rtl,
                                    fontSize: FontSize(16.0),
                                    fontFamily: 'Sakkal Majalla',
                                    textAlign: TextAlign.justify,
                                  ),
                                  'p': Style(margin:  Margins.symmetric(vertical: 8)),
                                  'div': Style(margin: Margins.symmetric(vertical: 4)),
                                },
                              ),
                            ],
                          ),
                          kFormHeight,
                          kFormHeight,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            showVoid,
          ],
        ),
      ),
    );
  }
}

//
// class ApplicationSubmissionConfirmationCard extends StatefulWidget {
//   final String applicationNumber;
//   final String arabicName;
//   final String englishName;
//   final GetAllActiveScholarshipsModel? selectedScholarship;
//
//
//
//   const ApplicationSubmissionConfirmationCard({super.key,
//     required this.applicationNumber,
//     required this.arabicName,
//     required this.englishName,
//     required this.selectedScholarship,
//   });
//
//   @override
//   State<ApplicationSubmissionConfirmationCard> createState() => _ApplicationSubmissionConfirmationCardState();
// }
//
// class _ApplicationSubmissionConfirmationCardState extends State<ApplicationSubmissionConfirmationCard> with MediaQueryMixin {
//   @override
//   Widget build(BuildContext context) {
//
//
//       final localization = AppLocalizations.of(context)!;
//       final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
//
//
//       final name = getTextDirection(langProvider) == TextDirection.ltr ? widget.englishName : widget.arabicName;
//
//       final successMessage =  getTextDirection(langProvider) == TextDirection.rtl ? widget.selectedScholarship?.successMessageArabic : widget.selectedScholarship?.successMessageEnglish;
//
//
//
//       return Container(
//           decoration: BoxDecoration(
//             color: AppColors.lightGrey,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Padding(
//             padding:  EdgeInsets.all(kPadding),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//
//                   // if(!_applicationSubmitted)  draftPrevNextButtons(langProvider),
//                   CustomInformationContainer(title: localization.applicationSubmission,
//                     expandedContent: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           kFormHeight,
//                           /// if application is submitted then show the confirmation to the user with the application number
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//
//                               Center(
//                                 child: SvgPicture.asset("assets/application_submitted.svg"),
//                               ),
//
//                               kFormHeight,
//                               // Name of the student:
//                               Text(name ,style:AppTextStyles.titleTextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
//
//                               kFormHeight,
//                               // static confirmation text
//                               // Text(localization.submissionSuccessMessage,style:AppTextStyles.titleTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),
//                               /// now the content will be dynamic
//                               Html(
//                                 data: successMessage?.replaceAll('%APPLICATION_NO%', widget.applicationNumber) ?? '',
//                               ),
//
//                               /// application number
//                               // Text(widget.applicationNumber,style:const TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: AppColors.SUCCESS,height: 4),)
//                             ],
//                           )
//                           ,
//                           kFormHeight,
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(horizontal: 50),
//                           //   child: CustomButton(buttonName: localization.print, isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){
//                           //     _alertService.toastMessage(localization.comingSoon);
//                           //   },
//                           //     buttonColor: AppColors.scoThemeColor,
//                           //     borderColor: Colors.transparent),
//                           // ),
//                           // kFormHeight,
//                           kFormHeight,
//                         ],
//                       ),
//                     ),
//                   ),
//                   showVoid,
//                   // if(!_applicationSubmitted)  draftPrevNextButtons(langProvider),
//
//
//                 ]),
//           ));
//
//   }
// }
//
//
