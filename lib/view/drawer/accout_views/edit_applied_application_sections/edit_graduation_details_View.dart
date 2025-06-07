import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../../data/response/status.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/custom_button.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../resources/components/kButtons/kReturnButton.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/edit_application/edit_application_sections_viewModel.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import 'package:provider/provider.dart';

import '../../../../viewModel/services/alert_services.dart';
import '../../../apply_scholarship/form_views/graduation_information_view.dart';

class EditGraduationDetailsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;

  const EditGraduationDetailsView(
      {super.key, required this.applicationStatusDetails});

  @override
  State<EditGraduationDetailsView> createState() =>
      _EditGraduationDetailsViewState();
}

class _EditGraduationDetailsViewState extends State<EditGraduationDetailsView> with MediaQueryMixin {
  late AlertServices _alertServices;


  PsApplication? peopleSoftApplication;

  @override
  void initState() {

    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
    await _refreshView();
    });
    super.initState();
  }


  _refreshView()async{
    WidgetsBinding.instance.addPostFrameCallback((callback) async {


      _nationalityMenuItemsList.clear();
      _graduationDetailsList.clear();
      _graduationLevelMenuItems.clear();
      _graduationLevelDDSMenuItems.clear();
      _caseStudyYearDropdownMenuItems.clear();

      _highSchoolList.clear();


      final LanguageChangeViewModel langProvider = Provider.of(context, listen: false);


      if (Constants.lovCodeMap['GRADUATION_LEVEL']?.values != null) {
        _graduationLevelMenuItems = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['GRADUATION_LEVEL']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['COUNTRY']?.values != null) {
        _nationalityMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      /// Making api call to ps-application
      final psApplicationProvider =
      Provider.of<GetApplicationSectionViewModel>(context, listen: false);
      await psApplicationProvider.getApplicationSections(
          applicationNumber:
          widget.applicationStatusDetails.admApplicationNumber);

      if (psApplicationProvider.apiResponse.status == Status.COMPLETED &&
          psApplicationProvider
              .apiResponse.data?.data.psApplication.graduationList !=
              null) {


        /// Setting the peoplesoft application to get and submit the full application.
        peopleSoftApplication = psApplicationProvider.apiResponse.data?.data.psApplication;




        final gradList = psApplicationProvider.apiResponse.data?.data.psApplication.graduationList;

        if (gradList?.isNotEmpty ?? false) {
          for (int index = 0; index < gradList!.length; index++) {
            var element = gradList[index];
            _graduationDetailsList.add(element);
            /// Add to the list
            /// populate dropdowns
            _populateGraduationLastTermMenuItemsList(
                langProvider: langProvider, index: index);
            _populateUniversityMenuItemsList(
                langProvider: langProvider, index: index);
          }
        }

        /// Retrieving the high school data because we also need check the high school list while marking highest Qualification
        final highSchoolList = psApplicationProvider.apiResponse.data?.data.psApplication.highSchoolList;
        if (highSchoolList?.isNotEmpty ?? false) {
          for (int index = 0; index < highSchoolList!.length; index++) {
            var element = highSchoolList[index];
            _highSchoolList.add(element);

            _populateHighSchoolStateDropdown(langProvider: langProvider,index: index);
            _populateHighSchoolNameDropdown(langProvider: langProvider,index: index);
            _populateHighSchoolCurriculumTypeDropdown(langProvider: langProvider,index: index);

          }
        }

        setState(() {});
      }
    });
  }


  bool _isProcessing = false;

  resetProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }




  /// HighSchool Data
  final List<HighSchool> _highSchoolList = [];

  /// to populate the states based on high school country
  _populateHighSchoolStateDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap[
      'STATE#${_highSchoolList[index].hsCountryController.text}']
          ?.values !=
          null) {
        _highSchoolList[index].schoolStateDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'STATE#${_highSchoolList[index].hsCountryController.text}']!
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
      'SCHOOL_CD#${_highSchoolList[index].hsStateController.text}']
          ?.values !=
          null) {
        _highSchoolList[index].schoolNameDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'SCHOOL_CD#${_highSchoolList[index].hsStateController.text}']!
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
      'CURRICULM_TYPE#${_highSchoolList[index].hsTypeController.text}']
          ?.values !=
          null) {
        _highSchoolList[index].schoolCurriculumTypeDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                'CURRICULM_TYPE#${_highSchoolList[index].hsTypeController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }






  @override
  Widget build(BuildContext context) {
    final LanguageChangeViewModel langProvider = context.read<
        LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustomSimpleAppBar(
          titleAsString: localization.graduationDetails,
        ),
        body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
            _graduationDetailsSection(step: 0, langProvider: langProvider),
          ),
        ));
  }

  List<DropdownMenuItem> _nationalityMenuItemsList = [];
  List<GraduationInfo> _graduationDetailsList = [];
  List<DropdownMenuItem> _graduationLevelMenuItems = [];
  List<DropdownMenuItem> _graduationLevelDDSMenuItems = [];
  List<DropdownMenuItem> _caseStudyYearDropdownMenuItems = [];




  /// sponsorship question for dds (One student can have only have one sponsor)
  String havingSponsor = '';
  String? _selectSponsorshipErrorText;

  void updateHavingSponsor(String value) {
    setState(() {
      havingSponsor = value;
      _selectSponsorshipErrorText = null;
    });
  }

  /// to populate the graduation Details
  _populateGraduationLastTermMenuItemsList(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants.lovCodeMap['LAST_TERM']?.values != null) {
        _graduationDetailsList[index].lastTerm = populateCommonDataDropdown(
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
      'GRAD_UNIVERSITY#${_graduationDetailsList[index].countryController
          .text}#UNV']
          ?.values !=
          null) {
        _graduationDetailsList[index].university = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap[
            'GRAD_UNIVERSITY#${_graduationDetailsList[index].countryController
                .text}#UNV']!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }
    });
  }

  _addGraduationDetail() {
    // bool isAlreadyCurrentlyStudying = _graduationDetailsList
    //     .any((element) => element.currentlyStudying == true);
    setState(() {
      _graduationDetailsList.add(GraduationInfo(
        levelController: TextEditingController(),
        countryController: TextEditingController(),
        universityController: TextEditingController(),
        majorController: TextEditingController(),
        cgpaController: TextEditingController(),
        graduationStartDateController: TextEditingController(),
        lastTermController: TextEditingController(),
        caseStudyTitleController: TextEditingController(),
        caseStudyDescriptionController: TextEditingController(),
        caseStudyStartYearController: TextEditingController(),
        levelFocusNode: FocusNode(),
        countryFocusNode: FocusNode(),
        universityFocusNode: FocusNode(),
        majorFocusNode: FocusNode(),
        cgpaFocusNode: FocusNode(),
        graduationStartDateFocusNode: FocusNode(),
        lastTermFocusNode: FocusNode(),
        caseStudyTitleFocusNode: FocusNode(),
        caseStudyDescriptionFocusNode: FocusNode(),
        caseStudyStartYearFocusNode: FocusNode(),
        isNewController: TextEditingController(text: 'true'),
        sponsorShipController: TextEditingController(),
        errorMessageController: TextEditingController(),
        highestQualification: false,
        showCurrentlyStudying: false,
        currentlyStudying: false,
        lastTerm: [],
        graduationLevel: [],
        university: [],
        otherUniversityController: TextEditingController(),
        otherUniversityFocusNode: FocusNode(),
        graduationEndDateController: TextEditingController(),
        graduationEndDateFocusNode: FocusNode(),
        sponsorShipFocusNode: FocusNode(),
      ));
    });
  }

  bool displayHighSchool() {
    /// We will show High school details option to UG,UGRD ,SCHL and HCHL scholarship types
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    return (academicCareer == 'UG' ||
        academicCareer == 'UGRD' ||
        academicCareer == 'SCHL' ||
        academicCareer == 'HCHL');
  }

  Widget _graduationDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    final localization = AppLocalizations.of(context)!;
    return Consumer<GetApplicationSectionViewModel>
      (

        builder: (context, provider, _) {
          switch (provider.apiResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator(context: context);
            case Status.ERROR:
              return Utils.showOnError();
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GraduationInformationView(
                      selectSponsorshipErrorText: _selectSponsorshipErrorText,
                      onUpdateHavingSponsor: updateHavingSponsor,
                      graduationDetailsList: _graduationDetailsList,
                      graduationLevelMenuItems: _graduationLevelMenuItems,
                      graduationLevelDDSMenuItems: _graduationLevelDDSMenuItems,
                      caseStudyYearDropdownMenuItems: _caseStudyYearDropdownMenuItems,
                      academicCareer: widget.applicationStatusDetails.acadCareer,
                      scholarshipType: widget.applicationStatusDetails.scholarshipType,
                      nationalityMenuItemsList: _nationalityMenuItemsList,
                      displayHighSchool: displayHighSchool(),
                      draftPrevNextButtons: draftDummy(langProvider),
                      havingSponsor: havingSponsor,
                      addGraduation: _addGraduationDetail,
                    ),
                    _submitAndBackButton(localization: localization, langProvider: langProvider),
                  ],
                ),
              );
            case Status.NONE:
              return Utils.showOnNone();
            case null:
              return Utils.showOnNone();
          }
        }
    );
  }


  Widget _submitAndBackButton({required AppLocalizations localization,required LanguageChangeViewModel langProvider}) {
    /// SubmitButton
    return  Padding(
      padding:  EdgeInsets.all(kPadding),
      child: Column(
        children: [

          Consumer<EditApplicationSectionsViewModel>(
            builder: (context,provider,_){
              return CustomButton(buttonName: localization.update, isLoading: provider.apiResponse.status == Status.LOADING, textDirection: getTextDirection(langProvider), onTap: ()
                async{
                  final logger =  Logger();
                  if(validateGraduationDetails(langProvider)){
                    dynamic form = peopleSoftApplication?.toJson();
                    var graduationRecords = form['graduationList'] = _graduationDetailsList.map((element){return element.toJson();}).toList();
                    var highSchoolRecords = form['highSchoolList'] = _highSchoolList.map((element){return element.toJson();}).toList();


                    final academicCareer =  widget.applicationStatusDetails.acadCareer;
                    final scholarshipType =  widget.applicationStatusDetails.scholarshipType;

                    String highestQualification = getHighestQualification(graduationDetailsList: _graduationDetailsList,academicCareer: academicCareer, scholarshipType: scholarshipType, highSchoolRecords: highSchoolRecords, graduationRecords: graduationRecords);


                    form['highestQualification'] = highestQualification;
                    form['graduationList'] = graduationRecords;
                    if(shouldShowHighSchoolDetails(academicCareer)) form['highSchoolList'] = highSchoolRecords;

                    await provider.editApplicationSections(sectionType: EditApplicationSection.education,applicationNumber: widget.applicationStatusDetails.admApplicationNumber,form: form);
                    await _refreshView();
                  }



                });
            },
          ),

          kFormHeight,
          const KReturnButton(),
        ],
      ),
    );
  }







  FocusNode? firstErrorFocusNode;

  bool validateGraduationDetails(langProvider) {
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    
    final localization = AppLocalizations.of(context)!;
    firstErrorFocusNode = null;

    /// validate graduation details
    if (academicCareer != 'SCHL' &&
        academicCareer != 'HCHL') {
      for (int index = 0; index < _graduationDetailsList.length; index++) {
        var element = _graduationDetailsList[index];
        validateGraduationDetails(element) {
          if (element.currentlyStudying && element.showCurrentlyStudying) {
            /// validating last term
            if (element.lastTermController.text.isEmpty || element.lastTermError != null) {
              setState(() {
                element.lastTermError = localization.lastTermRequired;
                firstErrorFocusNode ??= element.lastTermFocusNode;
              });
            }
          }
          /// #################################################################
          /// Condition using index and scholarship details
          if (index > 0 &&
              academicCareer != 'UGRD' &&
              academicCareer != 'DDS') {
            /// validating graduation level
            if (element.levelController.text.isEmpty || element.levelError != null) {
              setState(() {
                element.levelError = localization.hsGraduationLevelValidate;
                firstErrorFocusNode ??= element.levelFocusNode;
              });
            }
          }

          /// #################################################################
          /// validating dds graduation level
          if (index != 0 && academicCareer == 'DDS') {
            if (element.levelController.text.isEmpty || element.levelError != null) {
              setState(() {
                element.levelError = localization.hsGraduationLevelValidate;
                firstErrorFocusNode ??= element.levelFocusNode;
              });
            }
          }
          /// #################################################################
          /// validating graduation country
          if (element.countryController.text.isEmpty || element.countryError != null) {
            setState(() {
              element.countryError = localization.countryValidate;
              firstErrorFocusNode ??= element.countryFocusNode;
            });
          }
          /// #################################################################
          /// high school university
          if (academicCareer != 'DDS') {
            if (element.universityController.text.isEmpty || element.universityError !=null) {
              setState(() {
                element.universityError = localization.hsUniversityValidate;
                firstErrorFocusNode ??= element.universityFocusNode;
              });
            }
          }

          /// #################################################################
          /// other university
          if (element.universityController.text == 'OTH') {
            if (element.otherUniversityController.text.isEmpty || element.otherUniversityError != null) {
              setState(() {
                element.otherUniversityError = academicCareer != 'DDS'
                    ? localization.hsOtherUniversityValidate
                    : localization.ddsOtherUniversityRequired;
                firstErrorFocusNode ??= element.otherUniversityFocusNode;
              });
            }
          }
          /// #################################################################
          /// major
          if (element.majorController.text.isEmpty || element.majorError != null) {
            setState(() {
              element.majorError = academicCareer != 'DDS'
                  ? localization.hsMajorValidate
                  : localization.ddsMajorValidate;
              firstErrorFocusNode ??= element.majorFocusNode;
            });
          }
          /// #################################################################
          /// cgpa
          if (element.cgpaController.text.isEmpty || element.cgpaError != null) {
            setState(() {
              element.cgpaError = localization.cgpaValidate;
              firstErrorFocusNode ??= element.cgpaFocusNode;
            });
          }
          /// #################################################################
          if (element.graduationStartDateController.text.isEmpty || element.graduationStartDateError != null) {
            setState(() {
              element.graduationStartDateError = localization.hsGraducationStartDateValidate;
              firstErrorFocusNode ??= element.graduationStartDateFocusNode;
            });
          }
          /// #################################################################
          /// graduation end data
          element.graduationEndDateError = null;
          if ((!element.currentlyStudying && element.levelController.text.isNotEmpty)) {

            if (element.graduationEndDateController.text.isEmpty || element.graduationEndDateError != null) {
              setState(() {
                element.graduationEndDateError = localization.hsGraducationEndDateValidate;
                firstErrorFocusNode ??= element.graduationEndDateFocusNode;
              });
            }

            if (element.graduationEndDateController.text == element.graduationStartDateController.text) {
              setState(() {
                element.graduationEndDateError = "${localization.hsGraducationEndDateValidate}\nPlease Enter correct start and end Date";
                firstErrorFocusNode ??= element.graduationEndDateFocusNode;
              });
            }



          }
          /// #################################################################
          /// Are you currently receiving scholarship or grant from other university
          _selectSponsorshipErrorText = null;
          if (academicCareer == 'DDS') {
            if (havingSponsor.isEmpty) {
              _selectSponsorshipErrorText = localization.ddsGradQuestion;
              // _alertServices.flushBarErrorMessages(message: localization.ddsGradQuestion, // context: context,
              //     provider: langProvider);
              firstErrorFocusNode = FocusNode();
              return false;
            }
          }
          /// #################################################################
          /// sponsorship name
          if ((havingSponsor == 'Y') ||
              academicCareer != 'DDS') {
            if (element.sponsorShipController.text.isEmpty || element.sponsorShipError != null) {
              setState(() {
                element.sponsorShipError = localization.hsSponsorshipValidate;
                firstErrorFocusNode ??= element.sponsorShipFocusNode;
              });
            }
          }

          /// #################################################################
          if (element.levelController.text == 'PGRD' ||
              element.levelController.text == 'PG' ||
              element.levelController.text == 'DDS') {
            /// case study title
            if (element.caseStudyTitleController.text.isEmpty || element.caseSudyError != null) {
              setState(() {
                element.caseStudyTitleError = localization.caseStudyTitleValidate;
                firstErrorFocusNode ??= element.caseStudyTitleFocusNode;
              });
            }

            /// case study start year
            if (element.caseStudyStartYearController.text.isEmpty || element.caseStudyStartYearError != null) {
              setState(() {
                element.caseStudyStartYearError = localization.caseStudyStartYearValidate;
                firstErrorFocusNode ??= element.caseStudyStartYearFocusNode;
              });
            }
            /// case study description
            if (element.caseStudyDescriptionController.text.isEmpty || element.caseStudyDescriptionError !=  null) {
              setState(() {
                element.caseStudyDescriptionError = localization.caseStudyDescriptionValidate;
                firstErrorFocusNode ??= element.caseStudyDescriptionFocusNode;
              });
            }
          }
          /// #################################################################
        }
        if (academicCareer == 'UGRD' && element.currentlyStudying) {
          validateGraduationDetails(element);
        }
        if (academicCareer != 'UGRD') {
          validateGraduationDetails(element);
        }
      }
    }

    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      // await saveDraft();
      return true;
    }
  }






  Widget draftDummy(langProvider) {
  return Container();
  }
}


// bool showHighSchool = shouldShowHighSchoolDetails(academicCareer);
// bool showGraduation = shouldShowGraduationSection(academicCareer);
//
// print("show High School: $showHighSchool");
// print("show Graduation Details: $showHighSchool");
//
//
// String highestQualification = '';
//
// /// If we have graduation details then it is obvious that we can get highestQualification from graduation details only
// if(showGraduation){
// bool showingAddGraduationButton = shouldShowAddGraduationButton(scholarshipType: scholarshipType, academicCareer: academicCareer);
// /// If we are not showing the add more button then check if we have any detail which have parameter currently studying.
// /// If bool found with currently studying set highest qualification from graduation details
// if(!showingAddGraduationButton){
// final currentlyStudying = _graduationDetailsList.any((element){return element.currentlyStudying;});
// if(currentlyStudying){
// /// If after finding that student is currently studying from graduation then set highest qualification from graduation.
// highestQualification = markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecords);
//
// }
// if(!currentlyStudying){
// /// If we are not showing the add more button and also the currently studying for graduation in false then we have to check highest
// /// qualification from highSchool list and set highest qualification flags from high school list too.
// highestQualification = markHighestHighSchoolQualification(Constants.referenceValuesHighSchool, highSchoolRecords);
// }
// }
//
// /// If we are showing the add more button which means we have enough number of graduation details.
// /// Now set the boolean flag for all and set highest qualification also.
// if(showingAddGraduationButton) {
// highestQualification = markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecords);
// log(jsonEncode(graduationRecords));
// }
// }
//
// /// When we are showing only high school then get highest qualification from highschool only
// if(showHighSchool && !showGraduation){
// highestQualification = markHighestHighSchoolQualification(Constants.referenceValuesHighSchool, highSchoolRecords);
// log(jsonEncode(graduationRecords));
// }
//
// debugPrint("Printing the Highest Level: $highestQualification");

