import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/FillScholarshipFormModels.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../form_view_Utils.dart';

class HighSchoolView extends StatefulWidget {
  final  List<HighSchool> highSchoolList;
  final String admitType;
  final String academicCareer;
  final Widget draftPrevNextButtons;
  
  const HighSchoolView({super.key,required this.highSchoolList,required this.admitType, required this.academicCareer,required this.draftPrevNextButtons});

  @override
  State<HighSchoolView> createState() => _HighSchoolViewState();
}

class _HighSchoolViewState extends State<HighSchoolView> with MediaQueryMixin {

  List _highSchoolLevelMenuItemsList = [];
  List _highSchoolTypeMenuItemsList = [];
  List _highSchoolSubjectsItemsList = [];
  List<DropdownMenuItem> _nationalityMenuItemsList = [];
  String admitType = '';
  String academicCareer = '';
  
  late AlertServices _alertServices;


  /// to populate the states based on high school country
  _populateHighSchoolStateDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap[
      'STATE#${widget.highSchoolList[index].hsCountryController.text}']
          ?.values !=
          null) {
        widget.highSchoolList[index].schoolStateDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'STATE#${widget.highSchoolList[index].hsCountryController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  _populateHighSchoolNameDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap[
      'SCHOOL_CD#${widget.highSchoolList[index].hsStateController.text}']
          ?.values !=
          null) {
        widget.highSchoolList[index].schoolNameDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'SCHOOL_CD#${widget.highSchoolList[index].hsStateController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  _populateHighSchoolCurriculumTypeDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap[
      'CURRICULM_TYPE#${widget.highSchoolList[index].hsTypeController.text}']
          ?.values !=
          null) {
        widget.highSchoolList[index].schoolCurriculumTypeDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'CURRICULM_TYPE#${widget.highSchoolList[index].hsTypeController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  _addHighSchool() {
    setState(() {
      widget.highSchoolList.add(HighSchool(
          hsLevelController: TextEditingController(),
          hsNameController: TextEditingController(),
          hsCountryController: TextEditingController(),
          hsStateController: TextEditingController(),
          yearOfPassingController: TextEditingController(),
          hsTypeController: TextEditingController(),
          curriculumTypeController: TextEditingController(),
          curriculumAverageController: TextEditingController(),
          otherHsNameController: TextEditingController(),
          passingYearController: TextEditingController(),
          maxDateController: TextEditingController(),
          disableStateController: TextEditingController(),
          isNewController: TextEditingController(text: "true"),
          highestQualificationController: TextEditingController(text: 'false'),
          hsLevelFocusNode: FocusNode(),
          hsNameFocusNode: FocusNode(),
          hsCountryFocusNode: FocusNode(),
          hsStateFocusNode: FocusNode(),
          yearOfPassingFocusNode: FocusNode(),
          hsTypeFocusNode: FocusNode(),
          curriculumTypeFocusNode: FocusNode(),
          curriculumAverageFocusNode: FocusNode(),
          otherHsNameFocusNode: FocusNode(),
          passingYearFocusNode: FocusNode(),
          maxDateFocusNode: FocusNode(),
          hsDetails: _highSchoolSubjectsItemsList
              .where((element) => !element.code
              .startsWith('OTH')) /// Filter for regular subjects
              .map((element) => HSDetails(
            subjectTypeController: TextEditingController(text: element.code.toString()),
            otherSubjectNameController: TextEditingController(),
            gradeController: TextEditingController(),
            subjectTypeFocusNode: FocusNode(),
            otherSubjectNameFocusNode: FocusNode(),
            gradeFocusNode: FocusNode(),
            required:  element.required == true || element.required == 'true',

          ))
              .toList(),
          otherHSDetails: _highSchoolSubjectsItemsList
              .where((element) =>
              element.code.startsWith('OTH')) /// Filter for regular subjects
              .map(
                (element) => HSDetails(
              subjectTypeController: TextEditingController(text: element.code.toString()),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
              required:  element.required == true || element.required == 'true',
            ),
          )
              .toList(),
          schoolStateDropdownMenuItems: [],
          schoolNameDropdownMenuItems: [],
          schoolTypeDropdownMenuItems: [],
          schoolCurriculumTypeDropdownMenuItems: []));
    });
  }

  _removeHighSchool(int index) {
    if (index >= 2 && index < widget.highSchoolList.length) {
      setState(() {
        final highSchool = widget.highSchoolList[index];

        /// Dispose controllers and focus nodes of HSDetails
        for (var detail in highSchool.hsDetails) {
          detail.subjectTypeController.dispose();
          detail.gradeController.dispose();
          detail.subjectTypeFocusNode.dispose();
          detail.gradeFocusNode.dispose();
        }

        /// Dispose controllers and focus nodes of otherHSDetails
        for (var detail in highSchool.otherHSDetails) {
          detail.subjectTypeController.dispose();
          detail.gradeController.dispose();
          detail.otherSubjectNameController?.dispose();
          detail.subjectTypeFocusNode.dispose();
          detail.gradeFocusNode.dispose();
          detail.otherSubjectNameFocusNode?.dispose();
        }

        /// Dispose main HighSchool controllers and focus nodes
        highSchool.hsLevelController?.dispose();
        highSchool.hsNameController?.dispose();
        highSchool.hsCountryController.dispose();
        highSchool.hsStateController.dispose();
        highSchool.yearOfPassingController.dispose();
        highSchool.hsTypeController.dispose();
        highSchool.curriculumTypeController.dispose();
        highSchool.curriculumAverageController.dispose();
        highSchool.otherHsNameController.dispose();
        highSchool.passingYearController.dispose();
        highSchool.maxDateController.dispose();
        highSchool.disableStateController.dispose();
        highSchool.isNewController.dispose();
        highSchool.highestQualificationController.dispose();

        highSchool.hsLevelFocusNode.dispose();
        highSchool.hsNameFocusNode.dispose();
        highSchool.hsCountryFocusNode.dispose();
        highSchool.hsStateFocusNode.dispose();
        highSchool.yearOfPassingFocusNode.dispose();
        highSchool.hsTypeFocusNode.dispose();
        highSchool.curriculumTypeFocusNode.dispose();
        highSchool.curriculumAverageFocusNode.dispose();
        highSchool.otherHsNameFocusNode.dispose();
        highSchool.passingYearFocusNode.dispose();
        highSchool.maxDateFocusNode.dispose();

        highSchool.schoolStateDropdownMenuItems?.clear();
        highSchool.schoolNameDropdownMenuItems?.clear();
        highSchool.schoolTypeDropdownMenuItems?.clear();
        highSchool.schoolCurriculumTypeDropdownMenuItems?.clear();

        widget.highSchoolList.removeAt(index);
      });
    } else {
      // print("Cannot remove items at index less than 2.");
    }
  }
  
  
  
  @override
  void initState() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
    
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    /// Check and populate dropdowns only if the values exist
    if (Constants.lovCodeMap['COUNTRY']?.values != null) {
      _nationalityMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }
    
    if (Constants.lovCodeMap['HIGH_SCHOOL_LEVEL']?.values != null) {
      _highSchoolLevelMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['HIGH_SCHOOL_LEVEL']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    if (Constants.lovCodeMap['HIGH_SCHOOL_TYPE']?.values != null) {
      _highSchoolTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['HIGH_SCHOOL_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    if (Constants.lovCodeMap['SUBJECT']?.values != null) {
      _highSchoolSubjectsItemsList = populateUniqueSimpleValuesFromLOV(
          menuItemsList: Constants.lovCodeMap['SUBJECT']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }
    
    setState(() {});
    super.initState();
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
              /// kFormHeight,

              /// *--------------------------------------------------------------- High School Details Section Start ----------------------------------------------------------------------------*
              CustomInformationContainer(
                  title: localization.highSchoolDetails,
                  expandedContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// list view of high schools: this will include the information of the school like school level,country, ...., subjects details
                      Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.highSchoolList.length,
                            itemBuilder: (context, index) {
                              final highSchoolInfo = widget.highSchoolList[index];
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// ****************************************************************************************************************************************************

                                    sectionTitle(title: "${localization.highSchoolDetails} ${index + 1}"),
                                    kFormHeight,
                                    /// title
                                    fieldHeading(
                                        title: localization.hsLevel,
                                        important: true,
                                        langProvider: langProvider),

                                    /// dropdowns on the basis of selected one
                                    if (((admitType == 'MOS' ||
                                        admitType == 'MOP') &&
                                        index == 1) ||
                                        index <= 1) /// Todo: before <=2 did by me is <=1
                                      Column(children: [
                                        scholarshipFormDropdown(context:context,
                                          readOnly: true,
                                          filled: true,
                                          controller:
                                          highSchoolInfo.hsLevelController,
                                          currentFocusNode:
                                          highSchoolInfo.hsLevelFocusNode,
                                          menuItemsList: _highSchoolLevelMenuItemsList,
                                          hintText: localization.hsLevelWatermark,
                                          errorText: highSchoolInfo.hsLevelError,
                                          onChanged: (value) {
                                            highSchoolInfo.hsLevelError = null;
                                            setState(() {
                                              /// setting the value for address type
                                              highSchoolInfo.hsLevelController.text = value!;


                                              ///This thing is creating error: don't know how to fix it:
                                              Utils.requestFocus(focusNode: highSchoolInfo.hsCountryFocusNode, context: context);
                                            });
                                          },
                                        )
                                      ]),
                                    // if (((admitType == 'MOS' || admitType == 'MOP') && index > 0) || (_selectedScholarship?.acadmicCareer == 'HCHL' && index >= 1) || index >= 2)
                                    if (((admitType == 'MOS' ||
                                        admitType == 'MOP') &&
                                        index > 0) ||
                                        (academicCareer == 'HCHL' &&
                                            index >= 2) ||
                                        index >= 2)
                                      scholarshipFormDropdown(context:context,
                                        controller: highSchoolInfo.hsLevelController,
                                        currentFocusNode: highSchoolInfo.hsLevelFocusNode,
                                        menuItemsList: _highSchoolLevelMenuItemsList,
                                        hintText:localization.hsLevelWatermark,
                                        errorText: highSchoolInfo.hsLevelError,
                                        onChanged: (value) {highSchoolInfo.hsLevelError = null;
                                        setState(() {
                                          bool alreadySelected = widget.highSchoolList.any((info) {
                                            return info != highSchoolInfo && info.hsLevelController.text == value!;
                                          });
                                          if (alreadySelected) {
                                            /// If duplicate is found, show an error and clear the controller
                                            _alertServices.showToast(
                                              // context: context,
                                              message: "This level has already been selected. Please choose another one.",
                                            );
                                            highSchoolInfo.hsLevelError = localization.hsTypeValidate;
                                          } else {
                                            /// Assign the value only if it's not already selected
                                            highSchoolInfo.hsLevelController.text = value!;
                                            /// Move focus to the next field
                                            Utils.requestFocus(focusNode: highSchoolInfo.hsCountryFocusNode, context: context,
                                            );
                                          }
                                        });
                                        },
                                      ),
                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************

                                    /// country
                                    fieldHeading(
                                        title: localization.schoolCountry,
                                        important: true,
                                        langProvider: langProvider),

                                    scholarshipFormDropdown(context:context,
                                      controller: highSchoolInfo.hsCountryController,
                                      currentFocusNode: highSchoolInfo.hsCountryFocusNode,
                                      menuItemsList: _nationalityMenuItemsList,
                                      hintText: localization.countryWatermark,
                                      errorText: highSchoolInfo.hsCountryError,
                                      onChanged: (value) {
                                        highSchoolInfo.hsCountryError = null;
                                        highSchoolInfo.hsStateError = null;
                                        highSchoolInfo.hsNameError = null;
                                        setState(() {
                                          /// setting the value for address type
                                          highSchoolInfo.hsCountryController.text = value!;
                                          highSchoolInfo.hsStateController.clear();
                                          highSchoolInfo.hsNameController.clear();
                                          highSchoolInfo.schoolStateDropdownMenuItems?.clear();
                                          highSchoolInfo.schoolNameDropdownMenuItems?.clear();
                                          /// populating the high school state dropdown
                                          _populateHighSchoolStateDropdown(langProvider: langProvider, index: index);

                                          ///This thing is creating error: don't know how to fix it:
                                          Utils.requestFocus(focusNode: highSchoolInfo.hsStateFocusNode, context: context);
                                        });
                                      },
                                    ),

                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************

                                    /// state
                                    fieldHeading(
                                        title: localization.emirates,
                                        /// important: true,
                                        important: highSchoolInfo.schoolStateDropdownMenuItems?.isNotEmpty ?? false,
                                        langProvider: langProvider),

                                    scholarshipFormDropdown(context:context,
                                      filled: highSchoolInfo.schoolStateDropdownMenuItems?.isEmpty ?? false,
                                      readOnly: highSchoolInfo.schoolStateDropdownMenuItems?.isEmpty ?? false,
                                      controller: highSchoolInfo.hsStateController,
                                      currentFocusNode: highSchoolInfo.hsStateFocusNode,
                                      menuItemsList: highSchoolInfo.schoolStateDropdownMenuItems ?? [],
                                      hintText: localization.emiratesWatermark,
                                      errorText: highSchoolInfo.hsStateError,
                                      onChanged: (value) {
                                        highSchoolInfo.hsStateError = null;
                                        highSchoolInfo.hsNameError = null;
                                        setState(() {
                                          highSchoolInfo.hsStateController.text = value!;

                                          highSchoolInfo.hsNameController.clear();
                                          highSchoolInfo.schoolNameDropdownMenuItems?.clear();

                                          /// populating the high school state dropdown
                                          _populateHighSchoolNameDropdown(langProvider: langProvider, index: index);

                                          ///This thing is creating error: don't know how to fix it:
                                          Utils.requestFocus(focusNode: highSchoolInfo.hsNameFocusNode, context: context);
                                        });
                                      },
                                    ),

                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************
                                    /// high school name
                                    if (highSchoolInfo.hsCountryController.text == 'ARE')
                                      Column(
                                        children: [
                                          /// school name from Dropdown selection
                                          fieldHeading(
                                              title: localization.hsName,
                                              important: highSchoolInfo.hsCountryController.text == 'ARE',
                                              langProvider: langProvider),
                                          scholarshipFormDropdown(context:context,
                                            controller: highSchoolInfo.hsNameController,
                                            currentFocusNode: highSchoolInfo.hsNameFocusNode,
                                            menuItemsList: highSchoolInfo.schoolNameDropdownMenuItems ?? [],
                                            hintText: localization.hsNameWatermark,
                                            errorText: highSchoolInfo.hsNameError,
                                            onChanged: (value) {
                                              highSchoolInfo.hsNameError = null;
                                              setState(() {
                                                /// setting the value for address type
                                                highSchoolInfo.hsNameController.text = value!;
                                                Utils.requestFocus(focusNode: highSchoolInfo.hsTypeFocusNode, context: context);
                                              });
                                            },
                                          ),
                                        ],
                                      ),

                                    /// ****************************************************************************************************************************************************
                                    /// school name or other school name will be shown based on the conditions
                                    /// If selected country is not UAE or if selected from high school name dropdown as other school
                                    /// show school input filed based on the condition
                                    /// No other high school will go in otherHigSchool of list of Hign school
                                    if (highSchoolInfo.hsCountryController.text != 'ARE' || highSchoolInfo.hsNameController.text == 'OTH')
                                      Column(
                                        children: [
                                          kFormHeight,
                                          fieldHeading(
                                              title: highSchoolInfo.hsCountryController.text == 'ARE' ? localization.hsnameOther : localization.hsName,
                                              important: true,
                                              langProvider: langProvider),
                                          scholarshipFormTextField(
                                              currentFocusNode: highSchoolInfo.otherHsNameFocusNode,
                                              nextFocusNode: highSchoolInfo.hsTypeFocusNode,
                                              controller: highSchoolInfo.otherHsNameController,
                                              hintText: highSchoolInfo.hsCountryController.text == 'ARE' ? localization.hsnameOtherRequired : localization.hsNameWatermark,
                                              errorText: highSchoolInfo.otherHsNameError,
                                              onChanged: (value) {
                                                /// live error display for  high school name
                                                if (highSchoolInfo.otherHsNameFocusNode.hasFocus) {
                                                  setState(() {
                                                    highSchoolInfo.otherHsNameError =
                                                        ErrorText.getNameArabicEnglishValidationError(name: highSchoolInfo.otherHsNameController.text, context: context);
                                                  });
                                                }

                                                /// live error display for other high school name
                                                if (highSchoolInfo.otherHsNameFocusNode.hasFocus) {
                                                  setState(() {
                                                    highSchoolInfo.otherHsNameError = ErrorText.getNameArabicEnglishValidationError(name: highSchoolInfo.otherHsNameController.text, context: context);
                                                  });
                                                }
                                              }),
                                        ],
                                      ),

                                    /// ****************************************************************************************************************************************************
                                    /// school type
                                    kFormHeight,
                                    fieldHeading(
                                        title: localization.hsType,
                                        important: true,
                                        langProvider: langProvider),

                                    scholarshipFormDropdown(context:context,
                                      controller: highSchoolInfo.hsTypeController,
                                      currentFocusNode: highSchoolInfo.hsTypeFocusNode,
                                      menuItemsList: _highSchoolTypeMenuItemsList ?? [],
                                      hintText: localization.hsTypeWatermark,
                                      errorText: highSchoolInfo.hsTypeError,
                                      onChanged: (value) {
                                        highSchoolInfo.hsTypeError = null;
                                        highSchoolInfo.curriculumTypeError = null;
                                        setState(() {
                                          /// setting the value for high school type
                                          highSchoolInfo.hsTypeController.text =
                                          value!;

                                          highSchoolInfo.curriculumTypeController
                                              .clear();
                                          highSchoolInfo
                                              .schoolCurriculumTypeDropdownMenuItems
                                              ?.clear();

                                          /// populating the high school curriculum dropdown
                                          _populateHighSchoolCurriculumTypeDropdown(
                                              langProvider: langProvider,
                                              index: index);

                                          Utils.requestFocus(
                                              focusNode: highSchoolInfo
                                                  .curriculumTypeFocusNode,
                                              context: context);
                                        });
                                      },
                                    ),

                                    /// ****************************************************************************************************************************************************
                                    /// curriculum Type
                                    kFormHeight,
                                    fieldHeading(
                                        title: localization.curriculumTypes,
                                        important: true,
                                        langProvider: langProvider),

                                    scholarshipFormDropdown(context:context,
                                      controller: highSchoolInfo.curriculumTypeController,
                                      currentFocusNode: highSchoolInfo.curriculumTypeFocusNode,
                                      menuItemsList: highSchoolInfo.schoolCurriculumTypeDropdownMenuItems ?? [],
                                      hintText: localization.curriculumTypesWatermark,
                                      errorText: highSchoolInfo.curriculumTypeError,
                                      onChanged: (value) {
                                        highSchoolInfo.curriculumTypeError = null;
                                        setState(() {
                                          /// setting the value for high school type
                                          highSchoolInfo.curriculumTypeController.text = value!;
                                          Utils.requestFocus(focusNode: highSchoolInfo.curriculumAverageFocusNode, context: context);
                                        });
                                      },
                                    ),
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,
                                    fieldHeading(
                                        title: localization.curriculumAverage,
                                        important: true,
                                        langProvider: langProvider),
                                    scholarshipFormTextField(
                                        currentFocusNode: highSchoolInfo
                                            .curriculumAverageFocusNode,
                                        nextFocusNode:
                                        highSchoolInfo.yearOfPassingFocusNode,
                                        controller: highSchoolInfo
                                            .curriculumAverageController,
                                        hintText: localization.curriculumAverageWatermark,
                                        maxLength: highSchoolInfo.curriculumTypeController.text != 'BRT' ? 4 : 6,
                                        errorText:
                                        highSchoolInfo.curriculumAverageError,
                                        onChanged: (value) {
                                          if (highSchoolInfo
                                              .curriculumAverageFocusNode
                                              .hasFocus) {
                                            setState(() {
                                              highSchoolInfo
                                                  .curriculumAverageError =
                                                  ErrorText.getGradeValidationError(
                                                      grade: highSchoolInfo
                                                          .curriculumAverageController
                                                          .text,
                                                      context: context);
                                            });
                                          }
                                        }),

                                    /// ****************************************************************************************************************************************************
                                    /// year of passing
                                    fieldHeading(
                                        title: localization.hsYearOfPassing,
                                        important: (highSchoolInfo.curriculumAverageController.text.isNotEmpty),
                                        langProvider: langProvider),
                                    scholarshipFormDateField(
                                      /// Prevent manual typing
                                      currentFocusNode: highSchoolInfo.yearOfPassingFocusNode,
                                      controller: highSchoolInfo.yearOfPassingController,
                                      hintText: localization.hsYearOfPassingWatermark,
                                      errorText: highSchoolInfo.yearOfPassingError,
                                      /// Display error text if any
                                      onChanged: (value) {
                                        setState(() {
                                          if (highSchoolInfo.yearOfPassingFocusNode.hasFocus) {
                                            /// Check if the year of passing field is empty or invalid
                                            highSchoolInfo.yearOfPassingError = ErrorText.getEmptyFieldError(name: highSchoolInfo.yearOfPassingController.text, context: context);
                                          }
                                        });
                                      },
                                      onTap: () async {
                                        /// Clear the error message when a date is selected
                                        highSchoolInfo.yearOfPassingError = null;
                                        /// Define the initial date as today's date
                                        final DateTime initialDate = DateTime.now();

                                        /// Define the maximum date (current date plus 1 year)
                                        final DateTime maxDate = DateTime.now().add(const Duration(days: 365));

                                        /// Define the minimum date (20 years before the current date)
                                        final DateTime firstDate = DateTime.now().subtract(const Duration(days: 20 * 365));

                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                                          barrierDismissible: false,
                                          locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
                                          initialDate: initialDate, // Default to today's date
                                          firstDate: firstDate,     // Allow selection from 20 years ago
                                          lastDate: maxDate,        // Allow selection up to 1 year in the future
                                        );

                                        if (date != null) {
                                          setState(() {
                                            /// Set the selected date in the controller (format to show only the year)
                                            highSchoolInfo.yearOfPassingController.text = DateFormat("yyyy-MM-dd").format(date).toString();

                                            /// Get the current year
                                            String currentYear = DateFormat('yyyy').format(date);

                                            /// Get the next year
                                            String nextYear = DateFormat('yyyy').format(date.add(const Duration(days: 365))); /// Adding 365 days to get to next year

                                            /// Combine current and next year
                                            String yearOfGraduation = '$currentYear-$nextYear';

                                            /// Print the passing year
                                            highSchoolInfo.passingYearController.text = yearOfGraduation;
                                          });
                                        }
                                      },
                                    ),
                                    /// ****************************************************************************************************************************************************
                                    /// year of graduation:
                                    kFormHeight,
                                    const MyDivider(),
                                    Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        color: AppColors.lightBlue1.withOpacity(0.4),
                                        child: Row(children: [
                                          sectionTitle(title: localization.hsDateOfGraduation),
                                          kFormHeight,
                                          Expanded(child: Text(highSchoolInfo.passingYearController.text))
                                        ])),

                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************

                                    const MyDivider(color: AppColors.lightGrey),
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,
                                    sectionTitle(title: localization.highschoolSubjects),
                                    kFormHeight,
                                    /// ****************************************************************************************************************************************************
                                    /// regular subjects
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: highSchoolInfo.hsDetails.length,
                                      itemBuilder: (context, index) {
                                        var element = highSchoolInfo.hsDetails[index];
                                        return Column(
                                          children: [
                                            /// Subject Title
                                            _subjectTitle(element.subjectTypeController.text.toString()),
                                            /// Grade input Field
                                            scholarshipFormTextField(
                                              currentFocusNode: element.gradeFocusNode,
                                              nextFocusNode: index + 1 < highSchoolInfo.hsDetails.length ? highSchoolInfo.hsDetails[index + 1].gradeFocusNode : null,
                                              controller: element.gradeController,
                                              hintText: localization.gradeWatermark,
                                              maxLength: 4,
                                              errorText: element.gradeError,
                                              onChanged: (value) {
                                                if (element.gradeFocusNode.hasFocus) {
                                                  setState(() {
                                                    // element.gradeError = ErrorText.getGradeValidationError(grade: element.gradeController.text, context: context);
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    /// ****************************************************************************************************************************************************

                                    const MyDivider(
                                      color: AppColors.lightGrey,
                                    ),
                                    kFormHeight,

                                    /// ****************************************************************************************************************************************************
                                    /// OTHER SUBJECTS OF THE HIGH SCHOOL DETAILS
                                    /// other subjects
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: highSchoolInfo.otherHSDetails.length,
                                      itemBuilder: (context, index) {
                                        var element = highSchoolInfo.otherHSDetails[index];
                                        return Column(
                                          children: [
                                            _subjectTitle(element.subjectTypeController.text.toString()),

                                            /// subject Name
                                            scholarshipFormTextField(
                                              currentFocusNode: element.otherSubjectNameFocusNode,
                                              nextFocusNode: element.gradeFocusNode,
                                              controller: element.otherSubjectNameController,
                                              hintText: localization.otherSubjectName,
                                              errorText: element.otherSubjectNameError,
                                              onChanged: (value) {
                                                if (element.otherSubjectNameFocusNode?.hasFocus ?? false) {
                                                  setState(() {
                                                    // element.otherSubjectNameError = ErrorText.getNameArabicEnglishValidationError(name: element.otherSubjectNameController!.text, context: context);
                                                  });
                                                }
                                              },
                                            ),
                                            kFormHeight,
                                            /// grade
                                            scholarshipFormTextField(
                                              currentFocusNode: element.gradeFocusNode,
                                              nextFocusNode: index + 1 < highSchoolInfo.otherHSDetails.length ? highSchoolInfo.otherHSDetails[index + 1].otherSubjectNameFocusNode : null,
                                              controller: element.gradeController,
                                              hintText: localization.gradeWatermark,
                                              maxLength: 4,
                                              errorText: element.gradeError,
                                              onChanged: (value) {
                                                if (element.gradeFocusNode.hasFocus) {
                                                  setState(() {
                                                    // element.gradeError = ErrorText.getGradeValidationError(grade: element.gradeController.text, context: context);
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    /// ****************************************************************************************************************************************************
                                    /// if it obeys the constraints of showing dropdown only then it will be visible to the user to delete the item
                                    /// Todo: Condition Applied by me that index check should only for greater then not equal to
                                    (admitType == 'MOS' || admitType == 'MOP') || (academicCareer == 'HCHL' && index >= 1) || index > 1
                                        ? addRemoveMoreSection(
                                        title: localization.deleteRowHighschool,
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            _removeHighSchool(index);
                                          });
                                        })
                                        : showVoid,
                                  ]);
                            }),
                        /// ****************************************************************************************************************************************************
                        const MyDivider(color: AppColors.lightGrey),
                        kFormHeight,
                        /// ****************************************************************************************************************************************************
                        /// ADD HIGH SCHOOL BUTTON
                        addRemoveMoreSection(
                            title: localization.addRowHighschool,
                            add: true,
                            onChanged: () {
                              setState(() {
                                _addHighSchool();
                              });
                            }),
                      ]),
                      /// _highSchoolInformationSection()
                    ],
                  ))
            ])));;
  }

  Widget _subjectTitle(String subjectCode) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);

    final element = _highSchoolSubjectsItemsList.firstWhere((element) {
      return element.code.toString() == subjectCode;
    });
    return fieldHeading(
        title: getTextDirection(langProvider) == TextDirection.ltr ? element.value : element.valueArabic.toString(),
        important: element.required == true || element.required == 'true',
        langProvider: langProvider);
  }
}  /// subjectTitle:
/// WE HAVE SEVERAL SUBJECTS IN LOV'S ONLY SO WE HAVE TO RENDER THE TITLES OF THE SUBJECTS. THE FUNCTION BELOW DO'S SAME

