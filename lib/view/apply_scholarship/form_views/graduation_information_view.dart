import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/widgets/show_error_text.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_checkbox_tile.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../form_view_Utils.dart';
import '../../../l10n/app_localizations.dart';


class GraduationInformationView extends StatefulWidget {
  List<GraduationInfo> graduationDetailsList;
  dynamic academicCareer;
  dynamic scholarshipType;
  final bool displayHighSchool;
  dynamic havingSponsor;
  dynamic draftPrevNextButtons;
  dynamic nationalityMenuItemsList;
  dynamic Function() addGraduation;
  List<DropdownMenuItem> graduationLevelMenuItems;
  List<DropdownMenuItem> graduationLevelDDSMenuItems;
  List<DropdownMenuItem> caseStudyYearDropdownMenuItems;
  final Function(String) onUpdateHavingSponsor;
  final String? selectSponsorshipErrorText;

  GraduationInformationView(
      {super.key,
      required this.graduationDetailsList,
      required this.graduationLevelMenuItems,
      required this.caseStudyYearDropdownMenuItems,
      required this.graduationLevelDDSMenuItems,
      required this.academicCareer,
      required this.scholarshipType,
      required this.displayHighSchool,
       this.draftPrevNextButtons,
      required this.havingSponsor,
      this.nationalityMenuItemsList,
      required this.addGraduation,
      required this.onUpdateHavingSponsor,
        this.selectSponsorshipErrorText
      });

  @override
  State<GraduationInformationView> createState() =>
      _GraduationInformationViewState();
}

class _GraduationInformationViewState extends State<GraduationInformationView>
    with MediaQueryMixin {
  late AlertServices _alertService;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _alertService = getIt.get<AlertServices>();
    super.initState();
  }

  _deleteGraduationDetail(int index) {
    if (index > 0 && index < widget.graduationDetailsList.length) {
      setState(() {
        /// Get the item to be deleted
        final item = widget.graduationDetailsList[index];

        /// Dispose of all the TextEditingController instances
        item.levelController.dispose();
        item.countryController.dispose();
        item.universityController.dispose();
        item.majorController.dispose();
        item.cgpaController.dispose();
        item.graduationStartDateController.dispose();
        item.lastTermController.dispose();
        item.caseStudyTitleController.dispose();
        item.caseStudyDescriptionController.dispose();
        item.caseStudyStartYearController.dispose();
        item.isNewController.dispose();
        item.sponsorShipController.dispose();
        item.errorMessageController.dispose();
        item.otherUniversityController.dispose();
        item.graduationEndDateController.dispose();

        /// Dispose of all the FocusNode instances
        item.levelFocusNode.dispose();
        item.countryFocusNode.dispose();
        item.universityFocusNode.dispose();
        item.majorFocusNode.dispose();
        item.cgpaFocusNode.dispose();
        item.graduationStartDateFocusNode.dispose();
        item.lastTermFocusNode.dispose();
        item.caseStudyTitleFocusNode.dispose();
        item.caseStudyDescriptionFocusNode.dispose();
        item.caseStudyStartYearFocusNode.dispose();
        item.otherUniversityFocusNode.dispose();
        item.graduationEndDateFocusNode.dispose();
        item.sponsorShipFocusNode.dispose();

        /// Remove the item from the list
        widget.graduationDetailsList.removeAt(index);
      });
    }
    // print(widget.graduationDetailsList.length.toString());
    if (widget.graduationDetailsList.length == 1) {
      // print(widget.graduationDetailsList.length.toString());
      final item = widget.graduationDetailsList[0];
      _updateShowCurrentlyStudyingWithFalse(item);
    }
  }

  /// when selecting currently studying yes or no then update the ui accordingly
  _updateShowCurrentlyStudyingWithYes(GraduationInfo graduationInfo) {
    for (var element in widget.graduationDetailsList) {
      if (element != graduationInfo && element.showCurrentlyStudying) {
        setState(() {
          element.showCurrentlyStudying = false;
          element.currentlyStudying = false;
          element.lastTermController.clear();
        });
      }
    }
  }

  _updateShowCurrentlyStudyingWithFalse(GraduationInfo graduationInfo) {
    for (var element in widget.graduationDetailsList) {
      {
        setState(() {
          element.showCurrentlyStudying = true;
        });
      }
    }
  }

  /// to populate the graduation Details
  _populateGraduationLastTermMenuItemsList(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants.lovCodeMap['LAST_TERM']?.values != null) {
        widget.graduationDetailsList[index].lastTerm =
            populateCommonDataDropdown(
                menuItemsList: Constants.lovCodeMap['LAST_TERM']!.values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  /// populate menu items list
  _populateUniversityMenuItemsList(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
              .lovCodeMap[
                  'GRAD_UNIVERSITY#${widget.graduationDetailsList[index].countryController.text}#UNV']
              ?.values !=
          null) {
        widget.graduationDetailsList[index].university = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap[
                    'GRAD_UNIVERSITY#${widget.graduationDetailsList[index].countryController.text}#UNV']!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        margin: const EdgeInsets.only(bottom: 100),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          if (!widget.displayHighSchool)
            ...[kSmallSpace, kFormHeight],

          /// if selected scholarship matches the condition then high school details section else don't
          (widget.academicCareer != 'SCHL' && widget.academicCareer != 'HCHL')
              ? CustomInformationContainer(
                  title: widget.academicCareer == 'DDS' ? localization.ddsGraduationTitle : localization.graduationDetails,
                  expandedContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.graduationDetailsList.length,
                            itemBuilder: (context, index) {
                              final graduationInfo = widget.graduationDetailsList[index];
                              var graduationRecord = widget.graduationDetailsList.map((element){return element.toJson();}).toList();
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// ****************************************************************************************************************************************************
                                    sectionTitle(title: widget.academicCareer == 'DDS' ? '${localization.ddsGraduationTitle} ${index + 1}' : "${localization.graduationDetails} ${index + 1}"),
                                    kMinorSpace,
                                    sectionBackground(child:
                                        Column(
                                          children: [
                                            if(graduationInfo.levelController.text == markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecord))
                                              Column(children: [
                                                kMinorSpace,
                                                /// title
                                                fieldHeading(
                                                    title: localization.currentlyStudying,
                                                    important: true,
                                                    langProvider: langProvider),

                                                /// ****************************************************************************************************************************************************
                                                /// radiobuttons for yes or no
                                                /// Yes or no : Show round radio
                                                CustomRadioListTile(
                                                  value: true,
                                                  groupValue: graduationInfo.currentlyStudying,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      /// graduationInfo.showCurrentlyStudying = value;
                                                      graduationInfo.currentlyStudying = value;
                                                      _updateShowCurrentlyStudyingWithYes(graduationInfo);
                                                      /// populate LAST term
                                                      _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: index);
                                                    });
                                                  },
                                                  title: localization.yes,
                                                  textStyle: textFieldTextStyle,
                                                ),

                                                /// ****************************************************************************************************************************************************
                                                CustomRadioListTile(
                                                    value: false,
                                                    groupValue: graduationInfo
                                                        .currentlyStudying,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        /// graduationInfo.showCurrentlyStudying = value;
                                                        graduationInfo.currentlyStudying = value;

                                                        /// showing selection option that you are currently doing this course or not
                                                        // _updateShowCurrentlyStudyingWithFalse(graduationInfo);
                                                        graduationInfo.graduationEndDateController.clear();
                                                        graduationInfo.lastTermController.clear();
                                                      });
                                                    },
                                                    title: localization.no,
                                                    textStyle: textFieldTextStyle),
                                              ]),




                                            // graduationInfo.showCurrentlyStudying
                                            //     ? Column(children: [
                                            //         kFormHeight,
                                            //         /// title
                                            //         fieldHeading(
                                            //             title: localization.currentlyStudying,
                                            //             important: true,
                                            //             langProvider: langProvider),
                                            //
                                            //         /// ****************************************************************************************************************************************************
                                            //         /// radiobuttons for yes or no
                                            //         /// Yes or no : Show round radio
                                            //         CustomRadioListTile(
                                            //           value: true,
                                            //           groupValue: graduationInfo.currentlyStudying,
                                            //           onChanged: (value) {
                                            //             setState(() {
                                            //               /// graduationInfo.showCurrentlyStudying = value;
                                            //               graduationInfo.currentlyStudying = value;
                                            //               _updateShowCurrentlyStudyingWithYes(graduationInfo);
                                            //               /// populate LAST term
                                            //               _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: index);
                                            //             });
                                            //           },
                                            //           title: localization.yes,
                                            //           textStyle: textFieldTextStyle,
                                            //         ),
                                            //
                                            //         /// ****************************************************************************************************************************************************
                                            //         CustomRadioListTile(
                                            //             value: false,
                                            //             groupValue: graduationInfo
                                            //                 .currentlyStudying,
                                            //             onChanged: (value) {
                                            //               setState(() {
                                            //                 /// graduationInfo.showCurrentlyStudying = value;
                                            //                 graduationInfo.currentlyStudying = value;
                                            //
                                            //                 /// showing selection option that you are currently doing this course or not
                                            //                 _updateShowCurrentlyStudyingWithFalse(graduationInfo);
                                            //                 graduationInfo.graduationEndDateController.clear();
                                            //                 graduationInfo.lastTermController.clear();
                                            //               });
                                            //             },
                                            //             title: localization.no,
                                            //             textStyle: textFieldTextStyle),
                                            //       ])
                                            //     : showVoid,

                                            /// ****************************************************************************************************************************************************

                                            kFormHeight,




                                            /// last term
                                            graduationInfo.currentlyStudying && graduationInfo.showCurrentlyStudying
                                                ? Column(
                                              children: [
                                                fieldHeading(
                                                    title: localization.lastTerm,
                                                    important: graduationInfo.currentlyStudying,
                                                    langProvider: langProvider),
                                                scholarshipFormDropdown(
                                                  context: context,
                                                  controller: graduationInfo.lastTermController,
                                                  currentFocusNode: graduationInfo.lastTermFocusNode,
                                                  menuItemsList: graduationInfo.lastTerm ?? [],
                                                  hintText: localization.lastTermRequired,
                                                  errorText: graduationInfo.lastTermError,
                                                  onChanged: (value) {
                                                    graduationInfo.lastTermError = null;
                                                    setState(() {
                                                      /// setting the value for address type
                                                      graduationInfo.lastTermController.text = value!;

                                                      ///This thing is creating error: don't know how to fix it:
                                                      Utils.requestFocus(focusNode: graduationInfo.levelFocusNode, context: context);
                                                    });
                                                  },
                                                ),
                                                kFormHeight,
                                              ],
                                            )
                                                : showVoid,

                                            /// ****************************************************************************************************************************************************

                                            (widget.academicCareer == 'UGRD') ? (graduationInfo.currentlyStudying ?

                                            /// copy paste full below code
                                            /// for "UGRD" Specially We are not willing to provide add more graduation information. so we will give static option to fill graduation details for bachelor
                                            _graduationInformation(
                                                index: index,
                                                langProvider: langProvider,
                                                graduationInfo: graduationInfo)
                                                : showVoid)
                                                : _graduationInformation(
                                                index: index,
                                                langProvider: langProvider,
                                                graduationInfo: graduationInfo),

                                            /// ****************************************************************************************************************************************************



                                            (!(widget.scholarshipType == 'INT' && widget.academicCareer == 'UGRD') && index != 0)
                                                ? addRemoveMoreSection(
                                                title: localization.deleteRowGraduation,
                                                add: false,
                                                onChanged: () {
                                                  setState(() {
                                                    _deleteGraduationDetail(index);
                                                  });
                                                })
                                                : showVoid,




                                            /// ****************************************************************************************************************************************************
                                            kMinorSpace,
                                            const Divider(),
                                            kMinorSpace,
                                            /// ****************************************************************************************************************************************************
                                            (!(widget.scholarshipType == 'INT' && widget.academicCareer == 'UGRD') && widget.academicCareer != 'UGRD')
                                                ? addRemoveMoreSection(
                                                title: localization.addRowGraduation,
                                                add: true,
                                                onChanged: () {
                                                  setState(() {
                                                    widget.addGraduation();
                                                  });
                                                })
                                                : showVoid,
                                          ],
                                        )
                                    ),
                                    kFormHeight,

                                  ]);
                            }),

                      ]),
                    ],
                  ))
              : showVoid,
        ])));
  }

  Widget _graduationInformation(
      {required int index,
      required LanguageChangeViewModel langProvider,
      required GraduationInfo graduationInfo}) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        /// ****************************************************************************************************************************************************
        /// graduation level
        /// For student who are not applying ug scholarship will see options as editable to they can edit them to select graduation level
        (index >= 0 && widget.academicCareer != 'UGRD' && widget.academicCareer != 'DDS')
            ?
        /// WE don't need to set level statically
        Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: localization.hsGraduationLevel,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormDropdown(
                    context: context,
                    controller: graduationInfo.levelController,
                    currentFocusNode: graduationInfo.levelFocusNode,
                    menuItemsList: widget.graduationLevelMenuItems ?? [],
                    hintText: localization.hsGraduationLevelWatermark,
                    errorText: graduationInfo.levelError,
                    onChanged: (value) {
                      graduationInfo.levelError = null;

                      setState(() {
                        bool alreadySelected = widget.graduationDetailsList.any((info) {
                          return info != graduationInfo && info.levelController.text == value!;
                        });
                        if (alreadySelected) {
                          /// If duplicate is found, show an error and clear the controller
                          _alertService.showToast(
                            // context: context,
                            message: "تم تحديد هذا المستوى بالفعل. يرجى اختيار واحد آخر.",
                          );
                          graduationInfo.levelError = localization.hsGraduationLevelValidate;
                        } else {
                          /// Assign the value only if it's not already selected
                          graduationInfo.levelController.text = value!;
                          /// Move focus to the next field
                          Utils.requestFocus(focusNode: graduationInfo.countryFocusNode, context: context,);
                        }

                        if((graduationInfo.levelController.text == markHighestGraduationQualification(Constants.referenceValuesGraduation, widget.graduationDetailsList.map((element){return element.toJson();}).toList()))){
                          _updateShowCurrentlyStudyingWithFalse(graduationInfo);
                        }

                      });
                    },
                  )
                ],
              )
            :

            /// for "UGRD" Specially We are not willing to provide add more graduation information. so we will give static option to fill graduation details for bachelor
            /// ****************************************************************************************************************************************************
            /// show static bachelor graduation level
            (index == 0 || widget.academicCareer == 'UGRD')
                ? _showBachelorScholarshipByDefault(
                    index: index,
                    langProvider: langProvider,
                    graduationInfo: graduationInfo)
                : showVoid,

        /// ****************************************************************************************************************************************************

        /// to dropdown for dds
        (index != 0 && widget.academicCareer == 'DDS')
            ? Column(
                children: [
                  fieldHeading(
                      title: localization.ddsGraduationTitle2,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormDropdown(
                    context: context,
                    controller: graduationInfo.levelController,
                    currentFocusNode: graduationInfo.levelFocusNode,
                    menuItemsList: widget.graduationLevelDDSMenuItems ?? [],
                    hintText: localization.hsGraduationLevelWatermark,
                    errorText: graduationInfo.levelError,
                    onChanged: (value) {
                      graduationInfo.levelError = null;

                      setState(() {
                        bool alreadySelected = widget.graduationDetailsList.any((info) {
                          return info != graduationInfo && info.levelController.text == value!;
                        });
                        if (alreadySelected) {
                          /// If duplicate is found, show an error and clear the controller
                          _alertService.showToast(
                            // context: context,
                            message: "تم تحديد هذا المستوى بالفعل. يرجى اختيار واحد آخر.",
                          );
                          graduationInfo.levelError = localization.hsGraduationLevelValidate;
                        } else {
                          /// Assign the value only if it's not already selected
                          graduationInfo.levelController.text = value!;

                          /// Move focus to the next field
                          Utils.requestFocus(focusNode: graduationInfo.countryFocusNode, context: context,
                          );
                        }
                        if((graduationInfo.levelController.text == markHighestGraduationQualification(Constants.referenceValuesGraduation, widget.graduationDetailsList.map((element){return element.toJson();}).toList()))){
                          _updateShowCurrentlyStudyingWithFalse(graduationInfo);
                        }
                      });
                    },
                  ),
                ],
              )
            : showVoid,

        kFormHeight,

        /// ****************************************************************************************************************************************************
        /// country
        fieldHeading(
            title: localization.country, important: true, langProvider: langProvider),
        scholarshipFormDropdown(
          context: context,
          controller: graduationInfo.countryController,
          currentFocusNode: graduationInfo.countryFocusNode,
          menuItemsList: widget.nationalityMenuItemsList ?? [],
          hintText: localization.countryWatermark,
          errorText: graduationInfo.countryError,
          onChanged: (value) {
            graduationInfo.countryError = null;
            setState(() {
              /// setting the value for address type
              graduationInfo.countryController.text = value!;

              /// clearing and reinitializing the dropdowns
              graduationInfo.university?.clear();
              graduationInfo.universityController.clear();
              graduationInfo.otherUniversityController.clear();

              /// populate dropdowns
              _populateUniversityMenuItemsList(langProvider: langProvider, index: index);

              ///This thing is creating error: don't know how to fix it:
              Utils.requestFocus(focusNode: graduationInfo.universityFocusNode, context: context);
            });
          },
        ),

        /// ****************************************************************************************************************************************************
        /// graduation university

        widget.academicCareer != 'DDS'
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: localization.hsUniversity,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormDropdown(
                    context: context,
                    filled:true,
                    fillColor: (graduationInfo.university?.isEmpty ?? false) ? AppColors.lightGrey : Colors.white,
                    controller: graduationInfo.universityController,
                    currentFocusNode: graduationInfo.universityFocusNode,
                    menuItemsList: graduationInfo.university ?? [],
                    hintText: localization.hsUniversityWatermark,
                    errorText: graduationInfo.universityError,
                    onChanged: (value) {
                      graduationInfo.universityError = null;
                      setState(() {
                        /// setting the value for address type
                        graduationInfo.universityController.text = value!;

                        /// clearing and reinitializing the dropdowns
                        graduationInfo.otherUniversityController.clear();

                        Utils.requestFocus(
                            focusNode: graduationInfo.otherUniversityFocusNode,
                            context: context);
                      });
                    },
                  ),
                ],
              )
            : showVoid,

        /// ****************************************************************************************************************************************************
        /// other university
        graduationInfo.universityController.text == 'OTH'
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: widget.academicCareer != 'DDS'
                          ? localization.hsOtherUniversity
                          : localization.ddsUniversity,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormTextField(
                      maxLength: 40,
                      currentFocusNode: graduationInfo.otherUniversityFocusNode,
                      nextFocusNode: graduationInfo.majorFocusNode,
                      controller: graduationInfo.otherUniversityController,
                      hintText:
                          widget.academicCareer != 'DDS'
                              ? localization.hsOtherUniversityWatermark
                              : localization.ddsUniversityWatermark,
                      errorText: graduationInfo.otherUniversityError,
                      onChanged: (value) {
                        if (graduationInfo.otherUniversityFocusNode.hasFocus) {
                          setState(() {
                            graduationInfo.otherUniversityError =
                                ErrorText.getEmptyFieldError(
                                    name: graduationInfo
                                        .otherUniversityController.text,
                                    context: context);
                          });
                        }
                      })
                ],
              )
            : showVoid,

        /// ****************************************************************************************************************************************************
        ///  major
        kFormHeight,
        fieldHeading(title: widget.academicCareer != 'DDS' ? localization.hsMajor : localization.ddsMajor, important: true, langProvider: langProvider),
        scholarshipFormTextField(
            maxLength: 40,
            currentFocusNode: graduationInfo.majorFocusNode,
            nextFocusNode: graduationInfo.cgpaFocusNode,
            controller: graduationInfo.majorController,
            hintText: widget.academicCareer != 'DDS'
                ? localization.hsMajorWatermark
                : localization.ddsMajorWatermark,
            errorText: graduationInfo.majorError,
            onChanged: (value) {
              if (graduationInfo.majorFocusNode.hasFocus) {
                setState(() {
                  graduationInfo.majorError =
                      ErrorText.getEmptyFieldError(
                          name: graduationInfo.majorController.text,
                          context: context);
                });
              }
            }),

        /// ****************************************************************************************************************************************************
        /// cgpa
        fieldHeading(title: localization.cgpa, important: true, langProvider: langProvider),
        scholarshipFormTextField(
            maxLength: 4,
            currentFocusNode: graduationInfo.cgpaFocusNode,
            nextFocusNode: graduationInfo.graduationStartDateFocusNode,
            controller: graduationInfo.cgpaController,
            hintText: localization.cgpaWatermark,
            errorText: graduationInfo.cgpaError,
            onChanged: (value) {
              if (graduationInfo.cgpaFocusNode.hasFocus) {
                setState(() {
                  graduationInfo.cgpaError = ErrorText.getEmptyFieldError(
                      name: graduationInfo.cgpaController.text,
                      context: context);
                });
              }
            }),

        /// ****************************************************************************************************************************************************
        /// start date
        fieldHeading(title: localization.hsGraducationStartDate, important: true, langProvider: langProvider),
        scholarshipFormDateField(
          currentFocusNode: graduationInfo.graduationStartDateFocusNode,
          controller: graduationInfo.graduationStartDateController,
          hintText: localization.hsGraducationStartDateWatermark,
          errorText: graduationInfo.graduationStartDateError,
          onChanged: (value) async {
            setState(() {
              if (graduationInfo.graduationStartDateFocusNode.hasFocus) {
                graduationInfo.graduationStartDateError =
                    ErrorText.getEmptyFieldError(
                        name: graduationInfo.graduationStartDateController.text,
                        context: context);
              }
            });
          },
          onTap: () async {
            /// Clear the error if a date is selected
            graduationInfo.graduationStartDateError = null;
            /// Define the current date as the initial date
            final DateTime initialDate = DateTime.now();

            /// Define the first selectable date (20 years ago from today)
            final DateTime firstDate = initialDate.subtract(const Duration(days: 20 * 365));

            /// Define the last selectable date (current date)
            final DateTime lastDate = initialDate;

            DateTime? date = await showDatePicker(
              context: context,
              barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
              barrierDismissible: false,
              locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
              initialDate: initialDate, // Start at today's date
              firstDate: firstDate,     // Limit to 20 years ago
              lastDate: lastDate,       // Limit to today
            );

            if (date != null) {
              setState(() {
                Utils.requestFocus(
                    focusNode: graduationInfo.graduationEndDateFocusNode,
                    context: context);
                graduationInfo.graduationStartDateController.text =
                    DateFormat('yyyy-MM-dd').format(date).toString();
              });
            }
          },
        ),

        /// ****************************************************************************************************************************************************

        /// start date
        kFormHeight,
        fieldHeading(
            title:  localization.hsGraducationEndDate,
            important: (!graduationInfo.currentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty),
            langProvider: langProvider),
        scholarshipFormDateField(
          filled: true,
          fillColor: !(!graduationInfo.currentlyStudying && graduationInfo.levelController.text.isNotEmpty) ? AppColors.lightGrey : Colors.white,
          currentFocusNode: graduationInfo.graduationEndDateFocusNode,
          controller: graduationInfo.graduationEndDateController,
          hintText: localization.hsGraducationEndDateWatermark,
          errorText: graduationInfo.graduationEndDateError,
          onChanged: (value) async {
            setState(() {
              if (graduationInfo.graduationEndDateFocusNode.hasFocus) {
                graduationInfo.graduationEndDateError =
                    ErrorText.getEmptyFieldError(
                        name: graduationInfo.graduationEndDateController.text,
                        context: context);
              }
            });
          },
          onTap: () async {
            if ((!graduationInfo.currentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty)) {
              /// Clear the error if a date is selected
              graduationInfo.graduationEndDateError = null;

              /// Define the current date as the initial date
              final DateTime initialDate = DateTime.now();

              /// Define the first selectable date (20 years ago from today)
              final DateTime firstDate = initialDate.subtract(const Duration(days: 20 * 365));

              /// Define the last selectable date (current date)
              final DateTime lastDate = initialDate;

              DateTime? date = await showDatePicker(
                context: context,
                barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                barrierDismissible: false,
                locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
                initialDate: initialDate, // Default selection is today's date
                firstDate: firstDate,     // Range starts 20 years ago
                lastDate: lastDate,       // Range ends at today's date
              );

              if (date != null) {
                setState(() {
                  Utils.requestFocus(
                      focusNode: graduationInfo.graduationEndDateFocusNode,
                      context: context);
                  graduationInfo.graduationEndDateController.text =
                      DateFormat('yyyy-MM-dd').format(date).toString();
                });
              }
            }
          },
        ),

        /// ****************************************************************************************************************************************************
        /// questions if dds
        widget.academicCareer == 'DDS'
            ? Column(
                children: [
                  kFormHeight,

                  /// check if dds then only ask question if only dds scholarship
                  fieldHeading(
                      title: localization.ddsGradQuestion,
                      important: true,
                      langProvider: langProvider),

                  /// ****************************************************************************************************************************************************

                  /// Yes or no : Show round radio
                  CustomRadioListTile(
                    value: 'Y',
                    groupValue: widget.havingSponsor,
                    onChanged: (value) {
                      widget.onUpdateHavingSponsor(value); // Notify parent of the change
                    },
                    title: localization.yes,
                    textStyle: textFieldTextStyle,
                  ),

                  /// ****************************************************************************************************************************************************
                  CustomRadioListTile(
                      value: "N",
                      groupValue: widget.havingSponsor,
                      onChanged: (value) {
                        widget.onUpdateHavingSponsor(value); // Notify parent of the change
                        graduationInfo.sponsorShipController.clear(); // Clear controller when "No" is selected
                      },
                      title: localization.no,
                      textStyle: textFieldTextStyle),
                ],
              )
            : showVoid,
        showErrorText(widget.selectSponsorshipErrorText),

        /// ****************************************************************************************************************************************************

        /// SPONSORSHIP
        /// <div class="col-md-3 col-sm-6 col-12"style="display:#{applicationForm.applicationData.havingSponser eq 'Y' or applicationForm.applicationData.acadCareer ne 'DDS'?'block':'none'}">
        ((widget.havingSponsor == 'Y') || widget.academicCareer != 'DDS')
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: localization.hsSponsorship,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormTextField(
                      maxLength: 50,
                      currentFocusNode: graduationInfo.sponsorShipFocusNode,
                      nextFocusNode: graduationInfo.caseStudyTitleFocusNode,
                      controller: graduationInfo.sponsorShipController,
                      hintText: localization.hsSponsorshipWatermark,
                      errorText: graduationInfo.sponsorShipError,
                      onChanged: (value) {
                        if (graduationInfo.sponsorShipFocusNode.hasFocus) {
                          setState(() {
                            graduationInfo.sponsorShipError = ErrorText.getEmptyFieldError(name: graduationInfo.sponsorShipController.text, context: context);
                          });
                        }
                      }),
                ],
              )
            : showVoid,

        /// ****************************************************************************************************************************************************
        /// case study
        (graduationInfo.levelController.text == 'PGRD' || graduationInfo.levelController.text == 'PG' || graduationInfo.levelController.text == 'DDS')
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kFormHeight,
                  /// ****************************************************************************************************************************************************

                  const MyDivider(color: AppColors.lightGrey),
                  kFormHeight,

                  /// ****************************************************************************************************************************************************

                  sectionTitle(title: localization.caseStudy),

                  /// ****************************************************************************************************************************************************

                  kFormHeight,
                  fieldHeading(
                      title:localization.caseStudyTitle,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormTextField(
                      maxLength: 50,
                      currentFocusNode: graduationInfo.caseStudyTitleFocusNode,
                      nextFocusNode: graduationInfo.caseStudyStartYearFocusNode,
                      controller: graduationInfo.caseStudyTitleController,
                      hintText: localization.caseStudyTitleWatermark,
                      errorText: graduationInfo.caseStudyTitleError,
                      onChanged: (value) {
                        if (graduationInfo.caseStudyTitleFocusNode.hasFocus) {
                          setState(() {
                            graduationInfo.caseStudyTitleError =
                                ErrorText.getNameArabicEnglishValidationError(
                                    name: graduationInfo
                                        .caseStudyTitleController.text,
                                    context: context);
                          });
                        }
                      }),

                  /// ****************************************************************************************************************************************************
                  fieldHeading(
                      title: localization.caseStudyStartYear,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormDropdown(
                    context: context,
                    controller: graduationInfo.caseStudyStartYearController,
                    currentFocusNode:
                        graduationInfo.caseStudyStartYearFocusNode,
                    menuItemsList: widget.caseStudyYearDropdownMenuItems ?? [],
                    hintText: localization.caseStudyStartYearWatermark,
                    errorText: graduationInfo.caseStudyStartYearError,
                    onChanged: (value) {
                      graduationInfo.caseStudyStartYearError = null;
                      setState(() {
                        /// setting the value for address type
                        graduationInfo.caseStudyStartYearController.text = value!;

                        Utils.requestFocus(focusNode: graduationInfo.caseStudyDescriptionFocusNode, context: context);
                      });
                    },
                  ),

                  /// ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: localization.caseStudyDescription,
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormTextField(
                      maxLength: 500,
                      maxLines: 5,
                      currentFocusNode: graduationInfo.caseStudyDescriptionFocusNode,
                      controller: graduationInfo.caseStudyDescriptionController,
                      hintText: localization.caseStudyDescriptionWatermark,
                      errorText: graduationInfo.caseStudyDescriptionError,
                      onChanged: (value) {
                        if (graduationInfo.caseStudyDescriptionFocusNode.hasFocus) {
                          setState(() {
                            graduationInfo.caseStudyDescriptionError = ErrorText.getNameArabicEnglishValidationError(name: graduationInfo.caseStudyDescriptionController.text, context: context);
                          });
                        }
                      }),
                ],
              )
            : showVoid,

        /// ****************************************************************************************************************************************************
      ],
    );
  }

  /// this is made separate because we have to show bachelor by default for graduation level at index 0
  Widget _showBachelorScholarshipByDefault(
      {required int index,
      required LanguageChangeViewModel langProvider,
      required GraduationInfo graduationInfo}) {
    final localization = AppLocalizations.of(context)!;
    /// setting bachelor by default
    graduationInfo.levelController.text = 'UG';
    return Column(
      children: [
        fieldHeading(
            title: localization.hsGraduationLevel,
            important: true,
            langProvider: langProvider),
        scholarshipFormDropdown(
          context: context,
          readOnly: true,
          filled: true,
          controller: graduationInfo.levelController,
          currentFocusNode: graduationInfo.levelFocusNode,
          menuItemsList: widget.graduationLevelMenuItems ?? [],
          hintText: localization.hsGraduationLevelWatermark,
          errorText: graduationInfo.levelError,
          onChanged: (value) {
            graduationInfo.levelError = null;
            setState(() {
              /// setting the value for address type
              graduationInfo.levelController.text = value!;

              ///This thing is creating error: don't know how to fix it:
              Utils.requestFocus(focusNode: graduationInfo.countryFocusNode, context: context);
            });
          },
        ),
      ],
    );
  }
}
