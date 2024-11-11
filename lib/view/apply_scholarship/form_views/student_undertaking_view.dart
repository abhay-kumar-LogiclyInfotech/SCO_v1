import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_checkbox_tile.dart';

class StudentUndertakingView extends StatefulWidget {
  bool acceptStudentUndertaking;
   int step;
   dynamic filledSections;
   final VoidCallback onSubmit;
   final Function(bool?) onAcceptTerms;
   StudentUndertakingView({super.key,required this.acceptStudentUndertaking,required this.step,required this.onSubmit,required this.filledSections,required this.onAcceptTerms});

  @override
  State<StudentUndertakingView> createState() => _StudentUndertakingViewState();
}

class _StudentUndertakingViewState extends State<StudentUndertakingView> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Column(
      children: [
        /// Accept Pledge
        kFormHeight,
        CustomGFCheckbox(
          value: widget.acceptStudentUndertaking,
          onChanged: widget.onAcceptTerms,
          text: "Accept Scholarship terms and conditions",
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
    );
  }
}


