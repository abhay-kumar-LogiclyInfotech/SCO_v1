import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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


class GraduationInformationView extends StatefulWidget {

  dynamic graduationDetailsList;
  dynamic selectedScholarship;
  final bool displayHighSchool;
  dynamic havingSponsor;
  final Function(dynamic langProvider) draftPrevNextButtons;
  dynamic nationalityMenuItemsList;
  dynamic Function() addGraduation;
  dynamic graduationLevelMenuItems;
  dynamic  graduationLevelDDSMenuItems;
  dynamic  caseStudyYearDropdownMenuItems;

  GraduationInformationView({super.key, required this.graduationDetailsList,required this.graduationLevelMenuItems,required this.caseStudyYearDropdownMenuItems,required this.graduationLevelDDSMenuItems,required this.selectedScholarship,required this.displayHighSchool,required this.draftPrevNextButtons,required this.havingSponsor,this.nationalityMenuItemsList,required this.addGraduation});

  @override
  State<GraduationInformationView> createState() => _GraduationInformationViewState();
}




class _GraduationInformationViewState extends State<GraduationInformationView> with MediaQueryMixin {
  
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
    print(widget.graduationDetailsList.length.toString());
    if (widget.graduationDetailsList.length == 1) {
      print(widget.graduationDetailsList.length.toString());
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
  _populateGraduationLastTermMenuItemsList({required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants.lovCodeMap['LAST_TERM']?.values != null) {
        widget.graduationDetailsList[index].lastTerm = populateCommonDataDropdown(
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
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
              if(!widget.displayHighSchool)  widget.draftPrevNextButtons(langProvider),
              kFormHeight,
              /// if selected scholarship matches the condition then high school details section else don't
              (widget.selectedScholarship?.acadmicCareer != 'SCHL' &&
                  widget.selectedScholarship?.acadmicCareer != 'HCHL')
                  ? CustomInformationContainer(
                  title: widget.selectedScholarship?.acadmicCareer == 'DDS'
                      ? 'dds.graduation.title'
                      : "Graduation Details",
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
                              final graduationInfo =
                              widget.graduationDetailsList[index];
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// ****************************************************************************************************************************************************

                                    sectionTitle(
                                        title: widget.selectedScholarship
                                            ?.acadmicCareer ==
                                            'DDS'
                                            ? 'dds.graduation.title ${index + 1}'
                                            : "Graduation Detail ${index + 1}"),

                                    graduationInfo.showCurrentlyStudying
                                        ? Column(children: [
                                      kFormHeight,
                                      /// title
                                      fieldHeading(
                                          title: "Currently Studying",
                                          important: true,
                                          langProvider: langProvider),

                                      /// ****************************************************************************************************************************************************
                                      /// radiobuttons for yes or no
                                      /// Yes or no : Show round radio
                                      CustomRadioListTile(
                                        value: true,
                                        groupValue: graduationInfo
                                            .currentlyStudying,
                                        onChanged: (value) {
                                          setState(() {
                                            /// graduationInfo.showCurrentlyStudying = value;
                                            graduationInfo
                                                .currentlyStudying =
                                                value;
                                            _updateShowCurrentlyStudyingWithYes(
                                                graduationInfo);
                                            /// populate LAST term
                                            _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: index);
                                          });
                                        },
                                        title: "Yes",
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
                                              graduationInfo
                                                  .currentlyStudying =
                                                  value;
                                              /// showing selection option that you are currently doing this course or not
                                              _updateShowCurrentlyStudyingWithFalse(
                                                  graduationInfo);
                                              graduationInfo
                                                  .graduationEndDateController
                                                  .clear();
                                              graduationInfo
                                                  .lastTermController
                                                  .clear();

                                              /// clear the relatives list
                                              /// _relativeInfoList.clear();
                                            });
                                          },
                                          title: "No",
                                          textStyle: textFieldTextStyle),
                                    ])
                                        : showVoid,
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,

                                    /// last term
                                    graduationInfo.currentlyStudying &&
                                        graduationInfo.showCurrentlyStudying
                                        ? Column(
                                      children: [
                                        fieldHeading(
                                            title: "Last Term",
                                            important: true,
                                            langProvider: langProvider),
                                        scholarshipFormDropdown(context:context,
                                          controller: graduationInfo
                                              .lastTermController,
                                          currentFocusNode: graduationInfo
                                              .lastTermFocusNode,
                                          menuItemsList:
                                          graduationInfo.lastTerm ??
                                              [],
                                          hintText: "Select Last Term",
                                          errorText: graduationInfo
                                              .lastTermError,
                                          onChanged: (value) {
                                            graduationInfo.lastTermError =
                                            null;
                                            setState(() {
                                              /// setting the value for address type
                                              graduationInfo
                                                  .lastTermController
                                                  .text = value!;

                                              ///This thing is creating error: don't know how to fix it:
                                              Utils.requestFocus(
                                                  focusNode:
                                                  graduationInfo
                                                      .levelFocusNode,
                                                  context: context);
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                        : showVoid,
                                    /// ****************************************************************************************************************************************************

                                    (widget.selectedScholarship?.acadmicCareer ==
                                        'UGRD')
                                        ? (graduationInfo.currentlyStudying
                                        ? /// copy paste full below code
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

                                    (!(widget.selectedScholarship?.scholarshipType ==
                                        'INT' &&
                                        widget.selectedScholarship
                                            ?.acadmicCareer ==
                                            'UGRD') &&
                                        index != 0)
                                        ? addRemoveMoreSection(
                                        title: "Delete",
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            _deleteGraduationDetail(index);
                                          });
                                        })
                                        : showVoid,

                                    /// ****************************************************************************************************************************************************
                                    kFormHeight,
                                    const MyDivider(
                                      color: AppColors.lightGrey,
                                    ),
                                    kFormHeight,

                                    /// ****************************************************************************************************************************************************
                                  ]);
                            }),
                        (!(widget.selectedScholarship?.scholarshipType == 'INT' &&
                            widget.selectedScholarship?.acadmicCareer ==
                                'UGRD') &&
                            widget.selectedScholarship?.acadmicCareer != 'UGRD')
                            ? addRemoveMoreSection(
                            title: "Add",
                            add: true,
                            onChanged: () {
                              setState(() {
                                widget.addGraduation();
                              });
                            })
                            : showVoid,
                      ]),
                    ],
                  ))
                  : showVoid,
              widget.draftPrevNextButtons(langProvider)
            ])));
  }


  Widget _graduationInformation(
      {required int index,
        required LanguageChangeViewModel langProvider,
        required GraduationInfo graduationInfo}) {
    return Column(
      children: [
        /// ****************************************************************************************************************************************************
        /// graduation level
        (index > 0 &&
            widget.selectedScholarship?.acadmicCareer != 'UGRD' &&
            widget.selectedScholarship?.acadmicCareer != 'DDS')
            ? Column(
          children: [
            kFormHeight,
            fieldHeading(
                title: "Graduation Level",
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(context:context,
              controller: graduationInfo.levelController,
              currentFocusNode: graduationInfo.levelFocusNode,
              menuItemsList: widget.graduationLevelMenuItems ?? [],
              hintText: "Select Graduation Level",
              errorText: graduationInfo.levelError,
              onChanged: (value) {
                graduationInfo.levelError = null;

                setState(() {
                  bool alreadySelected =
                  widget.graduationDetailsList.any((info) {
                    return info != graduationInfo &&
                        info.levelController.text == value!;
                  });
                  if (alreadySelected) {
                    /// If duplicate is found, show an error and clear the controller
                    _alertService.showToast(
                      context: context,
                      message:
                      "This level has already been selected. Please choose another one.",
                    );
                    graduationInfo.levelError = "Please choose another";
                  } else {
                    /// Assign the value only if it's not already selected
                    graduationInfo.levelController.text = value!;
                    /// Move focus to the next field
                    Utils.requestFocus(
                      focusNode: graduationInfo.countryFocusNode,
                      context: context,
                    );
                  }
                });
              },
            )
          ],
        )
            : /// for UGRD Specially

        /// ****************************************************************************************************************************************************
        /// show static bachelor graduation level
        (index == 0 || widget.selectedScholarship?.acadmicCareer == 'UGRD')
            ? _showBachelorScholarshipByDefault(
            index: index,
            langProvider: langProvider,
            graduationInfo: graduationInfo)
            : showVoid,

        /// ****************************************************************************************************************************************************

        /// to dropdown for dds
        (index != 0 && widget.selectedScholarship?.acadmicCareer == 'DDS')
            ? Column(
          children: [
            fieldHeading(
                title: "DDS Graduation Level",
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(context:context,
              controller: graduationInfo.levelController,
              currentFocusNode: graduationInfo.levelFocusNode,
              menuItemsList: widget.graduationLevelDDSMenuItems ?? [],
              hintText: "Select DDS Graduation Level",
              errorText: graduationInfo.levelError,
              onChanged: (value) {
                graduationInfo.levelError = null;

                setState(() {
                  bool alreadySelected =
                  widget.graduationDetailsList.any((info) {
                    return info != graduationInfo &&
                        info.levelController.text == value!;
                  });
                  if (alreadySelected) {
                    /// If duplicate is found, show an error and clear the controller
                    _alertService.showToast(
                      context: context,
                      message:
                      "This level has already been selected. Please choose another one.",
                    );
                    graduationInfo.levelError = "Please choose another";
                  } else {
                    /// Assign the value only if it's not already selected
                    graduationInfo.levelController.text = value!;
                    /// Move focus to the next field
                    Utils.requestFocus(
                      focusNode: graduationInfo.countryFocusNode,
                      context: context,
                    );
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
            title: "Country", important: true, langProvider: langProvider),
        scholarshipFormDropdown(context:context,
          controller: graduationInfo.countryController,
          currentFocusNode: graduationInfo.countryFocusNode,
          menuItemsList: widget.nationalityMenuItemsList ?? [],
          hintText: "Select Country",
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
              Utils.requestFocus(
                  focusNode: graduationInfo.universityFocusNode,
                  context: context);
            });
          },
        ),

        /// ****************************************************************************************************************************************************
        /// graduation university

        widget.selectedScholarship?.acadmicCareer != 'DDS'
            ? Column(
          children: [
            kFormHeight,
            fieldHeading(
                title: "Graduation University",
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(context:context,
              controller: graduationInfo.universityController,
              currentFocusNode: graduationInfo.universityFocusNode,
              menuItemsList: graduationInfo.university ?? [],
              hintText: "Select Grad University",
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
                title: widget.selectedScholarship?.acadmicCareer != 'DDS'
                    ? "Other University"
                    : 'dds.university',
                important: true,
                langProvider: langProvider),
            scholarshipFormTextField(
                maxLength: 40,
                currentFocusNode: graduationInfo.otherUniversityFocusNode,
                nextFocusNode: graduationInfo.majorFocusNode,
                controller: graduationInfo.otherUniversityController,
                hintText: widget.selectedScholarship?.acadmicCareer != 'DDS'
                    ? "Enter Other University"
                    : 'Enter dds.university',
                errorText: graduationInfo.otherUniversityError,
                onChanged: (value) {
                  if (graduationInfo.otherUniversityFocusNode.hasFocus) {
                    setState(() {
                      graduationInfo.otherUniversityError =
                          ErrorText.getNameArabicEnglishValidationError(
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
        fieldHeading(
            title: widget.selectedScholarship?.acadmicCareer != 'DDS'
                ? 'hs.major'
                : 'dds.major',
            important: true,
            langProvider: langProvider),
        scholarshipFormTextField(
            maxLength: 40,
            currentFocusNode: graduationInfo.majorFocusNode,
            nextFocusNode: graduationInfo.cgpaFocusNode,
            controller: graduationInfo.majorController,
            hintText: widget.selectedScholarship?.acadmicCareer != 'DDS'
                ? 'Enter hs.major'
                : 'Enter dds.major',
            errorText: graduationInfo.majorError,
            onChanged: (value) {
              if (graduationInfo.majorFocusNode.hasFocus) {
                setState(() {
                  graduationInfo.majorError =
                      ErrorText.getNameArabicEnglishValidationError(
                          name: graduationInfo.majorController.text,
                          context: context);
                });
              }
            }),
        /// ****************************************************************************************************************************************************
        /// cgpa
        fieldHeading(
            title: "CGPA", important: true, langProvider: langProvider),
        scholarshipFormTextField(
            maxLength: 4,
            currentFocusNode: graduationInfo.cgpaFocusNode,
            nextFocusNode: graduationInfo.graduationStartDateFocusNode,
            controller: graduationInfo.cgpaController,
            hintText: 'Enter CGPA',
            errorText: graduationInfo.cgpaError,
            onChanged: (value) {
              if (graduationInfo.cgpaFocusNode.hasFocus) {
                setState(() {
                  graduationInfo.cgpaError = ErrorText.getCGPAValidationError(
                      cgpa: graduationInfo.cgpaController.text,
                      context: context);
                });
              }
            }),

        /// ****************************************************************************************************************************************************
        /// start date
        fieldHeading(
            title: "Start Date", important: true, langProvider: langProvider),
        scholarshipFormDateField(
          currentFocusNode: graduationInfo.graduationStartDateFocusNode,
          controller: graduationInfo.graduationStartDateController,
          hintText: "Select Start Date",
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

            /// Define the initial date (e.g., today's date)
            final DateTime initialDate = DateTime.now();

            /// Define the start date (100 years ago from today)
            final DateTime firstDate =
            DateTime.now().subtract(const Duration(days: 100 * 365));

            DateTime? date = await showDatePicker(
              context: context,
              barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
              barrierDismissible: false,
              locale:
              Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .appLocale,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: initialDate,
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
            title: "End Date",
            important: (!graduationInfo.currentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty),
            langProvider: langProvider),
        scholarshipFormDateField(
          filled: !(!graduationInfo.currentlyStudying &&
              graduationInfo.levelController.text.isNotEmpty),
          currentFocusNode: graduationInfo.graduationEndDateFocusNode,
          controller: graduationInfo.graduationEndDateController,
          hintText: "Select End Date",
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

              /// Define the initial date (e.g., today's date)
              final DateTime initialDate = DateTime.now();

              /// Define the start date (100 years ago from today)
              final DateTime firstDate =
              DateTime.now().subtract(const Duration(days: 100 * 365));

              DateTime? date = await showDatePicker(
                context: context,
                barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                barrierDismissible: false,
                locale:
                Provider.of<LanguageChangeViewModel>(context, listen: false)
                    .appLocale,
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: initialDate,
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
        widget.selectedScholarship?.acadmicCareer == 'DDS'
            ? Column(
          children: [
            kFormHeight,

            /// check if dds then only ask question if only dds scholarship
            fieldHeading(
                title:
                "Are you currently receiving a scholarship or grant from another party?",
                important: true,
                langProvider: langProvider),

            /// ****************************************************************************************************************************************************

            /// Yes or no : Show round radio
            CustomRadioListTile(
              value: 'Y',
              groupValue: widget.havingSponsor,
              onChanged: (value) {
                setState(() {
                  widget.havingSponsor = value;
                });
              },
              title: "Yes",
              textStyle: textFieldTextStyle,
            ),

            /// ****************************************************************************************************************************************************
            CustomRadioListTile(
                value: "N",
                groupValue: widget.havingSponsor,
                onChanged: (value) {
                  setState(() {
                    widget.havingSponsor = value;
                    /// clear the relatives list
                    graduationInfo.sponsorShipController.clear();
                  });
                },
                title: "No",
                textStyle: textFieldTextStyle),
          ],
        )
            : showVoid,

        /// ****************************************************************************************************************************************************

        /// SPONSORSHIP
        /// TODO: Need havingSponsor  key from fetch all scholarships
        ((widget.havingSponsor == 'Y') || widget.selectedScholarship?.acadmicCareer != 'DDS')
            ? Column(
          children: [
            kFormHeight,
            fieldHeading(
                title: "Sponsorship",
                important: true,
                langProvider: langProvider),
            scholarshipFormTextField(
                maxLength: 50,
                currentFocusNode: graduationInfo.sponsorShipFocusNode,
                nextFocusNode: graduationInfo.caseStudyTitleFocusNode,
                controller: graduationInfo.sponsorShipController,
                hintText: 'Enter Sponsorship',
                errorText: graduationInfo.sponsorShipError,
                onChanged: (value) {
                  if (graduationInfo.sponsorShipFocusNode.hasFocus) {
                    setState(() {
                      graduationInfo.sponsorShipError =
                          ErrorText.getEmptyFieldError(
                              name: graduationInfo
                                  .sponsorShipController.text,
                              context: context);
                    });
                  }
                }),
          ],
        )
            : showVoid,

        /// ****************************************************************************************************************************************************
        /// case study
        (graduationInfo.levelController.text == 'PGRD' ||
            graduationInfo.levelController.text == 'PG' ||
            graduationInfo.levelController.text == 'DDS')
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kFormHeight,
            /// ****************************************************************************************************************************************************

            const MyDivider(
              color: AppColors.lightGrey,
            ),
            kFormHeight,
            /// ****************************************************************************************************************************************************

            sectionTitle(title: "Case Study"),
            /// ****************************************************************************************************************************************************

            kFormHeight,
            fieldHeading(
                title: "Title",
                important: true,
                langProvider: langProvider),
            scholarshipFormTextField(
                maxLength: 50,
                currentFocusNode: graduationInfo.caseStudyTitleFocusNode,
                nextFocusNode: graduationInfo.caseStudyStartYearFocusNode,
                controller: graduationInfo.caseStudyTitleController,
                hintText: 'Enter Case Study Title',
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
                title: "Start Year",
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(context:context,
              controller: graduationInfo.caseStudyStartYearController,
              currentFocusNode:
              graduationInfo.caseStudyStartYearFocusNode,
              menuItemsList: widget.caseStudyYearDropdownMenuItems ?? [],
              hintText: "Select Start Year",
              errorText: graduationInfo.caseStudyStartYearError,
              onChanged: (value) {
                graduationInfo.caseStudyStartYearError = null;
                setState(() {
                  /// setting the value for address type
                  graduationInfo.caseStudyStartYearController.text =
                  value!;

                  Utils.requestFocus(
                      focusNode:
                      graduationInfo.caseStudyDescriptionFocusNode,
                      context: context);
                });
              },
            ),
            /// ****************************************************************************************************************************************************
            kFormHeight,
            fieldHeading(
                title: "Case Study Details",
                important: true,
                langProvider: langProvider),
            scholarshipFormTextField(
                maxLength: 500,
                maxLines: 5,
                currentFocusNode:
                graduationInfo.caseStudyDescriptionFocusNode,
                controller: graduationInfo.caseStudyDescriptionController,
                hintText: 'Enter Case Study Description',
                errorText: graduationInfo.caseStudyDescriptionError,
                onChanged: (value) {
                  if (graduationInfo
                      .caseStudyDescriptionFocusNode.hasFocus) {
                    setState(() {
                      graduationInfo.caseStudyDescriptionError =
                          ErrorText.getNameArabicEnglishValidationError(
                              name: graduationInfo
                                  .caseStudyDescriptionController.text,
                              context: context);
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


  /// this is made separate because we have to show bachelor by default for graduation level at index 1
  Widget _showBachelorScholarshipByDefault(
      {required int index,
        required LanguageChangeViewModel langProvider,
        required GraduationInfo graduationInfo}) {
    /// setting bachelor by default
    graduationInfo.levelController.text = 'UG';
    return Column(
      children: [
        fieldHeading(
            title: "Graduation Level",
            important: true,
            langProvider: langProvider),
        scholarshipFormDropdown(context:context,
          readOnly: true,
          filled: true,
          controller: graduationInfo.levelController,
          currentFocusNode: graduationInfo.levelFocusNode,
          menuItemsList: widget.graduationLevelMenuItems ?? [],
          hintText: "Select Graduation Level",
          errorText: graduationInfo.levelError,
          onChanged: (value) {
            graduationInfo.levelError = null;
            setState(() {
              /// setting the value for address type
              graduationInfo.levelController.text = value!;

              ///This thing is creating error: don't know how to fix it:
              Utils.requestFocus(
                  focusNode: graduationInfo.countryFocusNode, context: context);
            });
          },
        ),
      ],
    );
  }
}

