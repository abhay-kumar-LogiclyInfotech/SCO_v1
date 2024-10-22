import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/utils/utils.dart';
import '../../resources/app_colors.dart';

class StepsProgressView extends StatefulWidget {

  final int totalSections;
  final int currentSectionIndex;
  dynamic  selectedScholarship;
   StepsProgressView({super.key,required this.totalSections,required this.currentSectionIndex,required this.selectedScholarship});

  @override
  State<StepsProgressView> createState() => _StepsProgressViewState();
}

class _StepsProgressViewState extends State<StepsProgressView> with MediaQueryMixin {


  String getTextForSection({required int step}) {
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
        return "Student Undertaking Section";

      case 1:
        return "Student Details Section";

      case 2:
        if (shouldShowHighSchoolDetails()) {
          return "High School Details Section";
        }
        // Graduation Details Section as fallback
        return "Graduation Details Section";

      case 3:
        if (isUniversityAndMajorsRequired()) {
          return "University and Majors Section";
        }
        return "Not Applicable for University and Majors";

      case 4:
        if (isAttachmentSectionForExt()) {
          return "Attachments Section";
        } else if (isRequiredExaminationDetailsRequired()) {
          return "Required Examinations Section";
        }
        return "No Examination Required Section";

      case 5:
      // Attachments Section if UGRD key or show Employment History if applicable
        if (acadmicCareer == 'UGRD') {
          return "UGRD Attachments Section";
        } else if (shouldDisplayEmploymentHistory()) {
          return "Employment History Section";
        }
        return "No Employment History Required Section";

      case 6:
      // Final Confirmation or Attachments Section based on key
        if (key == 'SCOACTUGRD' ||
            key == 'SCOUGRDINT' ||
            key == 'SCOMETLOGINT' ||
            key == 'SCOUGRDEXT') {
          return "Final Confirmation Section";
        } else {
          return "Attachments Section";
        }

      case 7:
      // Confirmation at the end
        return "Final Confirmation Section";

      default:
        return "Unknown Section"; // Default case for unexpected step values
    }
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight/7,
      width: double.infinity,
      child: ListView.builder(
        // shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.totalSections,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Container(
                        width: 72,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: index < widget.currentSectionIndex ? Colors.black : Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: index > widget.currentSectionIndex ? AppColors.lightGrey.withOpacity(0.01) :Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Step ${index+1}",style: const TextStyle(fontSize: 8),),
                            Container(
                              width: 20,
                              height: 20,
                              padding:  EdgeInsets.all( widget.currentSectionIndex == index ? 5 :0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: (widget.currentSectionIndex == index || index > widget.currentSectionIndex) ? Colors.grey : Colors.transparent ),
                                  shape: BoxShape.circle
                              ),
                              child: widget.currentSectionIndex == index ? Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                ),) : Container(
                                width: 10,
                                height: 10,
                                decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index > widget.currentSectionIndex ? Colors.transparent : Colors.green
                                ), child: index > widget.currentSectionIndex ?    showVoid : const Center(child: Icon(Icons.done,color: Colors.white,size: 15,)),                          ) ,
                            ),

                          ],
                        )),
                    if(index < widget.totalSections-1) Container(height: 1,color: Colors.grey,width: 40,),

                  ],
                ),
                SizedBox(
                    width: 80,
          child: Text(
            getTextForSection(step: index),  // Use a helper function to handle all conditions
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          ),)

              ],
            ),
          );
        },
      ),
    );
  }
}
