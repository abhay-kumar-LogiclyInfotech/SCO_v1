import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../resources/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../resources/app_text_styles.dart';

class StepsProgressView extends StatefulWidget {
  final int totalSections;
  final int currentSectionIndex;
  dynamic selectedScholarship;
  String scholarshipTitle;

  StepsProgressView(
      {super.key,
      required this.totalSections,
      required this.currentSectionIndex,
      required this.selectedScholarship,
      required this.scholarshipTitle,});

  @override
  State<StepsProgressView> createState() => _StepsProgressViewState();
}

class _StepsProgressViewState extends State<StepsProgressView>
    with MediaQueryMixin {
  String getTextForSection({required int step}) {
    final localization = AppLocalizations.of(context)!;

    String? acadmicCareer = widget.selectedScholarship?.acadmicCareer;
    String key = widget.selectedScholarship?.configurationKey ?? '';

    // Helper functions for specific text conditions
    bool shouldShowHighSchoolDetails() {
      return acadmicCareer == 'UG' ||
          acadmicCareer == 'UGRD' ||
          acadmicCareer == 'SCHL' ||
          acadmicCareer == 'HCHL';
    }

    bool isUniversityAndMajorsRequired() {
      return acadmicCareer != 'SCHL';
    }

    bool isRequiredExaminationDetailsRequired() {
      return !(acadmicCareer == 'SCHL' || acadmicCareer == 'HCHL');
    }

    bool isAttachmentSectionForExt() {
      return key == 'SCOUPPEXT';
    }

    bool displayEmploymentHistory() {
      final key = widget.selectedScholarship?.configurationKey;
      return (key == 'SCOPGRDINT' || key == 'SCOPGRDEXT' || key == 'SCODDSEXT');
    }

    bool shouldDisplayEmploymentHistory() {
      return displayEmploymentHistory();
    }

    // Switch case for text based on step
    switch (step) {
      case 0:
        return localization.studentUndertaking;

      case 1:
        return localization.studentDetails;

      case 2:
        if (shouldShowHighSchoolDetails()) {
          return localization.highSchoolDetails;
        }
        // Graduation Details Section as fallback
        return localization.graduationDetails;

      case 3:
        if (isUniversityAndMajorsRequired()) {
          return localization.universityAndMajor;
        }
        return "Not Applicable for University and Majors";

      case 4:
        if (isAttachmentSectionForExt()) {
          return localization.attachments;
        } else if (isRequiredExaminationDetailsRequired()) {
          return localization.requiredExamination;
        }
        return "No Examination Required";

      case 5:
        // Attachments Section if UGRD key or show Employment History if applicable
        if (acadmicCareer == 'UGRD') {
          return localization.attachments;
        } else if (shouldDisplayEmploymentHistory()) {
          return localization.employmentHistory;
        } else if (isAttachmentSectionForExt()) {
          return localization.confirmation_title;
        }
        return localization.confirmation_title;

      case 6:
        // Final Confirmation or Attachments Section based on key
        if (key == 'SCOACTUGRD' ||
            key == 'SCOUGRDINT' ||
            key == 'SCOMETLOGINT' ||
            key == 'SCOUGRDEXT') {
          return localization.confirmation_title;
        } else {
          return localization.attachments;
        }

      case 7:
        // Confirmation at the end
        return localization.confirmation_title;

      default:
        return "Unknown"; // Default case for unexpected step values
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    // final localization = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: AnimatedContainer(duration: const Duration(milliseconds: 100),
        // height: 150,
        padding: EdgeInsets.only(top:5,left: kPadding,right: kPadding),
        decoration:  BoxDecoration(

            // color: AppColors.bgColor,
            gradient: LinearGradient(colors: [
              Color(0xff074976),
              Color(0xff042C46),
            ]),
            border: const Border(bottom: BorderSide(color: AppColors.darkGrey))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// scholarship title
            Text(
              widget.scholarshipTitle,
              style: AppTextStyles.titleBoldTextStyle().copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: ListView.builder(
                // shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.totalSections,
                itemBuilder: (context, index) {
                  return SizedBox(
                      // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   "${localization.step} ${index + 1}",
                          //   style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                          //   textAlign: TextAlign.center,
                          // ),
                          // const SizedBox(height: 8),

                          // Circle + Line Row
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              /// grey connecting lin
                              AnimatedContainer(duration: const Duration(milliseconds: 100),
                                height: 1,
                                width: 56.5,
                                color: index == 0 ? null : Colors.grey,
                              ),
                              const SizedBox(width: 1,),
                              /// Main indicator
                              AnimatedContainer(duration: const Duration(milliseconds: 100),
                                width: 25,
                                height: 25,
                                // padding: EdgeInsets.all(widget.currentSectionIndex == index ? 5 : 0),
                                decoration:
                                const BoxDecoration(
                                    // border: Border.all(color: (widget.currentSectionIndex == index || index > widget.currentSectionIndex) ? Colors.grey : Colors.transparent),

                                    shape: BoxShape.circle),
                                child: widget.currentSectionIndex == index ? AnimatedContainer(duration: const Duration(milliseconds: 100),
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff0195F7),
                                  ),
                                   child:  Center(child: Text((index + 1).toString(),style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),)
                                )
                                    : AnimatedContainer(duration: const Duration(milliseconds: 100),
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index >
                                          widget.currentSectionIndex
                                          ? const Color(0xff226795)
                                          : Colors.green,
                                  ),
                                  child:
                                  index > widget.currentSectionIndex
                                      ? Center(child: Text((index + 1).toString(),style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),)
                                      : const Center(
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 1,),
                              /// grey connecting lin
                              AnimatedContainer(duration: const Duration(milliseconds: 100),
                                height: 1,
                                width: 56.5,
                                color: index == widget.totalSections - 1
                                    ? null
                                    : Colors.grey,
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          Flexible(
                            child: SizedBox(
                              width: 120,
                              child: Text(
                                getTextForSection(step: index), // Use a helper function to handle all conditions
                                style: const TextStyle(fontSize: 10,color: Colors.white, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      )

                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         AnimatedContainer(duration: const Duration(milliseconds: 100),
                      //             width: 72,
                      //             height: 60,
                      //             decoration: BoxDecoration(
                      //               border: Border.all(
                      //                   color: index < widget.currentSectionIndex
                      //                       ? Colors.black
                      //                       : Colors.grey),
                      //               borderRadius: BorderRadius.circular(5),
                      //               color: index > widget.currentSectionIndex
                      //                   ? AppColors.lightGrey.withOpacity(0.01)
                      //                   : Colors.white,
                      //             ),
                      //             child: Column(
                      //               mainAxisSize: MainAxisSize.max,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   "${localization.step} ${index + 1}",
                      //                   style: const TextStyle(fontSize: 8),
                      //                 ),
                      //                 AnimatedContainer(duration: const Duration(milliseconds: 100),
                      //                   width: 20,
                      //                   height: 20,
                      //                   padding: EdgeInsets.all(
                      //                       widget.currentSectionIndex == index
                      //                           ? 5
                      //                           : 0),
                      //                   decoration: BoxDecoration(
                      //                       border: Border.all(
                      //                           color: (widget.currentSectionIndex ==
                      //                                       index ||
                      //                                   index >
                      //                                       widget.currentSectionIndex)
                      //                               ? Colors.grey
                      //                               : Colors.transparent),
                      //                       shape: BoxShape.circle),
                      //                   child: widget.currentSectionIndex == index
                      //                       ? AnimatedContainer(duration: const Duration(milliseconds: 100),
                      //                           width: 10,
                      //                           height: 10,
                      //                           decoration: const BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               color: Colors.green),
                      //                         )
                      //                       : AnimatedContainer(duration: const Duration(milliseconds: 100),
                      //                           width: 10,
                      //                           height: 10,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               color: index >
                      //                                       widget.currentSectionIndex
                      //                                   ? Colors.transparent
                      //                                   : Colors.green),
                      //                           child:
                      //                               index > widget.currentSectionIndex
                      //                                   ? showVoid
                      //                                   : const Center(
                      //                                       child: Icon(
                      //                                       Icons.done,
                      //                                       color: Colors.white,
                      //                                       size: 15,
                      //                                     )),
                      //                         ),
                      //                 ),
                      //               ],
                      //             )),
                      //         if (index < widget.totalSections - 1)
                      //           AnimatedContainer(duration: const Duration(milliseconds: 100),
                      //             height: 1,
                      //             color: Colors.grey,
                      //             width: 40,
                      //           ),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       width: 80,
                      //       child: Text(
                      //         getTextForSection(step: index),
                      //         // Use a helper function to handle all conditions
                      //         style: const TextStyle(
                      //             fontSize: 10, fontWeight: FontWeight.w600),
                      //         textAlign: TextAlign.center,
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     )
                      //   ],
                      // ),

                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
