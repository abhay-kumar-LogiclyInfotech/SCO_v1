import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/view/apply_scholarship/form_views/high_school_view.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/custom_button.dart';
import '../../../../resources/components/kButtons/kReturnButton.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EditHighSchoolDetailsView extends StatefulWidget {

  final ApplicationStatusDetail applicationStatusDetails;

  const EditHighSchoolDetailsView(
      {super.key, required this.applicationStatusDetails});


  @override
  State<EditHighSchoolDetailsView> createState() => _EditHighSchoolDetailsViewState();
}

class _EditHighSchoolDetailsViewState extends State<EditHighSchoolDetailsView> with MediaQueryMixin {


  PsApplication? peopleSoftApplication;


  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
    /// Making api call to ps-application
    final psApplicationProvider = Provider.of<GetApplicationSectionViewModel>(context, listen: false);
    await psApplicationProvider.getApplicationSections(
        applicationNumber:
        widget.applicationStatusDetails.admApplicationNumber);

    if (psApplicationProvider.apiResponse.status == Status.COMPLETED && psApplicationProvider.apiResponse.data?.data.psApplication.graduationList != null) {
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

      setState(() {});}});
    super.initState();
  }


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


  bool _isProcessing = false;

  resetProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: localization.highSchoolDetails,),
      body: Utils.modelProgressHud(
        processing: _isProcessing,
        child: _highSchoolDetailsSection(localization: localization,step: 0,langProvider: langProvider),
      ));
  }


  Widget _highSchoolDetailsSection(
      {required AppLocalizations localization,required int step, required LanguageChangeViewModel langProvider}) {
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    HighSchoolView(highSchoolList: _highSchoolList, admitType: widget.applicationStatusDetails.admitType, academicCareer: widget.applicationStatusDetails.acadCareer, draftPrevNextButtons: Container()),

                    _submitAndBackButton(localization: localization,langProvider: langProvider)],
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
          CustomButton(buttonName: localization.update, isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){
            final logger =  Logger();
            if(validateHighSchoolDetails(langProvider)){
              dynamic form = peopleSoftApplication?.toJson();
              form['highSchoolList'] = _highSchoolList.map((element){return element.toJson();}).toList();
              log(jsonEncode(form));
            }
          }),
          kFormHeight,
          const KReturnButton(),
        ],
      ),
    );
  }

  FocusNode? firstErrorFocusNode;
  bool validateHighSchoolDetails(langProvider) {
    final localization = AppLocalizations.of(context)!;
    firstErrorFocusNode = null;

    if (_highSchoolList.isNotEmpty) {
      for (var element in _highSchoolList) {
        if (element.hsLevelController.text.isEmpty || element.hsLevelError != null) {
          setState(() {
            element.hsLevelError = localization.hsTypeValidate;
            firstErrorFocusNode ??= element.hsLevelFocusNode;
          });
        }

        if (element.hsCountryController.text.isEmpty || element.hsCountryError != null) {
          setState(() {
            element.hsCountryError = localization.countryValidate;
            firstErrorFocusNode ??= element.hsCountryFocusNode;
          });
        }
        if (element.schoolStateDropdownMenuItems?.isNotEmpty ?? false) {
          if (element.hsStateController.text.isEmpty) {
            setState(() {
              element.hsStateError = localization.emiratesValidate;
              firstErrorFocusNode ??= element.hsStateFocusNode;
            });
          }
        }
        if (element.hsCountryController.text == 'ARE') {
          if (element.hsNameController.text.isEmpty) {
            setState(() {
              element.hsNameError = localization.hsNameValidate;
              firstErrorFocusNode ??= element.hsNameFocusNode;
            });
          }
        }
        if (element.hsCountryController.text != 'ARE' ||
            element.hsNameController.text == 'OTH') {
          if (element.otherHsNameController.text.isEmpty  || element.otherHsNameError != null) {
            setState(() {
              element.otherHsNameError = localization.hsnameOtherValidate;
              firstErrorFocusNode ??= element.otherHsNameFocusNode;
            });
          }
        }
        /// high school type
        if (element.hsTypeController.text.isEmpty || element.hsTypeError != null) {
          setState(() {
            element.hsTypeError = localization.hsTypeValidate;
            firstErrorFocusNode ??= element.hsTypeFocusNode;
          });
        }
        /// high school curriculum type
        if (element.curriculumTypeController.text.isEmpty || element.curriculumTypeError != null) {
          setState(() {
            element.curriculumTypeError = localization.curriculumTypesValidate;
            firstErrorFocusNode ??= element.curriculumTypeFocusNode;
          });
        }

        /// high school curriculum average
        if (element.curriculumAverageController.text.isEmpty || element.curriculumAverageError != null) {
          setState(() {
            element.curriculumAverageError = localization.curriculumAverageValidate;
            firstErrorFocusNode ??= element.curriculumAverageFocusNode;
          });
        }

        if (element.curriculumAverageController.text.isNotEmpty) {
          if (element.yearOfPassingController.text.isEmpty || element.yearOfPassingError != null) {
            setState(() {
              element.yearOfPassingError = localization.hsYearOfPassingValidate;
              firstErrorFocusNode ??= element.yearOfPassingFocusNode;
            });
          }
        }

        /// Validate high school subject grades and details
        if(element.hsDetails.isNotEmpty){
          for(var subject in element.hsDetails){
            if(subject.required && subject.gradeController.text.isEmpty){
              setState(() {
                subject.gradeError = localization.gradeValidate;
                firstErrorFocusNode ??= subject.gradeFocusNode;
              });
            }
          }

          /// validate other high school subjects
          if(element.otherHSDetails.isNotEmpty){
            for(var subject in element.otherHSDetails){
              if(subject.required && subject.otherSubjectNameController.text.isEmpty){
                setState(() {
                  subject.otherSubjectNameError = localization.otherSubjectNameValidate;
                  firstErrorFocusNode ??= subject.otherSubjectNameFocusNode;
                });
              }

              if(subject.required && subject.gradeController.text.isEmpty){
                setState(() {
                  subject.gradeError = localization.gradeValidate;
                  firstErrorFocusNode ??= subject.gradeFocusNode;
                });
              }
            }}}

      }
    }
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      return true;
    }
  }
}
