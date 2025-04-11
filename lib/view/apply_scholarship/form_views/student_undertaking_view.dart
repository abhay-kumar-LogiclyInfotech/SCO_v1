import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../../l10n/app_localizations.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_checkbox_tile.dart';

class StudentUndertakingView extends StatefulWidget {
  bool acceptStudentUndertaking;
   int step;
    GetAllActiveScholarshipsModel? selectedScholarship;
   dynamic filledSections;
   final VoidCallback onSubmit;
   final Function(bool?) onAcceptTerms;
   StudentUndertakingView({super.key,required this.acceptStudentUndertaking, this.selectedScholarship,required this.step,required this.onSubmit,required this.filledSections,required this.onAcceptTerms});

  @override
  State<StudentUndertakingView> createState() => _StudentUndertakingViewState();
}

class _StudentUndertakingViewState extends State<StudentUndertakingView> with MediaQueryMixin {


 String  getStudentGuidLine()
  {
    final localization = AppLocalizations.of(context)!;
    final selectedScholarship = widget.selectedScholarship;
    final admitType = selectedScholarship?.admitType;
    final academicCareer = selectedScholarship?.acadmicCareer;
    if(admitType != 'INT' && academicCareer != 'HCHL') {
      return localization.studentGuideline;
    }
    if(academicCareer == 'HCHL'){
      return localization.studentGuidelineHchl;
    }
    if(admitType == 'INT' && academicCareer != 'HCHL'){
      return localization.studentGuidelineInternational;
    }
    return '';
  }


  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Accept Pledge
            Text(
              AppLocalizations.of(context)!.studentGuidelineTitle,
              style: AppTextStyles.titleTextStyle(),
            ),
            Text(
              getStudentGuidLine(),
            ),
            kFormHeight,
            CustomGFCheckbox(
              value: widget.acceptStudentUndertaking,
              onChanged: widget.onAcceptTerms,
              text: localization.studentUndertaking,
              textStyle: AppTextStyles.titleBoldTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w600),
            ),

            Padding(
              padding: EdgeInsets.all(kPadding),
              child: CustomButton(
                  buttonName: localization.submit,
                  // buttonColor: AppColors.scoThemeColor,
                  borderColor: Colors.transparent,
                  isLoading: false,
                  textDirection: getTextDirection(langProvider),
                  onTap: widget.onSubmit),
            )
          ],
        ),
      ),
    );
  }
}


