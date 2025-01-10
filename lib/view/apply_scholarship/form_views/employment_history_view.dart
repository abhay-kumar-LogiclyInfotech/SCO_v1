import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        isNewController: TextEditingController(text: 'true'),
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
    final localization = AppLocalizations.of(context)!;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
              widget.draftPrevNextButtons,
              CustomInformationContainer(
                  title: localization.employmentHistory,
                  expandedContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ****************************************************************************************************************************************************
                              /// previously employed or not be using radio buttons
                              sectionTitle(title: localization.previouslyEmployed,),
                              kFormHeight,
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.employmentStatusItemsList.length,
                                  itemBuilder: (context, index) {
                                    final element = widget.employmentStatusItemsList[index];
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
                                      physics: const NeverScrollableScrollPhysics(),
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

                                            kFormHeight,
                                            /// Employer name
                                            fieldHeading(
                                                title: localization.emphistEmployerName,
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode: employmentHistInfo.employerNameFocusNode,
                                                nextFocusNode: employmentHistInfo.designationFocusNode,
                                                controller: employmentHistInfo.employerNameController,
                                                hintText: localization.emphistEmployerNameWatermark,
                                                errorText: employmentHistInfo.employerNameError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .employerNameFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .employerNameError =
                                                          ErrorText.getEmptyFieldError(
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
                                                title: localization.emphistTitleName,
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
                                                hintText: localization.emphistTitleNameWatermark,
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
                                            /// Name
                                            fieldHeading(
                                                title: localization.emphistOccupationName,
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
                                                hintText: localization.emphistOccupationNameWatermark,
                                                errorText: employmentHistInfo
                                                    .occupationError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .occupationFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .occupationError =
                                                          ErrorText.getNameArabicEnglishValidationError(
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
                                                title: localization.emphistPlace,
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
                                                hintText: localization.emphistPlaceWatermark,
                                                errorText: employmentHistInfo
                                                    .placeError,
                                                onChanged: (value) {
                                                  if (employmentHistInfo
                                                      .placeFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      employmentHistInfo
                                                          .placeError =
                                                          ErrorText.getNameArabicEnglishValidationError(
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
                                                title: localization.employmentStartDate,
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormDateField(
                                              currentFocusNode:
                                              employmentHistInfo
                                                  .startDateFocusNode,
                                              controller: employmentHistInfo
                                                  .startDateController,
                                              hintText: localization.employmentStartDateWatermark,
                                              errorText: employmentHistInfo.startDateError,
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
                                                /// Define the initial date as today's date
                                                final DateTime initialDate = DateTime.now();

                                                /// Define the maximum date as today
                                                final DateTime maxDate = DateTime.now();

                                                /// Define the first date as 10 years before today
                                                final DateTime firstDate = maxDate.subtract(const Duration(days: 10 * 365));

                                                /// Show the date picker
                                                DateTime? date = await showDatePicker(
                                                  context: context,
                                                  barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                                                  barrierDismissible: false,
                                                  locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
                                                  initialDate: initialDate,
                                                  firstDate: firstDate, // Limit to the last 10 years
                                                  lastDate: maxDate,   // Limit up to today's date
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
                                                title: localization.employmentEndDate,
                                                important: widget.employmentStatus == 'P',
                                                langProvider: langProvider),
                                            scholarshipFormDateField(
                                              currentFocusNode: employmentHistInfo.endDateFocusNode,
                                              controller: employmentHistInfo.endDateController,
                                              hintText: localization.employmentEndDateWatermark,
                                              errorText: employmentHistInfo.endDateError,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (employmentHistInfo.endDateFocusNode.hasFocus) {
                                                    employmentHistInfo.endDateError = ErrorText.getEmptyFieldError(name: employmentHistInfo.endDateController.text, context: context);
                                                  }
                                                });
                                              },
                                              onTap: () async {
                                                /// Clear the error message when a date is selected
                                                employmentHistInfo.endDateError = null;

                                                /// Define the initial date (current date)
                                                final DateTime initialDate = DateTime.now();

                                                /// Define the maximum date (today's date)
                                                final DateTime maxDate = DateTime.now();

                                                /// Define the first date (10 years ago from today)
                                                final DateTime firstDate = maxDate.subtract(const Duration(days: 10 * 365));

                                                /// Define a fallback minimum date if no specific value is available
                                                /// For example, 20 years ago from today
                                                final DateTime fallbackMinDate = DateTime.now().subtract(const Duration(days: 20 * 365));

                                                /// If you don't know the minDate, use the fallback or a default value
                                                final DateTime minDate = /* Retrieve from model/controller if available, otherwise */ fallbackMinDate;

                                                /// Show the date picker
                                                DateTime? date = await showDatePicker(
                                                  context: context,
                                                  barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                                                  barrierDismissible: false,
                                                  locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
                                                  initialDate: initialDate,
                                                  firstDate: minDate.isBefore(firstDate) ? firstDate : minDate, // Ensure minDate does not go beyond 10 years
                                                  lastDate: maxDate, // Limit up to today's date
                                                  selectableDayPredicate: (DateTime day) {
                                                    // Only allow days after the minimum date
                                                    return day.isAfter(minDate.subtract(const Duration(days: 1)));
                                                  },
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
                                                title: localization.emphistReportingManager,
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
                                                hintText:localization.emphistReportingManagerWatermark,
                                                errorText: employmentHistInfo.reportingManagerError,
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
                                                title: localization.emphistMgrContactNo,
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo.contactNumberFocusNode,
                                                nextFocusNode:
                                                employmentHistInfo.contactEmailFocusNode,
                                                controller: employmentHistInfo.contactNumberController,
                                                hintText: localization.emphistMgrContactNoWatermark,
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
                                                title: localization.managerEmail,
                                                important: true,
                                                langProvider: langProvider),
                                            scholarshipFormTextField(
                                                currentFocusNode:
                                                employmentHistInfo
                                                    .contactEmailFocusNode,
                                                controller: employmentHistInfo
                                                    .contactEmailController,
                                                nextFocusNode: index < widget.employmentHistoryList.length - 1 ? widget.employmentHistoryList[index + 1].employerNameFocusNode : null,
                                                hintText: localization.registrationEmailAddressWatermark,
                                                errorText: employmentHistInfo.contactEmailError,
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
                                                title: localization.deleteRow,
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
                                      title:localization.addRow,
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

