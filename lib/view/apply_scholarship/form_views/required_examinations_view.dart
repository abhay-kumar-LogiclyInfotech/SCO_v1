import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../form_view_Utils.dart';


class RequiredExaminationsView extends StatefulWidget {
  dynamic draftPrevNextButtons;
  dynamic acadmicCareer;
  List<RequiredExaminations> requiredExaminationList;
  dynamic testScoreVal;
 dynamic requiredExaminationDropdownMenuItems;

   RequiredExaminationsView({super.key,required this.draftPrevNextButtons,required this.acadmicCareer,required this.requiredExaminationList,required this.requiredExaminationDropdownMenuItems,required this.testScoreVal});

  @override
  State<RequiredExaminationsView> createState() => _RequiredExaminationsViewState();
}

class _RequiredExaminationsViewState extends State<RequiredExaminationsView> with MediaQueryMixin{
  late AlertServices _alertServices;
  @override
  void initState() {

final getIt = GetIt.instance;
_alertServices = getIt.get<AlertServices>();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return _requiredExaminationsDetailsSection();
  }



  /// min max score for values
  _setMinMaxScore({required LanguageChangeViewModel langProvider, required int index}) {
    if (widget.testScoreVal.isNotEmpty) {
      final requiredExaminationInfo = widget.requiredExaminationList[index];

      final code =
          "${requiredExaminationInfo.examinationController.text}:${requiredExaminationInfo.examinationTypeIdController.text}";

      for (var element in widget.testScoreVal) {
        if (element.code.toString() == code.toString()) {
          requiredExaminationInfo.minScoreController.text = element.value.toString().split(":").elementAt(0).toString();
          requiredExaminationInfo.maxScoreController.text = element.value.toString().split(":").last.toString();
       }
      }
    } else {
      // debugPrint("TEST_SCORE_VAL is Empty");
    }
  }


  /// get examination type
  _populateExaminationTypeDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap[
      'EXAMINATION_TYPE#${widget.requiredExaminationList[index].examinationController.text}']
          ?.values !=
          null) {
        widget.requiredExaminationList[index].examinationTypeDropdown =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'EXAMINATION_TYPE#${widget.requiredExaminationList[index].examinationController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  /// function to add examination from list
  _addRequiredExamination() {
    setState(() {
      widget.requiredExaminationList.add(RequiredExaminations(
        examinationController: TextEditingController(),
        examinationTypeIdController: TextEditingController(),
        examinationGradeController: TextEditingController(),
        minScoreController: TextEditingController(),
        maxScoreController: TextEditingController(),
        examDateController: TextEditingController(),
        isNewController: TextEditingController(text: "true"),
        errorMessageController: TextEditingController(),
        examinationFocusNode: FocusNode(),
        examinationTypeIdFocusNode: FocusNode(),
        examinationGradeFocusNode: FocusNode(),
        minScoreFocusNode: FocusNode(),
        maxScoreFocusNode: FocusNode(),
        examDateFocusNode: FocusNode(),
        examinationTypeDropdown: [],
      ));
    });
  }

  /// function to delete examination from list
  _deleteRequiredExamination(int index) {
    if (index > 0 && index < widget.requiredExaminationList.length) {
      setState(() {
        /// Get the item to be deleted
        final item = widget.requiredExaminationList[index];

        /// Dispose of all the TextEditingController instances
        item.examinationController.dispose();
        item.examinationTypeIdController.dispose();
        item.examinationGradeController.dispose();
        item.minScoreController.dispose();
        item.maxScoreController.dispose();
        item.examDateController.dispose();
        item.isNewController.dispose();
        item.errorMessageController.dispose();

        /// Dispose of all the FocusNode instances
        item.examinationFocusNode.dispose();
        item.examinationTypeIdFocusNode.dispose();
        item.examinationGradeFocusNode.dispose();
        item.minScoreFocusNode.dispose();
        item.maxScoreFocusNode.dispose();
        item.examDateFocusNode.dispose();

        /// Remove the item from the list
        widget.requiredExaminationList.removeAt(index);
      });
    }
  }


  /// Section for Required Examinations
  Widget _requiredExaminationsDetailsSection() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
              kSmallSpace,
              // widget.draftPrevNextButtons,
              CustomInformationContainer(
                  title: widget.acadmicCareer == 'DDS'
                      ? localization.ddsExams
                      : localization.examinationForUniversities,
                  expandedContent: sectionBackground(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(children: [
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.requiredExaminationList.length,
                              itemBuilder: (context, index) {
                                final requiredExamInfo = widget.requiredExaminationList[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// ****************************************************************************************************************************************************
                                    /// Examination name
                                    fieldHeading(
                                        title: localization.examination,
                                        important: false,
                                        langProvider: langProvider),
                                    scholarshipFormDropdown(context:context,
                                        controller: requiredExamInfo.examinationController,
                                        currentFocusNode:
                                        requiredExamInfo.examinationFocusNode,
                                        menuItemsList: widget.requiredExaminationDropdownMenuItems ??
                                            [],
                                        hintText: localization.select,
                                        errorText: requiredExamInfo.examinationError,
                                        onChanged: (value) {
                                          requiredExamInfo.examinationError = null;
                                          requiredExamInfo.examinationTypeIdError = null;
                                          requiredExamInfo.examinationTypeDropdown?.clear();
                                          requiredExamInfo.examinationGradeController.clear();
                                          requiredExamInfo.examDateController.clear();

                                          setState(() {
                                            /// Check for existing selected values and ensure non-empty comparison
                                            bool alreadySelected = widget.requiredExaminationList.any((info) {
                                              return info != requiredExamInfo &&
                                                  value != null &&
                                                  value.trim().isNotEmpty &&
                                                  info.examinationController.text.trim() == value.trim();
                                            });

                                            if (alreadySelected) {
                                              /// If duplicate is found, show an error and clear the controller
                                              _alertServices.showToast(
                                                // context: context,
                                                message: localization.duplicateExaminationMessage,
                                              );
                                              requiredExamInfo.examinationError = localization.duplicateExaminationMessage;
                                            } else {
                                              /// Assign the value only if it's valid and not already selected
                                              requiredExamInfo.examinationController.text = value!.trim();

                                              /// Clear dependent dropdown values
                                              requiredExamInfo.examinationTypeIdController.clear();
                                              requiredExamInfo.examinationTypeDropdown?.clear();

                                              /// Populate examination type dropdown
                                              _populateExaminationTypeDropdown(
                                                langProvider: langProvider,
                                                index: index,
                                              );

                                              /// Move focus to the next field
                                              Utils.requestFocus(
                                                focusNode: requiredExamInfo.examinationTypeIdFocusNode,
                                                context: context,
                                              );
                                            }
                                          });
                                        }

                                    ),
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,
                                    /// examination type dropdown
                                    fieldHeading(
                                        title:  localization.examinationType,
                                        important: requiredExamInfo.examinationController.text.isNotEmpty && (requiredExamInfo.examinationTypeDropdown?.isNotEmpty ?? false || requiredExamInfo.examinationTypeDropdown != null),
                                        langProvider: langProvider),
                                    scholarshipFormDropdown(
                                      filled: !(requiredExamInfo.examinationController.text.isNotEmpty && (requiredExamInfo.examinationTypeDropdown?.isNotEmpty ?? false || requiredExamInfo.examinationTypeDropdown != null)),
                                      context:context,
                                      controller: requiredExamInfo.examinationTypeIdController,
                                      currentFocusNode: requiredExamInfo.examinationTypeIdFocusNode,
                                      menuItemsList: requiredExamInfo.examinationTypeDropdown ?? [],
                                      hintText: localization.select,
                                      errorText: requiredExamInfo.examinationTypeIdError,
                                      onChanged: (value) {
                                        requiredExamInfo.examinationTypeIdError =
                                        null;

                                        setState(() {
                                          /// Assign the value only if it's not already selected
                                          requiredExamInfo
                                              .examinationTypeIdController
                                              .text = value!;

                                          /// setting min max score for indexed item
                                          _setMinMaxScore(
                                              langProvider: langProvider,
                                              index: index);

                                          /// Move focus to the next field
                                          Utils.requestFocus(
                                            focusNode: requiredExamInfo
                                                .examinationGradeFocusNode,
                                            context: context,
                                          );
                                        });
                                      },
                                    ),
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,
                                    /// examination grade dropdown
                                    fieldHeading(
                                        title:
                                        widget.acadmicCareer !=
                                            'DDS'
                                            ? localization.examinationGrade
                                            : localization.examinationDdsGrade,
                                        important: false,
                                        langProvider: langProvider),
                                    scholarshipFormTextField(
                                        currentFocusNode: requiredExamInfo.examinationGradeFocusNode,
                                        nextFocusNode: requiredExamInfo.examDateFocusNode,
                                        controller: requiredExamInfo.examinationGradeController,
                                        hintText: widget.acadmicCareer != 'DDS' ? localization.examinationGradeWatermark : localization.examinationDdsGradeWatermark ,
                                        errorText: requiredExamInfo.examinationGradeError,
                                        onChanged: (value) {
                                          if (requiredExamInfo.examinationGradeFocusNode.hasFocus) {
                                            setState(() {
                                              requiredExamInfo.examinationGradeError =
                                                  ErrorText.getGradeValidationError(grade: requiredExamInfo.examinationGradeController.text, context: context);
                                            });
                                          }
                                        }),
                                    /// ****************************************************************************************************************************************************
                                    kFormHeight,
                                    /// 'Exam Date'
                                    fieldHeading(
                                        title:  localization.dateExam ,
                                        important: requiredExamInfo.examinationController.text.isNotEmpty,
                                        langProvider: langProvider),
                                    scholarshipFormDateField(
                                      currentFocusNode:
                                      requiredExamInfo.examDateFocusNode,
                                      controller:
                                      requiredExamInfo.examDateController,
                                      hintText: localization.dateExamWatermark ,
                                      errorText: requiredExamInfo.examDateError,
                                      onChanged: (value) {
                                        setState(() {
                                          if (requiredExamInfo
                                              .examDateFocusNode.hasFocus) {
                                            requiredExamInfo.examDateError =
                                                ErrorText.getEmptyFieldError(
                                                  name: requiredExamInfo
                                                      .examDateController.text,
                                                  context: context,
                                                );
                                          }
                                        });
                                      },
                                      onTap: () async {
                                        /// Clear the error message when a date is selected
                                        requiredExamInfo.examDateError = null;

                                        /// Define the initial date as today's date (default selection)
                                        final DateTime initialDate = DateTime.now();

                                        /// Define the maximum date as 20 years from today
                                        final DateTime maxDate = initialDate.add(const Duration(days: 20 * 365));

                                        /// Define the minimum date as 20 years before today
                                        final DateTime firstDate = initialDate.subtract(const Duration(days: 20 * 365));

                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          barrierColor: AppColors.scoButtonColor.withOpacity(0.1), // Background color
                                          barrierDismissible: false, // Disable outside touch to close
                                          locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale, // Locale for the picker
                                          initialDate: initialDate, // Default selected date
                                          firstDate: firstDate, // Earliest selectable date
                                          lastDate: maxDate, // Latest selectable date
                                        );


                                        if (date != null) {
                                          setState(() {
                                            /// Set the selected date in the controller (format to show only the year)
                                            requiredExamInfo
                                                .examDateController.text =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(date)
                                                    .toString();
                                          });
                                        }
                                      },
                                    ),

                                    /// ****************************************************************************************************************************************************
                                    /// add examination
                                    (index >= 1)
                                        ? addRemoveMoreSection(
                                        title: localization.deleteRowExamination,
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            _deleteRequiredExamination(index);
                                          });
                                        })
                                        : showVoid,
                                    kFormHeight,
                                    const Divider(),
                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************
                                  ],
                                );
                              }),
                          /// ****************************************************************************************************************************************************
                          /// add examination
                          addRemoveMoreSection(
                              title: localization.addRowExamination,
                              add: true,
                              onChanged: () {
                                setState(() {
                                  _addRequiredExamination();
                                });
                              })
                          /// ****************************************************************************************************************************************************
                          ,
                        ])
                      ]))),

              const SizedBox(height: 100,),

            ])));
  }
}
