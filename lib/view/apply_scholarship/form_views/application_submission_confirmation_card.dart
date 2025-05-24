

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';

class ApplicationSubmissionConfirmationCard extends StatefulWidget {
  final String applicationNumber;
  final String arabicName;
  final String englishName;
  

  const ApplicationSubmissionConfirmationCard({super.key,
    required this.applicationNumber,
    required this.arabicName,
    required this.englishName,
  });

  @override
  State<ApplicationSubmissionConfirmationCard> createState() => _ApplicationSubmissionConfirmationCardState();
}

class _ApplicationSubmissionConfirmationCardState extends State<ApplicationSubmissionConfirmationCard> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    

      final localization = AppLocalizations.of(context)!;
      final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);


      final name = getTextDirection(langProvider) == TextDirection.ltr ? widget.englishName : widget.arabicName;



      return Container(
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding:  EdgeInsets.all(kPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // if(!_applicationSubmitted)  draftPrevNextButtons(langProvider),
                  CustomInformationContainer(title: localization.applicationSubmission,
                    expandedContent: Column(
                      children: [
                        kFormHeight,
                        /// if application is submitted then show the confirmation to the user with the application number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Center(
                              child: SvgPicture.asset("assets/application_submitted.svg"),
                            ),

                            kFormHeight,
                            // Name of the student:
                            Text(name ,style:AppTextStyles.titleTextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),

                            kFormHeight,
                            // static confirmation text
                            Text(localization.submissionSuccessMessage,style:AppTextStyles.titleTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),

                            /// application number
                            Text(widget.applicationNumber,style:const TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: AppColors.SUCCESS,height: 4),)
                          ],
                        )
                        ,
                        kFormHeight,
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 50),
                        //   child: CustomButton(buttonName: localization.print, isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){
                        //     _alertService.toastMessage(localization.comingSoon);
                        //   },
                        //     buttonColor: AppColors.scoThemeColor,
                        //     borderColor: Colors.transparent),
                        // ),
                        // kFormHeight,
                        kFormHeight,
                      ],
                    ),
                  ),
                  showVoid,
                  // if(!_applicationSubmitted)  draftPrevNextButtons(langProvider),


                ]),
          ));
    
  }
}


