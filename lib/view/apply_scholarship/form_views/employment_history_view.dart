import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_checkbox_tile.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/validations_and_errorText.dart';
import '../form_view_Utils.dart';

class EmploymentHistoryView extends StatefulWidget {
  
  dynamic employmentStatus;
  dynamic employmentHistoryList;
  dynamic employmentStatusItemsList;
  dynamic draftPrevNextButtons;
  final  void Function(dynamic?) onEmploymentStatusChanged;
  EmploymentHistoryView({super.key,this.employmentStatus,this.employmentHistoryList,this.employmentStatusItemsList,this.draftPrevNextButtons,required this.onEmploymentStatusChanged});

  @override
  State<EmploymentHistoryView> createState() => _EmploymentHistoryViewState();
}

class _EmploymentHistoryViewState extends State<EmploymentHistoryView> with MediaQueryMixin {

  void _removeEmploymentHistory(int index) {
    if (index >= 0 && index < widget.employmentHistoryList.length) {
      setState(() {
        /// Get the item to be deleted
        final item = widget.employmentHistoryList[index];

        /// Dispose of all the TextEditingController instances
        item.employerNameController.dispose();
        item.designationController.dispose();
        item.startDateController.dispose();
        item.endDateController.dispose();
        item.occupationController.dispose();
        item.titleController.dispose();
        item.placeController.dispose();
        item.reportingManagerController.dispose();
        item.contactNumberController.dispose();
        item.contactEmailController.dispose();
        item.isNewController.dispose();
        item.errorMessageController.dispose();

        /// Dispose of all the FocusNode instances
        item.employerNameFocusNode.dispose();
        item.designationFocusNode.dispose();
        item.startDateFocusNode.dispose();
        item.endDateFocusNode.dispose();
        item.occupationFocusNode.dispose();
        item.titleFocusNode.dispose();
        item.placeFocusNode.dispose();
        item.reportingManagerFocusNode.dispose();
        item.contactNumberFocusNode.dispose();
        item.contactEmailFocusNode.dispose();

        /// Remove the item from the list
        widget.employmentHistoryList.removeAt(index);
      });
    }
  }
  void _addEmploymentHistory() {
    setState(() {
      widget.employmentHistoryList.add(EmploymentHistory(
        employerNameController: TextEditingController(),
        designationController: TextEditingController(),
        startDateController: TextEditingController(),
        endDateController: TextEditingController(),
        occupationController: TextEditingController(),
        titleController: TextEditingController(),
        placeController: TextEditingController(),
        reportingManagerController: TextEditingController(),
        contactNumberController: TextEditingController(),
        contactEmailController: TextEditingController(),
        isNewController: TextEditingController(),
        errorMessageController: TextEditingController(),
        employerNameFocusNode: FocusNode(),
        designationFocusNode: FocusNode(),
        startDateFocusNode: FocusNode(),
        endDateFocusNode: FocusNode(),
        occupationFocusNode: FocusNode(),
        titleFocusNode: FocusNode(),
        placeFocusNode: FocusNode(),
        reportingManagerFocusNode: FocusNode(),
        contactNumberFocusNode: FocusNode(),
        contactEmailFocusNode: FocusNode(),
      ));
    });
  }





  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
              widget.draftPrevNextButtons,
              CustomInformationContainer(
                  title: "Employment History",
                  expandedContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ****************************************************************************************************************************************************
                              /// previously employed or not be using radio buttons
                              sectionTitle(title: "Previously Employed"),
                              kFormHeight,
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.employmentStatusItemsList.length,
                                  itemBuilder: (context, index) {
                                    final element =
                                    widget.employmentStatusItemsList[index];
                                    return CustomRadioListTile(
                                      value: element.code,
                                      groupValue: widget.employmentStatus,
                                      onChanged: widget.onEmploymentStatusChanged,
                                      title: getTextDirection(langProvider) ==
                                          TextDirection.ltr
                                          ? element.value
                                          : element.valueArabic,
                                      textStyle: textFieldTextStyle,
                                    );
                                  }),
                              /// ****************************************************************************************************************************************************

                              /// employment history details section
                              widget.employmentStatus != null && widget.employmentStatus != '' && widget.employmentStatus != 'N'
                                  ? Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount:
                                      widget.employmentHistoryList.length,
                                      itemBuilder: (context, index) {
                                        final employmentHistInfo =
                                        widget.employmentHistoryList[index];
                                        return Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            /// ****************************************************************************************************************************************************

                                            /// Employer name
                                            fieldHeading(
                                                title: "Employer Name",
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .employerNameFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .designationFocusNode,
                                                controller: employmentHistInfo
                                                    .employerNameController,
                                                hintText:
                                                'Enter Employer Name',
                                                errorText: employmentHistInfo
                                                    .employerNameError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .employerNameFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .employerNameError =
                                                          ErrorText.getNameArabicEnglishValidationError(
                                                              name: employmentHistInfo
                                                                  .employerNameController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),

                                            /// ****************************************************************************************************************************************************

                                            kFormHeight,
                                            /// Designation
                                            fieldHeading(
                                                title: "Designation",
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .titleFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .occupationFocusNode,
                                                controller: employmentHistInfo
                                                    .titleController,
                                                hintText: 'Enter Designation',
                                                errorText: employmentHistInfo
                                                    .titleError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .titleFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .titleError =
                                                          ErrorText
                                                              .getNameArabicEnglishValidationError(
                                                              name: employmentHistInfo
                                                                  .titleController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),

                                            /// ****************************************************************************************************************************************************

                                            kFormHeight,
                                            /// occupation
                                            fieldHeading(
                                                title: 'Occupation',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .occupationFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .placeFocusNode,
                                                controller: employmentHistInfo
                                                    .occupationController,
                                                hintText: 'Enter Occupation',
                                                errorText: employmentHistInfo
                                                    .occupationError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .occupationFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .occupationError =
                                                          ErrorText.getEmptyFieldError(
                                                              name: employmentHistInfo
                                                                  .occupationController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),
                                            /// ****************************************************************************************************************************************************
                                            kFormHeight,
                                            /// work place
                                            fieldHeading(
                                                title: 'Work Place',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .placeFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .startDateFocusNode,
                                                controller: employmentHistInfo
                                                    .placeController,
                                                hintText: 'Enter Work Place',
                                                errorText: employmentHistInfo
                                                    .placeError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .placeFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .placeError =
                                                          ErrorText
                                                              .getEmptyFieldError(
                                                              name: employmentHistInfo
                                                                  .placeController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),

                                            /// ****************************************************************************************************************************************************

                                            kFormHeight,
                                            /// start date
                                            fieldHeading(
                                                title:
                                                'Employment Start Date',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormDateField(
                                              currentFocusNode:
                                              employmentHistInfo
                                                  .startDateFocusNode,
                                              controller: employmentHistInfo
                                                  .startDateController,
                                              hintText:
                                              "Select Employment Start Date",
                                              errorText: employmentHistInfo
                                                  .startDateError,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (employmentHistInfo
                                                      .startDateFocusNode
                                                      .hasFocus) {
                                                    employmentHistInfo
                                                        .startDateError =
                                                        ErrorText
                                                            .getEmptyFieldError(
                                                          name: employmentHistInfo
                                                              .startDateController
                                                              .text,
                                                          context: context,
                                                        );
                                                  }
                                                });
                                              },
                                              onTap: () async {
                                                /// Clear the error message when a date is selected
                                                employmentHistInfo
                                                    .startDateError = null;

                                                /// Define the initial date as today's date (for year selection)
                                                final DateTime initialDate =
                                                DateTime.now();
                                                final DateTime maxDate =
                                                DateTime.now();

                                                final DateTime firstDate =
                                                maxDate.subtract(
                                                    const Duration(
                                                        days: 10 * 365));
                                                DateTime? date =
                                                await showDatePicker(
                                                  context: context,
                                                  barrierColor: AppColors
                                                      .scoButtonColor
                                                      .withOpacity(0.1),
                                                  barrierDismissible: false,
                                                  locale: Provider.of<
                                                      LanguageChangeViewModel>(
                                                      context,
                                                      listen: false)
                                                      .appLocale,
                                                  initialDate: initialDate,
                                                  firstDate: firstDate,
                                                  /// Limit to the last 10 years
                                                  lastDate:
                                                  initialDate, /// Limit up to the maxDate or current year
                                                );

                                                if (date != null) {
                                                  setState(() {
                                                    employmentHistInfo
                                                        .startDateController
                                                        .text = DateFormat(
                                                        "yyyy-MM-dd")
                                                        .format(date)
                                                        .toString();

                                                    Utils.requestFocus(
                                                        focusNode:
                                                        employmentHistInfo
                                                            .endDateFocusNode,
                                                        context: context);
                                                  });
                                                }
                                              },
                                            ),

                                            /// ****************************************************************************************************************************************************
                                            kFormHeight,
                                            /// end date
                                            fieldHeading(
                                                title: 'Employment End Date',
                                                important: widget.employmentStatus == 'P',
                                                langProvider: langProvider),
                                            scholarshipFormDateField(
                                              currentFocusNode:
                                              employmentHistInfo
                                                  .endDateFocusNode,
                                              controller: employmentHistInfo
                                                  .endDateController,
                                              hintText:
                                              "Select Employment End Date",
                                              errorText: employmentHistInfo
                                                  .endDateError,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (employmentHistInfo
                                                      .endDateFocusNode
                                                      .hasFocus) {
                                                    employmentHistInfo
                                                        .endDateError =
                                                        ErrorText
                                                            .getEmptyFieldError(
                                                          name: employmentHistInfo
                                                              .endDateController
                                                              .text,
                                                          context: context,
                                                        );
                                                  }
                                                });
                                              },
                                              onTap: () async {
                                                /// Clear the error message when a date is selected
                                                employmentHistInfo
                                                    .endDateError = null;

                                                /// Define the initial date as today's date (for year selection)
                                                final DateTime initialDate =
                                                DateTime.now();
                                                final DateTime maxDate =
                                                DateTime.now();

                                                final DateTime firstDate =
                                                maxDate.subtract(
                                                    const Duration(
                                                        days: 10 * 365));
                                                DateTime? date =
                                                await showDatePicker(
                                                  context: context,
                                                  barrierColor: AppColors
                                                      .scoButtonColor
                                                      .withOpacity(0.1),
                                                  barrierDismissible: false,
                                                  locale: Provider.of<
                                                      LanguageChangeViewModel>(
                                                      context,
                                                      listen: false)
                                                      .appLocale,
                                                  initialDate: initialDate,
                                                  firstDate: firstDate,
                                                  /// Limit to the last 10 years
                                                  lastDate:
                                                  initialDate, /// Limit up to the maxDate or current year
                                                );

                                                if (date != null) {
                                                  setState(() {
                                                    employmentHistInfo
                                                        .endDateController
                                                        .text = DateFormat(
                                                        "yyyy-MM-dd")
                                                        .format(date)
                                                        .toString();

                                                    Utils.requestFocus(
                                                        focusNode:
                                                        employmentHistInfo
                                                            .reportingManagerFocusNode,
                                                        context: context);
                                                  });
                                                }
                                              },
                                            ),

                                            /// ****************************************************************************************************************************************************
                                            kFormHeight,
                                            /// reporting manager
                                            fieldHeading(
                                                title: 'Reporting Manager',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .reportingManagerFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .contactNumberFocusNode,
                                                controller: employmentHistInfo
                                                    .reportingManagerController,
                                                hintText:
                                                'Enter Reporting Manager',
                                                errorText: employmentHistInfo
                                                    .reportingManagerError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .reportingManagerFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .reportingManagerError =
                                                          ErrorText.getNameArabicEnglishValidationError(
                                                              name: employmentHistInfo
                                                                  .reportingManagerController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),
                                            /// ****************************************************************************************************************************************************
                                            kFormHeight,
                                            /// contact number
                                            fieldHeading(
                                                title: 'Contact Number',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .contactNumberFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo
                                                    .contactEmailFocusNode,
                                                controller: employmentHistInfo
                                                    .contactNumberController,
                                                hintText:
                                                'Enter Contact Number',
                                                errorText: employmentHistInfo
                                                    .contactNumberError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .contactNumberFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .contactNumberError =
                                                          ErrorText.getPhoneNumberError(
                                                              phoneNumber:
                                                              employmentHistInfo
                                                                  .contactNumberController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),
                                            /// ****************************************************************************************************************************************************
                                            kFormHeight,
                                            /// contact email
                                            fieldHeading(
                                                title: 'Contact Email',
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .contactEmailFocusNode,
                                                controller: employmentHistInfo
                                                    .contactEmailController,
                                                nextFocusNode: index < widget.employmentHistoryList.length - 1 ? widget.employmentHistoryList[index + 1].employerNameFocusNode : null,
                                                hintText:
                                                'Enter Manager Email',
                                                errorText: employmentHistInfo
                                                    .contactEmailError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .contactEmailFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .contactEmailError =
                                                          ErrorText.getEmailError(
                                                              email: employmentHistInfo
                                                                  .contactEmailController
                                                                  .text,
                                                              context:
                                                              context);
                                                    });
                                                  }
                                                }),
                                            /// ****************************************************************************************************************************************************

                                            (index >= 1)
                                                ? addRemoveMoreSection(
                                                title: "Delete",
                                                add: false,
                                                onChanged: () {
                                                  setState(() {
                                                    _removeEmploymentHistory(
                                                        index);
                                                  });
                                                })
                                                : showVoid,
                                            kFormHeight,
                                            const MyDivider(
                                              color: AppColors.lightGrey,
                                            ),
                                            kFormHeight,
                                            /// ****************************************************************************************************************************************************
                                          ],
                                        );
                                      }),
                                  /// ****************************************************************************************************************************************************
                                  addRemoveMoreSection(
                                      title: "Add",
                                      add: true,
                                      onChanged: () {
                                        setState(() {
                                          _addEmploymentHistory();
                                        });
                                      })
                                ],
                              )
                                  : showVoid,

                              /// ****************************************************************************************************************************************************
                            ])
                      ])),
              widget.draftPrevNextButtons
            ])));
  }
}

