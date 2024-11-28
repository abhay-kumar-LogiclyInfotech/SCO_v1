import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final selectedScholarship = widget.selectedScholarship;
    final admitType = selectedScholarship?.admitType;
    final academicCareer = selectedScholarship?.acadmicCareer;
    if(admitType != 'INT' && academicCareer != 'HCHL') {
      return AppLocalizations.of(context)!.studentGuideline;
    }
    if(academicCareer == 'HCHL'){
      return AppLocalizations.of(context)!.studentGuidelineHchl;
    }
    if(admitType == 'INT' && academicCareer != 'HCHL'){
      return AppLocalizations.of(context)!.studentGuidelineInternational;
    }
    return '';
  }


  @override
  Widget build(BuildContext context) {
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
              text: AppLocalizations.of(context)!.studentUndertaking,
            ),

            Padding(
              padding: EdgeInsets.all(kPadding),
              child: CustomButton(
                  buttonName: "Submit",
                  buttonColor: AppColors.scoThemeColor,
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


