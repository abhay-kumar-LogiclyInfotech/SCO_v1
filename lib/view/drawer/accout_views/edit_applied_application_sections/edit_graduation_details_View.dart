import 'package:flutter/material.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../apply_scholarship/form_views/graduation_information_view.dart';

class EditGraduationDetailsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;

  const EditGraduationDetailsView(
      {super.key, required this.applicationStatusDetails});

  @override
  State<EditGraduationDetailsView> createState() =>
      _EditGraduationDetailsViewState();
}

class _EditGraduationDetailsViewState extends State<EditGraduationDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final LanguageChangeViewModel langProvider =
      Provider.of(context, listen: false);


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
        final gradList = psApplicationProvider.apiResponse.data?.data
            .psApplication.graduationList;

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
        print(_graduationDetailsList.length);

        setState(() {});
      }
    });
    super.initState();
  }

  bool _isProcessing = false;

  resetProcessing(bool value) {
    setState(() {
      _isProcessing = value;
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

  void updateHavingSponsor(String value) {
    setState(() {
      havingSponsor = value;
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
    bool isAlreadyCurrentlyStudying = _graduationDetailsList
        .any((element) => element.currentlyStudying == true);
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
        showCurrentlyStudying: !isAlreadyCurrentlyStudying,
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
    return Consumer<GetApplicationSectionViewModel>
      (

        builder: (context, provider, _) {
          switch (provider.apiResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator(context: context);
            case Status.ERROR:
              return Utils.showOnError();
            case Status.COMPLETED:
              return GraduationInformationView(
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
              );
            case Status.NONE:
              return Utils.showOnNone();
            case null:
              return Utils.showOnNone();
          }
        }
    );
  }





  Widget draftDummy(langProvider) {
  return Container();
  }
}

