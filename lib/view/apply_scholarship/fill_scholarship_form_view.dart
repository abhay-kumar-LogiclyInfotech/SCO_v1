import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/components/form/form_field/widgets/gf_formdropdown.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/resources/input_formatters/emirates_id_input_formatter.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/steps_progress_view.dart';
import 'package:sco_v1/viewModel/apply_scholarship/FetchDraftByConfigurationKeyViewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/saveAsDraftViewmodel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../data/response/status.dart';
import '../../models/account/StudentProfileModel.dart';
import '../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/account/Custom_inforamtion_container.dart';
import '../../resources/components/custom_dropdown.dart';
import '../../resources/components/myDivider.dart';
import '../../utils/constants.dart';
import '../../viewModel/account/studentProfileViewmodel.dart';
import '../../viewModel/apply_scholarship/deleteDraftViewmodel.dart';
import '../../viewModel/services/alert_services.dart';
import '../../viewModel/services/navigation_services.dart';

import 'dart:convert';
import 'package:xml/xml.dart';

class FillScholarshipFormView extends StatefulWidget {
  final String selectedScholarshipConfigurationKey;
  final List<GetAllActiveScholarshipsModel?>? getAllActiveScholarships;

  FillScholarshipFormView(
      {super.key,
      required this.selectedScholarshipConfigurationKey,
      required this.getAllActiveScholarships});

  @override
  _FillScholarshipFormViewState createState() =>
      _FillScholarshipFormViewState();
}

class _FillScholarshipFormViewState extends State<FillScholarshipFormView>
    with MediaQueryMixin {
  // my required services
  late NavigationServices _navigationService;
  late MediaServices _mediaServices;
  late AlertServices _alertService;

  // initialize the services
  void _initializeServices() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertService = getIt.get<AlertServices>();
    _mediaServices = getIt.get<MediaServices>();
  }

  // Controller for managing the pages
  final PageController _pageController = PageController();
  int _currentSectionIndex = 0; // Track current section index
  int totalSections = 1; // Assume dynamic number of sections

  // Function to navigate to the next section
  void nextSection() {
    if (_currentSectionIndex < totalSections - 1) {
      setState(() {
        _currentSectionIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  // Function to navigate to the previous section
  void previousSection() {
    if (_currentSectionIndex > 0) {
      setState(() {
        _currentSectionIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  // Track filled sections
  List<bool> filledSections = [];

  // update sections count method
  void updateSections(int sections) {
    setState(() {
      filledSections = List.filled(sections, false);
    });
  }

  dynamic draftId;

  // Function to save draft
  void saveDraft() async {
    _finalForm();
    final saveDraftProvider = Provider.of<SaveAsDraftViewmodel>(context, listen: false);
    await saveDraftProvider.saveAsDraft(form: form, applicationNumber: draftId?.toString() ?? '0');
    if(saveDraftProvider.apiResponse.status == Status.COMPLETED){
      draftId = saveDraftProvider.apiResponse.data?.data?.applicationNumber ?? '0';
    }
  }

  // scholarship title
  String _scholarshipTitle = '';

  // selected scholarship:
  GetAllActiveScholarshipsModel? _selectedScholarship;

  // function to set selected scholarship
  void _getSelectedScholarship() {
    try {
      // Get selected scholarship from the provided key
      _selectedScholarship = widget.getAllActiveScholarships?.firstWhere(
          (scholarship) =>
              scholarship?.configurationKey ==
              widget.selectedScholarshipConfigurationKey);
      // refreshing the selected scholarship
      setState(() {
        debugPrint(_selectedScholarship.toString());
      });
    } catch (e) {
      _alertService.toastMessage(
          "An error occurred while trying to fetch the selected scholarship. Please try again.");
      debugPrint("Error fetching selected scholarship: $e");
    }
  }

  // creating the title for scholarship(Name of the scholarship visible to the user) and number of tabs using multiple conditions
  void _setTitleAndTotalSections({required BuildContext context}) {
    try {
      if (_selectedScholarship != null) {
        // Internal Bachelor
        if (_selectedScholarship!.configurationKey == 'SCOUGRDINT') {
          setState(() {
            _scholarshipTitle = "Bachelors In UAE";
            totalSections = 7; // Example number of sections
          });
        }

        // Internal Postgraduate
        else if (_selectedScholarship!.configurationKey == 'SCOPGRDINT') {
          setState(() {
            _scholarshipTitle = "Post Graduation In UAE";
            totalSections = 8; // Example number of sections
          });
        }

        // Meterological scholarship in UAE
        else if (_selectedScholarship!.configurationKey == 'SCOMETLOGINT') {
          setState(() {
            _scholarshipTitle = "Meterological scholarship in UAE";
            totalSections = 7; // Example number of sections
          });
        }

        // Bachelor Graduation scholarship outside UAE
        else if (_selectedScholarship!.configurationKey == 'SCOUGRDEXT') {
          setState(() {
            _scholarshipTitle = "Bachelor Scholarship Outside UAE";
            totalSections = 7; // Example number of sections
          });
        }

        // Bachelor Graduation scholarship outside UAE
        else if (_selectedScholarship!.configurationKey == 'SCONLUEXT') {
          setState(() {
            _scholarshipTitle = "Under Graduate External NLU";
            totalSections = 7; // Example number of sections
          });
        }

        // Bachelor Post Graduation scholarship outside UAE
        else if (_selectedScholarship!.configurationKey == 'SCOPGRDEXT') {
          setState(() {
            _scholarshipTitle = "Post Graduation Scholarship Outside UAE";
            totalSections = 8; // Example number of sections
          });
        }

        // External Doctors
        else if (_selectedScholarship!.configurationKey == 'SCODDSEXT') {
          setState(() {
            _scholarshipTitle = "Doctorate Graduation Outside UAE";
            totalSections = 8; // Example number of sections
          });
        }

        // University Preparation Scholarship
        else if (_selectedScholarship!.configurationKey == 'SCOUPPEXT') {
          setState(() {
            _scholarshipTitle = "University Preparation Scholarship";
            totalSections = 6; // Example number of sections
          });
        }

        // Actuarial Science Mission - Bachelor's Degree
        else if (_selectedScholarship!.configurationKey == 'SCOACTUGRD') {
          setState(() {
            _scholarshipTitle = "Actuarial Science - Bachelor's Degree";
            totalSections = 7; // Example number of sections
          });
        }
      } else {
        throw "_selectedScholarship is found null";
      }
    } catch (e) {
      _alertService.toastMessage(
          "An error occurred while trying to set the title & number of tabs of the selected scholarship. Please try again.");
      debugPrint("Something went wrong: $e");
    }
  }

  final _notifier =
      ValueNotifier<AsyncSnapshot<void>>(const AsyncSnapshot.waiting());

  //  Initializer to process initial data
  void _initializer() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.waiting, null);

      final langProvider =
          Provider.of<LanguageChangeViewModel>(context, listen: false);

      // get selected scholarship
      _getSelectedScholarship();

      // set title and total sections
      _setTitleAndTotalSections(context: context);

      // Initialize filledSections based on the current totalSections
      updateSections(totalSections);

      // *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
      // Check and populate dropdowns only if the values exist
      if (Constants.lovCodeMap['COUNTRY']?.values != null) {
        _nationalityMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['GENDER']?.values != null) {
        _genderMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['GENDER']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['MARITAL_STATUS']?.values != null) {
        _maritalStatusMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['MARITAL_STATUS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['RELATIONSHIP_TYPE']?.values != null) {
        _relationshipTypeMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['RELATIONSHIP_TYPE']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['PHONE_TYPE']?.values != null) {
        _phoneNumberTypeMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['PHONE_TYPE']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['EMIRATES_ID']?.values != null) {
        _familyInformationEmiratesMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['EMIRATES_ID']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['ADDRESS_TYPE']?.values != null) {
        _addressTypeMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['ADDRESS_TYPE']!.values!,
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
        _highSchoolSubjectsItemsList = populateSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['SUBJECT']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['DDS_GRAD_LEVEL#SIS_GRAD_LEVEL']?.values !=
          null) {
        _graduationLevelDDSMenuItems = populateCommonDataDropdown(
            menuItemsList:
                Constants.lovCodeMap['DDS_GRAD_LEVEL#SIS_GRAD_LEVEL']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['GRADUATION_LEVEL']?.values != null) {
        _graduationLevelMenuItems = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['GRADUATION_LEVEL']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['BATCH#${_selectedScholarship?.acadmicCareer}']
              ?.values !=
          null) {
        _caseStudyYearDropdownMenuItems = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap['BATCH#${_selectedScholarship?.acadmicCareer}']!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants
              .lovCodeMap['EXAMINATION#${_selectedScholarship?.acadmicCareer}']
              ?.values !=
          null) {
        _requiredExaminationDropdownMenuItems = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap[
                    'EXAMINATION#${_selectedScholarship?.acadmicCareer}']!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['ACAD_PROG_PGRD']?.values != null) {
        _acadProgramPgrdMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['ACAD_PROG_PGRD']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['ACAD_PROG_DDS']?.values != null) {
        _acadProgramDdsMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['ACAD_PROG_DDS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['UNIVERSITY_STATUS']?.values != null) {
        _universityPriorityStatus = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['UNIVERSITY_STATUS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['TEST_SCORE_VAL']?.values != null) {
        _testScoreVal = populateSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['TEST_SCORE_VAL']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['EMPLOYMENT_STATUS']?.values != null) {
        _employmentStatusItemsList = populateSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['EMPLOYMENT_STATUS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      // when we approved checklist of attachments
      if (_selectedScholarship?.approvedChecklistCode != null &&
          _selectedScholarship!.approvedChecklistCode.toString().isNotEmpty) {
        // attachments list
        _attachmentsList = populateSimpleValuesFromLOV(
            menuItemsList: Constants
                .lovCodeMap[
                    _selectedScholarship!.approvedChecklistCode.toString()]!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);

        // creating attachments list
        for (var element in _attachmentsList) {
          final processCD =
              element.code.toString().split(':').elementAt(0).toString();
          final documentCD = element.code.toString().split(':').last.toString();
          _myAttachmentsList.add(Attachment(
            processCDController: TextEditingController(text: processCD),
            documentCDController: TextEditingController(text: documentCD),
            descriptionController: TextEditingController(),
            userFileNameController: TextEditingController(),
            commentController: TextEditingController(),
            base64StringController: TextEditingController(),
            errorMessageController: TextEditingController(),
          ));
        }
      } else {
        // if there is no approved checklist then use simple checklist
        if (_selectedScholarship?.checklistCode != null &&
            _selectedScholarship!.checklistCode.toString().isNotEmpty) {
          // attachments list
          _attachmentsList = populateSimpleValuesFromLOV(
              menuItemsList: Constants
                  .lovCodeMap[_selectedScholarship!.checklistCode.toString()]!
                  .values!,
              provider: langProvider,
              textColor: AppColors.scoButtonColor);

          // creating attachments list
          for (var element in _attachmentsList) {
            final processCD = element.code.toString().split(':').elementAt(0).toString();
            final documentCD = element.code.toString().split(':').last.toString();
            _myAttachmentsList.add(Attachment(
              processCDController: TextEditingController(text: processCD),
              documentCDController: TextEditingController(text: documentCD),
              descriptionController: TextEditingController(),
              userFileNameController: TextEditingController(),
              commentController: TextEditingController(),
              base64StringController: TextEditingController(),
              errorMessageController: TextEditingController(),
            ));
          }
        }
      }

      _initializeStudentDetailsModels();

      // setting studyCountry Variable
      // isStudyCountry for majors selection
      isStudyCountry = _selectedScholarship?.scholarshipType == 'INT' ? true : false;
      _majorsMenuItemsList = getMajors(); // calling the getMajors method to populate the majors function

      // initializing contact information manually because Phone types are constants for first two index elements
      _phoneNumberList.add(PhoneNumber(
        phoneTypeController: TextEditingController(text: 'CELL'),
        countryCodeController: TextEditingController(),
        phoneNumberController: TextEditingController(),
        preferred: true,
        countryCodeFocusNode: FocusNode(),
        phoneNumberFocusNode: FocusNode(),
        phoneTypeFocusNode: FocusNode(),
      ));

      _phoneNumberList.add(PhoneNumber(
        phoneTypeController: TextEditingController(text: 'GRD'),
        countryCodeController: TextEditingController(),
        phoneNumberController: TextEditingController(),
        preferred: false,
        countryCodeFocusNode: FocusNode(),
        phoneNumberFocusNode: FocusNode(),
        phoneTypeFocusNode: FocusNode(),
      ));

      // adding at-least one address
      _addAddress();


      // add high school :
      if(displayHighSchool()) {
        _highSchoolList.add(HighSchool(
            hsLevelController: TextEditingController(text: '1'),
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
            highestQualificationController: TextEditingController(),
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
                    .startsWith('OTH')) // Filter for regular subjects
                .map((element) => HSDetails(
                      subjectTypeController:
                          TextEditingController(text: element.code.toString()),
                      gradeController: TextEditingController(),
                      subjectTypeFocusNode: FocusNode(),
                      gradeFocusNode: FocusNode(),
                    ))
                .toList(),
            otherHSDetails: _highSchoolSubjectsItemsList
                .where((element) => element.code
                    .startsWith('OTH')) // Filter for regular subjects
                .map(
                  (element) => HSDetails(
                    subjectTypeController:
                        TextEditingController(text: element.code.toString()),
                    gradeController: TextEditingController(),
                    otherSubjectNameController: TextEditingController(),
                    subjectTypeFocusNode: FocusNode(),
                    gradeFocusNode: FocusNode(),
                    otherSubjectNameFocusNode: FocusNode(),
                  ),
                )
                .toList(),
            schoolStateDropdownMenuItems: [],
            schoolNameDropdownMenuItems: [],
            schoolTypeDropdownMenuItems: [],
            schoolCurriculumTypeDropdownMenuItems: []));
        _highSchoolList.add(HighSchool(
            hsLevelController: TextEditingController(text: '3'),
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
            highestQualificationController: TextEditingController(),
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
                    .startsWith('OTH')) // Filter for regular subjects
                .map((element) => HSDetails(
                      subjectTypeController:
                          TextEditingController(text: element.code.toString()),
                      gradeController: TextEditingController(),
                      subjectTypeFocusNode: FocusNode(),
                      gradeFocusNode: FocusNode(),
                    ))
                .toList(),
            otherHSDetails: _highSchoolSubjectsItemsList
                .where((element) => element.code
                    .startsWith('OTH')) // Filter for regular subjects
                .map(
                  (element) => HSDetails(
                    subjectTypeController:
                        TextEditingController(text: element.code.toString()),
                    gradeController: TextEditingController(),
                    otherSubjectNameController: TextEditingController(),
                    subjectTypeFocusNode: FocusNode(),
                    gradeFocusNode: FocusNode(),
                    otherSubjectNameFocusNode: FocusNode(),
                  ),
                )
                .toList(),
            schoolStateDropdownMenuItems: [],
            schoolNameDropdownMenuItems: [],
            schoolTypeDropdownMenuItems: [],
            schoolCurriculumTypeDropdownMenuItems: []));
      }

      // add graduation detail
      _addGraduationDetail();

      // add majors
      for (var i = 0; i < 3; i++) {
        addMajorWishList();
      }
      // add university priority
      if (_selectedScholarship?.acadmicCareer != 'SCHL') {
        addUniversityPriority();
      }

      if (!(_selectedScholarship?.acadmicCareer == 'SCHL' ||
          _selectedScholarship?.acadmicCareer == 'HCHL')) {
        // add Required Examination
        _addRequiredExamination();
      }

      // add employment history
      if (displayEmploymentHistory()) {
        _addEmploymentHistory();
      }

      // fetch student profile Information t prefill the user information
      final studentProfileProvider = Provider.of<StudentProfileViewmodel>(context, listen: false);
      await studentProfileProvider.studentProfile();

      if (studentProfileProvider.apiResponse.status == Status.COMPLETED) {
        var data = studentProfileProvider.apiResponse.data?.data?.user;


        _arabicName.studentNameController.text = data?.firstName ?? '';
        _arabicName.fatherNameController.text = data?.middleName ?? '';
        _arabicName.grandFatherNameController.text = data?.middleName2 ?? '';
        _arabicName.familyNameController.text = data?.lastName ?? '';


        _englishName.studentNameController.text = data?.firstName ?? '';
        _englishName.fatherNameController.text = data?.middleName ?? '';
        _englishName.grandFatherNameController.text = data?.middleName2 ?? '';
        _englishName.familyNameController.text = data?.lastName ?? '';

        // prefill email
        _studentEmailController.text = data?.emailAddress ?? '';

        // setting emirates id
        _emiratesIdController.text = data?.emirateId ?? '';

        // set date of birth
        _dateOfBirthController.text = data?.birthDate ?? '';

        // set Gender
        _genderController.text = data?.gender ?? '';

        // set Nationality
        _passportNationalityController.text = data?.nationality ?? '';

        // set phone Number
        if (_phoneNumberList.isNotEmpty) {
          _phoneNumberList[0].phoneNumberController.text =
              data?.phoneNumber ?? '';
        }
      }

      // initialize the name As passport



      // fetch Draft for current Application
      await _fetchDraft();

      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.done, null);
    });
  }

  // fetch draft and check if available then set draft id and if the user want to move with draft then prefill form with draft and if not then delete draft and set userId null.
  Future _fetchDraft() async {
    final findDraftByConfigurationKeyProvider =
        Provider.of<FindDraftByConfigurationKeyViewmodel>(context,
            listen: false);

    // fetching te draft
    await findDraftByConfigurationKeyProvider.findDraftByConfigurationKey(
        configurationKey: _selectedScholarship?.configurationKey);

    if (findDraftByConfigurationKeyProvider.apiResponse.status ==
        Status.COMPLETED) {
      var draftData = findDraftByConfigurationKeyProvider.apiResponse.data;
      final draft =
          draftData?.status; // to ensure that draft version is available or not

      if (draft != null) {
        // setting draft id ( it is used to store save draft with the same id if it is available before)
        draftId = draftData?.applicationId;
        return Dialogs.materialDialog(
            barrierDismissible: false,
            msg: 'Would you like to move with the Draft version',
            title: "Draft Available",
            color: Colors.white,
            context: context,
            actionsBuilder: (context) {
              return [
                // delete draft
                Consumer<DeleteDraftViewmodel>(
                  builder: (context, provider, _) {
                    return provider.apiResponse.status == Status.LOADING
                        ? Utils.cupertinoLoadingIndicator()
                        : IconsOutlineButton(
                            onPressed: () async {
                              // delete Draft Permanent
                              await provider.deleteDraft(
                                  draftId: draftId ?? '');
                              if (provider.apiResponse.status ==
                                  Status.COMPLETED) {
                                draftId = null;
                                _navigationService.goBack();
                              }
                            },
                            text: 'No',
                            iconData: Icons.cancel_outlined,
                            textStyle: const TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          );
                  },
                ),

                // go with draft
                IconsButton(
                  onPressed: () {
                    // clean the draft application data and prefill the fields
                    Map<String, dynamic> cleanedDraft = jsonDecode(
                        cleanDraftXmlToJson(draftData?.applicationData ?? ''));


                    final langProvider = Provider.of<LanguageChangeViewModel>(
                        context,
                        listen: false);

                    if (cleanedDraft['nameAsPasport'] != null) {
                      _nameAsPassport.clear();
                      if(cleanedDraft['nameAsPasport'] is List){
                        for (var ele in cleanedDraft['nameAsPasport']) {
                          final element = PersonName.fromJson(ele);
                          if(element.nameTypeController.text == 'PRI'){
                            _arabicName = element;
                          }
                          if(element.nameTypeController.text == 'ENG'){
                            _englishName = element;
                          }
                      }
                      }
                    }



                    // passport Data Prefilled
                    _passportNationalityController.text =
                        cleanedDraft['country'] ?? '';
                    _passportPlaceOfIssueController.text =
                        cleanedDraft['passportIssuePlace'] ?? '';
                    _passportNumberController.text =
                        cleanedDraft['passportId'] ?? '';
                    _passportIssueDateController.text =
                        cleanedDraft['passportIssueDate'] ?? '';
                    _passportExpiryDateController.text =
                        cleanedDraft['passportExpiryDate'] ?? '';
                    _passportUnifiedNoController.text =
                        cleanedDraft['unifiedNo'] ?? '';

                    // personal information prefill
                    _emiratesIdExpiryDateController.text =
                        cleanedDraft['emirateIdExpiryDate'] ?? '';
                    _dateOfBirthController.text =
                        cleanedDraft['dateOfBirth'] ?? '';
                    _placeOfBirthController.text =
                        cleanedDraft['placeOfBirth'] ?? '';
                    _genderController.text = cleanedDraft['gender'] ?? '';

                    _maritalStatusController.text =
                        cleanedDraft['maritalStatus'] ?? '';
                    _studentEmailController.text =
                        cleanedDraft['emailId'] ?? '';


                    _isMotherUAECheckbox = cleanedDraft["uaeMother"] == 'true'? true : false;
                    havingSponsor = cleanedDraft["havingSponser"] ?? '';



                    // family information
                    _familyInformationEmiratesController.text =
                        cleanedDraft['familyNo'] ?? '';
                    _populateTownOnFamilyInformationEmiratesItem(
                        langProvider: langProvider);
                    _familyInformationTownVillageNoController.text =
                        cleanedDraft['town'] ?? '';
                    _familyInformationParentGuardianNameController.text =
                        cleanedDraft['parentName'] ?? '';
                    _familyInformationRelationTypeController.text =
                        cleanedDraft['relationType'] ?? '';
                    _familyInformationFamilyBookNumberController.text =
                        cleanedDraft['familyNumber'] ?? '';
                    _familyInformationMotherNameController.text =
                        cleanedDraft['motherName'] ?? '';

                    // scholarship relative
                    _isRelativeStudyingFromScholarship = cleanedDraft['relativeStudyinScholarship'] == 'true';
                    if ((_isRelativeStudyingFromScholarship ?? false) && cleanedDraft['relativeDetails'] != null) {

                      _relativeInfoList.clear();

                      if(cleanedDraft['relativeDetails'] is List)
                      {
                      for (var element in cleanedDraft['relativeDetails']) {
                        _relativeInfoList.add(RelativeInfo.fromJson(element));
                      }
                      }
                      else{
                        _relativeInfoList.add(RelativeInfo.fromJson(cleanedDraft['relativeDetails']));
                      }

                    }

                    // contact information
                    if (cleanedDraft['phoneNunbers'] != null) {
                      _phoneNumberList.clear();
                      for (var element in cleanedDraft['phoneNunbers']) {
                        _phoneNumberList.add(PhoneNumber.fromJson(element));
                      }
                    }

                    // address information
                    if (cleanedDraft['addressList'] != null) {
                      _addressInformationList.clear(); // Clear the current list


                      if (cleanedDraft['addressList'] is List) {
                        for (int index = 0;
                        index < cleanedDraft['addressList'].length;
                        index++) {
                          var element = cleanedDraft['addressList'][index];
                          _addressInformationList.add(Address.fromJson(element)); // Add to the list
                          _populateStateDropdown(langProvider: langProvider, index: index);
                        }
                      } else {

                        _addressInformationList.add(Address.fromJson(cleanedDraft['addressList'])); // Add to the list
                        _populateStateDropdown(langProvider: langProvider, index: 0);

                     }
                    }

                    // military Services:
                    _militaryServiceController.text =
                        cleanedDraft['militaryService'] ?? '';
                    switch (_militaryServiceController.text) {
                      case 'Y':
                        _isMilitaryService = MilitaryStatus.yes;
                      case 'N':
                        _isMilitaryService = MilitaryStatus.no;
                      case 'P':
                        _isMilitaryService = MilitaryStatus.postponed;
                      case 'R':
                        _isMilitaryService = MilitaryStatus.exemption;
                    }
                    _militaryServiceStartDateController.text =
                        cleanedDraft['militaryServiceStartDate'] ?? '';
                    _militaryServiceEndDateController.text =
                        cleanedDraft['militaryServiceEndDate'] ?? '';
                    _reasonForMilitaryController.text =
                        cleanedDraft['reasonForMilitarty'] ?? '';

                    // graduation details
                    if (cleanedDraft['graduationList'] != null) {
                      _graduationDetailsList.clear(); // Clear the current list
                      if(cleanedDraft['graduationList'] is List) {

                        for (int index = 0; index < cleanedDraft['graduationList'].length; index++) {
                          var element = cleanedDraft['graduationList'][index];
                          _graduationDetailsList.add(GraduationInfo.fromJson(element)); // Add to the list
                          // populate dropdowns
                          _populateGraduationLastTermMenuItemsList(
                              langProvider: langProvider, index: index);
                          _populateUniversityMenuItemsList(
                              langProvider: langProvider, index: index);
                        }

                      }
                    else{
                        _graduationDetailsList.add(GraduationInfo.fromJson(cleanedDraft['graduationList'])); // Add to the list
                        // populate dropdowns
                        _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: 0);
                        _populateUniversityMenuItemsList(langProvider: langProvider, index: 0);
                    }
                    }

                    _acadProgramDdsController.text = cleanedDraft['acadProgramDds'] ?? '';
                    _acadProgramPgrdController.text = cleanedDraft['acadProgramPgrd'] ?? '';

                    // major Details
                    if (cleanedDraft['majorWishList'] != null && cleanedDraft['majorWishList'] != 'true') {
                      _majorsWishlist.clear(); // Clear the current list

                      if(cleanedDraft['majorWishList'] is List){
                        for (int index = 0;
                        index < cleanedDraft['majorWishList'].length;
                        index++) {
                          var element = cleanedDraft['majorWishList'][index];
                          _majorsWishlist.add(MajorWishList.fromJson(element)); // Add to the list
                        }
                      }
                      else{
                        _majorsWishlist.add(MajorWishList.fromJson(cleanedDraft['majorWishList'])); // Add to the list
                      }


                    }




                    // university Priority
                    if (cleanedDraft['universtiesPriorityList'] != null) {
                      _universityPriorityList.clear(); // Clear the current list

                      if( cleanedDraft['universtiesPriorityList'] is List){

                      for (int index = 0; index < cleanedDraft['universtiesPriorityList'].length; index++) {
                        var element = cleanedDraft['universtiesPriorityList'][index];
                        _universityPriorityList.add(UniversityPriority.fromJson(element)); // Add to the list
                        populateUniversitiesWishList(_universityPriorityList[index]);
                      }}
                      else{
                        _universityPriorityList.add(UniversityPriority.fromJson(cleanedDraft['universtiesPriorityList']));
                        populateUniversitiesWishList(_universityPriorityList[0]);
                      }
                    }

                    // required Examinations
                    if (cleanedDraft['requiredExaminationList'] != null) {
                      _requiredExaminationList.clear(); // Clear the current list
                      if (cleanedDraft['requiredExaminationList'] is List) {
                        for (int index = 0; index < cleanedDraft['requiredExaminationList'].length; index++) {

                        var element = cleanedDraft['requiredExaminationList'][index];
                        _requiredExaminationList.add(RequiredExaminations.fromJson(element)); // Add to the list
                        // populate examination type dropdown
                        _populateExaminationTypeDropdown(langProvider: langProvider, index: index,);
                      }

                      } else {
                        _requiredExaminationList.add(RequiredExaminations.fromJson(cleanedDraft['requiredExaminationList'])); // Add to the list
                        _populateExaminationTypeDropdown(langProvider: langProvider, index: 0,);


                    }}

                    // employment Status
                    _employmentStatus = cleanedDraft['employmentStatus'] ?? '';


                    // Employment History
                    if (cleanedDraft['emplymentHistory'] != null && cleanedDraft['emplymentHistory'] != 'true' &&  displayEmploymentHistory()) {
                      _employmentHistoryList.clear(); // Clear the current list

                      if (cleanedDraft['emplymentHistory'] is List) {

                        for (int index = 0;
                        index < cleanedDraft['emplymentHistory'].length;
                        index++) {
                          var element = cleanedDraft['emplymentHistory'][index];
                          _employmentHistoryList.add(EmploymentHistory.fromJson(
                              element)); // Add to the list
                          // populate examination type dropdown
                          _populateExaminationTypeDropdown(
                            langProvider: langProvider,
                            index: index,
                          );
                        }

                      } else {
                        _employmentHistoryList.add(EmploymentHistory.fromJson(
                            cleanedDraft['emplymentHistory'])); // Add to the list
                        // populate examination type dropdown
                        _populateExaminationTypeDropdown(
                          langProvider: langProvider,
                          index: 0,
                        );
                      }
                    }

                    // high school
                    if (cleanedDraft['highSchoolList'] != null && displayHighSchool()) {
                      _highSchoolList.clear(); // Clear the current list
                      if (cleanedDraft['highSchoolList'] is List) {

                        for (int index = 0; index < cleanedDraft['highSchoolList'].length; index++) {
                          var element = cleanedDraft['highSchoolList'][index];
                          _highSchoolList.add( HighSchool(
                              hsLevelController: TextEditingController(text: element['hsLevel']),
                              hsNameController: TextEditingController(text: element['hsName']),
                              hsCountryController: TextEditingController(text: element['hsCountry']),
                              hsStateController: TextEditingController(text: element['hsState']),
                              yearOfPassingController: TextEditingController(text: element['yearOfPassing']),
                              hsTypeController: TextEditingController(text: element['hsType']),
                              curriculumTypeController: TextEditingController(text: element['curriculumType']),
                              curriculumAverageController: TextEditingController(text: element['curriculumAverage']),
                              otherHsNameController: TextEditingController(text: element['otherHsName'] ),
                              passingYearController: TextEditingController(text: element['passingYear']),
                              maxDateController: TextEditingController(text: element['maxDate']),
                              disableStateController: TextEditingController(text: element['disableState']),
                              isNewController: TextEditingController(text: element['isNew']),
                              highestQualificationController: TextEditingController(text: element['highestQualification']),
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
                              hsDetails: (element['hsDetails'] is List
                                  ? (element['hsDetails'] as List)
                                  .map((e) => HSDetails.fromJson(e))
                                  .toList()
                                  : []), // Provide an empty list if hsDetails is not a List

                              otherHSDetails: (element['otherHSDetails'] is List
                                  ? (element['otherHSDetails'] as List)
                                  .map((e) => HSDetails.fromJson(e))
                                  .toList()
                                  : []), // Provide an empty list if otherHSDetails is not a List
                              schoolStateDropdownMenuItems: [],
                              schoolNameDropdownMenuItems: [],
                              schoolTypeDropdownMenuItems: [],
                              schoolCurriculumTypeDropdownMenuItems: [])); // Add to the list
                          _populateHighSchoolStateDropdown(langProvider: langProvider,index: index);
                          _populateHighSchoolNameDropdown(langProvider: langProvider,index: index);
                          _populateHighSchoolCurriculumTypeDropdown(langProvider: langProvider,index: index);
                        }
                      } else {
                        _highSchoolList.add(HighSchool.fromJson(cleanedDraft['highSchoolList'])); // Add to the list
                      }
                    }


                    print("print attachements issue: ${cleanedDraft['attachments']}");
                    // attachments
                    if (cleanedDraft['attachments'] != null && cleanedDraft['attachments'].toString().trim().isNotEmpty) {
                      _myAttachmentsList.clear(); // Clear the current list
                      if(cleanedDraft['attachments'] is List){
                      for (int index = 0; index < cleanedDraft['attachments'].length; index++) {
                        var element = cleanedDraft['attachments'][index];
                        _myAttachmentsList.add(Attachment.fromJson(element));
                    }}
                      else{
              _myAttachmentsList.add(Attachment.fromJson(cleanedDraft['attachments']));
              }}


                    _navigationService.goBack();
                  },
                  text: 'Yes',
                  iconData: Icons.arrow_circle_right_outlined,
                  color: Colors.green,
                  textStyle: const TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ];
            });
        // prefill the form with the draft
        // _prefillFormWithDraft(draft);
      }
    }
  }

  // *------------------------- Init State of the form start ----------------------------------*
  @override
  void initState() {
    // initialize the services
    _initializeServices();
    // calling initializer to initialize the data
    _initializer();
    super.initState();
  }

  // *------------------------- Init State of the form end -----------------------------------------*

  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: true);

    return Scaffold(
        appBar: CustomSimpleAppBar(
            title: Text("Apply Scholarship",
                style: AppTextStyles.appBarTitleStyle())),
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
            valueListenable: _notifier,
            builder: (context, snapshot, child) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Utils.cupertinoLoadingIndicator());
              }
              if (snapshot.hasError) {
                return Utils.showOnError();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title and progress section
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: kPadding - 10),
                    decoration: const BoxDecoration(
                        color: AppColors.bgColor,
                        border: Border(
                            bottom: BorderSide(color: AppColors.darkGrey))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // scholarship title
                        Text(
                          _scholarshipTitle,
                          style: AppTextStyles.titleBoldTextStyle(),
                        ),
                        const SizedBox(height: 8),
                        const MyDivider(
                          color: AppColors.hintDarkGrey,
                        ),
                        // Progress Indicator for validated steps:
                        StepsProgressView(
                            totalSections: totalSections,
                            currentSectionIndex: _currentSectionIndex,
                        selectedScholarship: _selectedScholarship,
                        ),
                      ],
                    ),
                  ),

                  // Form Sections with PageView
                  Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable swipe gestures
                        itemCount: totalSections,
                        itemBuilder: (context, index) {
                          String key = _selectedScholarship?.configurationKey;
                          String? acadmicCareer =
                              _selectedScholarship?.acadmicCareer;

                          // Use a helper function to avoid repetition
                          bool shouldShowHighSchoolDetails() {
                            return acadmicCareer == 'UG' ||
                                acadmicCareer == 'UGRD' ||
                                acadmicCareer == 'SCHL' ||
                                acadmicCareer == 'HCHL';
                          }

                          bool isUniversityAndMajorsRequired() {
                            return acadmicCareer != 'SCHL';
                          }

                          bool isRequiredExaminationDetailsRequired() {
                            return !(acadmicCareer == 'SCHL' ||
                                acadmicCareer == 'HCHL');
                          }

                          bool isAttachmentSectionForExt() {
                            return key == 'SCOUPPEXT';
                          }

                          bool shouldDisplayEmploymentHistory() {
                            return displayEmploymentHistory(); // Assuming this is a helper function
                          }

                          // Switch case handling for index
                          switch (index) {
                            case 0:
                              return _studentUndertakingSection(
                                  step: index, langProvider: langProvider);

                            case 1:
                              return _studentDetailsSection(
                                  step: index, langProvider: langProvider);

                            case 2:
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // High school details section if the condition matches
                                    shouldShowHighSchoolDetails()
                                        ? _highSchoolDetailsSection(
                                            step: index,
                                            langProvider: langProvider)
                                        : showVoid,

                                    // Graduation details section
                                    _graduationDetailsSection(
                                        step: index,
                                        langProvider: langProvider),
                                  ],
                                ),
                              );

                            case 3:
                              // University and majors section if the condition matches
                              return isUniversityAndMajorsRequired()
                                  ? _universityAndMajorsDetailsSection(
                                      step: index, langProvider: langProvider)
                                  : showVoid;

                            case 4:
                              // Handle based on scholarship type and configuration key
                              if (isAttachmentSectionForExt()) {
                                return _attachmentsSection(
                                    step: index, langProvider: langProvider);
                              } else {
                                return isRequiredExaminationDetailsRequired()
                                    ? _requiredExaminationsDetailsSection(
                                        step: index, langProvider: langProvider)
                                    : showVoid;
                              }

                            case 5:
                              // Handling based on configuration key for attachments or employment history
                              if (isAttachmentSectionForExt()) {
                                return _confirmation();
                              } else if (key == 'SCOACTUGRD' ||
                                  key == "SCOUGRDINT" ||
                                  key == 'SCOMETLOGINT' ||
                                  key == 'SCOUGRDEXT') {
                                return _attachmentsSection(
                                    step: index, langProvider: langProvider);
                              } else {
                                return shouldDisplayEmploymentHistory()
                                    ? _employmentHistoryDetailsSection(
                                        step: index, langProvider: langProvider)
                                    : showVoid;
                              }

                            case 6:
                              // Display confirmation based on configuration key
                              if (key == 'SCOACTUGRD' ||
                                  key == "SCOUGRDINT" ||
                                  key == "SCOMETLOGINT" ||
                                  key == "SCOUGRDEXT") {
                                return _confirmation();
                              } else {
                                return _attachmentsSection(
                                    step: index, langProvider: langProvider);
                              }

                            case 7:
                              // Confirmation at the end
                              return _confirmation();

                            default:
                              return Container(); // Fallback for unexpected index values
                          }
                        }),
                  ),
                ],
              );
            }));
  }

  // *--------------------------------------------------------------- Accept terms and conditions start ----------------------------------------------------------------------------*
  // step-1: student undertaking

  // student undertaking check:
  bool _acceptStudentUndertaking = false;

  Widget _studentUndertakingSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Column(
      children: [
        // Accept Pledge
        kFormHeight,
        CustomGFCheckbox(
          value: _acceptStudentUndertaking,
          onChanged: (value) {
            setState(() {
              _acceptStudentUndertaking = value ?? false;
              filledSections[step] =
                  _acceptStudentUndertaking; // Update section as filled
            });
          },
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
              onTap: () {
                var result =
                    validateSection(step: 0, langProvider: langProvider);
                if (result) {
                  nextSection();
                }
              }),
        )
      ],
    );
  }

  // *--------------------------------------------------------------- Accept terms and conditions end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Student Details Section start ----------------------------------------------------------------------------*
  // step-2
  // *--------------------------------------------------------------- Name as Passport data start ----------------------------------------------------------------------------*

   PersonName _arabicName = PersonName(
    nameTypeController: TextEditingController(text: 'PRI'),
    studentNameController: TextEditingController(),
    fatherNameController: TextEditingController(),
    grandFatherNameController: TextEditingController(),
    familyNameController: TextEditingController(),
    nameTypeFocusNode: FocusNode(),
    studentNameFocusNode: FocusNode(),
    fatherNameFocusNode: FocusNode(),
    grandFatherNameFocusNode: FocusNode(),
    familyNameFocusNode: FocusNode(),
  );

   PersonName _englishName = PersonName(
    nameTypeController: TextEditingController(text: 'ENG'),
    studentNameController: TextEditingController(),
    fatherNameController: TextEditingController(),
    grandFatherNameController: TextEditingController(),
    familyNameController: TextEditingController(),
    nameTypeFocusNode: FocusNode(),
    studentNameFocusNode: FocusNode(),
    fatherNameFocusNode: FocusNode(),
    grandFatherNameFocusNode: FocusNode(),
    familyNameFocusNode: FocusNode(),
  );
   List<PersonName> _nameAsPassport = [];

  void _initializeStudentDetailsModels() {
    _nameAsPassport = [_arabicName, _englishName];
  }

  // *--------------------------------------------------------------- Name as Passport data end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- passport data start ----------------------------------------------------------------------------*
  List<DropdownMenuItem> _nationalityMenuItemsList = [];

  // Private TextEditingControllers
  final TextEditingController _passportNationalityController =
      TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _passportIssueDateController =
      TextEditingController();
  final TextEditingController _passportExpiryDateController =
      TextEditingController();
  final TextEditingController _passportPlaceOfIssueController =
      TextEditingController();
  final TextEditingController _passportUnifiedNoController =
      TextEditingController();

  // Private FocusNodes
  final FocusNode _passportNationalityFocusNode = FocusNode();
  final FocusNode _passportNumberFocusNode = FocusNode();
  final FocusNode _passportIssueDateFocusNode = FocusNode();
  final FocusNode _passportExpiryDateFocusNode = FocusNode();
  final FocusNode _passportPlaceOfIssueFocusNode = FocusNode();
  final FocusNode _passportUnifiedNoFocusNode = FocusNode();

  // Error texts for validation
  String? _passportNationalityError;
  String? _passportNumberError;
  String? _passportIssueDateError;
  String? _passportExpiryDateError;
  String? _passportPlaceOfIssueError;
  String? _passportUnifiedNoError;

  // *--------------------------------------------------------------- passport data end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- personal details data start ----------------------------------------------------------------------------*

  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _maritalStatusMenuItemsList = [];

  // Emirates ID
  final TextEditingController _emiratesIdController =
      TextEditingController(text: "784196207416171");

// Emirates ID Expiry Date
  final TextEditingController _emiratesIdExpiryDateController =
      TextEditingController();

// Date of Birth
  final TextEditingController _dateOfBirthController = TextEditingController();

// Place of Birth
  final TextEditingController _placeOfBirthController = TextEditingController();

// Gender
  final TextEditingController _genderController = TextEditingController();

// Marital Status
  final TextEditingController _maritalStatusController =
      TextEditingController();

// Student Email Address
  final TextEditingController _studentEmailController = TextEditingController();

// Is Mother UAE National?
  final TextEditingController _motherUAENationalController =
      TextEditingController();

// Focus Nodes

// Emirates ID
  final FocusNode _emiratesIdFocusNode = FocusNode();

// Emirates ID Expiry Date
  final FocusNode _emiratesIdExpiryDateFocusNode = FocusNode();

// Date of Birth
  final FocusNode _dateOfBirthFocusNode = FocusNode();

// Place of Birth
  final FocusNode _placeOfBirthFocusNode = FocusNode();

// Gender
  final FocusNode _genderFocusNode = FocusNode();

// Marital Status
  final FocusNode _maritalStatusFocusNode = FocusNode();

// Student Email Address
  final FocusNode _studentEmailFocusNode = FocusNode();

// Is Mother UAE National?
  final FocusNode _motherUAENationalFocusNode = FocusNode();

  // Error Variables:
  // Error text variables for Emirates ID fields
  String? _emiratesIdError;
  String? _emiratesIdExpiryDateError;

// Error text variables for Date of Birth and Place of Birth fields
  String? _dateOfBirthError;
  String? _placeOfBirthError;

// Error text variables for Gender, Marital Status, and Student Email Address fields
  String? _genderError;
  String? _maritalStatusError;
  String? _studentEmailError;

// Error text variable for Is Mother UAE National? field
  String? _motherUAENationalError;

  // boolean variable for is mother uae
  bool _isMotherUAECheckbox = false;

  // *--------------------------------------------------------------- personal details data end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Family Information data start ----------------------------------------------------------------------------*

// Family Information is visible only when selected nationality is United Arab Emirates
// Also make son of citizens checkbox disable

  // Controllers for Family Information
  final TextEditingController _familyInformationEmiratesController =
      TextEditingController();
  final TextEditingController _familyInformationTownVillageNoController =
      TextEditingController();
  final TextEditingController _familyInformationParentGuardianNameController =
      TextEditingController();
  final TextEditingController _familyInformationRelationTypeController =
      TextEditingController();
  final TextEditingController _familyInformationFamilyBookNumberController =
      TextEditingController();
  final TextEditingController _familyInformationMotherNameController =
      TextEditingController();

// Focus Nodes for Family Information
  final FocusNode _familyInformationEmiratesFocusNode = FocusNode();
  final FocusNode _familyInformationTownVillageNoFocusNode = FocusNode();
  final FocusNode _familyInformationParentGuardianNameFocusNode = FocusNode();
  final FocusNode _familyInformationRelationTypeFocusNode = FocusNode();
  final FocusNode _familyInformationFamilyBookNumberFocusNode = FocusNode();
  final FocusNode _familyInformationMotherNameFocusNode = FocusNode();

// Error texts for validation
  String? _familyInformationEmiratesErrorText;
  String? _familyInformationTownVillageNoErrorText;
  String? _familyInformationParentGuardianNameErrorText;
  String? _familyInformationRelationTypeErrorText;
  String? _familyInformationFamilyBookNumberErrorText;
  String? _familyInformationMotherNameErrorText;

  // emirates menuItem List
  List<DropdownMenuItem> _familyInformationEmiratesMenuItemsList = [];

  // village or town menuItem List
  List<DropdownMenuItem> _familyInformationTownMenuItemsList = [];

  _populateTownOnFamilyInformationEmiratesItem(
      {required LanguageChangeViewModel langProvider}) {
    setState(() {
      _familyInformationTownMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['VILLAGE_NUM#${_familyInformationEmiratesController.text}']?.values ?? [],
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    });
  }

  // for relation type use from relative information relation type

  // *--------------------------------------------------------------- Family Information data end ----------------------------------------------------------------------------*

  // *---------------------------------------------------------------Relative Information data start----------------------------------------------------------------------------*
  bool? _isRelativeStudyingFromScholarship;

  FocusNode _isRelativeStudyingFromScholarshipYesFocusNode = FocusNode();

  // relationship type dropdown menu items list
  List<DropdownMenuItem> _relationshipTypeMenuItemsList = [];

  // List of Relative information
  List<RelativeInfo> _relativeInfoList = [];

  // Method to add a new relative section (new RelativeInfo model)
  void _addRelative() {
    setState(() {
      _relativeInfoList.add(RelativeInfo(
        relativeNameController: TextEditingController(),
        countryUniversityController: TextEditingController(),
        relationTypeController: TextEditingController(),
        familyBookNumberController: TextEditingController(),
        relativeNameFocusNode: FocusNode(),
        relationTypeFocusNode: FocusNode(),
        countryUniversityFocusNode: FocusNode(),
        familyBookNumberFocusNode: FocusNode(),
        relativeNameError: null,
        relationTypeError: null,
        countryUniversityError: null,
        familyBookNumberError: null,
      ));
    });
  }

  // Method to remove a relative section
  void _removeRelative(int index) {
    if (index >= 0 && index < _relativeInfoList.length) {
      // Check if index is valid
      setState(() {
        final relativeInformation = _relativeInfoList[index];
        relativeInformation.relativeNameController
            .dispose(); // Dispose the controllers
        relativeInformation.countryUniversityController.dispose();
        relativeInformation.relationTypeController.dispose();
        relativeInformation.familyBookNumberController.dispose();
        relativeInformation.relativeNameFocusNode
            .dispose(); // Dispose the controllers
        relativeInformation.countryUniversityFocusNode.dispose();
        relativeInformation.relationTypeFocusNode.dispose();
        relativeInformation.familyBookNumberFocusNode.dispose();

        _relativeInfoList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); // Debugging print to show invalid index
    }
  }

  // *---------------------------------------------------------------Relative Information data end----------------------------------------------------------------------------*

  // step-2: student details
  Widget _studentDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPadding),
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            draftPrevNextButtons(langProvider),
            CustomInformationContainer(
                title: "Student Details",
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //*--------------------------------------------------------- Arabic Name Section start ------------------------------------------------------------------------------*/
                    // Title for arabic name same as passport
                    _sectionTitle(title: "Arabic name in passport"),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    //  Arabic name
                    fieldHeading(
                        title: "Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _arabicName.studentNameFocusNode,
                        nextFocusNode: _arabicName.fatherNameFocusNode,
                        controller: _arabicName.studentNameController,
                        hintText: "Enter Name",
                        errorText: _arabicName.studentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicName.studentNameFocusNode.hasFocus) {
                              // calling to convert to json name as passport
                              _initializeStudentDetailsModels();
                              _arabicName.studentNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicName.studentNameController.text,
                                      context: context);
                            }
                          });
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Arabic father name
                    fieldHeading(
                        title: "Father's Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode:  _arabicName.fatherNameFocusNode,
                        nextFocusNode:  _arabicName.grandFatherNameFocusNode,
                        controller:  _arabicName.fatherNameController,
                        hintText: "Enter Father's Name",
                        errorText:  _arabicName.fatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicName.fatherNameFocusNode.hasFocus) {
                              _initializeStudentDetailsModels();
                              _arabicName.fatherNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicName.fatherNameController.text,
                                      context: context);
                            }
                          });
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Arabic Grandfather name
                    fieldHeading(
                        title: "Grandfather's Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _arabicName.grandFatherNameFocusNode,
                        nextFocusNode: _arabicName.familyNameFocusNode,
                        controller: _arabicName.grandFatherNameController,
                        hintText: "Enter Grandfather's Name",
                        errorText: _arabicName.grandFatherNameError,
                        onChanged: (value) {
                          if ( _arabicName.grandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _initializeStudentDetailsModels();

                              _arabicName.grandFatherNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicName.grandFatherNameController.text,
                                      context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Arabic Family name
                    fieldHeading(
                        title: "Family Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _arabicName.familyNameFocusNode,
                        nextFocusNode: _englishName.studentNameFocusNode,
                        controller: _arabicName.familyNameController,
                        hintText: "Enter Family Name",
                        errorText: _arabicName.familyNameError,
                        onChanged: (value) {
                          if (_arabicName.familyNameFocusNode.hasFocus) {
                            setState(() {
                              _initializeStudentDetailsModels();

                              _arabicName.familyNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicName.familyNameController.text,
                                      context: context);
                            });
                          }
                        }),

                    // *--------------------------------------------------------- Arabic Name Section end ------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *--------------------------------------------------------- English Name Section Start ------------------------------------------------------------------------------*/
                    // Title for English name same as passport
                    _sectionTitle(title: "English name in passport"),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // English student name
                    fieldHeading(
                        title: "Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _englishName.studentNameFocusNode,
                        nextFocusNode: _englishName.fatherNameFocusNode,
                        controller: _englishName.studentNameController,
                        hintText: "Enter Name",
                        errorText: _englishName.studentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_englishName.studentNameFocusNode.hasFocus) {
                              _initializeStudentDetailsModels();

                              _englishName.studentNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishName.studentNameController.text,
                                      context: context);
                            }
                          });
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // English father name
                    fieldHeading(
                        title: "Father's Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode:  _englishName.fatherNameFocusNode,
                        nextFocusNode:  _englishName.grandFatherNameFocusNode,
                        controller:  _englishName.fatherNameController,
                        hintText: "Enter Father's Name",
                        errorText:  _englishName.fatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if ( _englishName.fatherNameFocusNode.hasFocus) {
                              _initializeStudentDetailsModels();

                              _englishName.fatherNameError =
                                  ErrorText.getEnglishNameError(
                                      name:  _englishName.fatherNameController.text,
                                      context: context);
                            }
                          });
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // English Grandfather name
                    fieldHeading(
                        title: "Grandfather's Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _englishName.grandFatherNameFocusNode,
                        nextFocusNode: _englishName.familyNameFocusNode,
                        controller: _englishName.grandFatherNameController,
                        hintText: "Enter Grandfather's Name",
                        errorText: _englishName.grandFatherNameError,
                        onChanged: (value) {
                          if (_englishName.grandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _initializeStudentDetailsModels();

                              _englishName.grandFatherNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishName.grandFatherNameController
                                          .text,
                                      context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // English Family name
                    fieldHeading(
                        title: "Family Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _englishName.familyNameFocusNode,
                        nextFocusNode: _englishName.studentNameFocusNode,
                        controller: _englishName.familyNameController,
                        hintText: "Enter Family Name",
                        errorText: _englishName.familyNameError,
                        onChanged: (value) {
                          if ( _englishName.familyNameFocusNode.hasFocus) {
                            setState(() {
                              _initializeStudentDetailsModels();

                              _englishName.familyNameError =
                                  ErrorText.getEnglishNameError(
                                      name:  _englishName.familyNameController.text,
                                      context: context);
                            });
                          }
                        }),
                    //*--------------------------------------------------------- English Name Section end ------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    //*--------------------------------------------------------- Passport Data Section Start ------------------------------------------------------------------------------*/
                    // passport data heading
                    _sectionTitle(title: "Passport Data"),

                    // ****************************************************************************************************************************************************
                    kFormHeight,
                    // Nationality
                    fieldHeading(
                        title: "Nationality",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDropdown(
                      controller: _passportNationalityController,
                      currentFocusNode: _passportNationalityFocusNode,
                      menuItemsList: _nationalityMenuItemsList,
                      hintText: "Select Nationality",
                      errorText: _passportNationalityError,
                      onChanged: (value) {
                        _passportNationalityError = null;
                        setState(() {
                          _passportNationalityController.text = value!;

                          // if nationality is not UAE then clear all the values of the family information
                          if (value! != 'ARE') {
                            _familyInformationEmiratesController.clear();
                            _familyInformationTownVillageNoController.clear();
                            _familyInformationParentGuardianNameController
                                .clear();
                            _familyInformationRelationTypeController.clear();
                            _familyInformationFamilyBookNumberController
                                .clear();
                          }

                          // by default set no for military service
                          _isMilitaryService = MilitaryStatus.no;

                          //This thing is creating error: don't know how to fix it:
                          FocusScope.of(context)
                              .requestFocus(_passportNumberFocusNode);
                        });
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // passport number
                    fieldHeading(
                        title: "Passport Number",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _passportNumberFocusNode,
                        controller: _passportNumberController,
                        hintText: "Enter Passport Number",
                        errorText: _passportNumberError,
                        onChanged: (value) {
                          if (_passportNumberFocusNode.hasFocus) {
                            setState(() {
                              _passportNumberError =
                                  ErrorText.getPassportNumberError(
                                      passportNumber:
                                          _passportNumberController.text,
                                      context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Issue Date
                    fieldHeading(
                        title: "Issue Date",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDateField(
                      currentFocusNode: _passportIssueDateFocusNode,
                      controller: _passportIssueDateController,
                      hintText: "Enter Issue Date",
                      errorText: _passportIssueDateError,
                      onChanged: (value) async {
                        setState(() {
                          if (_passportIssueDateFocusNode.hasFocus) {
                            _passportIssueDateError =
                                ErrorText.getEmptyFieldError(
                                    name: _passportIssueDateController.text,
                                    context: context);
                          }
                        });
                      },
                      onTap: () async {
                        // Clear the error if a date is selected
                        _passportIssueDateError = null;

                        DateTime? dob = await showDatePicker(
                          context: context,
                          barrierColor:
                              AppColors.scoButtonColor.withOpacity(0.1),
                          barrierDismissible: false,
                          locale: Provider.of<LanguageChangeViewModel>(context,
                                  listen: false)
                              .appLocale,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                        );
                        if (dob != null) {
                          setState(() {
                            _passportIssueDateController.text =
                                DateFormat('yyyy-MM-dd').format(dob).toString();
                            Utils.requestFocus(
                                focusNode: _passportExpiryDateFocusNode,
                                context: context);
                          });
                        }
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Expiry Date
                    fieldHeading(
                        title: "Expiry Date",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDateField(
                      currentFocusNode: _passportExpiryDateFocusNode,
                      controller: _passportExpiryDateController,
                      hintText: "Enter Expiry Date",
                      errorText: _passportExpiryDateError,
                      onChanged: (value) async {
                        setState(() {
                          if (_passportExpiryDateFocusNode.hasFocus) {
                            _passportExpiryDateError =
                                ErrorText.getEmptyFieldError(
                                    name: _passportExpiryDateController.text,
                                    context: context);
                          }
                        });
                      },
                      onTap: () async {
                        // Clear the error if a date is selected
                        _passportExpiryDateError = null;

                        DateTime? dob = await showDatePicker(
                            context: context,
                            barrierColor:
                                AppColors.scoButtonColor.withOpacity(0.1),
                            barrierDismissible: false,
                            locale: Provider.of<LanguageChangeViewModel>(
                                    context,
                                    listen: false)
                                .appLocale,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 50 * 365)));
                        if (dob != null) {
                          setState(() {
                            Utils.requestFocus(
                                focusNode: _passportPlaceOfIssueFocusNode,
                                context: context);
                            _passportExpiryDateController.text =
                                DateFormat('yyyy-MM-dd').format(dob).toString();
                          });
                        }
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // place of issue
                    fieldHeading(
                        title: "Place Of Issue",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _passportPlaceOfIssueFocusNode,
                        nextFocusNode: _passportUnifiedNoFocusNode,
                        controller: _passportPlaceOfIssueController,
                        hintText: "Enter Place Of Issue",
                        errorText: _passportPlaceOfIssueError,
                        onChanged: (value) {
                          if (_passportPlaceOfIssueFocusNode.hasFocus) {
                            setState(() {
                              _passportPlaceOfIssueError =
                                  ErrorText.getNameArabicEnglishValidationError(
                                      name:
                                          _passportPlaceOfIssueController.text,
                                      context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // passport unified number
                    fieldHeading(
                        title: "Passport Unified Number",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _passportUnifiedNoFocusNode,
                        nextFocusNode: _emiratesIdFocusNode,
                        controller: _passportUnifiedNoController,
                        hintText: "Unified number is on the last page",
                        errorText: _passportUnifiedNoError,
                        onChanged: (value) {
                          if (_passportUnifiedNoFocusNode.hasFocus) {
                            setState(() {
                              _passportUnifiedNoError =
                                  ErrorText.getUnifiedNumberError(
                                      unifiedNumber:
                                          _passportUnifiedNoController.text,
                                      context: context);
                            });
                          }
                        }),
                    // *--------------------------------------------------------- Passport Data Section end ------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *--------------------------------------------------------- Personal Details Section start ------------------------------------------------------------------------------*/
                    // personal Details heading
                    _sectionTitle(title: "Personal Details"),
                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // emirates id
                    fieldHeading(
                        title: "Emirates ID",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                      readOnly: true,
                      currentFocusNode: _emiratesIdFocusNode,
                      nextFocusNode: _emiratesIdFocusNode,
                      controller: _emiratesIdController,
                      hintText: "Enter Emirates ID",
                      errorText: _emiratesIdError,
                      inputFormat: [EmiratesIDFormatter()],
                      onChanged: (value) {
                        if (_emiratesIdFocusNode.hasFocus) {
                          setState(() {
                            _emiratesIdError = ErrorText.getEmirateIdError(
                                emirateId: _emiratesIdController.text,
                                context: context);
                          });
                        }
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // emirates id expiry Date
                    fieldHeading(
                        title: "Emirates ID Expiry Date",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDateField(
                      currentFocusNode: _emiratesIdExpiryDateFocusNode,
                      controller: _emiratesIdExpiryDateController,
                      hintText: "Enter Emirates ID Expiry Date",
                      errorText: _emiratesIdExpiryDateError,
                      onChanged: (value) async {
                        setState(() {
                          if (_emiratesIdExpiryDateFocusNode.hasFocus) {
                            _emiratesIdExpiryDateError =
                                ErrorText.getEmptyFieldError(
                                    name: _emiratesIdExpiryDateController.text,
                                    context: context);
                          }
                        });
                      },
                      onTap: () async {
                        // Clear the error if a date is selected
                        _emiratesIdExpiryDateError = null;

                        DateTime? dob = await showDatePicker(
                            context: context,
                            barrierColor:
                                AppColors.scoButtonColor.withOpacity(0.1),
                            barrierDismissible: false,
                            locale: Provider.of<LanguageChangeViewModel>(
                                    context,
                                    listen: false)
                                .appLocale,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 50 * 365)));
                        if (dob != null) {
                          setState(() {
                            _emiratesIdExpiryDateController.text =
                                DateFormat('yyyy-MM-dd').format(dob).toString();
                            Utils.requestFocus(
                                focusNode: _dateOfBirthFocusNode,
                                context: context);
                          });
                        }
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    //  Date of birth
                    fieldHeading(
                        title: "Date Of Birth",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDateField(
                      currentFocusNode: _dateOfBirthFocusNode,
                      controller: _dateOfBirthController,
                      hintText: "Enter Date Of Birth",
                      errorText: _dateOfBirthError,
                      onChanged: (value) async {
                        setState(() {
                          if (_dateOfBirthFocusNode.hasFocus) {
                            _dateOfBirthError = ErrorText.getEmptyFieldError(
                                name: _dateOfBirthController.text,
                                context: context);
                          }
                        });
                      },
                      onTap: () async {
                        // Clear the error if a date is selected
                        _dateOfBirthError = null;

                        // Define the initial date (e.g., today's date)
                        final DateTime initialDate = DateTime.now();

                        // Define the start date (100 years ago from today)
                        final DateTime firstDate = DateTime.now()
                            .subtract(const Duration(days: 100 * 365));

                        DateTime? dob = await showDatePicker(
                          context: context,
                          barrierColor:
                              AppColors.scoButtonColor.withOpacity(0.1),
                          barrierDismissible: false,
                          locale: Provider.of<LanguageChangeViewModel>(context,
                                  listen: false)
                              .appLocale,
                          initialDate: initialDate,
                          firstDate: firstDate,
                          lastDate: initialDate,
                        );
                        if (dob != null) {
                          setState(() {
                            Utils.requestFocus(
                                focusNode: _placeOfBirthFocusNode,
                                context: context);
                            _dateOfBirthController.text =
                                DateFormat('yyyy-MM-dd').format(dob).toString();
                          });
                        }
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // place of birth
                    fieldHeading(
                        title: "Place Of Birth",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _placeOfBirthFocusNode,
                        nextFocusNode: _genderFocusNode,
                        controller: _placeOfBirthController,
                        hintText: "Enter Place Of Birth",
                        errorText: _placeOfBirthError,
                        onChanged: (value) {
                          if (_placeOfBirthFocusNode.hasFocus) {
                            setState(() {
                              _placeOfBirthError =
                                  ErrorText.getNameArabicEnglishValidationError(
                                      name: _placeOfBirthController.text,
                                      context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Gender
                    fieldHeading(
                        title: "Gender",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDropdown(
                      controller: _genderController,
                      currentFocusNode: _genderFocusNode,
                      menuItemsList: _genderMenuItemsList,
                      hintText: "Select Gender",
                      errorText: _genderError,
                      onChanged: (value) {
                        _genderError = null;
                        setState(() {
                          _genderController.text = value!;
                          //This thing is creating error: don't know how to fix it:
                          Utils.requestFocus(
                              focusNode: _maritalStatusFocusNode,
                              context: context);
                        });
                      },
                    ),

                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // Gender
                    fieldHeading(
                        title: "Marital Status",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormDropdown(
                      controller: _maritalStatusController,
                      currentFocusNode: _maritalStatusFocusNode,
                      menuItemsList: _maritalStatusMenuItemsList,
                      hintText: "Select Marital Status",
                      errorText: _maritalStatusError,
                      onChanged: (value) {
                        _maritalStatusError = null;
                        setState(() {
                          _maritalStatusController.text = value!;
                          //This thing is creating error: don't know how to fix it:
                          Utils.requestFocus(
                              focusNode: _studentEmailFocusNode,
                              context: context);
                        });
                      },
                    ),

                    // ****************************************************************************************************************************************************
                    kFormHeight,
                    // email address
                    fieldHeading(
                        title: "Email Address",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _studentEmailFocusNode,
                        // nextFocusNode: ,
                        controller: _studentEmailController,
                        hintText: "Enter Email Address",
                        errorText: _studentEmailError,
                        onChanged: (value) {
                          if (_studentEmailFocusNode.hasFocus) {
                            setState(() {
                              _studentEmailError = ErrorText.getEmailError(
                                  email: _studentEmailController.text,
                                  context: context);
                            });
                          }
                        }),

                    // ****************************************************************************************************************************************************

                    // Family Information

                    (_passportNationalityController.text != "ARE" &&
                            _selectedScholarship?.admitType != 'INT')
                        ? Column(
                            children: [
                              kFormHeight,
                              // is mother UAE
                              CustomGFCheckbox(
                                  value: _isMotherUAECheckbox,
                                  onChanged: (value) {
                                    setState(() {
                                      _isMotherUAECheckbox = value ?? false;
                                      _motherUAENationalController.text =
                                          _isMotherUAECheckbox.toString();
                                    });
                                  },
                                  text: "Sons of citizens",
                                  textStyle: AppTextStyles.titleTextStyle()
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                            ],
                          )
                        : _passportNationalityController.text == 'ARE'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // *--------------------------------------------------------- Family Information Section start ------------------------------------------------------------------------------*/

                                  _sectionDivider(),

                                  // *--------------------------------------------------------- Family Information Section end ------------------------------------------------------------------------------*/
                                  // Family Information
                                  _sectionTitle(title: "Family Information"),
                                  // ****************************************************************************************************************************************************
                                  kFormHeight,
                                  // Emirates
                                  fieldHeading(
                                      title: "Emirates",
                                      important: true,
                                      langProvider: langProvider),

                                  _scholarshipFormDropdown(
                                    controller:
                                        _familyInformationEmiratesController,
                                    currentFocusNode:
                                        _familyInformationEmiratesFocusNode,
                                    menuItemsList:
                                        _familyInformationEmiratesMenuItemsList,
                                    hintText: "Select Emirates Type",
                                    errorText:
                                        _familyInformationEmiratesErrorText,
                                    onChanged: (value) {
                                      _familyInformationEmiratesErrorText =
                                          null;
                                      setState(() {
                                        // setting the value for emirates type
                                        _familyInformationEmiratesController
                                            .text = value!;
                                        // populate the village or town dropdown
                                        _familyInformationTownMenuItemsList
                                            .clear();
                                        _familyInformationTownVillageNoController
                                            .clear();
                                        _populateTownOnFamilyInformationEmiratesItem(
                                            langProvider: langProvider);
                                        Utils.requestFocus(
                                            focusNode:
                                                _familyInformationTownVillageNoFocusNode,
                                            context: context);
                                      });
                                    },
                                  ),

                                  // ****************************************************************************************************************************************************
                                  kFormHeight,
                                  // Emirates
                                  fieldHeading(
                                      title: "Town's/Village's no",
                                      important: true,
                                      langProvider: langProvider),

                                  _scholarshipFormDropdown(
                                    controller:
                                        _familyInformationTownVillageNoController,
                                    currentFocusNode:
                                        _familyInformationTownVillageNoFocusNode,
                                    menuItemsList:
                                        _familyInformationTownMenuItemsList,
                                    hintText: "Select Town's/Village's no",
                                    errorText:
                                        _familyInformationTownVillageNoErrorText,
                                    onChanged: (value) {
                                      _familyInformationTownVillageNoErrorText =
                                          null;
                                      setState(() {
                                        // setting the value for village or town type
                                        _familyInformationTownVillageNoController
                                            .text = value!;
                                        Utils.requestFocus(
                                            focusNode:
                                                _familyInformationParentGuardianNameFocusNode,
                                            context: context);
                                      });
                                    },
                                  ),

                                  // ****************************************************************************************************************************************************

                                  kFormHeight,
                                  // relative name
                                  fieldHeading(
                                      title: "Parent/Guardian name",
                                      important: true,
                                      langProvider: langProvider),
                                  _scholarshipFormTextField(
                                      currentFocusNode:
                                          _familyInformationParentGuardianNameFocusNode,
                                      nextFocusNode:
                                          _familyInformationRelationTypeFocusNode,
                                      controller:
                                          _familyInformationParentGuardianNameController,
                                      hintText: "Enter Parent/Guardian name",
                                      errorText:
                                          _familyInformationParentGuardianNameErrorText,
                                      onChanged: (value) {
                                        if (_familyInformationParentGuardianNameFocusNode
                                            .hasFocus) {
                                          setState(() {
                                            _familyInformationParentGuardianNameErrorText =
                                                ErrorText
                                                    .getNameArabicEnglishValidationError(
                                                        name:
                                                            _familyInformationParentGuardianNameController
                                                                .text,
                                                        context: context);
                                          });
                                        }
                                      }),

                                  // ****************************************************************************************************************************************************
                                  kFormHeight,
                                  // Emirates
                                  fieldHeading(
                                      title: "Relation Type",
                                      important: true,
                                      langProvider: langProvider),
                                  _scholarshipFormDropdown(
                                    controller:
                                        _familyInformationRelationTypeController,
                                    currentFocusNode:
                                        _familyInformationRelationTypeFocusNode,
                                    menuItemsList:
                                        _relationshipTypeMenuItemsList,
                                    hintText: "Select Relation Type",
                                    errorText:
                                        _familyInformationRelationTypeErrorText,
                                    onChanged: (value) {
                                      _familyInformationRelationTypeErrorText =
                                          null;
                                      setState(() {
                                        // setting the value for village or town type
                                        _familyInformationRelationTypeController
                                            .text = value!;
                                        Utils.requestFocus(
                                            focusNode:
                                                _familyInformationFamilyBookNumberFocusNode,
                                            context: context);
                                      });
                                    },
                                  ),
                                  // ****************************************************************************************************************************************************

                                  kFormHeight,
                                  // relative name
                                  fieldHeading(
                                      title: "Family Book Number",
                                      important: false,
                                      langProvider: langProvider),
                                  _scholarshipFormTextField(
                                      currentFocusNode:
                                          _familyInformationFamilyBookNumberFocusNode,
                                      controller:
                                          _familyInformationFamilyBookNumberController,
                                      hintText: "Enter Family Book Number",
                                      errorText:
                                          _familyInformationFamilyBookNumberErrorText,
                                      onChanged: (value) {
                                        if (_familyInformationFamilyBookNumberFocusNode
                                            .hasFocus) {
                                          // setState(() {
                                          //   _familyInformationFamilyBookNumberErrorText =
                                          //       ErrorText.getEmptyFieldError(
                                          //           name:
                                          //               _familyInformationFamilyBookNumberController
                                          //                   .text,
                                          //           context: context);
                                          // });
                                        }
                                      }),

                                  // ****************************************************************************************************************************************************

                                  kFormHeight,
                                  // relative name
                                  fieldHeading(
                                      title: "Mother Name",
                                      important: true,
                                      langProvider: langProvider),
                                  _scholarshipFormTextField(
                                      currentFocusNode:
                                          _familyInformationMotherNameFocusNode,
                                      controller:
                                          _familyInformationMotherNameController,
                                      hintText: "Enter Mother Name",
                                      errorText:
                                          _familyInformationMotherNameErrorText,
                                      onChanged: (value) {
                                        if (_familyInformationMotherNameFocusNode
                                            .hasFocus) {
                                          setState(() {
                                            _familyInformationMotherNameErrorText =
                                                ErrorText.getEmptyFieldError(
                                                    name:
                                                        _familyInformationMotherNameController
                                                            .text,
                                                    context: context);
                                          });
                                        }
                                      }),
                                ],
                              )
                            : showVoid,

                    // *--------------------------------------------------------- Personal Details Section end ------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *--------------------------------------------------------- Relative Information Section Start ------------------------------------------------------------------------------*/
                    // Relative Information
                    _sectionTitle(title: "Add a Scholarship Relative"),
                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // heading text for user reading
                    fieldHeading(
                        title:
                            "Do you have relatives currently on scholarships from the office?",
                        important: true,
                        langProvider: langProvider),

                    // ****************************************************************************************************************************************************

                    // Yes or no : Show round checkboxes
                    CustomRadioListTile(
                      value: true,
                      focusNode: _isRelativeStudyingFromScholarshipYesFocusNode,
                      groupValue: _isRelativeStudyingFromScholarship,
                      onChanged: (value) {
                        setState(() {
                          _isRelativeStudyingFromScholarship = value;
                          // add first relative
                          _addRelative();
                        });
                      },
                      title: "Yes",
                      textStyle: _textFieldTextStyle,
                    ),

                    // ****************************************************************************************************************************************************
                    CustomRadioListTile(
                        value: false,
                        groupValue: _isRelativeStudyingFromScholarship,
                        onChanged: (value) {
                          setState(() {
                            _isRelativeStudyingFromScholarship = value;
                            // clear the relatives list
                            _relativeInfoList.clear();
                          });
                        },
                        title: "No",
                        textStyle: _textFieldTextStyle),

                    // ****************************************************************************************************************************************************

                    // No: If no then don't show module to fill the relative information
                    // Yes: if yes then show module to fill the relative information
                    kFormHeight,
                    _isRelativeStudyingFromScholarship == null
                        ? showVoid
                        : _isRelativeStudyingFromScholarship!
                            ? ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _relativeInfoList.length,
                                itemBuilder: (context, index) {
                                  final relativeInformation =
                                      _relativeInfoList[index];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // ****************************************************************************************************************************************************
                                      // relative name
                                      fieldHeading(
                                          title: "Relative Name",
                                          important: false,
                                          langProvider: langProvider),
                                      _scholarshipFormTextField(
                                          currentFocusNode: relativeInformation
                                              .relativeNameFocusNode,
                                          nextFocusNode: relativeInformation
                                              .relationTypeFocusNode,
                                          controller: relativeInformation
                                              .relativeNameController,
                                          hintText: "Enter Relative Name",
                                          errorText: relativeInformation
                                              .relativeNameError,
                                          onChanged: (value) {
                                            if (relativeInformation
                                                .relativeNameFocusNode
                                                .hasFocus) {
                                              setState(() {
                                                relativeInformation
                                                        .relativeNameError =
                                                    ErrorText.getNameArabicEnglishValidationError(
                                                        name: _relativeInfoList[
                                                                index]
                                                            .relativeNameController
                                                            .text,
                                                        context: context);
                                              });
                                            }
                                          }),
                                      // ****************************************************************************************************************************************************

                                      // relative relation type
                                      kFormHeight,
                                      fieldHeading(
                                          title: "Relation Type",
                                          important: true,
                                          langProvider: langProvider),
                                      _scholarshipFormDropdown(
                                        controller: relativeInformation
                                            .relationTypeController,
                                        currentFocusNode: relativeInformation
                                            .relationTypeFocusNode,
                                        menuItemsList:
                                            _relationshipTypeMenuItemsList,
                                        hintText: "Select Relation Type",
                                        errorText: relativeInformation
                                            .relationTypeError,
                                        onChanged: (value) {
                                          relativeInformation
                                              .relationTypeError = null;
                                          setState(() {
                                            // setting the value for relation type
                                            relativeInformation
                                                .relationTypeController
                                                .text = value!;
                                            //This thing is creating error: don't know how to fix it:
                                            Utils.requestFocus(
                                                focusNode: _relativeInfoList[
                                                        index]
                                                    .countryUniversityFocusNode,
                                                context: context);
                                          });
                                        },
                                      ),
                                      // ****************************************************************************************************************************************************

                                      // relative country-University
                                      kFormHeight,
                                      fieldHeading(
                                          title: "Country - University",
                                          important: false,
                                          langProvider: langProvider),
                                      _scholarshipFormTextField(
                                          currentFocusNode: relativeInformation
                                              .countryUniversityFocusNode,
                                          nextFocusNode: index <
                                                  _relativeInfoList.length - 1
                                              ? _relativeInfoList[index + 1]
                                                  .relativeNameFocusNode
                                              : null,
                                          controller: relativeInformation
                                              .countryUniversityController,
                                          hintText:
                                              "Enter Country - University",
                                          errorText: relativeInformation
                                              .countryUniversityError,
                                          onChanged: (value) {
                                            // no validation has been provided
                                            if (relativeInformation
                                                .countryUniversityFocusNode
                                                .hasFocus) {
                                              setState(() {
                                                relativeInformation
                                                        .countryUniversityError =
                                                    ErrorText.getNameArabicEnglishValidationError(
                                                        name: _relativeInfoList[
                                                                index]
                                                            .countryUniversityController
                                                            .text,
                                                        context: context);
                                              });
                                            }
                                          }),

                                      // ****************************************************************************************************************************************************

                                      // relative country-University
                                      // kFormHeight,
                                      // fieldHeading(
                                      //     title: "Family Book Number",
                                      //     important: true,
                                      //     langProvider: langProvider),
                                      // _scholarshipFormTextField(
                                      //     currentFocusNode: relativeInformation
                                      //         .familyBookNumberFocusNode,
                                      //     nextFocusNode: index <
                                      //             _relativeInfoList.length - 1
                                      //         ? _relativeInfoList[index + 1]
                                      //             .relativeNameFocusNode
                                      //         : null,
                                      //     controller: relativeInformation
                                      //         .familyBookNumberController,
                                      //     errorText: relativeInformation
                                      //         .familyBookNumberError,
                                      //     hintText: "Enter Family Book Number",
                                      //     onChanged: (value) {
                                      //       if (relativeInformation
                                      //           .familyBookNumberFocusNode
                                      //           .hasFocus) {
                                      //         setState(() {
                                      //           relativeInformation
                                      //                   .familyBookNumberError =
                                      //               ErrorText.getEnglishArabicNumberError(
                                      //                   input: _relativeInfoList[
                                      //                           index]
                                      //                       .familyBookNumberController
                                      //                       .text,
                                      //                   context: context);
                                      //         });
                                      //       }
                                      //     }),

                                      // ****************************************************************************************************************************************************
                                      // remove Relative
                                      _addRemoveMoreSection(
                                          title: "Delete Info",
                                          add: false,
                                          onChanged: () {
                                            // if we remove 0'th index item also then set _isRelativeStudying to false
                                            if (_relativeInfoList.length == 1 &&
                                                index == 0) {
                                              _removeRelative(index);
                                              _isRelativeStudyingFromScholarship =
                                                  false;
                                            } else {
                                              _removeRelative(index);
                                            }
                                          }),
                                      // ****************************************************************************************************************************************************

                                      // internal sections divider
                                      const MyDivider(
                                        color: AppColors.lightGrey,
                                      ),

                                      // ****************************************************************************************************************************************************

                                      // space based on if not last item
                                      (index != _relativeInfoList.length - 1)
                                          ? kFormHeight
                                          : showVoid,
                                    ],
                                  );
                                })
                            : showVoid,

                    // ****************************************************************************************************************************************************
                    // Add More Information container
                    _relativeInfoList.isNotEmpty
                        ? _addRemoveMoreSection(
                            title: "Add Relative Info",
                            add: true,
                            onChanged: () {
                              _addRelative();
                            })
                        : showVoid,

                    // *--------------------------------------------------------- Relative Information Section end ------------------------------------------------------------------------------*/
                    _sectionDivider(),

                    // *--------------------------------------------------------- Contact Information Section start ------------------------------------------------------------------------------*/

                    // ****************************************************************************************************************************************************
                    // Title for Contact Information
                    _sectionTitle(title: "Contact Information"),
                    kFormHeight,
                    // ****************************************************************************************************************************************************

                    _phoneNumberSection(),
                    // *--------------------------------------------------------- Contact Information Section end ------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *--------------------------------------------------------- Address Information Section start ------------------------------------------------------------------------------*/

                    // ****************************************************************************************************************************************************
                    // Title for Address Information
                    _sectionTitle(title: "Address Data"),
                    kFormHeight,
                    // ****************************************************************************************************************************************************
                    _addressInformationSection(),
                    // *--------------------------------------------------------- Address Information Section end ------------------------------------------------------------------------------*/

                    (_passportNationalityController.text.isNotEmpty &&
                            _passportNationalityController.text == "ARE")
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionDivider(),

                              // *--------------------------------------------------------- Military Services Information Section start ------------------------------------------------------------------------------*/

                              // ****************************************************************************************************************************************************
                              // Title for Address Information
                              _sectionTitle(title: "Military Services"),
                              kFormHeight,
                              // ****************************************************************************************************************************************************

                              _militaryServicesSection(),

                              // *--------------------------------------------------------- Military Services  Section end ------------------------------------------------------------------------------*/
                            ],
                          )
                        : showVoid
                  ],
                )),
            draftPrevNextButtons(langProvider),
          ],
        ),
      ),
    );
  }

  // *--------------------------------------------------------------- Phone Number Information data start----------------------------------------------------------------------------*

  // phone number dropdown menu items list
  List<DropdownMenuItem> _phoneNumberTypeMenuItemsList = [];

  // List of Phone Number information
  List<PhoneNumber> _phoneNumberList = [];

  // Method to add a new phone number to the contact information list
  void _addPhoneNumber() {
    setState(() {
      _phoneNumberList.add(PhoneNumber(
          countryCodeController: TextEditingController(),
          phoneNumberController: TextEditingController(),
          phoneTypeController: TextEditingController(),
          preferred: false,
          countryCodeFocusNode: FocusNode(),
          phoneNumberFocusNode: FocusNode(),
          phoneTypeFocusNode: FocusNode(),
          phoneNumberError: null,
          phoneTypeError: null,
          countryCodeError: null));
    });
  }

  // Method to add a new phone number to the contact information list
  void _removePhoneNumber(int index) {
    if (index >= 2 && index < _phoneNumberList.length) {
      // Check if index is valid
      setState(() {
        final phoneNumber = _phoneNumberList[index];

        phoneNumber.countryCodeController.dispose(); // Dispose the controllers
        phoneNumber.phoneNumberController.dispose();
        phoneNumber.phoneTypeController.dispose();
        phoneNumber.preferred = false;
        phoneNumber.countryCodeFocusNode.dispose(); // Dispose the controllers
        phoneNumber.phoneNumberFocusNode.dispose();
        phoneNumber.phoneTypeFocusNode.dispose();
        _phoneNumberList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); // Debugging print to show invalid index
    }
  }

  Widget _phoneNumberSection() {
    // defining langProvider
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _phoneNumberList.length,
            itemBuilder: (context, index) {
              final phoneNumber = _phoneNumberList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // phone Type
                  fieldHeading(
                      title: "Phone Type",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    readOnly: (index == 0 || index == 1),
                    filled: (index == 0 || index == 1),
                    controller: phoneNumber.phoneTypeController,
                    currentFocusNode: phoneNumber.phoneTypeFocusNode,
                    menuItemsList: _phoneNumberTypeMenuItemsList,
                    hintText: "Select Phone Type",
                    errorText: phoneNumber.phoneTypeError,
                    onChanged: (value) {
                      phoneNumber.phoneTypeError = null;
                      setState(() {
                        // setting the value for relation type
                        phoneNumber.phoneTypeController.text = value!;
                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(
                            focusNode: phoneNumber.phoneNumberFocusNode,
                            context: context);
                      });
                    },
                  ),
                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "Phone Number",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode: phoneNumber.phoneNumberFocusNode,
                      nextFocusNode: phoneNumber.countryCodeFocusNode,
                      controller: phoneNumber.phoneNumberController,
                      hintText: "Enter Phone Number",
                      errorText: phoneNumber.phoneNumberError,
                      onChanged: (value) {
                        // no validation has been provided
                        if (phoneNumber.phoneNumberFocusNode.hasFocus) {
                          setState(() {
                            phoneNumber.phoneNumberError =
                                ErrorText.getPhoneNumberError(
                                    phoneNumber:
                                        phoneNumber.phoneNumberController.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "Country Code",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode: phoneNumber.countryCodeFocusNode,
                      nextFocusNode: index < _phoneNumberList.length - 1
                          ? _phoneNumberList[index + 1].phoneTypeFocusNode
                          : null,
                      controller: phoneNumber.countryCodeController,
                      hintText: "Enter Phone Number",
                      errorText: phoneNumber.countryCodeError,
                      onChanged: (value) {
                        // no validation has been provided
                        if (phoneNumber.countryCodeFocusNode.hasFocus) {
                          setState(() {
                            phoneNumber.countryCodeError =
                                ErrorText.getEmptyFieldError(
                                    name:
                                        phoneNumber.countryCodeController.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  // Preferred
                  CustomGFCheckbox(
                      value: phoneNumber.preferred,
                      onChanged: (onChanged) {
                        setState(() {
                          phoneNumber.preferred = !phoneNumber.preferred;
                        });
                      },
                      text: "Favorite Phone"),

                  // ****************************************************************************************************************************************************

                  // space based on condition
                  (index == 0 || index == 1) ? kFormHeight : showVoid,

                  // Add More Information container
                  (_phoneNumberList.isNotEmpty && (index != 0 && index != 1))
                      ? _addRemoveMoreSection(
                          title: "Delete Info",
                          add: false,
                          onChanged: () {
                            _removePhoneNumber(index);
                          })
                      : showVoid,

                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  // ****************************************************************************************************************************************************

                  // space based on if not last item
                  index != _phoneNumberList.length - 1 ? kFormHeight : showVoid,
                ],
              );
            }),

        // Add more Phones Numbers
        // Add More Information container
        _phoneNumberList.isNotEmpty
            ? _addRemoveMoreSection(
                title: "Add Phone Number",
                add: true,
                onChanged: () {
                  _addPhoneNumber();
                })
            : showVoid,
      ],
    );
  }

  // *---------------------------------------------------------------Phone Number Information data end----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Address Information Section start ----------------------------------------------------------------------------*

  // address type dropdown menu Item list
  List<DropdownMenuItem> _addressTypeMenuItemsList = [];

  // populate state dropdown menuItem List
  _populateStateDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
              .lovCodeMap[
                  'STATE#${_addressInformationList[index].countryController.text}']
              ?.values !=
          null) {
        _addressInformationList[index].stateDropdownMenuItems =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                        'STATE#${_addressInformationList[index].countryController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  // address list
  List<Address> _addressInformationList = [];

  // add Address
  void _addAddress() {
    setState(() {
      _addressInformationList.add(Address(
          addressTypeController: TextEditingController(),
          addressLine1Controller: TextEditingController(),
          addressLine2Controller: TextEditingController(),
          // Optional
          cityController: TextEditingController(),
          stateController: TextEditingController(),
          // Optional
          postalCodeController: TextEditingController(),
          // Optional
          countryController: TextEditingController(),
          addressTypeFocusNode: FocusNode(),
          addressLine1FocusNode: FocusNode(),
          addressLine2FocusNode: FocusNode(),
          // Optional
          cityFocusNode: FocusNode(),
          stateFocusNode: FocusNode(),
          // Optional
          postalCodeFocusNode: FocusNode(),
          // Optional
          countryFocusNode: FocusNode(),
          countryDropdownMenuItems: _nationalityMenuItemsList,
          stateDropdownMenuItems: []));
    });
  }

  // remove address
  void _removeAddress(int index) {
    if (index >= 1 && index < _addressInformationList.length) {
      setState(() {
        final addressInformation = _addressInformationList[index];

        // Dispose controllers and focus nodes
        addressInformation.addressTypeController.dispose();
        addressInformation.addressLine1Controller.dispose();
        addressInformation.addressLine2Controller.dispose(); // Optional
        addressInformation.cityController.dispose();
        addressInformation.stateController.dispose(); // Optional
        addressInformation.postalCodeController.dispose(); // Optional
        addressInformation.countryController.dispose();

        addressInformation.addressTypeFocusNode.dispose();
        addressInformation.addressLine1FocusNode.dispose();
        addressInformation.addressLine2FocusNode.dispose(); // Optional
        addressInformation.cityFocusNode.dispose();
        addressInformation.stateFocusNode.dispose(); // Optional
        addressInformation.postalCodeFocusNode.dispose(); // Optional
        addressInformation.countryFocusNode.dispose();

        addressInformation.countryDropdownMenuItems?.clear();
        addressInformation.stateDropdownMenuItems?.clear();

        // Remove the address entry from the list
        _addressInformationList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); // For debugging invalid index
    }
  }

  Widget _addressInformationSection() {
    // defining langProvider
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _addressInformationList.length,
            itemBuilder: (context, index) {
              final addressInformation = _addressInformationList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // phone Type
                  fieldHeading(
                      title: "Address Type",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: addressInformation.addressTypeController,
                    currentFocusNode: addressInformation.addressTypeFocusNode,
                    menuItemsList: _addressTypeMenuItemsList,
                    hintText: "Select Address Type",
                    errorText: addressInformation.addressTypeError,
                    onChanged: (value) {
                      addressInformation.addressTypeError = null;
                      setState(() {
                        // setting the value for address type
                        addressInformation.addressTypeController.text = value!;
                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(
                            focusNode: addressInformation.addressLine1FocusNode,
                            context: context);
                      });
                    },
                  ),
                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "Address Line 1",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode:
                          addressInformation.addressLine1FocusNode,
                      nextFocusNode: addressInformation.addressLine2FocusNode,
                      controller: addressInformation.addressLine1Controller,
                      hintText: "Enter Address Line 1",
                      errorText: addressInformation.addressLine1Error,
                      onChanged: (value) {
                        if (addressInformation.addressLine1FocusNode.hasFocus) {
                          setState(() {
                            addressInformation.addressLine1Error =
                                ErrorText.getNameArabicEnglishValidationError(
                                    name: addressInformation
                                        .addressLine1Controller.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "Address Line 2",
                      important: false,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode:
                          addressInformation.addressLine2FocusNode,
                      nextFocusNode: addressInformation.countryFocusNode,
                      controller: addressInformation.addressLine2Controller,
                      hintText: "Enter Address Line 2",
                      errorText: addressInformation.addressLine2Error,
                      onChanged: (value) {
                        if (addressInformation.addressLine2FocusNode.hasFocus) {
                          setState(() {
                            addressInformation.addressLine2Error =
                                ErrorText.getNameArabicEnglishValidationError(
                                    name: addressInformation
                                        .addressLine2Controller.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  // phone Type
                  fieldHeading(
                      title: "Country",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: addressInformation.countryController,
                    currentFocusNode: addressInformation.countryFocusNode,
                    menuItemsList: _nationalityMenuItemsList,
                    hintText: "Select Country",
                    errorText: addressInformation.countryError,
                    onChanged: (value) {
                      addressInformation.countryError = null;
                      setState(() {
                        // setting the value for address type
                        addressInformation.countryController.text = value!;

                        // populating the state dropdown
                        addressInformation.stateDropdownMenuItems?.clear();
                        addressInformation.stateController.clear();
                        _populateStateDropdown(
                            langProvider: langProvider, index: index);

                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(
                            focusNode: addressInformation.stateFocusNode,
                            context: context);
                      });
                    },
                  ),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  // phone Type
                  fieldHeading(
                      title: "Emirates/State",
                      important: addressInformation
                              .stateDropdownMenuItems?.isNotEmpty ??
                          false,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    filled: addressInformation.stateDropdownMenuItems?.isEmpty,
                    controller: addressInformation.stateController,
                    currentFocusNode: addressInformation.stateFocusNode,
                    menuItemsList: addressInformation.stateDropdownMenuItems,
                    hintText: "Select Emirates/State",
                    errorText: addressInformation.stateError,
                    onChanged: (value) {
                      addressInformation.stateError = null;
                      setState(() {
                        // setting the value for address type
                        addressInformation.stateController.text = value!;
                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(
                            focusNode: addressInformation.cityFocusNode,
                            context: context);
                      });
                    },
                  ),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "City",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode: addressInformation.cityFocusNode,
                      nextFocusNode: addressInformation.postalCodeFocusNode,
                      controller: addressInformation.cityController,
                      hintText: "Enter City",
                      errorText: addressInformation.cityError,
                      onChanged: (value) {
                        if (addressInformation.cityFocusNode.hasFocus) {
                          setState(() {
                            addressInformation.cityError =
                                ErrorText.getNameArabicEnglishValidationError(
                                    name:
                                        addressInformation.cityController.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "PO Box",
                      important: false,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      currentFocusNode: addressInformation.postalCodeFocusNode,
                      controller: addressInformation.postalCodeController,
                      hintText: "Enter PO Box",
                      errorText: addressInformation.postalCodeError,
                      onChanged: (value) {
                        if (addressInformation.postalCodeFocusNode.hasFocus) {
                          setState(() {
                            addressInformation.postalCodeError =
                                ErrorText.getPinCodeValidationError(
                                    pinCode: addressInformation
                                        .postalCodeController.text,
                                    context: context);
                          });
                        }
                      }),

                  // ****************************************************************************************************************************************************

                  // space based on condition
                  (index == 0) ? kFormHeight : showVoid,

                  // Add More Information container
                  (_addressInformationList.isNotEmpty && (index != 0))
                      ? _addRemoveMoreSection(
                          title: "Delete Address",
                          add: false,
                          onChanged: () {
                            _removeAddress(index);
                          })
                      : showVoid,

                  // light color divider
                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  // ****************************************************************************************************************************************************

                  // space based on if not last item
                  index != _addressInformationList.length - 1
                      ? kFormHeight
                      : showVoid,
                ],
              );
            }),

        // Add more Phones Numbers
        // Add More Information container
        _addressInformationList.isNotEmpty
            ? _addRemoveMoreSection(
                title: "Add Address",
                add: true,
                onChanged: () {
                  _addAddress();
                })
            : showVoid,
      ],
    );
  }

  // *--------------------------------------------------------------- Address Information Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Military Information Section start ----------------------------------------------------------------------------*

  dynamic _isMilitaryService;

  // TextEditingControllers for military service
  TextEditingController _militaryServiceController = TextEditingController();
  TextEditingController _militaryServiceStartDateController =
      TextEditingController();
  TextEditingController _militaryServiceEndDateController =
      TextEditingController();
  TextEditingController _reasonForMilitaryController = TextEditingController();

  // FocusNodes for each field
  FocusNode _militaryServiceFocusNode = FocusNode();
  FocusNode _militaryServiceStartDateFocusNode = FocusNode();
  FocusNode _militaryServiceEndDateFocusNode = FocusNode();
  FocusNode _reasonForMilitaryFocusNode = FocusNode();

  // Error texts for each field
  String? _militaryServiceErrorText;
  String? _militaryServiceStartDateErrorText;
  String? _militaryServiceEndDateErrorText;
  String? _reasonForMilitaryErrorText;

  // Show round radiobuttons to select the military options
  Widget _militaryServicesSection() {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Column(
      children: [
        kFormHeight,
        // heading text for user reading
        fieldHeading(
            title: "Did you served in military?",
            important: true,
            langProvider: langProvider),

        // ****************************************************************************************************************************************************

        // Yes or no : Show round checkboxes to select the military options
        CustomRadioListTile(
          value: MilitaryStatus.yes,
          groupValue: _isMilitaryService,
          onChanged: (value) {
            setState(() {
              _isMilitaryService = value;
              _militaryServiceController.text = 'Y';
            });
          },
          title: "Yes",
          textStyle: _textFieldTextStyle,
        ),

        // ****************************************************************************************************************************************************
        CustomRadioListTile(
            value: MilitaryStatus.no,
            groupValue: _isMilitaryService,
            onChanged: (value) {
              setState(() {
                _isMilitaryService = value;

                // if no is selected then clear the values in the text editing controllers
                _militaryServiceController.text = 'N';
                _militaryServiceStartDateController.clear();
                _militaryServiceEndDateController.clear();
                _reasonForMilitaryController.clear();
              });
            },
            title: "No",
            textStyle: _textFieldTextStyle),

        // ****************************************************************************************************************************************************
        CustomRadioListTile(
            value: MilitaryStatus.postponed,
            groupValue: _isMilitaryService,
            onChanged: (value) {
              setState(() {
                _isMilitaryService = value;
                _militaryServiceController.text = 'P';
                _militaryServiceStartDateController.clear();
                _militaryServiceEndDateController.clear();
                _reasonForMilitaryController.clear();
              });
            },
            title: "Postponed",
            textStyle: _textFieldTextStyle),

        // ****************************************************************************************************************************************************
        CustomRadioListTile(
            value: MilitaryStatus.exemption,
            groupValue: _isMilitaryService,
            onChanged: (value) {
              setState(() {
                _isMilitaryService = value;
                _militaryServiceController.text = 'R';
                _militaryServiceStartDateController.clear();
                _militaryServiceEndDateController.clear();
                _reasonForMilitaryController.clear();
              });
            },
            title: "Relief or Exemption",
            textStyle: _textFieldTextStyle),
        // ****************************************************************************************************************************************************
        _militaryServicesFields(),
      ],
    );
  }

  // input fields based on selection on military services
  Widget _militaryServicesFields() {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    switch (_isMilitaryService) {
      case MilitaryStatus.yes:
        return Column(
          children: [
            kFormHeight,
            //  Start Date
            fieldHeading(
                title: "Start Date",
                important: true,
                langProvider: langProvider),
            _scholarshipFormDateField(
              currentFocusNode: _militaryServiceStartDateFocusNode,
              controller: _militaryServiceStartDateController,
              hintText: "Select Start Date",
              errorText: _militaryServiceStartDateErrorText,
              onChanged: (value) async {
                setState(() {
                  if (_militaryServiceStartDateFocusNode.hasFocus) {
                    _militaryServiceStartDateErrorText =
                        ErrorText.getEmptyFieldError(
                            name: _militaryServiceStartDateController.text,
                            context: context);
                  }
                });
              },
              onTap: () async {
                // Clear the error if a date is selected
                _militaryServiceStartDateErrorText = null;

                // Define the initial date (e.g., today's date)
                final DateTime initialDate = DateTime.now();

                // Define the start date (100 years ago from today)
                final DateTime firstDate =
                    DateTime.now().subtract(const Duration(days: 100 * 365));

                DateTime? date = await showDatePicker(
                  context: context,
                  barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                  barrierDismissible: false,
                  locale: Provider.of<LanguageChangeViewModel>(context,
                          listen: false)
                      .appLocale,
                  initialDate: initialDate,
                  firstDate: firstDate,
                  lastDate: initialDate,
                );
                if (date != null) {
                  setState(() {
                    Utils.requestFocus(
                        focusNode: _militaryServiceEndDateFocusNode,
                        context: context);
                    _militaryServiceStartDateController.text =
                        DateFormat('yyyy-MM-dd').format(date).toString();
                  });
                }
              },
            ),

            // ****************************************************************************************************************************************************
            kFormHeight,
            //  End Date
            fieldHeading(
                title: "End Date", important: true, langProvider: langProvider),

            _scholarshipFormDateField(
              currentFocusNode: _militaryServiceEndDateFocusNode,
              controller: _militaryServiceEndDateController,
              hintText: "Select End Date",
              errorText: _militaryServiceEndDateErrorText,
              onChanged: (value) async {
                setState(() {
                  if (_militaryServiceEndDateFocusNode.hasFocus) {
                    _militaryServiceEndDateErrorText =
                        ErrorText.getEmptyFieldError(
                      name: _militaryServiceEndDateController.text,
                      context: context,
                    );
                  }
                });
              },
              onTap: () async {
                // Clear the error if a date is selected
                _militaryServiceEndDateErrorText = null;

                // Define the initial date (e.g., today's date)
                final DateTime initialDate = DateTime.now();

                // Define the start date (100 years ago from today)
                final DateTime firstDate =
                    DateTime.now().subtract(const Duration(days: 100 * 365));

                final DateTime lastDate =
                    DateTime.now().add(const Duration(days: 100 * 365));

                DateTime? date = await showDatePicker(
                  context: context,
                  barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
                  barrierDismissible: false,
                  locale: Provider.of<LanguageChangeViewModel>(context,
                          listen: false)
                      .appLocale,
                  initialDate: initialDate,
                  firstDate: firstDate,
                  lastDate: lastDate,
                );
                if (date != null) {
                  setState(() {
                    _militaryServiceEndDateController.text =
                        DateFormat('yyyy-MM-dd').format(date).toString();
                    // Optionally, request focus on the next field
                  });
                }
              },
            ),
          ],
        );
      case MilitaryStatus.no:
        return showVoid;
      case MilitaryStatus.postponed:
        return _reason(langProvider);
      case MilitaryStatus.exemption:
        return _reason(langProvider);
      case null:
        return showVoid;
    }
    return showVoid;
  }

  // reason widget which is used as common for both relief and exemption
  Widget _reason(langProvider) {
    return Column(
      children: [
        // ****************************************************************************************************************************************************
        kFormHeight,
        fieldHeading(
            title: "Reason", important: true, langProvider: langProvider),
        _scholarshipFormTextField(
            currentFocusNode: _reasonForMilitaryFocusNode,
            controller: _reasonForMilitaryController,
            maxLines: 3,
            hintText: "Enter Reason",
            errorText: _reasonForMilitaryErrorText,
            onChanged: (value) {
              if (_reasonForMilitaryFocusNode.hasFocus) {
                setState(() {
                  _reasonForMilitaryErrorText =
                      ErrorText.getNameArabicEnglishValidationError(
                          name: _reasonForMilitaryController.text,
                          context: context);
                });
              }
            }),
      ],
    );
  }

  // *--------------------------------------------------------------- Military Information Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- High School Section Start ----------------------------------------------------------------------------*
  // step-3: high school details
    bool displayHighSchool(){
    return (_selectedScholarship?.acadmicCareer == 'UG' ||
        _selectedScholarship?.acadmicCareer == 'UGRD' ||
        _selectedScholarship?.acadmicCareer == 'SCHL' ||
        _selectedScholarship?.acadmicCareer == 'HCHL');
  }
  List _highSchoolLevelMenuItemsList = [];
  List _highSchoolTypeMenuItemsList = [];
  List _highSchoolSubjectsItemsList = [];
  List<HighSchool> _highSchoolList = [];

  // to populate the states based on high school country
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

  // subjectTitle:
  Widget _subjectTitle(String subjectCode) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);

    final element = _highSchoolSubjectsItemsList.firstWhere((element) {
      return element.code.toString() == subjectCode;
    });
    return fieldHeading(
        title: getTextDirection(langProvider) == TextDirection.ltr
            ? element.value
            : element.valueArabic.toString(),
        important: false,
        langProvider: langProvider);
  }

  _addHighSchool() {
    setState(() {
      _highSchoolList.add(HighSchool(
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
          highestQualificationController: TextEditingController(),
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
                  .startsWith('OTH')) // Filter for regular subjects
              .map((element) => HSDetails(
                    subjectTypeController:
                        TextEditingController(text: element.code.toString()),
                    gradeController: TextEditingController(),
                    subjectTypeFocusNode: FocusNode(),
                    gradeFocusNode: FocusNode(),
                  ))
              .toList(),
          otherHSDetails: _highSchoolSubjectsItemsList
              .where((element) =>
                  element.code.startsWith('OTH')) // Filter for regular subjects
              .map(
                (element) => HSDetails(
                  subjectTypeController:
                      TextEditingController(text: element.code.toString()),
                  gradeController: TextEditingController(),
                  otherSubjectNameController: TextEditingController(),
                  subjectTypeFocusNode: FocusNode(),
                  gradeFocusNode: FocusNode(),
                  otherSubjectNameFocusNode: FocusNode(),
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
    if (index >= 2 && index < _highSchoolList.length) {
      setState(() {
        final highSchool = _highSchoolList[index];

        // Dispose controllers and focus nodes of HSDetails
        for (var detail in highSchool.hsDetails) {
          detail.subjectTypeController.dispose();
          detail.gradeController.dispose();
          detail.subjectTypeFocusNode.dispose();
          detail.gradeFocusNode.dispose();
        }

        // Dispose controllers and focus nodes of otherHSDetails
        for (var detail in highSchool.otherHSDetails) {
          detail.subjectTypeController.dispose();
          detail.gradeController.dispose();
          detail.otherSubjectNameController?.dispose();
          detail.subjectTypeFocusNode.dispose();
          detail.gradeFocusNode.dispose();
          detail.otherSubjectNameFocusNode?.dispose();
        }

        // Dispose main HighSchool controllers and focus nodes
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

        _highSchoolList.removeAt(index);
      });
    } else {
      print("Cannot remove items at index less than 2.");
    }
  }

  Widget _highSchoolDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          kFormHeight,

          // *--------------------------------------------------------------- High School Details Section Start ----------------------------------------------------------------------------*
          CustomInformationContainer(
              title: "High School Details",
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // list view of high schools: this will include the information of the school like school level,country, ...., subjects details
                  Column(children: [
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _highSchoolList.length,
                        itemBuilder: (context, index) {
                          final highSchoolInfo = _highSchoolList[index];
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // ****************************************************************************************************************************************************

                                _sectionTitle(
                                    title: "High School Detail ${index + 1}"),

                                kFormHeight,
                                // title
                                fieldHeading(
                                    title: "High School Level",
                                    important: true,
                                    langProvider: langProvider),

                                // dropdowns on the basis of selected one
                                ((_selectedScholarship?.admitType == 'MOS' ||
                                                _selectedScholarship
                                                        ?.admitType ==
                                                    'MOP') &&
                                            index == 1) ||
                                        index <=
                                            1 // Todo: before <=2 did be me is <=1

                                    ? Column(children: [
                                        _scholarshipFormDropdown(
                                          readOnly: true,
                                          filled: true,
                                          controller:
                                              highSchoolInfo.hsLevelController,
                                          currentFocusNode:
                                              highSchoolInfo.hsLevelFocusNode,
                                          menuItemsList:
                                              _highSchoolLevelMenuItemsList,
                                          hintText: "Select High School Level",
                                          errorText:
                                              highSchoolInfo.hsLevelError,
                                          onChanged: (value) {
                                            highSchoolInfo.hsLevelError = null;
                                            setState(() {
                                              // setting the value for address type
                                              highSchoolInfo.hsLevelController
                                                  .text = value!;

                                              // populating the state dropdown

                                              _populateStateDropdown(
                                                  langProvider: langProvider,
                                                  index: index);

                                              //This thing is creating error: don't know how to fix it:
                                              Utils.requestFocus(
                                                  focusNode: highSchoolInfo
                                                      .hsCountryFocusNode,
                                                  context: context);
                                            });
                                          },
                                        )
                                      ])
                                    : (((_selectedScholarship?.admitType ==
                                                        'MOS' ||
                                                    _selectedScholarship
                                                            ?.admitType ==
                                                        'MOP') &&
                                                index > 0) ||
                                            (_selectedScholarship
                                                        ?.acadmicCareer ==
                                                    'HCHL' &&
                                                index >= 1) ||
                                            index >= 2)
                                        ? _scholarshipFormDropdown(
                                            controller: highSchoolInfo
                                                .hsLevelController,
                                            currentFocusNode:
                                                highSchoolInfo.hsLevelFocusNode,
                                            menuItemsList:
                                                _highSchoolLevelMenuItemsList,
                                            hintText:
                                                "Select High School Level",
                                            errorText:
                                                highSchoolInfo.hsLevelError,
                                            onChanged: (value) {
                                              highSchoolInfo.hsLevelError =
                                                  null;

                                              setState(() {
                                                bool alreadySelected =
                                                    _highSchoolList.any((info) {
                                                  return info !=
                                                          highSchoolInfo &&
                                                      info.hsLevelController
                                                              .text ==
                                                          value!;
                                                });
                                                if (alreadySelected) {
                                                  // If duplicate is found, show an error and clear the controller
                                                  _alertService.showToast(
                                                    context: context,
                                                    message:
                                                        "This level has already been selected. Please choose another one.",
                                                  );
                                                  highSchoolInfo.hsLevelError =
                                                      "Please choose another";
                                                } else {
                                                  // Assign the value only if it's not already selected
                                                  highSchoolInfo
                                                      .hsLevelController
                                                      .text = value!;
                                                  // Move focus to the next field
                                                  Utils.requestFocus(
                                                    focusNode: highSchoolInfo
                                                        .hsCountryFocusNode,
                                                    context: context,
                                                  );
                                                }
                                              });
                                            },
                                          )
                                        : showVoid,

                                kFormHeight,
                                // ****************************************************************************************************************************************************

                                // country
                                fieldHeading(
                                    title: "Country",
                                    important: true,
                                    langProvider: langProvider),

                                _scholarshipFormDropdown(
                                  controller:
                                      highSchoolInfo.hsCountryController,
                                  currentFocusNode:
                                      highSchoolInfo.hsCountryFocusNode,
                                  menuItemsList: _nationalityMenuItemsList,
                                  hintText: "Select Country",
                                  errorText: highSchoolInfo.hsCountryError,
                                  onChanged: (value) {
                                    highSchoolInfo.hsCountryError = null;
                                    highSchoolInfo.hsStateError = null;
                                    highSchoolInfo.hsNameError = null;
                                    setState(() {
                                      // setting the value for address type
                                      highSchoolInfo.hsCountryController.text =
                                          value!;

                                      highSchoolInfo.hsStateController.clear();
                                      highSchoolInfo.hsNameController.clear();
                                      highSchoolInfo
                                          .schoolStateDropdownMenuItems
                                          ?.clear();
                                      highSchoolInfo.schoolNameDropdownMenuItems
                                          ?.clear();
                                      // populating the high school state dropdown
                                      _populateHighSchoolStateDropdown(
                                          langProvider: langProvider,
                                          index: index);

                                      //This thing is creating error: don't know how to fix it:
                                      Utils.requestFocus(
                                          focusNode:
                                              highSchoolInfo.hsStateFocusNode,
                                          context: context);
                                    });
                                  },
                                ),

                                kFormHeight,
                                // ****************************************************************************************************************************************************

                                // state
                                fieldHeading(
                                    title: "State",
                                    // important: true,
                                    important: highSchoolInfo
                                            .schoolStateDropdownMenuItems
                                            ?.isNotEmpty ??
                                        false,
                                    langProvider: langProvider),

                                _scholarshipFormDropdown(
                                  filled: highSchoolInfo
                                          .schoolStateDropdownMenuItems
                                          ?.isEmpty ??
                                      false,
                                  readOnly: highSchoolInfo
                                          .schoolStateDropdownMenuItems
                                          ?.isEmpty ??
                                      false,
                                  controller: highSchoolInfo.hsStateController,
                                  currentFocusNode:
                                      highSchoolInfo.hsStateFocusNode,
                                  menuItemsList: highSchoolInfo
                                          .schoolStateDropdownMenuItems ??
                                      [],
                                  hintText: "Select State",
                                  errorText: highSchoolInfo.hsStateError,
                                  onChanged: (value) {
                                    highSchoolInfo.hsStateError = null;
                                    highSchoolInfo.hsNameError = null;
                                    setState(() {
                                      highSchoolInfo.hsStateController.text =
                                          value!;

                                      highSchoolInfo.hsNameController.clear();
                                      highSchoolInfo.schoolNameDropdownMenuItems
                                          ?.clear();

                                      // populating the high school state dropdown
                                      _populateHighSchoolNameDropdown(
                                          langProvider: langProvider,
                                          index: index);

                                      //This thing is creating error: don't know how to fix it:
                                      Utils.requestFocus(
                                          focusNode:
                                              highSchoolInfo.hsNameFocusNode,
                                          context: context);
                                    });
                                  },
                                ),

                                kFormHeight,
                                // ****************************************************************************************************************************************************
// high school name
                                if (highSchoolInfo.hsCountryController.text ==
                                    'ARE')
                                  Column(
                                    children: [
// school name from dropdown
                                      fieldHeading(
                                          title: "School Name",
                                          important: highSchoolInfo
                                                  .hsCountryController.text ==
                                              'ARE',
                                          langProvider: langProvider),
                                      _scholarshipFormDropdown(
                                        controller:
                                            highSchoolInfo.hsNameController,
                                        currentFocusNode:
                                            highSchoolInfo.hsNameFocusNode,
                                        menuItemsList: highSchoolInfo
                                                .schoolNameDropdownMenuItems ??
                                            [],
                                        hintText: "Select School Name",
                                        errorText: highSchoolInfo.hsNameError,
                                        onChanged: (value) {
                                          highSchoolInfo.hsNameError = null;
                                          setState(() {
                                            // setting the value for address type
                                            highSchoolInfo
                                                .hsNameController.text = value!;
                                            Utils.requestFocus(
                                                focusNode: highSchoolInfo
                                                    .hsTypeFocusNode,
                                                context: context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                // ****************************************************************************************************************************************************
                                // school name or other school name will be shown based on the conditions

                                // show school input filed based on the condition
                                if (highSchoolInfo.hsCountryController.text !=
                                        'ARE' ||
                                    highSchoolInfo.hsNameController.text ==
                                        'OTH')
                                  Column(
                                    children: [
                                      kFormHeight,
                                      fieldHeading(
                                          title: highSchoolInfo
                                                      .hsCountryController
                                                      .text ==
                                                  'ARE'
                                              ? "Other School Name"
                                              : "School Name",
                                          important: true,
                                          langProvider: langProvider),
                                      _scholarshipFormTextField(
                                          currentFocusNode: highSchoolInfo
                                              .otherHsNameFocusNode,
                                          nextFocusNode:
                                              highSchoolInfo.hsTypeFocusNode,
                                          controller: highSchoolInfo
                                              .otherHsNameController,
                                          hintText: highSchoolInfo
                                                      .hsCountryController
                                                      .text ==
                                                  'ARE'
                                              ? "Enter Other School Name"
                                              : "Enter School Name",
                                          errorText:
                                              highSchoolInfo.otherHsNameError,
                                          onChanged: (value) {
                                            // live error display for  high school name
                                            if (highSchoolInfo
                                                .otherHsNameFocusNode
                                                .hasFocus) {
                                              setState(() {
                                                highSchoolInfo
                                                        .otherHsNameError =
                                                    ErrorText
                                                        .getNameArabicEnglishValidationError(
                                                            name: highSchoolInfo
                                                                .otherHsNameController
                                                                .text,
                                                            context: context);
                                              });
                                            }

                                            // live error display for other high school name
                                            if (highSchoolInfo
                                                .otherHsNameFocusNode
                                                .hasFocus) {
                                              setState(() {
                                                highSchoolInfo
                                                        .otherHsNameError =
                                                    ErrorText
                                                        .getNameArabicEnglishValidationError(
                                                            name: highSchoolInfo
                                                                .otherHsNameController
                                                                .text,
                                                            context: context);
                                              });
                                            }
                                          }),
                                    ],
                                  ),

                                // ****************************************************************************************************************************************************
                                // school type
                                kFormHeight,
                                fieldHeading(
                                    title: "School Type",
                                    important: true,
                                    langProvider: langProvider),

                                _scholarshipFormDropdown(
                                  controller: highSchoolInfo.hsTypeController,
                                  currentFocusNode:
                                      highSchoolInfo.hsTypeFocusNode,
                                  menuItemsList:
                                      _highSchoolTypeMenuItemsList ?? [],
                                  hintText: "Select School Type",
                                  errorText: highSchoolInfo.hsTypeError,
                                  onChanged: (value) {
                                    highSchoolInfo.hsTypeError = null;
                                    highSchoolInfo.curriculumTypeError = null;
                                    setState(() {
                                      // setting the value for high school type
                                      highSchoolInfo.hsTypeController.text =
                                          value!;

                                      highSchoolInfo.curriculumTypeController
                                          .clear();
                                      highSchoolInfo
                                          .schoolCurriculumTypeDropdownMenuItems
                                          ?.clear();

                                      // populating the high school curriculum dropdown
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

                                // ****************************************************************************************************************************************************
                                // curriculum Type
                                kFormHeight,
                                fieldHeading(
                                    title: "Curriculum Type",
                                    important: true,
                                    langProvider: langProvider),

                                _scholarshipFormDropdown(
                                  controller:
                                      highSchoolInfo.curriculumTypeController,
                                  currentFocusNode:
                                      highSchoolInfo.curriculumTypeFocusNode,
                                  menuItemsList: highSchoolInfo
                                          .schoolCurriculumTypeDropdownMenuItems ??
                                      [],
                                  hintText: "Select Curriculum Type",
                                  errorText: highSchoolInfo.curriculumTypeError,
                                  onChanged: (value) {
                                    highSchoolInfo.curriculumTypeError = null;
                                    setState(() {
                                      // setting the value for high school type
                                      highSchoolInfo.curriculumTypeController
                                          .text = value!;

                                      Utils.requestFocus(
                                          focusNode: highSchoolInfo
                                              .curriculumAverageFocusNode,
                                          context: context);
                                    });
                                  },
                                ),
                                // ****************************************************************************************************************************************************

                                kFormHeight,
                                fieldHeading(
                                    title: "Curriculum Average",
                                    important: true,
                                    langProvider: langProvider),
                                _scholarshipFormTextField(
                                    currentFocusNode: highSchoolInfo
                                        .curriculumAverageFocusNode,
                                    nextFocusNode:
                                        highSchoolInfo.yearOfPassingFocusNode,
                                    controller: highSchoolInfo
                                        .curriculumAverageController,
                                    hintText: "Enter Curriculum Average",
                                    maxLength: highSchoolInfo
                                                .curriculumTypeController
                                                .text !=
                                            'BRT'
                                        ? 4
                                        : 6,
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

                                // ****************************************************************************************************************************************************
                                // year of passing
                                fieldHeading(
                                    title: "Year Of Passing",
                                    important: (highSchoolInfo
                                        .curriculumAverageController
                                        .text
                                        .isNotEmpty),
                                    langProvider: langProvider),
                                _scholarshipFormDateField(
                                  // Prevent manual typing
                                  currentFocusNode:
                                      highSchoolInfo.yearOfPassingFocusNode,
                                  controller:
                                      highSchoolInfo.yearOfPassingController,
                                  hintText: "Select Year of Passing",
                                  errorText: highSchoolInfo.yearOfPassingError,
                                  // Display error text if any
                                  onChanged: (value) {
                                    setState(() {
                                      if (highSchoolInfo
                                          .yearOfPassingFocusNode.hasFocus) {
                                        // Check if the year of passing field is empty or invalid
                                        highSchoolInfo.yearOfPassingError =
                                            ErrorText.getEmptyFieldError(
                                          name: highSchoolInfo
                                              .yearOfPassingController.text,
                                          context: context,
                                        );
                                      }
                                    });
                                  },
                                  onTap: () async {
                                    // Clear the error message when a date is selected
                                    highSchoolInfo.yearOfPassingError = null;

                                    // Define the initial date as today's date (for year selection)
                                    final DateTime initialDate = DateTime.now();

                                    // Use a specific max date if required (like schoolPassingDate from your controller)
                                    // If no schoolPassingDate is available, use the current date as a fallback

                                    // Todo: No Max date is given
                                    final DateTime maxDate = DateTime.now();

                                    // Define the valid date range for "Year of Passing"
                                    final DateTime firstDate = maxDate.subtract(
                                        const Duration(
                                            days: 20 * 365)); // Last 20 years
                                    final DateTime lastDate = maxDate.add(
                                        const Duration(
                                            days:
                                                365)); // Limit up to the maxDate (e.g., current year or schoolPassingDate)

                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      barrierColor: AppColors.scoButtonColor
                                          .withOpacity(0.1),
                                      barrierDismissible: false,
                                      locale:
                                          Provider.of<LanguageChangeViewModel>(
                                                  context,
                                                  listen: false)
                                              .appLocale,
                                      initialDate: initialDate,
                                      firstDate: firstDate,
                                      // Limit to the last 20 years
                                      lastDate:
                                          lastDate, // Limit up to the maxDate or current year
                                    );

                                    if (date != null) {
                                      setState(() {
                                        // Set the selected date in the controller (format to show only the year)
                                        highSchoolInfo
                                                .yearOfPassingController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(date)
                                                .toString();

                                        // Get the current year
                                        String currentYear =
                                            DateFormat('yyyy').format(date);

                                        // Get the next year
                                        String nextYear = DateFormat('yyyy')
                                            .format(date.add(const Duration(
                                                days:
                                                    365))); // Adding 365 days to get to next year

                                        // Combine current and next year
                                        String yearOfGraduation =
                                            '$currentYear-$nextYear';

                                        // Print the passing year
                                        highSchoolInfo.passingYearController
                                            .text = yearOfGraduation;
                                      });
                                    }
                                  },
                                ),
                                // ****************************************************************************************************************************************************
                                // year of graduation:
                                kFormHeight,
                                const MyDivider(),
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    color:
                                        AppColors.lightBlue1.withOpacity(0.4),
                                    child: Row(children: [
                                      _sectionTitle(
                                          title: "Year of Graduation"),
                                      kFormHeight,
                                      Expanded(
                                          child: Text(highSchoolInfo
                                              .passingYearController.text))
                                    ])),

                                kFormHeight,
                                // ****************************************************************************************************************************************************

                                const MyDivider(
                                  color: AppColors.lightGrey,
                                ),
                                // ****************************************************************************************************************************************************

                                kFormHeight,
                                _sectionTitle(title: "Subjects"),
                                kFormHeight,
                                // ****************************************************************************************************************************************************
                                // regular subjects
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: highSchoolInfo.hsDetails.length,
                                  itemBuilder: (context, index) {
                                    var element =
                                        highSchoolInfo.hsDetails[index];
                                    return Column(
                                      children: [
                                        _subjectTitle(element
                                            .subjectTypeController.text
                                            .toString()),
                                        _scholarshipFormTextField(
                                          currentFocusNode:
                                              element.gradeFocusNode,
                                          nextFocusNode: index + 1 <
                                                  highSchoolInfo
                                                      .hsDetails.length
                                              ? highSchoolInfo
                                                  .hsDetails[index + 1]
                                                  .gradeFocusNode
                                              : null,
                                          controller: element.gradeController,
                                          hintText: "Grade/Percentage",
                                          maxLength: 4,
                                          errorText: element.gradeError,
                                          onChanged: (value) {
                                            if (element
                                                .gradeFocusNode.hasFocus) {
                                              setState(() {
                                                element.gradeError = ErrorText
                                                    .getGradeValidationError(
                                                        grade: element
                                                            .gradeController
                                                            .text,
                                                        context: context);
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                // ****************************************************************************************************************************************************

                                const MyDivider(
                                  color: AppColors.lightGrey,
                                ),
                                kFormHeight,

                                // ****************************************************************************************************************************************************
                                // other subjects
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      highSchoolInfo.otherHSDetails.length,
                                  itemBuilder: (context, index) {
                                    var element =
                                        highSchoolInfo.otherHSDetails[index];
                                    return Column(
                                      children: [
                                        _subjectTitle(element
                                            .subjectTypeController.text
                                            .toString()),

                                        // subject Name
                                        _scholarshipFormTextField(
                                          currentFocusNode: element
                                                  .otherSubjectNameFocusNode ??
                                              FocusNode(),
                                          nextFocusNode: element.gradeFocusNode,
                                          controller: element
                                                  .otherSubjectNameController ??
                                              TextEditingController(),
                                          hintText: "Other Subject Name",
                                          errorText:
                                              element.otherSubjectNameError,
                                          onChanged: (value) {
                                            if (element
                                                .otherSubjectNameFocusNode!
                                                .hasFocus) {
                                              setState(() {
                                                element.otherSubjectNameError =
                                                    ErrorText
                                                        .getNameArabicEnglishValidationError(
                                                            name: element
                                                                .otherSubjectNameController!
                                                                .text,
                                                            context: context);
                                              });
                                            }
                                          },
                                        ),
                                        kFormHeight,
                                        // grade
                                        _scholarshipFormTextField(
                                          currentFocusNode:
                                              element.gradeFocusNode,
                                          nextFocusNode: index + 1 <
                                                  highSchoolInfo
                                                      .otherHSDetails.length
                                              ? highSchoolInfo
                                                  .otherHSDetails[index + 1]
                                                  .otherSubjectNameFocusNode
                                              : null,
                                          controller: element.gradeController,
                                          hintText: "Grade/Percentage",
                                          maxLength: 4,
                                          errorText: element.gradeError,
                                          onChanged: (value) {
                                            if (element
                                                .gradeFocusNode.hasFocus) {
                                              setState(() {
                                                element.gradeError = ErrorText
                                                    .getGradeValidationError(
                                                        grade: element
                                                            .gradeController
                                                            .text,
                                                        context: context);
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                // ****************************************************************************************************************************************************
                                // if it obeys the constraints of showing dropdown only then it will be visible to the user to delete the item
                                // Todo: Condition Applied by me that index check should only for greater then not equal to
                                (_selectedScholarship?.admitType == 'MOS' ||
                                            _selectedScholarship?.admitType ==
                                                'MOP') ||
                                        (_selectedScholarship?.acadmicCareer ==
                                                'HCHL' &&
                                            index >= 1) ||
                                        index > 1
                                    ? _addRemoveMoreSection(
                                        title: "Delete",
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            _removeHighSchool(index);
                                          });
                                        })
                                    : showVoid,
                              ]);
                        }),
                    // ****************************************************************************************************************************************************
                    const MyDivider(
                      color: AppColors.lightGrey,
                    ),
                    kFormHeight,

                    // ****************************************************************************************************************************************************

                    _addRemoveMoreSection(
                        title: "Add",
                        add: true,
                        onChanged: () {
                          setState(() {
                            _addHighSchool();
                          });
                        }),
                  ]),
                  // _highSchoolInformationSection()
                ],
              ))
        ])));
  }

  // *--------------------------------------------------------------- High School Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Graduation Details Section start ----------------------------------------------------------------------------*

  List<GraduationInfo> _graduationDetailsList = [];

  List<DropdownMenuItem> _graduationLevelMenuItems = [];
  List<DropdownMenuItem> _graduationLevelDDSMenuItems = [];
  List<DropdownMenuItem> _caseStudyYearDropdownMenuItems = [];

  // sponsorship question for dds
  String havingSponsor = '';

  // to populate the graduation Details
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

  // populate menu items list
  _populateUniversityMenuItemsList(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
              .lovCodeMap[
                  'GRAD_UNIVERSITY#${_graduationDetailsList[index].countryController.text}#UNV']
              ?.values !=
          null) {
        _graduationDetailsList[index].university = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap[
                    'GRAD_UNIVERSITY#${_graduationDetailsList[index].countryController.text}#UNV']!
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
        isNewController: TextEditingController(),
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

  _deleteGraduationDetail(int index) {
    if (index > 0 && index < _graduationDetailsList.length) {
      setState(() {
        // Get the item to be deleted
        final item = _graduationDetailsList[index];

        // Dispose of all the TextEditingController instances
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

        // Dispose of all the FocusNode instances
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

        // Remove the item from the list
        _graduationDetailsList.removeAt(index);
      });
    }
    print(_graduationDetailsList.length.toString());
    if (_graduationDetailsList.length == 1) {
      print(_graduationDetailsList.length.toString());
      final item = _graduationDetailsList[0];
      _updateShowCurrentlyStudyingWithFalse(item);
    }
  }

  // when selecting currently studying yes or no then update the ui accordingly
  _updateShowCurrentlyStudyingWithYes(GraduationInfo graduationInfo) {
    for (var element in _graduationDetailsList) {
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
    for (var element in _graduationDetailsList) {
      {
        setState(() {
          element.showCurrentlyStudying = true;
        });
      }
    }
  }

  Widget _graduationDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          draftPrevNextButtons(langProvider),
          // if selected scholarship matches the condition then high school details section else don't
          (_selectedScholarship?.acadmicCareer != 'SCHL' &&
                  _selectedScholarship?.acadmicCareer != 'HCHL')
              ? CustomInformationContainer(
                  title: _selectedScholarship?.acadmicCareer == 'DDS'
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
                            itemCount: _graduationDetailsList.length,
                            itemBuilder: (context, index) {
                              final graduationInfo =
                                  _graduationDetailsList[index];
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ****************************************************************************************************************************************************

                                    _sectionTitle(
                                        title: _selectedScholarship
                                                    ?.acadmicCareer ==
                                                'DDS'
                                            ? 'dds.graduation.title ${index + 1}'
                                            : "Graduation Detail ${index + 1}"),

                                    graduationInfo.showCurrentlyStudying
                                        ? Column(children: [
                                            kFormHeight,
// title
                                            fieldHeading(
                                                title: "Currently Studying",
                                                important: true,
                                                langProvider: langProvider),

                                            // ****************************************************************************************************************************************************
                                            // radiobuttons for yes or no
                                            // Yes or no : Show round radio
                                            CustomRadioListTile(
                                              value: true,
                                              groupValue: graduationInfo
                                                  .currentlyStudying,
                                              onChanged: (value) {
                                                setState(() {
                                                  // graduationInfo.showCurrentlyStudying = value;
                                                  graduationInfo
                                                          .currentlyStudying =
                                                      value;
                                                  _updateShowCurrentlyStudyingWithYes(
                                                      graduationInfo);
                                                  // populate LAST term
                                                  _populateGraduationLastTermMenuItemsList(
                                                      langProvider:
                                                          langProvider,
                                                      index: index);
                                                });
                                              },
                                              title: "Yes",
                                              textStyle: _textFieldTextStyle,
                                            ),

                                            // ****************************************************************************************************************************************************
                                            CustomRadioListTile(
                                                value: false,
                                                groupValue: graduationInfo
                                                    .currentlyStudying,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // graduationInfo.showCurrentlyStudying = value;
                                                    graduationInfo
                                                            .currentlyStudying =
                                                        value;
                                                    // showing selection option that you are currently doing this course or not
                                                    _updateShowCurrentlyStudyingWithFalse(
                                                        graduationInfo);
                                                    graduationInfo
                                                        .graduationEndDateController
                                                        .clear();
                                                    graduationInfo
                                                        .lastTermController
                                                        .clear();

                                                    // clear the relatives list
                                                    // _relativeInfoList.clear();
                                                  });
                                                },
                                                title: "No",
                                                textStyle: _textFieldTextStyle),
                                          ])
                                        : showVoid,
                                    // ****************************************************************************************************************************************************

                                    kFormHeight,

                                    // last term
                                    graduationInfo.currentlyStudying &&
                                            graduationInfo.showCurrentlyStudying
                                        ? Column(
                                            children: [
                                              fieldHeading(
                                                  title: "Last Term",
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormDropdown(
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
                                                    // setting the value for address type
                                                    graduationInfo
                                                        .lastTermController
                                                        .text = value!;

                                                    //This thing is creating error: don't know how to fix it:
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
                                    // ****************************************************************************************************************************************************

                                    (_selectedScholarship?.acadmicCareer ==
                                            'UGRD')
                                        ? (graduationInfo.currentlyStudying
                                            ? // copy paste full below code
                                            _graduationInformation(
                                                index: index,
                                                langProvider: langProvider,
                                                graduationInfo: graduationInfo)
                                            : showVoid)
                                        : _graduationInformation(
                                            index: index,
                                            langProvider: langProvider,
                                            graduationInfo: graduationInfo),

                                    // ****************************************************************************************************************************************************

                                    (!(_selectedScholarship?.scholarshipType ==
                                                    'INT' &&
                                                _selectedScholarship
                                                        ?.acadmicCareer ==
                                                    'UGRD') &&
                                            index != 0)
                                        ? _addRemoveMoreSection(
                                            title: "Delete",
                                            add: false,
                                            onChanged: () {
                                              setState(() {
                                                _deleteGraduationDetail(index);
                                              });
                                            })
                                        : showVoid,

                                    // ****************************************************************************************************************************************************
                                    kFormHeight,
                                    const MyDivider(
                                      color: AppColors.lightGrey,
                                    ),
                                    kFormHeight,

                                    // ****************************************************************************************************************************************************
                                  ]);
                            }),
                        (!(_selectedScholarship?.scholarshipType == 'INT' &&
                                    _selectedScholarship?.acadmicCareer ==
                                        'UGRD') &&
                                _selectedScholarship?.acadmicCareer != 'UGRD')
                            ? _addRemoveMoreSection(
                                title: "Add",
                                add: true,
                                onChanged: () {
                                  setState(() {
                                    _addGraduationDetail();
                                  });
                                })
                            : showVoid,
                      ]),
                    ],
                  ))
              : showVoid,
          draftPrevNextButtons(langProvider)
        ])));
  }

  // graduation detail information
  Widget _graduationInformation(
      {required int index,
      required LanguageChangeViewModel langProvider,
      required GraduationInfo graduationInfo}) {
    return Column(
      children: [
        // ****************************************************************************************************************************************************
        // graduation level
        (index > 0 &&
                _selectedScholarship?.acadmicCareer != 'UGRD' &&
                _selectedScholarship?.acadmicCareer != 'DDS')
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: "Graduation Level",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: graduationInfo.levelController,
                    currentFocusNode: graduationInfo.levelFocusNode,
                    menuItemsList: _graduationLevelMenuItems ?? [],
                    hintText: "Select Graduation Level",
                    errorText: graduationInfo.levelError,
                    onChanged: (value) {
                      graduationInfo.levelError = null;

                      setState(() {
                        bool alreadySelected =
                            _graduationDetailsList.any((info) {
                          return info != graduationInfo &&
                              info.levelController.text == value!;
                        });
                        if (alreadySelected) {
                          // If duplicate is found, show an error and clear the controller
                          _alertService.showToast(
                            context: context,
                            message:
                                "This level has already been selected. Please choose another one.",
                          );
                          graduationInfo.levelError = "Please choose another";
                        } else {
                          // Assign the value only if it's not already selected
                          graduationInfo.levelController.text = value!;
                          // Move focus to the next field
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
            : // for UGRD Specially

            // ****************************************************************************************************************************************************
            // show static bachelor graduation level
            (index == 0 || _selectedScholarship?.acadmicCareer == 'UGRD')
                ? _showBachelorScholarshipByDefault(
                    index: index,
                    langProvider: langProvider,
                    graduationInfo: graduationInfo)
                : showVoid,

        // ****************************************************************************************************************************************************

        // to dropdown for dds
        (index != 0 && _selectedScholarship?.acadmicCareer == 'DDS')
            ? Column(
                children: [
                  fieldHeading(
                      title: "DDS Graduation Level",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: graduationInfo.levelController,
                    currentFocusNode: graduationInfo.levelFocusNode,
                    menuItemsList: _graduationLevelDDSMenuItems ?? [],
                    hintText: "Select DDS Graduation Level",
                    errorText: graduationInfo.levelError,
                    onChanged: (value) {
                      graduationInfo.levelError = null;

                      setState(() {
                        bool alreadySelected =
                            _graduationDetailsList.any((info) {
                          return info != graduationInfo &&
                              info.levelController.text == value!;
                        });
                        if (alreadySelected) {
                          // If duplicate is found, show an error and clear the controller
                          _alertService.showToast(
                            context: context,
                            message:
                                "This level has already been selected. Please choose another one.",
                          );
                          graduationInfo.levelError = "Please choose another";
                        } else {
                          // Assign the value only if it's not already selected
                          graduationInfo.levelController.text = value!;
                          // Move focus to the next field
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

        // ****************************************************************************************************************************************************
        // country
        fieldHeading(
            title: "Country", important: true, langProvider: langProvider),
        _scholarshipFormDropdown(
          controller: graduationInfo.countryController,
          currentFocusNode: graduationInfo.countryFocusNode,
          menuItemsList: _nationalityMenuItemsList ?? [],
          hintText: "Select Country",
          errorText: graduationInfo.countryError,
          onChanged: (value) {
            graduationInfo.countryError = null;
            setState(() {
              // setting the value for address type
              graduationInfo.countryController.text = value!;

              // clearing and reinitializing the dropdowns
              graduationInfo.university?.clear();
              graduationInfo.universityController.clear();
              graduationInfo.otherUniversityController.clear();

              // populate dropdowns
              _populateUniversityMenuItemsList(
                  langProvider: langProvider, index: index);

              //This thing is creating error: don't know how to fix it:
              Utils.requestFocus(
                  focusNode: graduationInfo.universityFocusNode,
                  context: context);
            });
          },
        ),

        // ****************************************************************************************************************************************************
        // graduation university

        _selectedScholarship?.acadmicCareer != 'DDS'
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: "Graduation University",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: graduationInfo.universityController,
                    currentFocusNode: graduationInfo.universityFocusNode,
                    menuItemsList: graduationInfo.university ?? [],
                    hintText: "Select Grad University",
                    errorText: graduationInfo.universityError,
                    onChanged: (value) {
                      graduationInfo.universityError = null;
                      setState(() {
                        // setting the value for address type
                        graduationInfo.universityController.text = value!;

                        // clearing and reinitializing the dropdowns
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

        // ****************************************************************************************************************************************************
        // other university
        graduationInfo.universityController.text == 'OTH'
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: _selectedScholarship?.acadmicCareer != 'DDS'
                          ? "Other University"
                          : 'dds.university',
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
                      maxLength: 40,
                      currentFocusNode: graduationInfo.otherUniversityFocusNode,
                      nextFocusNode: graduationInfo.majorFocusNode,
                      controller: graduationInfo.otherUniversityController,
                      hintText: _selectedScholarship?.acadmicCareer != 'DDS'
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

        // ****************************************************************************************************************************************************
        //  major
        kFormHeight,
        fieldHeading(
            title: _selectedScholarship?.acadmicCareer != 'DDS'
                ? 'hs.major'
                : 'dds.major',
            important: true,
            langProvider: langProvider),
        _scholarshipFormTextField(
            maxLength: 40,
            currentFocusNode: graduationInfo.majorFocusNode,
            nextFocusNode: graduationInfo.cgpaFocusNode,
            controller: graduationInfo.majorController,
            hintText: _selectedScholarship?.acadmicCareer != 'DDS'
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
        // ****************************************************************************************************************************************************
        // cgpa
        fieldHeading(
            title: "CGPA", important: true, langProvider: langProvider),
        _scholarshipFormTextField(
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

        // ****************************************************************************************************************************************************
        // start date
        fieldHeading(
            title: "Start Date", important: true, langProvider: langProvider),
        _scholarshipFormDateField(
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
            // Clear the error if a date is selected
            graduationInfo.graduationStartDateError = null;

            // Define the initial date (e.g., today's date)
            final DateTime initialDate = DateTime.now();

            // Define the start date (100 years ago from today)
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

        // ****************************************************************************************************************************************************

        // start date
        kFormHeight,
        fieldHeading(
            title: "End Date",
            important: (!graduationInfo.currentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty),
            langProvider: langProvider),
        _scholarshipFormDateField(
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
              // Clear the error if a date is selected
              graduationInfo.graduationEndDateError = null;

              // Define the initial date (e.g., today's date)
              final DateTime initialDate = DateTime.now();

              // Define the start date (100 years ago from today)
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
        // ****************************************************************************************************************************************************
        // questions if dds
        _selectedScholarship?.acadmicCareer == 'DDS'
            ? Column(
                children: [
                  kFormHeight,

                  // check if dds then only ask question if only dds scholarship
                  fieldHeading(
                      title:
                          "Are you currently receiving a scholarship or grant from another party?",
                      important: true,
                      langProvider: langProvider),

                  // ****************************************************************************************************************************************************

                  // Yes or no : Show round radio
                  CustomRadioListTile(
                    value: 'Y',
                    groupValue: havingSponsor,
                    onChanged: (value) {
                      setState(() {
                        havingSponsor = value;
                      });
                    },
                    title: "Yes",
                    textStyle: _textFieldTextStyle,
                  ),

                  // ****************************************************************************************************************************************************
                  CustomRadioListTile(
                      value: "N",
                      groupValue: havingSponsor,
                      onChanged: (value) {
                        setState(() {
                          havingSponsor = value;
                          // clear the relatives list
                          graduationInfo.sponsorShipController.clear();
                        });
                      },
                      title: "No",
                      textStyle: _textFieldTextStyle),
                ],
              )
            : showVoid,

        // ****************************************************************************************************************************************************

        // SPONSORSHIP
        // TODO: Need havingSponsor  key from fetch all scholarships
        ((havingSponsor == 'Y') || _selectedScholarship?.acadmicCareer != 'DDS')
            ? Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                      title: "Sponsorship",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
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

        // ****************************************************************************************************************************************************
        // case study
        (graduationInfo.levelController.text == 'PGRD' ||
                graduationInfo.levelController.text == 'PG' ||
                graduationInfo.levelController.text == 'DDS')
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kFormHeight,
                  // ****************************************************************************************************************************************************

                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  kFormHeight,
                  // ****************************************************************************************************************************************************

                  _sectionTitle(title: "Case Study"),
                  // ****************************************************************************************************************************************************

                  kFormHeight,
                  fieldHeading(
                      title: "Title",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
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
                  // ****************************************************************************************************************************************************
                  fieldHeading(
                      title: "Start Year",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
                    controller: graduationInfo.caseStudyStartYearController,
                    currentFocusNode:
                        graduationInfo.caseStudyStartYearFocusNode,
                    menuItemsList: _caseStudyYearDropdownMenuItems ?? [],
                    hintText: "Select Start Year",
                    errorText: graduationInfo.caseStudyStartYearError,
                    onChanged: (value) {
                      graduationInfo.caseStudyStartYearError = null;
                      setState(() {
                        // setting the value for address type
                        graduationInfo.caseStudyStartYearController.text =
                            value!;

                        Utils.requestFocus(
                            focusNode:
                                graduationInfo.caseStudyDescriptionFocusNode,
                            context: context);
                      });
                    },
                  ),
                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  fieldHeading(
                      title: "Case Study Details",
                      important: true,
                      langProvider: langProvider),
                  _scholarshipFormTextField(
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

        // ****************************************************************************************************************************************************
      ],
    );
  }

  // this is made separate because we have to show bachelor by default for graduation level at index 1
  Widget _showBachelorScholarshipByDefault(
      {required int index,
      required LanguageChangeViewModel langProvider,
      required GraduationInfo graduationInfo}) {
    // setting bachelor by default
    graduationInfo.levelController.text = 'UG';
    return Column(
      children: [
        fieldHeading(
            title: "Graduation Level",
            important: true,
            langProvider: langProvider),
        _scholarshipFormDropdown(
          readOnly: true,
          filled: true,
          controller: graduationInfo.levelController,
          currentFocusNode: graduationInfo.levelFocusNode,
          menuItemsList: _graduationLevelMenuItems ?? [],
          hintText: "Select Graduation Level",
          errorText: graduationInfo.levelError,
          onChanged: (value) {
            graduationInfo.levelError = null;
            setState(() {
              // setting the value for address type
              graduationInfo.levelController.text = value!;

              //This thing is creating error: don't know how to fix it:
              Utils.requestFocus(
                  focusNode: graduationInfo.countryFocusNode, context: context);
            });
          },
        ),
      ],
    );
  }

  // *--------------------------------------------------------------- Graduation Details Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- University And Majors Section Start ----------------------------------------------------------------------------*
  // step-4

  // "acadProgram": "SCO-P",
  // "acadProgramDds": "FELL",
  // "acadProgramPgrd": "MSTRS",

  // controllers, focus nodes and error text variables for Academic program
  final TextEditingController _acadProgramController = TextEditingController();
  final TextEditingController _acadProgramDdsController =
      TextEditingController();
  final TextEditingController _acadProgramPgrdController =
      TextEditingController();

  final FocusNode _acadProgramFocusNode = FocusNode();
  final FocusNode _acadProgramDdsFocusNode = FocusNode();
  final FocusNode _acadProgramPgrdFocusNode = FocusNode();

  String? _acadProgramErrorText;
  String? _acadProgramDdsErrorText;
  String? _acadProgramPgrdErrorText;

  // list of Academic Program PGRD
  List<DropdownMenuItem> _acadProgramPgrdMenuItemsList = [];

  // list of Academic Program DDS
  List<DropdownMenuItem> _acadProgramDdsMenuItemsList = [];

  List<DropdownMenuItem> getMajors() {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);

    // Step 1: Check for postgraduate academic career ("PGRD")
    if (_selectedScholarship?.acadmicCareer?.toUpperCase() == "PGRD") {
      String majorCriteria =
          "MAJORSPGRD#${_selectedScholarship?.acadmicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      return populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap[majorCriteria]?.values ?? [],
        provider: langProvider,
      );
    }

    // Step 2: Default major criteria for non-PGRD
    String majorCriteria =
        "MAJORS#${_selectedScholarship?.acadmicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
    List<dynamic> items = Constants.lovCodeMap[majorCriteria]?.values ?? [];

    // Step 3: Check for different admit types
    if (_selectedScholarship?.admitType?.toUpperCase() == "ACT") {
      // For "ACT" admit type
      majorCriteria =
          "MAJORSACT#${_selectedScholarship?.acadmicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      items = Constants.lovCodeMap[majorCriteria]?.values ?? [];
    } else if (_selectedScholarship?.admitType?.toUpperCase() == "NLU") {
      // For "NLU" admit type
      majorCriteria =
          "MAJORSNL#${_selectedScholarship?.acadmicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      items = Constants.lovCodeMap[majorCriteria]?.values ?? [];
    } else if (_selectedScholarship?.scholarshipType?.toUpperCase() == "INT" &&
        _selectedScholarship?.admitType?.toUpperCase() != "MET") {
      // Handle "INT" admit type with specific filtering for "OTH"
      List<dynamic> filteredItems = [];
      for (var item in items) {
        if (item.code?.toUpperCase() == "OTH") {
          if (_isValidAdmitTypeForINT(_selectedScholarship?.admitType,
              _selectedScholarship?.configurationKey)) {
            filteredItems.add(item);
          }
        } else {
          filteredItems.add(item); // Add other items directly
        }
      }
      items = filteredItems; // Update items with filtered items
    } else if (_selectedScholarship?.scholarshipType?.toUpperCase() == "EXT") {
      // For "EXT" scholarship type, items already fetched
    } else {
      // Default case to only add "BAM" items
      List<dynamic> filteredItems = [];
      for (var item in items) {
        if (item.code?.toUpperCase() == "BAM") {
          filteredItems.add(item);
        }
      }
      items = filteredItems; // Update items with filtered items
    }

    // Step 4: Handle special cases
    if (_selectedScholarship?.isSpecialCase ?? false) {
      items.add({'value': 'OTH', 'label': 'آخر'}); // Append special case "OTH"
    }

    // Return the final list of majors
    return populateCommonDataDropdown(
        menuItemsList: items, provider: langProvider);
  }

// Helper method to validate INT admit type
  bool _isValidAdmitTypeForINT(String? admitType, String? configurationKey) {
    return ["MOP", "MOS"].contains(admitType?.toUpperCase()) ||
        configurationKey?.toUpperCase() == "SCOUGRDINTHH";
  }

// major dropdown menu items list
  List<DropdownMenuItem> _majorsMenuItemsList = [];

  bool isStudyCountry = false;

  // majors wishlist
// Initialize the list
  List<MajorWishList> _majorsWishlist = [];

// Function to add a new MajorWishList item
  void addMajorWishList() {
    // Create a new MajorWishList instance
    MajorWishList newWishList = MajorWishList(
      majorController: TextEditingController(),
      errorMessageController: TextEditingController(),
      isNewController: TextEditingController(),
      majorFocusNode: FocusNode(),
      errorMessageFocusNode: FocusNode(),
      isNewFocusNode: FocusNode(),
    );

    // Add the new instance to the list
    _majorsWishlist.add(newWishList);
  }

// Function to remove a MajorWishList item by index
  void removeMajorWishList(int index) {
    if (index >= 0 && index < _majorsWishlist.length) {
      // Dispose the controllers and focus nodes to avoid memory leaks
      _majorsWishlist[index].majorController.dispose();
      _majorsWishlist[index].errorMessageController.dispose();
      _majorsWishlist[index].isNewController.dispose();
      _majorsWishlist[index].majorFocusNode.dispose();
      _majorsWishlist[index].errorMessageFocusNode.dispose();
      _majorsWishlist[index].isNewFocusNode.dispose();

      // Remove the item from the list
      _majorsWishlist.removeAt(index);
    }
  }

  // university priority list
// List to store UniversityPriority items
  List<UniversityPriority> _universityPriorityList = [];

  List<DropdownMenuItem> populateUniversitiesWishList(
      UniversityPriority universityInfo) {
    String _country = universityInfo.countryIdController.text;
    // Step 1: Fetch initial list of universities based on country
    List<DropdownMenuItem> items = fetchListOfValue("UNIVERSITY#$_country#UNV");

    // List to store final items
    List<DropdownMenuItem> itemsNew = [];

    // Step 2: Handle special case
    if (_selectedScholarship?.isSpecialCase ?? false) {
      itemsNew.add(const DropdownMenuItem(
          value: "OTH", child: Text("آخر"))); // "OTH" means "Other"
    }

    // Step 3: Check for different admit types
    if (_selectedScholarship?.admitType?.toUpperCase() == "NLU") {
      // For "NLU" admit type
      itemsNew = fetchListOfValue("EXTUNIVERSITYNL#$_country#UNV");
    } else if (_country.toUpperCase() == "GBR") {
      // For country "GBR"
      itemsNew.add(const DropdownMenuItem(value: "OTH", child: Text("آخر")));
    } else if (_country.toUpperCase() != "ARE" &&
        _selectedScholarship?.scholarshipType?.toUpperCase() != "INT") {
      // For countries not equal to "ARE" and scholarship type not "INT"
      itemsNew = fetchListOfValue("GRAD_UNIVERSITY#$_country#UNV");
    } else if (_selectedScholarship?.scholarshipType?.toUpperCase() == "INT" &&
        _selectedScholarship?.admitType?.toUpperCase() == "MET") {
      // For "INT" scholarship type with "MET" admit type
      for (var item in items) {
        if (item.value.toString().toUpperCase() == "00000105") {
          itemsNew.add(item);
        }
      }
    } else {
      // Default case, add all items
      itemsNew.addAll(items);
    }

    universityInfo.universityDropdown = itemsNew;
    return itemsNew;
  }

// Helper function to mimic fetchListOfValue, should return a list of DropdownMenuItem
  List<DropdownMenuItem> fetchListOfValue(String key) {
    // Your logic to fetch values goes here
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    if (Constants.lovCodeMap[key]?.values != null) {
      return populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap[key]!.values!,
        provider: langProvider,
        textColor: AppColors.scoButtonColor,
      );
    } else {
      // Handle the case where the values are null (e.g., return an empty list or log an error)
      return []; // or any appropriate fallback
    }
  }

  List<DropdownMenuItem> _universityPriorityStatus = [];

// Function to add a new UniversityPriority item with only countryId provided
  void addUniversityPriority() {
    // Create a new UniversityPriority instance with only countryId set
    UniversityPriority newPriority = UniversityPriority(
      // countryIdController: TextEditingController(text: _selectedScholarship?.acadmicCareer == 'UGRD' ? "ARE" : ''),
      countryIdController:
          TextEditingController(text: isStudyCountry ? "ARE" : ''),
      universityIdController: TextEditingController(),
      otherUniversityNameController: TextEditingController(),
      majorsController: TextEditingController(),
      otherMajorsController: TextEditingController(),
      statusController: TextEditingController(),
      errorMessageController: TextEditingController(),
      isNewController: TextEditingController(text: 'true'),
      countryIdFocusNode: FocusNode(),
      universityIdFocusNode: FocusNode(),
      otherUniversityNameFocusNode: FocusNode(),
      majorsFocusNode: FocusNode(),
      otherMajorsFocusNode: FocusNode(),
      statusFocusNode: FocusNode(),
    );

    // Add the new instance to the list
    _universityPriorityList.add(newPriority);
    populateUniversitiesWishList(newPriority);
  }

// Function to remove a UniversityPriority item by index
  void removeUniversityPriority(int index) {
    if (index >= 0 && index < _universityPriorityList.length) {
      // Dispose the controllers and focus nodes to avoid memory leaks
      _universityPriorityList[index].countryIdController.dispose();
      _universityPriorityList[index].universityIdController.dispose();
      _universityPriorityList[index].otherUniversityNameController.dispose();
      _universityPriorityList[index].majorsController.dispose();
      _universityPriorityList[index].statusController.dispose();
      _universityPriorityList[index].errorMessageController.dispose();
      _universityPriorityList[index].isNewController.dispose();
      _universityPriorityList[index].countryIdFocusNode.dispose();
      _universityPriorityList[index].universityIdFocusNode.dispose();
      _universityPriorityList[index].otherUniversityNameFocusNode.dispose();
      _universityPriorityList[index].majorsFocusNode.dispose();
      _universityPriorityList[index].statusFocusNode.dispose();

      // Remove the item from the list
      _universityPriorityList.removeAt(index);
    }
  }

  _universityAndMajorsDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          draftPrevNextButtons(langProvider),
          // majors
          CustomInformationContainer(
              title: _selectedScholarship?.acadmicCareer == 'PGRD'
                  ? 'pgrd.major.wishlist'
                  : 'major.wishlist',
              expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // dropdown for pgrd students academic program
                    (_selectedScholarship?.acadmicCareer == 'PGRD' &&
                            _selectedScholarship?.acadmicCareer != 'DDS')
                        ? Column(
                            children: [
                              fieldHeading(
                                title: "pgrd.adac.program",
                                important: true,
                                langProvider: langProvider,
                              ),
                              _scholarshipFormDropdown(
                                controller: _acadProgramPgrdController,
                                currentFocusNode: _acadProgramPgrdFocusNode,
                                menuItemsList: _acadProgramPgrdMenuItemsList,
                                hintText: "Select Academic Program",
                                errorText: _acadProgramPgrdErrorText,
                                onChanged: (value) {
                                  _acadProgramPgrdErrorText = null;

                                  setState(() {
                                    _acadProgramPgrdController.text = value!;

// TODO: Pending implementation of the academic program next focus request
                                    // // Move focus to the next field
                                    // Utils.requestFocus(
                                    //   focusNode: requiredExamInfo
                                    //       .examinationGradeFocusNode,
                                    //   context: context,
                                    // );
                                  });
                                },
                              )
                            ],
                          )
                        : showVoid,

                    kFormHeight,

                    // Select Majors wishlist
                    _selectedScholarship?.acadmicCareer != 'DDS'
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _majorsWishlist.length,
                            itemBuilder: (context, index) {
                              final majorInfo = _majorsWishlist[index];

                              return Column(
                                children: [
                                  fieldHeading(
                                      title: index == 0
                                          ? 'majors.wish.1'
                                          : index == 1
                                              ? 'majors.wish.2'
                                              : 'majors.wish.3',
                                      important:
                                          _selectedScholarship?.acadmicCareer !=
                                                  'DDS' &&
                                              index == 0,
                                      langProvider: langProvider),
                                  _scholarshipFormDropdown(
                                    controller: majorInfo.majorController,
                                    currentFocusNode: majorInfo.majorFocusNode,
                                    menuItemsList: _majorsMenuItemsList ?? [],
                                    hintText: "Select Major Program",
                                    errorText: majorInfo.majorError,
                                    onChanged: (value) {
                                      majorInfo.majorError = null;
                                      bool alreadySelected =
                                          _majorsWishlist.any((info) {
                                        return info != majorInfo &&
                                            info.majorController.text == value;
                                      });

                                      if (alreadySelected) {
                                        setState(() {
                                          majorInfo.majorError = null;
                                          majorInfo.majorController.clear();
                                          majorInfo.isNewController.text =
                                              "false";

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "This major has already been selected. Please choose another one.")));
                                          // Show the toast message inside setState to reflect UI change
                                          _alertService.toastMessage(
                                            "This major has already been selected. Please choose another one.",
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          majorInfo.majorController.text =
                                              value!;
                                          majorInfo.isNewController.text =
                                              "true"; // Mark entry as valid

                                          // If necessary, you can also add a success toast here
                                          _alertService.toastMessage(
                                              "Major selected successfully.");
                                        });
                                      }
                                    },
                                  ),
                                  kFormHeight,
                                ],
                              );
                            })
                        : showVoid,

                    // major when academic program is dds
                    _selectedScholarship?.acadmicCareer == 'DDS'
                        ? Column(
                            children: [
                              fieldHeading(
                                title: "ddsMajor1",
                                important: true,
                                langProvider: langProvider,
                              ),
                              _scholarshipFormDropdown(
                                controller: _acadProgramDdsController,
                                currentFocusNode: _acadProgramDdsFocusNode,
                                menuItemsList: _acadProgramDdsMenuItemsList,
                                hintText: "Select DDS Academic Program",
                                errorText: _acadProgramDdsErrorText,
                                onChanged: (value) {
                                  _acadProgramDdsErrorText = null;

                                  setState(() {
                                    _acadProgramDdsController.text = value!;
                                  });
                                },
                              )
                            ],
                          )
                        : showVoid
                  ])),
          kFormHeight,
          // university list
          CustomInformationContainer(
              title: _selectedScholarship?.acadmicCareer == 'DDS'
                  ? 'DDS University wishlist'
                  : 'University wishlist',
              expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Select Majors wishlist
                    _selectedScholarship?.acadmicCareer != 'HCHL'
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _universityPriorityList.length,
                            itemBuilder: (context, index) {
                              final universityInfo =
                                  _universityPriorityList[index];

                              return Column(
                                children: [
                                  // ****************************************************************************************************************************************************

                                  fieldHeading(
                                      title: "Country",
                                      important: true,
                                      langProvider: langProvider),

                                  _scholarshipFormDropdown(
                                    readOnly: isStudyCountry,
                                    filled: isStudyCountry,
                                    controller:
                                        universityInfo.countryIdController,
                                    currentFocusNode:
                                        universityInfo.universityIdFocusNode,
                                    menuItemsList:
                                        _nationalityMenuItemsList ?? [],
                                    hintText: "Select Country",
                                    errorText: universityInfo.countryIdError,
                                    onChanged: (value) {
                                      // Clear the error initially
                                      setState(() {
                                        universityInfo.countryIdError = null;
                                        // Set the major value if no duplicates are found
                                        universityInfo
                                            .countryIdController.text = value!;
                                        populateUniversitiesWishList(
                                            universityInfo);
                                      });
                                    },
                                  ),
                                  // ********************************************************************
                                  kFormHeight,
                                  // major
                                  _selectedScholarship?.acadmicCareer != 'DDS'
                                      ? Column(
                                          children: [
                                            fieldHeading(
                                                title: "Majors",
                                                important: true,
                                                langProvider: langProvider),
                                            _scholarshipFormDropdown(
                                              controller: universityInfo
                                                  .majorsController,
                                              currentFocusNode: universityInfo
                                                  .majorsFocusNode,
                                              menuItemsList:
                                                  _majorsMenuItemsList ?? [],
                                              hintText: "Select",
                                              errorText:
                                                  universityInfo.majorsError,
                                              onChanged: (value) {
                                                // Clear the error initially
                                                setState(() {
                                                  universityInfo.majorsError =
                                                      null;

                                                  // // Check if the selected major is already in the wishlist
                                                  // bool alreadySelected =
                                                  // _universityPriorityList.any((info) {
                                                  //   // Make sure we're not checking against the current item and compare the selected value
                                                  //   return info != universityInfo &&
                                                  //       info.majorsController.text ==
                                                  //           value;
                                                  // });
                                                  //
                                                  // if (alreadySelected) {
                                                  //   // If the major is already selected, show a toast message and set an error
                                                  //   _alertService.showToast(
                                                  //     context: context,
                                                  //     message:
                                                  //     "This  has already been selected. Please choose another one.",
                                                  //   );
                                                  //   universityInfo.majorsError =
                                                  //   "Please choose another";
                                                  //
                                                  //   // Clear the selected major value in the controller
                                                  //   universityInfo.majorsController
                                                  //       .clear();
                                                  //   universityInfo.isNewController.text =
                                                  //   "false"; // Reset to indicate it's not a valid entry
                                                  // } else {
                                                  // Set the major value if no duplicates are found
                                                  universityInfo
                                                      .majorsController
                                                      .text = value!;
                                                  // }
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : showVoid,

                                  // ****************************************************************************************************************************************************
                                  kFormHeight,

                                  universityInfo.majorsController.text == 'OTH' || _selectedScholarship
                                      ?.acadmicCareer == 'DDS'
                                      ? Column(
                                          children: [
                                            fieldHeading(
                                                title:
                                                    _selectedScholarship
                                                                ?.acadmicCareer !=
                                                            'DDS'
                                                        ? "Other Major"
                                                        : "dds.major",
                                                important: _selectedScholarship?.acadmicCareer != 'DDS' && universityInfo.majorsController.text == 'OTH' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty),
                                                langProvider: langProvider),
                                            _scholarshipFormTextField(
                                                currentFocusNode: universityInfo.otherMajorsFocusNode,
                                                nextFocusNode: universityInfo.universityIdFocusNode,
                                                controller: universityInfo.otherMajorsController,
                                                hintText: 'Enter majors',
                                                maxLength: 30,
                                                errorText: universityInfo.otherMajorsError,
                                                onChanged: (value) {
                                                  print(universityInfo.otherMajorsController.text)
;
                                                  if (universityInfo
                                                      .otherMajorsFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      universityInfo.otherMajorsError = _selectedScholarship
                                                                      ?.acadmicCareer !=
                                                                  'DDS' &&
                                                              universityInfo
                                                                      .majorsController
                                                                      .text ==
                                                                  'OTH' &&
                                                              (universityInfo
                                                                      .countryIdController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .otherMajorsController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .otherUniversityNameController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .statusController
                                                                      .text
                                                                      .isNotEmpty)
                                                          ? ErrorText.getEmptyFieldError(
                                                              name: universityInfo
                                                                  .otherMajorsController
                                                                  .text,
                                                              context: context)
                                                          : null;
                                                    });
                                                  }
                                                }),
                                          ],
                                        )
                                      : showVoid,

                                  // ****************************************************************************************************************************************************

                                  _selectedScholarship?.acadmicCareer != "DDS"
                                      ? Column(
                                          children: [
                                            fieldHeading(
                                                title: "University",
                                                important: true,
                                                langProvider: langProvider),
                                            _scholarshipFormDropdown(
                                              controller: universityInfo
                                                  .universityIdController,
                                              currentFocusNode: universityInfo
                                                  .majorsFocusNode,
                                              menuItemsList: universityInfo
                                                      .universityDropdown ??
                                                  [],
                                              hintText: "Select",
                                              errorText: universityInfo
                                                  .universityIdError,
                                              onChanged: (value) {
                                                // Clear the error initially
                                                setState(() {
                                                  universityInfo
                                                      .universityIdError = null;

                                                  // Check if the selected major is already in the wishlist
                                                  bool alreadySelected =
                                                      _universityPriorityList
                                                          .any((info) {
                                                    // Make sure we're not checking against the current item and compare the selected value
                                                    return info !=
                                                            universityInfo &&
                                                        info.universityIdController
                                                                .text ==
                                                            value;
                                                  });

                                                  if (alreadySelected) {
                                                    // If the major is already selected, show a toast message and set an error
                                                    _alertService.showToast(
                                                      context: context,
                                                      message:
                                                          "This  has already been selected. Please choose another one.",
                                                    );
                                                    universityInfo
                                                            .universityIdError =
                                                        "Please choose another";

                                                    // Clear the selected major value in the controller
                                                    universityInfo
                                                        .universityIdController
                                                        .clear();
                                                  } else {
                                                    // Set the major value if no duplicates are found
                                                    universityInfo
                                                        .universityIdController
                                                        .text = value!;
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : showVoid,
                                  // ****************************************************************************************************************************************************

                                  kFormHeight,
                                  universityInfo.universityIdController.text ==
                                          'OTH' || _selectedScholarship
                                      ?.acadmicCareer == 'DDS'
                                      ? Column(
                                          children: [
                                            fieldHeading(
                                                title: _selectedScholarship
                                                            ?.acadmicCareer !=
                                                        'DDS'
                                                    ? 'university.name.if.other'
                                                    : 'dds.university',
                                                important: (_selectedScholarship
                                                            ?.acadmicCareer !=
                                                        'DDS' &&
                                                    universityInfo.universityIdController.text ==
                                                        'OTH' &&
                                                    (universityInfo
                                                            .countryIdController
                                                            .text
                                                            .isNotEmpty ||
                                                        universityInfo
                                                            .otherMajorsController
                                                            .text
                                                            .isNotEmpty ||
                                                        universityInfo
                                                            .otherUniversityNameController
                                                            .text
                                                            .isNotEmpty ||
                                                        universityInfo
                                                            .statusController
                                                            .text
                                                            .isNotEmpty)),
                                                langProvider: langProvider),
                                            _scholarshipFormTextField(
                                                currentFocusNode: universityInfo
                                                    .otherUniversityNameFocusNode,
                                                nextFocusNode: universityInfo
                                                    .statusFocusNode,
                                                controller: universityInfo
                                                    .otherUniversityNameController,
                                                hintText:
                                                    'Enter other University Name',
                                                errorText: universityInfo
                                                    .otherUniversityNameError,
                                                onChanged: (value) {
                                                  if (universityInfo
                                                      .otherUniversityNameFocusNode
                                                      .hasFocus) {
                                                    setState(() {
                                                      universityInfo.otherUniversityNameError = (_selectedScholarship
                                                                      ?.acadmicCareer !=
                                                                  'DDS' &&
                                                              universityInfo
                                                                      .universityIdController
                                                                      .text ==
                                                                  'OTH' &&
                                                              (universityInfo
                                                                      .countryIdController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .otherMajorsController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .otherUniversityNameController
                                                                      .text
                                                                      .isNotEmpty ||
                                                                  universityInfo
                                                                      .statusController
                                                                      .text
                                                                      .isNotEmpty))
                                                          ? ErrorText.getEmptyFieldError(
                                                              name: universityInfo
                                                                  .otherUniversityNameController
                                                                  .text,
                                                              context: context)
                                                          : null;
                                                    });
                                                  }
                                                }),
                                          ],
                                        )
                                      : showVoid,
                                  // ****************************************************************************************************************************************************

                                  kFormHeight,
                                  fieldHeading(
                                      title: "Status",
                                      important: _selectedScholarship
                                                  ?.acadmicCareer !=
                                              'DDS' &&
                                          (universityInfo.countryIdController
                                                  .text.isNotEmpty ||
                                              universityInfo.otherMajorsController
                                                  .text.isNotEmpty ||
                                              universityInfo
                                                  .otherUniversityNameController
                                                  .text
                                                  .isNotEmpty ||
                                              universityInfo.statusController
                                                  .text.isNotEmpty),
                                      langProvider: langProvider),

                                  _scholarshipFormDropdown(
                                    controller: universityInfo.statusController,
                                    currentFocusNode:
                                        universityInfo.statusFocusNode,
                                    menuItemsList:
                                        _universityPriorityStatus ?? [],
                                    hintText: "Select  Status",
                                    errorText: universityInfo.statusError,
                                    onChanged: (value) {
                                      // Clear the error initially
                                      universityInfo.statusError = null;
                                      setState(() {
                                        universityInfo.statusController.text =
                                            value!;
                                      });
                                    },
                                  ),

                                  index != 0
                                      ? _addRemoveMoreSection(
                                          title: "Delete",
                                          add: false,
                                          onChanged: () {
                                            setState(() {
                                              removeUniversityPriority(index);
                                            });
                                          })
                                      : showVoid,

                                  kFormHeight,
                                  const MyDivider(
                                    color: AppColors.lightGrey,
                                  ),
                                  kFormHeight,
                                ],
                              );
                            })
                        : showVoid,

                    _addRemoveMoreSection(
                        title: "Add",
                        add: true,
                        onChanged: () {
                          setState(() {
                            addUniversityPriority();
                          });
                        }),
                  ])),
          draftPrevNextButtons(langProvider)
        ])));
  }

  // *--------------------------------------------------------------- University And Majors Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Required Examinations start ----------------------------------------------------------------------------*
  // step-5

  List<RequiredExaminations> _requiredExaminationList = [];

  List<DropdownMenuItem>? _requiredExaminationDropdownMenuItems = [];

  // get examination type
  _populateExaminationTypeDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
              .lovCodeMap[
                  'EXAMINATION_TYPE#${_requiredExaminationList[index].examinationController.text}']
              ?.values !=
          null) {
        _requiredExaminationList[index].examinationTypeDropdown =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                        'EXAMINATION_TYPE#${_requiredExaminationList[index].examinationController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  // get min score and max score just fetching the elements from the lov and based on exam and exam type selection we will find min and max score and set that to the fields
  List _testScoreVal = [];

  // min max score for values
  _setMinMaxScore(
      {required LanguageChangeViewModel langProvider, required int index}) {
    if (_testScoreVal.isNotEmpty) {
      final requiredExaminationInfo = _requiredExaminationList[index];

      final code =
          "${requiredExaminationInfo.examinationController.text}:${requiredExaminationInfo.examinationTypeIdController.text}";

      for (var element in _testScoreVal) {
        if (element.code.toString() == code.toString()) {
          requiredExaminationInfo.minScoreController.text =
              element.value.toString().split(":").elementAt(0).toString();
          requiredExaminationInfo.maxScoreController.text =
              element.value.toString().split(":").last.toString();
        }
      }
    } else {
      debugPrint("TEST_SCORE_VAL is Empty");
    }
  }

// function to add examination from list
  _addRequiredExamination() {
    setState(() {
      _requiredExaminationList.add(RequiredExaminations(
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

// function to delete examination from list
  _deleteRequiredExamination(int index) {
    if (index > 0 && index < _requiredExaminationList.length) {
      setState(() {
        // Get the item to be deleted
        final item = _requiredExaminationList[index];

        // Dispose of all the TextEditingController instances
        item.examinationController.dispose();
        item.examinationTypeIdController.dispose();
        item.examinationGradeController.dispose();
        item.minScoreController.dispose();
        item.maxScoreController.dispose();
        item.examDateController.dispose();
        item.isNewController.dispose();
        item.errorMessageController.dispose();

        // Dispose of all the FocusNode instances
        item.examinationFocusNode.dispose();
        item.examinationTypeIdFocusNode.dispose();
        item.examinationGradeFocusNode.dispose();
        item.minScoreFocusNode.dispose();
        item.maxScoreFocusNode.dispose();
        item.examDateFocusNode.dispose();

        // Remove the item from the list
        _requiredExaminationList.removeAt(index);
      });
    }
  }

  // Section for Required Examinations
  Widget _requiredExaminationsDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          draftPrevNextButtons(langProvider),
          CustomInformationContainer(
              title: _selectedScholarship?.acadmicCareer == 'DDS'
                  ? 'dds.exams'
                  : "'examination.for.universiti",
              expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _requiredExaminationList.length,
                          itemBuilder: (context, index) {
                            final requiredExamInfo =
                                _requiredExaminationList[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // ****************************************************************************************************************************************************
                                // Examination name
                                fieldHeading(
                                    title: "Examination",
                                    important: true,
                                    langProvider: langProvider),
                                _scholarshipFormDropdown(
                                  controller:
                                      requiredExamInfo.examinationController,
                                  currentFocusNode:
                                      requiredExamInfo.examinationFocusNode,
                                  menuItemsList:
                                      _requiredExaminationDropdownMenuItems ??
                                          [],
                                  hintText: "Select Examination",
                                  errorText: requiredExamInfo.examinationError,
                                  onChanged: (value) {
                                    requiredExamInfo.examinationError = null;

                                    setState(() {
                                      // checking for existing selected
                                      bool alreadySelected =
                                          _requiredExaminationList.any((info) {
                                        return info != requiredExamInfo &&
                                            info.examinationController.text ==
                                                value!;
                                      });
                                      if (alreadySelected) {
                                        // If duplicate is found, show an error and clear the controller
                                        _alertService.showToast(
                                          context: context,
                                          message:
                                              "This level has already been selected. Please choose another one.",
                                        );
                                        requiredExamInfo.examinationError =
                                            "Please choose another";
                                      } else {
                                        // Assign the value only if it's not already selected
                                        requiredExamInfo.examinationController
                                            .text = value!;

                                        // clearing dependent dropdowns values
                                        requiredExamInfo
                                            .examinationTypeIdController
                                            .clear();
                                        requiredExamInfo.examinationTypeDropdown
                                            ?.clear();

                                        // populate examination type dropdown
                                        _populateExaminationTypeDropdown(
                                          langProvider: langProvider,
                                          index: index,
                                        );

                                        // Move focus to the next field
                                        Utils.requestFocus(
                                          focusNode: requiredExamInfo
                                              .examinationTypeIdFocusNode,
                                          context: context,
                                        );
                                      }
                                    });
                                  },
                                ),
                                // ****************************************************************************************************************************************************

                                kFormHeight,
                                // examination type dropdown
                                fieldHeading(
                                    title: "Examination Type",
                                    important: true,
                                    langProvider: langProvider),
                                _scholarshipFormDropdown(
                                  controller: requiredExamInfo
                                      .examinationTypeIdController,
                                  currentFocusNode: requiredExamInfo
                                      .examinationTypeIdFocusNode,
                                  menuItemsList: requiredExamInfo
                                          .examinationTypeDropdown ??
                                      [],
                                  hintText: "Select Examination Type",
                                  errorText:
                                      requiredExamInfo.examinationTypeIdError,
                                  onChanged: (value) {
                                    requiredExamInfo.examinationTypeIdError =
                                        null;

                                    setState(() {
                                      // Assign the value only if it's not already selected
                                      requiredExamInfo
                                          .examinationTypeIdController
                                          .text = value!;

                                      // setting min max score for indexed item
                                      _setMinMaxScore(
                                          langProvider: langProvider,
                                          index: index);

                                      // Move focus to the next field
                                      Utils.requestFocus(
                                        focusNode: requiredExamInfo
                                            .examinationGradeFocusNode,
                                        context: context,
                                      );
                                    });
                                  },
                                ),
                                // ****************************************************************************************************************************************************

                                kFormHeight,
                                // examination grade dropdown
                                fieldHeading(
                                    title:
                                        _selectedScholarship?.acadmicCareer !=
                                                'DDS'
                                            ? 'examination.grade'
                                            : 'examination.dds.grade',
                                    important: true,
                                    langProvider: langProvider),
                                _scholarshipFormTextField(
                                    currentFocusNode: requiredExamInfo.examinationGradeFocusNode,
                                    nextFocusNode: requiredExamInfo.examDateFocusNode,
                                    controller: requiredExamInfo.examinationGradeController,
                                    hintText: _selectedScholarship?.acadmicCareer != 'DDS' ? 'Enter examination.grade' : 'Enter examination.dds.grade',
                                    errorText:
                                        requiredExamInfo.examinationGradeError,
                                    onChanged: (value) {
                                      if (requiredExamInfo
                                          .examinationGradeFocusNode.hasFocus) {
                                        setState(() {
                                          requiredExamInfo
                                                  .examinationGradeError =
                                              ErrorText.getGradeValidationError(
                                                  grade: requiredExamInfo
                                                      .examinationGradeController
                                                      .text,
                                                  context: context);
                                        });
                                      }
                                    }),
                                // ****************************************************************************************************************************************************
                                kFormHeight,
                                // 'Exam Date'
                                fieldHeading(
                                    title: 'Exam Date',
                                    important: true,
                                    langProvider: langProvider),
                                _scholarshipFormDateField(
                                  currentFocusNode:
                                      requiredExamInfo.examDateFocusNode,
                                  controller:
                                      requiredExamInfo.examDateController,
                                  hintText: "Select Exam Date",
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
                                    // Clear the error message when a date is selected
                                    requiredExamInfo.examDateError = null;

                                    // Define the initial date as today's date (for year selection)
                                    final DateTime initialDate = DateTime.now();

                                    // Use a specific max date if required (like schoolPassingDate from your controller)
                                    // If no schoolPassingDate is available, use the current date as a fallback
                                    final DateTime maxDate = DateTime.now();

                                    // Define the valid date range for "Year of Passing"
                                    final DateTime firstDate = maxDate.subtract(
                                        const Duration(
                                            days: 20 * 365)); // Last 20 years
                                    final DateTime lastDate = maxDate.add(
                                        const Duration(
                                            days: 20 *
                                                365)); // Limit up to the maxDate (e.g., current year or schoolPassingDate)

                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      barrierColor: AppColors.scoButtonColor
                                          .withOpacity(0.1),
                                      barrierDismissible: false,
                                      locale:
                                          Provider.of<LanguageChangeViewModel>(
                                                  context,
                                                  listen: false)
                                              .appLocale,
                                      initialDate: initialDate,
                                      firstDate: firstDate,
                                      // Limit to the last 20 years
                                      lastDate:
                                          lastDate, // Limit up to the maxDate or current year
                                    );

                                    if (date != null) {
                                      setState(() {
                                        // Set the selected date in the controller (format to show only the year)
                                        requiredExamInfo
                                                .examDateController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(date)
                                                .toString();
                                      });
                                    }
                                  },
                                ),

                                // ****************************************************************************************************************************************************
                                // add examination
                                (index >= 1)
                                    ? _addRemoveMoreSection(
                                        title: "Delete",
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            _deleteRequiredExamination(index);
                                          });
                                        })
                                    : showVoid,
                                kFormHeight,
                                const MyDivider(
                                  color: AppColors.lightGrey,
                                ),
                                kFormHeight,
                                // ****************************************************************************************************************************************************
                              ],
                            );
                          }),
                      // ****************************************************************************************************************************************************
                      // add examination
                      _addRemoveMoreSection(
                          title: "Add",
                          add: true,
                          onChanged: () {
                            setState(() {
                              _addRequiredExamination();
                            });
                          })
                      // ****************************************************************************************************************************************************
                      ,
                    ])
                  ])),
          draftPrevNextButtons(langProvider)
        ])));
  }

  // *--------------------------------------------------------------- Required Examinations end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Employment history section start ----------------------------------------------------------------------------*
  // step-6
// function to check weather to display employment history or not
  bool displayEmploymentHistory() {
    final key = _selectedScholarship?.configurationKey;
    return (key == 'SCOPGRDINT' || key == 'SCOPGRDEXT' || key == 'SCODDSEXT');
  }

  // available employment status from lov
  List _employmentStatusItemsList = [];

  // current Employment status
  String? _employmentStatus;

  // employment history list

  List<EmploymentHistory> _employmentHistoryList = [];

  // add employment history
  void _addEmploymentHistory() {
    setState(() {
      _employmentHistoryList.add(EmploymentHistory(
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

  void _removeEmploymentHistory(int index) {
    if (index >= 0 && index < _employmentHistoryList.length) {
      setState(() {
        // Get the item to be deleted
        final item = _employmentHistoryList[index];

        // Dispose of all the TextEditingController instances
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

        // Dispose of all the FocusNode instances
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

        // Remove the item from the list
        _employmentHistoryList.removeAt(index);
      });
    }
  }

  Widget _employmentHistoryDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          draftPrevNextButtons(langProvider),
          CustomInformationContainer(
              title: "Employment History",
              expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ****************************************************************************************************************************************************
                          // previously employed or not be using radio buttons
                          _sectionTitle(title: "Previously Employed"),
                          kFormHeight,
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _employmentStatusItemsList.length,
                              itemBuilder: (context, index) {
                                final element =
                                    _employmentStatusItemsList[index];
                                return CustomRadioListTile(
                                  value: element.code,
                                  groupValue: _employmentStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      _employmentStatus = value;

                                      if (_employmentStatus == 'N') {
                                        _employmentHistoryList.clear();
                                      }
                                      if (_employmentHistoryList.isEmpty) {
                                        _addEmploymentHistory();
                                      } else {
                                        _employmentHistoryList.clear();
                                        _addEmploymentHistory();
                                      }
                                    });
                                  },
                                  title: getTextDirection(langProvider) ==
                                          TextDirection.ltr
                                      ? element.value
                                      : element.valueArabic,
                                  textStyle: _textFieldTextStyle,
                                );
                              }),
                          // ****************************************************************************************************************************************************

// employment history details section
                          _employmentStatus != null &&
                                  _employmentStatus != '' &&
                                  _employmentStatus != 'N'
                              ? Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            _employmentHistoryList.length,
                                        itemBuilder: (context, index) {
                                          final employmentHistInfo =
                                              _employmentHistoryList[index];
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // ****************************************************************************************************************************************************

                                              // Employer name
                                              fieldHeading(
                                                  title: "Employer Name",
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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

                                              // ****************************************************************************************************************************************************

                                              kFormHeight,
                                              // Designation
                                              fieldHeading(
                                                  title: "Designation",
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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

                                              // ****************************************************************************************************************************************************

                                              kFormHeight,
                                              // occupation
                                              fieldHeading(
                                                  title: 'Occupation',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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
                                              // ****************************************************************************************************************************************************
                                              kFormHeight,
                                              // work place
                                              fieldHeading(
                                                  title: 'Work Place',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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

                                              // ****************************************************************************************************************************************************

                                              kFormHeight,
                                              // start date
                                              fieldHeading(
                                                  title:
                                                      'Employment Start Date',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormDateField(
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
                                                  // Clear the error message when a date is selected
                                                  employmentHistInfo
                                                      .startDateError = null;

                                                  // Define the initial date as today's date (for year selection)
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
                                                    // Limit to the last 10 years
                                                    lastDate:
                                                        initialDate, // Limit up to the maxDate or current year
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

                                              // ****************************************************************************************************************************************************
                                              kFormHeight,
                                              // end date
                                              fieldHeading(
                                                  title: 'Employment End Date',
                                                  important:
                                                      _employmentStatus == 'P',
                                                  langProvider: langProvider),
                                              _scholarshipFormDateField(
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
                                                  // Clear the error message when a date is selected
                                                  employmentHistInfo
                                                      .endDateError = null;

                                                  // Define the initial date as today's date (for year selection)
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
                                                    // Limit to the last 10 years
                                                    lastDate:
                                                        initialDate, // Limit up to the maxDate or current year
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

                                              // ****************************************************************************************************************************************************
                                              kFormHeight,
                                              // reporting manager
                                              fieldHeading(
                                                  title: 'Reporting Manager',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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
                                              // ****************************************************************************************************************************************************
                                              kFormHeight,
                                              // contact number
                                              fieldHeading(
                                                  title: 'Contact Number',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
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
                                              // ****************************************************************************************************************************************************
                                              kFormHeight,
                                              // contact email
                                              fieldHeading(
                                                  title: 'Contact Email',
                                                  important: true,
                                                  langProvider: langProvider),
                                              _scholarshipFormTextField(
                                                  currentFocusNode:
                                                      employmentHistInfo
                                                          .contactEmailFocusNode,
                                                  controller: employmentHistInfo
                                                      .contactEmailController,
                                                  nextFocusNode: index <
                                                          _employmentHistoryList
                                                                  .length -
                                                              1
                                                      ? _employmentHistoryList[
                                                              index + 1]
                                                          .employerNameFocusNode
                                                      : null,
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
                                              // ****************************************************************************************************************************************************

                                              (index >= 1)
                                                  ? _addRemoveMoreSection(
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
                                              // ****************************************************************************************************************************************************
                                            ],
                                          );
                                        }),
                                    // ****************************************************************************************************************************************************
                                    _addRemoveMoreSection(
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

                          // ****************************************************************************************************************************************************
                        ])
                  ])),
          draftPrevNextButtons(langProvider)
        ])));
  }

  // *--------------------------------------------------------- Attachments Section start ------------------------------------------------------------------------------*
  // step-7

  // List of Attachments:
  List _attachmentsList = [];

  List<Attachment> _myAttachmentsList = [];

  Widget _attachmentsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          draftPrevNextButtons(langProvider),
          CustomInformationContainer(
              title: "Attachments",
              expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _myAttachmentsList.length,
                        itemBuilder: (context, index) {
                          final attachment = _attachmentsList[index];
                          final myAttachment = _myAttachmentsList[index];
                          final title = getTextDirection(langProvider) ==
                                  TextDirection.ltr
                              ? attachment.value.toString().replaceAll('\n', '')
                              : attachment.valueArabic
                                  .toString()
                                  .replaceAll('\n', '');

                          // create file
                          File? file;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ****************************************************************************************************************************************************
                                // title name for document

                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: title,
                                    style: AppTextStyles.titleBoldTextStyle()
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: (attachment.required.toString() == 'XMRL' || attachment.required.toString() == 'MRL' || attachment.required.toString() == 'NMRL') ? "*" : "",
                                    style: AppTextStyles.titleBoldTextStyle()
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red),
                                  ),
                                ])),

                                kFormHeight,
                                // container to pick attachment
                                Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        // choose file button
                                        MaterialButton(
                                          onPressed: () async {
                                            // pick file



                                            // available extensions
                                            // 'jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx'

                                            final permissionChecker = PermissionChecker();
                                            permissionChecker.checkAndRequestPermission(Platform.isIOS ? Permission.storage : Permission.photos, context);
                                            file = await _mediaServices.getSingleFileFromPicker(allowedExtensions: myAttachment.documentCDController.text.toUpperCase() == 'SEL006' ? ['jpg', 'jpeg'] : ['pdf']);

                                            if (file != null) {
                                              setState(() {
                                                myAttachment.userFileNameController.text = file!.path.toString().split('-').last;

                                                // converted and stored in base64 string
                                                myAttachment.base64StringController.text = base64Encode(file!.readAsBytesSync());
                                              });
                                            }
                                          },
                                          color: AppColors.scoButtonColor,
                                          enableFeedback: false,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          child: Text("Choose File",
                                            style: AppTextStyles.titleTextStyle().copyWith(color: Colors.white),
                                          ),
                                        ),

                                        kFormHeight,
                                        // file name
                                        Expanded(
                                            child: Text(
                                          myAttachment
                                              .userFileNameController.text,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    )),

                                // show available file type
                                Text( myAttachment.documentCDController.text.toUpperCase() == 'SEL006'  ? "Select .jpeg|.jpg|.JPEG|.JPG file type only" : "Select Pdf file only",
                                    style: AppTextStyles.normalTextStyle()
                                        .copyWith(
                                            color: Colors.blueGrey,
                                            fontSize: 12)),
                                kFormHeight,

                                // comments
                                _sectionTitle(title: "Comments"),
                                // comments box
                                _scholarshipFormTextField(
                                    currentFocusNode: FocusNode(),
                                    controller: myAttachment.commentController,
                                    maxLines: 3,
                                    maxLength: 30,
                                    hintText: "Enter your view",
                                    onChanged: (value) {}),

                                kFormHeight,
                                // light grey divider
                                const MyDivider(
                                  color: AppColors.lightGrey,
                                ),

                                kFormHeight,
                                // Action
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Action",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.scoButtonColor),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          // remove the file
                                          setState(() {
                                            myAttachment.userFileNameController
                                                .text = "";
                                            myAttachment.base64StringController
                                                .text = "";
                                            myAttachment
                                                .commentController.text = '';
                                            file = null;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/action.svg"))
                                  ],
                                ),
                                kFormHeight,
                                const MyDivider(),
                                kFormHeight
                              ]);
                        })
                  ])),
          draftPrevNextButtons(langProvider)
        ])));
  }

  // *--------------------------------------------------------- Attachments Section end ------------------------------------------------------------------------------*


  Widget _confirmation()
  {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding:  EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            draftPrevNextButtons(langProvider),
          CustomInformationContainer(
              title: "Confirmation",
        expandedContent: Column(
          children: [

            kFormHeight,
            CustomGFCheckbox(value: true, onChanged: (value){}, text: "I agree. All information is correct and filled properly"),
            kFormHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(buttonName: "Print", isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){},buttonColor: AppColors.scoThemeColor,borderColor: Colors.transparent,),
            ),
            kFormHeight,
            kFormHeight,

          ],
        ),
          ),

            SizedBox(height: 20),

            draftPrevNextButtons(langProvider),


          ]),
      ));
  }


  // *--------------------------------------------------------- validate section in accordance with the steps start ------------------------------------------------------------------------------*

  // *--------------------------------------------------------- validate section in accordance with the steps start ------------------------------------------------------------------------------*

  // if section is already fulfilling the requirements then move forward to next step:
  bool validateSection(
      {required int step, required LanguageChangeViewModel langProvider})
  {
    String? acadmicCareer = _selectedScholarship?.acadmicCareer;
    String key = _selectedScholarship?.configurationKey ?? '';

    // Helper functions for specific validations
    bool shouldShowHighSchoolDetails() {
      return acadmicCareer == 'UG' ||
          acadmicCareer == 'UGRD' ||
          acadmicCareer == 'SCHL' ||
          acadmicCareer == 'HCHL';
    }

    bool isUniversityAndMajorsRequired() {
      return acadmicCareer != 'SCHL';
    }

    bool isRequiredExaminationDetailsRequired() {
      return !(acadmicCareer == 'SCHL' || acadmicCareer == 'HCHL');
    }

    bool isAttachmentSectionForExt() {
      return key == 'SCOUPPEXT';
    }

    bool shouldDisplayEmploymentHistory() {
      return displayEmploymentHistory();
    }

    // Switch case for validation based on step
    switch (step) {
      case 0:
        return validateStudentUndertakingSection(langProvider);

      case 1:
        return validateStudentDetailsSection(langProvider);

      case 2:
        if (shouldShowHighSchoolDetails()) {
          if (!validateHighSchoolDetails(langProvider)) return false;
        }
        return validateGraduationDetails(langProvider);

      case 3:
        if (isUniversityAndMajorsRequired()) {
          return validateUniversityAndMajorsDetails(langProvider);
        }
        return true;

      case 4:
        if (key == 'SCOUPPEXT') {
          return validateAttachmentsSection(langProvider); // Validation for SCOUPPEXT at step 4
        } else if (isRequiredExaminationDetailsRequired()) {
          return validateRequiredExaminations(langProvider);
        }
        return true;

      case 5:
        if (acadmicCareer == 'UGRD') {
          return validateAttachmentsSection(langProvider); // Validation for UGRD at step 5
        } else if (shouldDisplayEmploymentHistory()) {
          return validateEmploymentHistory(langProvider);
        }
        return true;

      case 6:
        return validateAttachmentsSection(langProvider); // Final confirmation for attachments if applicable

      case 7:
        return true; // No validation required

      default:
        return true;
    }
  }


  // To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  // Step 0: Validate "Accept Student Undertaking" section
  bool validateStudentUndertakingSection(langProvider) {
    firstErrorFocusNode = null;

    // Add validation logic for student details
    if (!_acceptStudentUndertaking) {
      _alertService.flushBarErrorMessages(
          message: 'Please accept the scholarship terms and conditions.',
          context: context,
          provider: langProvider);
      return false;
    }
    return true;
  }

  bool validateStudentDetailsSection(langProvider) {
    firstErrorFocusNode = null;
    // Validate Arabic Name fields
    if (_arabicName.studentNameController.text.isEmpty || !Validations.isArabicNameValid(_arabicName.studentNameController.text)) {
      setState(() {
        _arabicName.studentNameError = 'Please enter the student name in Arabic.';
        firstErrorFocusNode ??= _arabicName.studentNameFocusNode; // Set firstErrorFocusNode if it's null
      });
    }

    if (_arabicName.fatherNameController.text.isEmpty ||
        !Validations.isArabicNameValid(_arabicName.fatherNameController.text)) {
      setState(() {
        _arabicName.fatherNameError = 'Please enter the father\'s name in Arabic.';
        firstErrorFocusNode ??=
            _arabicName.fatherNameFocusNode; // Set firstErrorFocusNode if it's null
      });
    }

    if (_arabicName.grandFatherNameController.text.isEmpty ||
        !Validations.isArabicNameValid(_arabicName.grandFatherNameController.text)) {
      setState(() {
        _arabicName.grandFatherNameError =
            'Please enter the grandfather\'s name in Arabic.';
        firstErrorFocusNode ??= _arabicName.grandFatherNameFocusNode;
      });
    }

    if (_arabicName.familyNameController.text.isEmpty ||
        !Validations.isArabicNameValid(_arabicName.familyNameController.text)) {
      setState(() {
        _arabicName.familyNameError = 'Please enter the family name in Arabic.';
        firstErrorFocusNode ??= _arabicName.familyNameFocusNode;
      });
    }

    // Validate English Name fields
    if (_englishName.studentNameController.text.isEmpty ||
        !Validations.isEnglishNameValid(_englishName.studentNameController.text)) {
      setState(() {
        _englishName.studentNameError = 'Please enter the student name in English.';
        firstErrorFocusNode ??= _englishName.studentNameFocusNode;
      });
    }

    if (_englishName.fatherNameController.text.isEmpty ||
        !Validations.isEnglishNameValid(_englishName.fatherNameController.text)) {
      setState(() {
        _englishName.fatherNameError = 'Please enter the father\'s name in English.';
        firstErrorFocusNode ??= _englishName.fatherNameFocusNode;
      });
    }

    if (_englishName.grandFatherNameController.text.isEmpty ||
        !Validations.isEnglishNameValid(
            _englishName.grandFatherNameController.text)) {
      setState(() {
        _englishName.grandFatherNameError =
            'Please enter the grandfather\'s name in English.';
        firstErrorFocusNode ??= _englishName.grandFatherNameFocusNode;
      });
    }

    if (_englishName.familyNameController.text.isEmpty ||
        !Validations.isEnglishNameValid(_englishName.familyNameController.text)) {
      setState(() {
        _englishName.familyNameError = 'Please enter the family name in English.';
        firstErrorFocusNode ??= _englishName.familyNameFocusNode;
      });
    }

    // passport data validation start
    if (_passportNationalityController.text.isEmpty) {
      setState(() {
        _passportNationalityError = 'Please select your nationality';
        firstErrorFocusNode ??= _passportNationalityFocusNode;
      });
    }

    if (_passportNumberController.text.isEmpty) {
      setState(() {
        _passportNumberError = 'Please enter your passport number';
        firstErrorFocusNode ??= _passportNumberFocusNode;
      });
    }

    if (_passportIssueDateController.text.isEmpty) {
      setState(() {
        _passportIssueDateError = 'Please select your passport issue date';
        firstErrorFocusNode ??= _passportIssueDateFocusNode;
      });
    }

    if (_passportExpiryDateController.text.isEmpty) {
      setState(() {
        _passportExpiryDateError = 'Please select your passport Expiry date';
        firstErrorFocusNode ??= _passportExpiryDateFocusNode;
      });
    }
    if(_passportIssueDateController.text == _passportExpiryDateController.text ){
      setState(() {
        _passportExpiryDateError = 'Please select correct passport Expiry date';
        firstErrorFocusNode ??= _passportExpiryDateFocusNode;
      });
    }



    if (_passportPlaceOfIssueController.text.isEmpty) {
      setState(() {
        _passportPlaceOfIssueError =
            'Please select your passport place of issue';
        firstErrorFocusNode ??= _passportPlaceOfIssueFocusNode;
      });
    }

    if (_passportUnifiedNoController.text.isEmpty) {
      setState(() {
        _passportUnifiedNoError = 'Please enter your passport unified no';
        firstErrorFocusNode ??= _passportUnifiedNoFocusNode;
      });
    }

    // personal details validation
    if (_emiratesIdController.text.isEmpty) {
      setState(() {
        _emiratesIdError = 'Please enter your Emirates ID';
        firstErrorFocusNode ??= _emiratesIdFocusNode;
      });
    }

    if (_emiratesIdExpiryDateController.text.isEmpty) {
      setState(() {
        _emiratesIdExpiryDateError =
            'Please select your Emirates ID expiry date';
        firstErrorFocusNode ??= _emiratesIdExpiryDateFocusNode;
      });
    }

    if (_dateOfBirthController.text.isEmpty) {
      setState(() {
        _dateOfBirthError = 'Please enter your date of birth';
        firstErrorFocusNode ??= _dateOfBirthFocusNode;
      });
    }
    if(!isEighteenYearsOld(_dateOfBirthController.text)){
      setState(() {
        _dateOfBirthError = 'Please enter your correct DOB';
        firstErrorFocusNode ??= _dateOfBirthFocusNode;
      });
    }

    if (_placeOfBirthController.text.isEmpty) {
      setState(() {
        _placeOfBirthError = 'Please enter your place of birth';
        firstErrorFocusNode ??= _placeOfBirthFocusNode;
      });
    }

    if (_genderController.text.isEmpty) {
      setState(() {
        _genderError = 'Please select your gender';
        firstErrorFocusNode ??= _genderFocusNode;
      });
    }

    if (_maritalStatusController.text.isEmpty) {
      setState(() {
        _maritalStatusError = 'Please select your marital status';
        firstErrorFocusNode ??= _maritalStatusFocusNode;
      });
    }

    if (_studentEmailController.text.isEmpty) {
      setState(() {
        _studentEmailError = 'Please enter your student email';
        firstErrorFocusNode ??= _studentEmailFocusNode;
      });
    }

    //validate the family information
    if (_passportNationalityController.text == "ARE") {
      if (_familyInformationEmiratesController.text.isEmpty) {
        setState(() {
          _familyInformationEmiratesErrorText = 'Please select the Emirates';
          firstErrorFocusNode ??= _familyInformationEmiratesFocusNode;
        });
      }

      if (_familyInformationTownVillageNoController.text.isEmpty) {
        setState(() {
          _familyInformationTownVillageNoErrorText =
              'Please enter Town/Village';
          firstErrorFocusNode ??= _familyInformationTownVillageNoFocusNode;
        });
      }

      if (_familyInformationParentGuardianNameController.text.isEmpty) {
        setState(() {
          _familyInformationParentGuardianNameErrorText =
              'Please enter Parent/Guardian Name';
          firstErrorFocusNode ??= _familyInformationParentGuardianNameFocusNode;
        });
      }

      if (_familyInformationRelationTypeController.text.isEmpty) {
        setState(() {
          _familyInformationRelationTypeErrorText =
              'Please Select Relation Type';
          firstErrorFocusNode ??= _familyInformationRelationTypeFocusNode;
        });
      }

      if (_familyInformationMotherNameController.text.isEmpty) {
        setState(() {
          _familyInformationMotherNameErrorText = 'Please Enter Mother Name';
          firstErrorFocusNode ??= _familyInformationMotherNameFocusNode;
        });
      }
    }

    // validate the Relative information
    if (_isRelativeStudyingFromScholarship == null) {
      setState(() {
        firstErrorFocusNode ??= _isRelativeStudyingFromScholarshipYesFocusNode;
      });
    }

    if (_relativeInfoList.isNotEmpty) {
      for (var element in _relativeInfoList) {
        if (element.relationTypeController.text.isEmpty) {
          setState(() {
            element.relationTypeError = "Please Select Relation Type";
            firstErrorFocusNode ??= element.relationTypeFocusNode;
          });
        }

        // if (element.familyBookNumberController.text.isEmpty) {
        //   setState(() {
        //     element.familyBookNumberError =
        //         "Please Enter your family book number";
        //     firstErrorFocusNode ??= element.familyBookNumberFocusNode;
        //   });
        // }
      }
    }

    // validate the Phone Number information
    if (_phoneNumberList.isNotEmpty) {
      for (var element in _phoneNumberList) {
        if (element.phoneTypeController.text.isEmpty) {
          setState(() {
            element.phoneTypeError = "Please Select Phone Type";
            firstErrorFocusNode ??= element.phoneTypeFocusNode;
          });
        }

        if (element.phoneNumberController.text.isEmpty || !Validations.isPhoneNumberValid(element.phoneNumberController.text)) {
          setState(() {
            element.phoneNumberError = "Please Enter correct phone number";
            firstErrorFocusNode ??= element.phoneNumberFocusNode;
          });
        }

        if (element.countryCodeController.text.isEmpty) {
          setState(() {
            element.countryCodeError = "Please Enter your country code";
            firstErrorFocusNode ??= element.countryCodeFocusNode;
          });
        }
      }
    }

    // validate the Address information
    if (_addressInformationList.isNotEmpty) {
      for (var element in _addressInformationList) {
        if (element.addressTypeController.text.isEmpty) {
          setState(() {
            element.addressTypeError = "Please Select Address Type";
            firstErrorFocusNode ??= element.addressTypeFocusNode;
          });
        }

        if (element.addressLine1Controller.text.isEmpty) {
          setState(() {
            element.addressLine1Error = "Please Enter Address Line 1";
            firstErrorFocusNode ??= element.addressLine1FocusNode;
          });
        }

        if (element.countryController.text.isEmpty) {
          setState(() {
            element.countryError = "Please Select Country";
            firstErrorFocusNode ??= element.countryFocusNode;
          });
        }

        // if ( element.stateController.text.isEmpty && element.stateDropdownMenuItems?.isNotEmpty ?? false) {
        if ( element.stateController.text.isEmpty && (element.stateDropdownMenuItems?.isNotEmpty ?? false)) {

        setState(() {
            element.stateError = "Please Select State";
            firstErrorFocusNode ??= element.stateFocusNode;
          });
        }

        if (element.cityController.text.isEmpty) {
          setState(() {
            element.cityError = "Please Enter City";
            firstErrorFocusNode ??= element.cityFocusNode;
          });
        }
      }
    }

    // validate military services:
    if (_passportNationalityController.text == 'ARE') {
      switch (_isMilitaryService) {
        case MilitaryStatus.yes:
          if (_militaryServiceStartDateController.text.isEmpty) {
            setState(() {
              _militaryServiceStartDateErrorText =
                  'Please select Military Service Start Date';
              firstErrorFocusNode ??= _militaryServiceStartDateFocusNode;
            });
          }

          if (_militaryServiceEndDateController.text.isEmpty) {
            setState(() {
              _militaryServiceEndDateErrorText =
                  'Please select Military Service End Date';
              firstErrorFocusNode ??= _militaryServiceEndDateFocusNode;
            });
          }

          if (_militaryServiceStartDateController.text == _militaryServiceEndDateController.text) {
            setState(() {
              _militaryServiceEndDateErrorText =
              'Start Date and end Date cannot be same';
              firstErrorFocusNode ??= _militaryServiceEndDateFocusNode;
            });
          }
          break;

        case MilitaryStatus.no:
          break;

        case (MilitaryStatus.exemption || MilitaryStatus.postponed):
          if (_reasonForMilitaryController.text.isEmpty) {
            setState(() {
              _reasonForMilitaryErrorText = 'Please Enter Reason';
              firstErrorFocusNode ??= _reasonForMilitaryFocusNode;
            });
          }

          break;
      }
    }

    // If any error found, move to the first error focus node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true

      // saving student details in model
      // // initialize the models also
      // _initializeStudentDetailsModels();
      _finalForm(isUrlEncoded: true);

      return true;
    }
  }

  bool validateHighSchoolDetails(langProvider) {
    firstErrorFocusNode = null;

    if ((_selectedScholarship?.acadmicCareer == 'UG' ||
            _selectedScholarship?.acadmicCareer == 'UGRD' ||
            _selectedScholarship?.acadmicCareer == 'SCHL' ||
            _selectedScholarship?.acadmicCareer == 'HCHL') &&
        _highSchoolList.isNotEmpty) {
      for (var element in _highSchoolList) {
        if (element.hsLevelController.text.isEmpty) {
          setState(() {
            element.hsLevelError = "Please Select High school level";
            firstErrorFocusNode ??= element.hsLevelFocusNode;
          });
        }

        if (element.hsCountryController.text.isEmpty) {
          setState(() {
            element.hsCountryError = "Please Select the Country";
            firstErrorFocusNode ??= element.hsCountryFocusNode;
          });
        }
        if (element.schoolStateDropdownMenuItems?.isNotEmpty ?? false) {
          if (element.hsStateController.text.isEmpty) {
            setState(() {
              element.hsStateError = "Please Enter your State";
              firstErrorFocusNode ??= element.hsStateFocusNode;
            });
          }
        }
        if (element.hsCountryController.text == 'ARE') {
          if (element.hsNameController.text.isEmpty) {
            setState(() {
              element.hsNameError = "Please Enter your High School Name";
              firstErrorFocusNode ??= element.hsNameFocusNode;
            });
          }
        }
        if (element.hsCountryController.text != 'ARE' ||
            element.hsNameController.text == 'OTH') {

            if (element.otherHsNameController.text.isEmpty) {
              setState(() {
                element.otherHsNameError = "Please Enter your High School Name";
                firstErrorFocusNode ??= element.otherHsNameFocusNode;
              });
            }

        }
        // high school type
        if (element.hsTypeController.text.isEmpty) {
          setState(() {
            element.hsTypeError = "Please Select High School Type";
            firstErrorFocusNode ??= element.hsTypeFocusNode;
          });
        }
        // high school curriculum type
        if (element.curriculumTypeController.text.isEmpty) {
          setState(() {
            element.curriculumTypeError =
                "Please Select High School Curriculum Type";
            firstErrorFocusNode ??= element.curriculumTypeFocusNode;
          });
        }

        // high school curriculum average
        if (element.curriculumAverageController.text.isEmpty) {
          setState(() {
            element.curriculumAverageError =
                "Please Select High School Curriculum Type";
            firstErrorFocusNode ??= element.curriculumAverageFocusNode;
          });
        }

        if (element.curriculumAverageController.text.isNotEmpty) {
          if (element.yearOfPassingController.text.isEmpty) {
            setState(() {
              element.yearOfPassingError = "Please Select Year of Passing";
              firstErrorFocusNode ??= element.yearOfPassingFocusNode;
            });
          }
        }
      }
    }
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true
      return true;
    }
  }

  bool validateGraduationDetails(langProvider) {
    firstErrorFocusNode = null;

    // validate graduation details
    if (_selectedScholarship?.acadmicCareer != 'SCHL' &&
        _selectedScholarship?.acadmicCareer != 'HCHL') {
      for (int index = 0; index < _graduationDetailsList.length; index++) {
        var element = _graduationDetailsList[index];
        validateGraduationDetails(element) {
          if (element.currentlyStudying && element.showCurrentlyStudying) {
            // validating last term
            if (element.lastTermController.text.isEmpty) {
              setState(() {
                element.lastTermError = "Please Select Your Last Term";
                firstErrorFocusNode ??= element.lastTermFocusNode;
              });
            }
          }
// #################################################################
          // Condition using index and scholarship details
          if (index > 0 &&
              _selectedScholarship?.acadmicCareer != 'UGRD' &&
              _selectedScholarship?.acadmicCareer != 'DDS') {
            // validating graduation level
            if (element.levelController.text.isEmpty) {
              setState(() {
                element.levelError = "Please Select Your Graduation Level";
                firstErrorFocusNode ??= element.levelFocusNode;
              });
            }
          }

          // #################################################################
          // validating dds graduation level
          if (index != 0 && _selectedScholarship?.acadmicCareer == 'DDS') {
            if (element.levelController.text.isEmpty) {
              setState(() {
                element.levelError = "Please Select Your DDS Graduation Level";
                firstErrorFocusNode ??= element.levelFocusNode;
              });
            }
          }
          // #################################################################
          // validating graduation country
          if (element.countryController.text.isEmpty) {
            setState(() {
              element.countryError = "Please Select Your Graduation Country";
              firstErrorFocusNode ??= element.countryFocusNode;
            });
          }
          // #################################################################
          // high school university
          if (_selectedScholarship?.acadmicCareer != 'DDS') {
            if (element.universityController.text.isEmpty) {
              setState(() {
                element.universityError =
                    "Please Select Your High School University";
                firstErrorFocusNode ??= element.universityFocusNode;
              });
            }
          }

          // #################################################################
          // other university
          if (element.universityController.text == 'OTH') {
            if (element.otherUniversityController.text.isEmpty) {
              setState(() {
                element.otherUniversityError =
                    "Please Enter Other Univeersity Name";
                firstErrorFocusNode ??= element.otherUniversityFocusNode;
              });
            }
          }
          // #################################################################
          // major
          if (element.majorController.text.isEmpty) {
            setState(() {
              element.majorError = "Please select your major";
              firstErrorFocusNode ??= element.majorFocusNode;
            });
          }
          // #################################################################
          // cgpa
          if (element.cgpaController.text.isEmpty) {
            setState(() {
              element.cgpaError = "Please Enter your cgpa";
              firstErrorFocusNode ??= element.cgpaFocusNode;
            });
          }
          // #################################################################
          if (element.graduationStartDateController.text.isEmpty) {
            setState(() {
              element.graduationStartDateError =
                  "Please Enter Graduation Start Date";
              firstErrorFocusNode ??= element.graduationStartDateFocusNode;
            });
          }
          // #################################################################
          // graduation end data
          element.graduationEndDateError = null;
          if ((!element.currentlyStudying &&
              element.levelController.text.isNotEmpty)) {
            print("In graduation");

            if (element.graduationEndDateController.text.isEmpty) {
              setState(() {
                element.graduationEndDateError =
                    "Please Enter Graduation End Date";
                firstErrorFocusNode ??= element.graduationEndDateFocusNode;
              });
            }

            if (element.graduationEndDateController.text == element.graduationStartDateController.text) {
              setState(() {
                element.graduationEndDateError =
                "Please Enter correct start and end Date";
                firstErrorFocusNode ??= element.graduationEndDateFocusNode;
              });
            }



          }
          // #################################################################
          // Are you currently receiving scholarship or grant from other university
          if (_selectedScholarship?.acadmicCareer == 'DDS') {
            if (havingSponsor.isEmpty) {
              _alertService.flushBarErrorMessages(
                  message:
                      "Are you currently receiving scholarship or grant from other university",
                  context: context,
                  provider: Provider.of<LanguageChangeViewModel>(context,
                      listen: false));
              return false;
            }
          }
          // #################################################################
          // sponsorship name
          if ((havingSponsor == 'Y') ||
              _selectedScholarship?.acadmicCareer != 'DDS') {
            if (element.sponsorShipController.text.isEmpty) {
              setState(() {
                element.sponsorShipError = "Please Fill Sponsorship";
                firstErrorFocusNode ??= element.sponsorShipFocusNode;
              });
            }
          }

          // #################################################################
          if (element.levelController.text == 'PGRD' ||
              element.levelController.text == 'PG' ||
              element.levelController.text == 'DDS') {
            // case study title
            if (element.caseStudyTitleController.text.isEmpty) {
              setState(() {
                element.caseStudyTitleError = "Please Enter Case Study Title";
                firstErrorFocusNode ??= element.caseStudyTitleFocusNode;
              });
            }

            // case study start year
            if (element.caseStudyStartYearController.text.isEmpty) {
              setState(() {
                element.caseStudyStartYearError =
                    "Please Enter Case Study Title";
                firstErrorFocusNode ??= element.caseStudyStartYearFocusNode;
              });
            }
            // case study description
            if (element.caseStudyDescriptionController.text.isEmpty) {
              setState(() {
                element.caseStudyDescriptionError =
                    "Please Enter Case Study Description";
                firstErrorFocusNode ??= element.caseStudyDescriptionFocusNode;
              });
            }
          }
          // #################################################################
        }

        if (_selectedScholarship?.acadmicCareer == 'UGRD' &&
            element.currentlyStudying) {
          validateGraduationDetails(element);
        }
        if (_selectedScholarship?.acadmicCareer != 'UGRD') {
          validateGraduationDetails(element);
        }
      }
    }

    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true
      return true;
    }
  }

  bool validateUniversityAndMajorsDetails(langProvider) {
    firstErrorFocusNode = null;

    // academic program pgrd
    if (_selectedScholarship?.acadmicCareer == 'PGRD' &&
        _selectedScholarship?.acadmicCareer != 'DDS') {
      if (_acadProgramPgrdController.text.isEmpty) {
        setState(() {
          _acadProgramPgrdErrorText = "Please Enter Your PGRD Program";
          firstErrorFocusNode ??= _acadProgramPgrdFocusNode;
        });
      }

// #################################################################
    // major
    for (int i = 0; i < _majorsWishlist.length; i++) {
      var element = _majorsWishlist[i];
      if (i == 0 && element.majorController.text.isEmpty) {
        setState(() {
          element.majorError = "Please Enter Your Major Name";
          firstErrorFocusNode ??= element.majorFocusNode;
        });
      }
      if (element.majorError != null) {
        setState(() {
          element.majorError = "Please Select Other major";
          firstErrorFocusNode ??= element.majorFocusNode;
        });
      }
    }}
// #################################################################

    // academic program dds
    if (_selectedScholarship?.acadmicCareer == 'DDS') {
      if (_acadProgramDdsController.text.isEmpty) {
        setState(() {
          _acadProgramDdsErrorText = "Please Enter Your DDS Program";
          firstErrorFocusNode ??= _acadProgramDdsFocusNode;
        });
      }
    }

    // #################################################################

    // university wishlish validation
    if (_selectedScholarship?.acadmicCareer != 'HCHL') {
      for (int i = 0; i < _universityPriorityList.length; i++) {
        var element = _universityPriorityList[i];
        if (!isStudyCountry && element.countryIdController.text.isEmpty) {
          setState(() {
            element.countryIdError = "Please Select Your University Country";
            firstErrorFocusNode ??= element.countryIdFocusNode;
          });
        }

        // #################################################################
        if (_selectedScholarship?.acadmicCareer != 'DDS') {
          if (element.majorsController.text.isEmpty) {
            setState(() {
              element.majorsError = "Please Select Your Major";
              firstErrorFocusNode ??= element.majorsFocusNode;
            });
          }
        }
        // #################################################################
        // validate other university
        if (_selectedScholarship?.acadmicCareer != 'DDS' &&
            element.universityIdController.text == 'OTH' &&
            (element.countryIdController.text.isNotEmpty ||
                element.otherMajorsController.text.isNotEmpty ||
                element.otherUniversityNameController.text.isNotEmpty ||
                element.statusController.text.isNotEmpty)) {
          if (element.majorsController.text.isEmpty) {
            setState(() {
              element.otherMajorsError = "Please Enter other majors name";
              firstErrorFocusNode ??= element.otherMajorsFocusNode;
            });
          }
        }

// #################################################################
        // validate university
        if (_selectedScholarship?.acadmicCareer != 'DDS') {
          if (element.universityIdController.text.isEmpty) {
            setState(() {
              element.universityIdError = "Please Select Your Major";
              firstErrorFocusNode ??= element.universityIdFocusNode;
            });
          }
        }
// #################################################################
        // validate other university
        if (_selectedScholarship?.acadmicCareer != 'DDS' &&
            element.universityIdController.text == 'OTH' &&
            (element.countryIdController.text.isNotEmpty ||
                element.otherMajorsController.text.isNotEmpty ||
                element.otherUniversityNameController.text.isNotEmpty ||
                element.statusController.text.isNotEmpty)) {
          if (element.otherUniversityNameController.text.isEmpty) {
            setState(() {
              element.otherUniversityNameError = "Please Enter university name";
              firstErrorFocusNode ??= element.otherUniversityNameFocusNode;
            });
          }
        }

        // #################################################################
        if (_selectedScholarship?.acadmicCareer != 'DDS' &&
            (element.countryIdController.text.isNotEmpty ||
                element.otherMajorsController.text.isNotEmpty ||
                element.otherUniversityNameController.text.isNotEmpty ||
                element.statusController.text.isNotEmpty)) {
          if (element.statusController.text.isEmpty) {
            setState(() {
              element.statusError = "Please Select University Status";
              firstErrorFocusNode ??= element.statusFocusNode;
            });
          }
        }
      }
    }

    // checking for fist error node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true
      return true;
    }
  }

  bool validateRequiredExaminations(langProvider) {
    for (int i = 0; i < _requiredExaminationList.length; i++) {
      firstErrorFocusNode = null;

      var element = _requiredExaminationList[i];
      if (element.examinationController.text.isEmpty) {
        setState(() {
          element.examinationError = "Please Enter Examination Name";
          firstErrorFocusNode ??= element.examinationFocusNode;
        });
      }
      if (element.examinationTypeIdController.text.isEmpty) {
        setState(() {
          element.examinationTypeIdError = "Please Enter Examination Type";
          firstErrorFocusNode ??= element.examinationTypeIdFocusNode;
        });
      }
      if (element.examinationGradeController.text.isEmpty) {
        setState(() {
          element.examinationGradeError = "Please Enter Examination Grade";
          firstErrorFocusNode ??= element.examinationGradeFocusNode;
        });
      }
      if (element.examDateController.text.isEmpty) {
        setState(() {
          element.examDateError = "Please Enter Exam Date";
          firstErrorFocusNode ??= element.examDateFocusNode;
        });
      }
    }

    // checking for fist error node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true
      return true;
    }
  }

  bool validateEmploymentHistory(langProvider) {
    firstErrorFocusNode = null;

    // validate employment history

    // select employment status
    if (_employmentStatus == null || _employmentStatus == '') {
      _alertService.showToast(
          message: "Please select your employment status", context: context);
    }

    if (_employmentStatus != null &&
        _employmentStatus != '' &&
        _employmentStatus != 'N') {
      for (int i = 0; i < _employmentHistoryList.length; i++) {
        var element = _employmentHistoryList[i];

        // employer name
        if (element.employerNameController.text.isEmpty) {
          setState(() {
            element.employerNameError = "Please Enter Employer Name";
            firstErrorFocusNode ??= element.employerNameFocusNode;
          });
        }

        // designation
        if (element.titleController.text.isEmpty) {
          setState(() {
            element.titleError = "Please Enter Employer Name";
            firstErrorFocusNode ??= element.titleFocusNode;
          });
        }

        //work place
        if (element.placeController.text.isEmpty) {
          setState(() {
            element.placeError = "Please Enter Work Place";
            firstErrorFocusNode ??= element.placeFocusNode;
          });
        }

        //occupation
        if (element.occupationController.text.isEmpty) {
          setState(() {
            element.occupationError = "Please Enter Occupation";
            firstErrorFocusNode ??= element.occupationFocusNode;
          });
        }

        // start date
        if (element.startDateController.text.isEmpty) {
          setState(() {
            element.startDateError = "Please Enter Start Date";
            firstErrorFocusNode ??= element.startDateFocusNode;
          });
        }

        // end date
        if (_employmentStatus == 'P' &&
            element.endDateController.text.isEmpty) {
          setState(() {
            element.endDateError = "Please Enter End Date";
            firstErrorFocusNode ??= element.endDateFocusNode;
          });
        }

        // end date
        if (element.endDateController.text.isNotEmpty && (element.endDateController.text == element.startDateController.text)) {

          setState(() {
            element.endDateError = "Please correct start and End Date";
            firstErrorFocusNode ??= element.endDateFocusNode;
          });
        }

        // reporting manager
        if (element.reportingManagerController.text.isEmpty) {
          setState(() {
            element.reportingManagerError = "Please Enter Reporting Manager";
            firstErrorFocusNode ??= element.reportingManagerFocusNode;
          });
        }
        // contact number
        if (element.contactNumberController.text.isEmpty) {
          setState(() {
            element.contactNumberError = "Please Enter Reporting Manager";
            firstErrorFocusNode ??= element.contactNumberFocusNode;
          });
        }
        // email
        if (element.contactEmailController.text.isEmpty) {
          setState(() {
            element.contactEmailError = "Please Enter Reporting Manager";
            firstErrorFocusNode ??= element.contactEmailFocusNode;
          });
        }
      }
    }
    // checking for fist error node
    if (firstErrorFocusNode != null ||
        _employmentStatus == null ||
        _employmentStatus == '') {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      // No errors found, return true
      return true;
    }
  }

  bool validateAttachmentsSection(langProvider) {
    firstErrorFocusNode = null;


    print("validate Attachments section");
    for(var i = 0; i < _myAttachmentsList.length; i++) {
      var element = _myAttachmentsList[i];


      final code1 = "${element.processCDController.text}:${element.documentCDController.text}";
      bool required = false;
      for(var i = 0; i < _attachmentsList.length; i++) {
        var val = _attachmentsList[i];
        if(val.code.toString() == code1){
          required =  val.required.toString() == 'XMRL' || val.required.toString() == 'MRL' || val.required.toString() == 'NMRL';
        }
      }

      if(required &&  element.base64StringController.text.isEmpty)
      {

        print("Upload all attachments");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red,content: Text("Upload all required attachments")));
        return false;
      }
    }
    for(var ele in _myAttachmentsList){
      print(ele.toJson());
    }

    return true;
  }

  // *--------------------------------------------------------- validate section in accordance with the steps end ------------------------------------------------------------------------------*

  @override
  void dispose() {


    // Dispose controllers
    _militaryServiceController.dispose();
    _militaryServiceStartDateController.dispose();
    _militaryServiceEndDateController.dispose();
    _reasonForMilitaryController.dispose();

    // Dispose focus nodes
    _militaryServiceFocusNode.dispose();
    _militaryServiceStartDateFocusNode.dispose();
    _militaryServiceEndDateFocusNode.dispose();
    _reasonForMilitaryFocusNode.dispose();
    super.dispose();
  }

  // *----------------------------------------------------------------------------- Custom Widgets for Scholarship Form only start --------------------------------------------------------------------------------------------------***

  // text field style which is used to styling hint and actual text
  final TextStyle _textFieldTextStyle = AppTextStyles.titleTextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.scoButtonColor);

  // Buttons Section (Previous, Next, Save Draft)
  Widget draftPrevNextButtons(langProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPadding),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          runSpacing: 10,
          children: <Widget>[
            saveDraftButton(context),
            Wrap(spacing: 10, children: <Widget>[
              previousButton(),
              nextButton(langProvider),
            ]),
          ],
        ),
      ),
    );
  }

  Widget saveDraftButton(BuildContext context) {
    return Consumer<SaveAsDraftViewmodel>(
      builder: (context, provider, _) {
        final status = provider.apiResponse.status;
        return MaterialButton(
          onPressed: status == Status.LOADING ? null : saveDraft,
          color: AppColors.scoButtonColor,
          textColor: Colors.white,
          height: 30,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: status == Status.LOADING
              ? SizedBox(
                  height: 10,
                  width: 10,
                  child: Utils.cupertinoLoadingIndicator())
              : const Text(
                  'Save as Draft',
                  style: TextStyle(fontSize: 12),
                ),
        );
      },
    );
  }

  Widget previousButton() {
    return MaterialButton(
      onPressed: _currentSectionIndex > 0 ? previousSection : null,
      color: AppColors.lightBlue1,
      height: 30,
      textColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text(
        'Previous',
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget nextButton(langProvider) {
    return MaterialButton(
      color: AppColors.lightBlue2,
      height: 30,
      textColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: _currentSectionIndex == totalSections-1 ? (){

        // submit Application function
        showDialog(context: context, builder: (context){
          return Dialog(
            alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                child:  CustomInformationContainer(
                    title: "Confirmation",
                  trailing: GestureDetector(onTap:(){_navigationService.goBack();},child: const Icon(Icons.close,color: Colors.white,)),
                  expandedContent: Column(
                      children: [

                       kFormHeight,
                        Text( "Are your sure?",style: AppTextStyles.titleTextStyle(),),

                        kFormHeight,
                        Text( "You want to submit this application.",style: AppTextStyles.normalTextStyle(),),
                        kFormHeight,
                    Wrap(

                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 10,
                      spacing: 20,


                      children: [
                        // MaterialButton(child: Text("No",style: TextStyle(color: AppColors.scoThemeColor),),  onPressed: (){},color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),),
                        SizedBox(
                          width: screenWidth/4,
                          child: CustomButton(buttonName: "No", isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){_navigationService.goBack();},buttonColor: Colors.white,borderColor: AppColors.scoThemeColor,textColor: AppColors.scoThemeColor,),
                        ),
                        SizedBox(
                          width: screenWidth/4,
                          child: CustomButton(buttonName: "Yes", isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){},buttonColor: AppColors.scoThemeColor,textColor: Colors.white,borderColor: Colors.transparent,),
                        ),
                      ],
                    ),
      kFormHeight,
      kFormHeight,

    ],
  ),
),

          );


        });


      }: () {
        // run validations function
        if (validateSection(
            step: _currentSectionIndex, langProvider: langProvider)) {
          nextSection(); // Only move to the next section if validation passes
        } else {
          // Optionally show a validation error message (like a SnackBar)
          _alertService.flushBarErrorMessages(
              message: 'Please complete the required fields.',
              context: context,
              provider: langProvider);
        }
      },
      child:  Text(
        _currentSectionIndex == totalSections-1 ? "Submit": 'Next',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  // to reduce the copy of code we created this where obscure text and border is not copied again and again, and if we need to use more features then we will use CustomTextField
  dynamic _scholarshipFormTextField({
    required FocusNode currentFocusNode,
    FocusNode? nextFocusNode,
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    int? maxLines,
    int? maxLength,
    bool? filled,
    bool? readOnly,
    List<TextInputFormatter>? inputFormat,
    required Function(String? value) onChanged,
  }) {
    return CustomTextField(
      readOnly: readOnly,
      currentFocusNode: currentFocusNode,
      nextFocusNode: nextFocusNode,
      controller: controller,
      filled: filled,
      obscureText: false,
      border: Utils.outlinedInputBorder(),
      hintText: hintText,
      textStyle: _textFieldTextStyle,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormat: inputFormat,
      errorText: errorText,
      onChanged: onChanged,
      textInputType: TextInputType.multiline,
    );
  }

  dynamic _scholarshipFormDateField(
      {required FocusNode currentFocusNode,
      required TextEditingController controller,
      required String hintText,
      String? errorText,
      required Function(String? value) onChanged,
      required Function()? onTap,
      bool? filled}) {
    return CustomTextField(
      readOnly: true,
      filled: filled,
      // Prevent manual typing
      currentFocusNode: currentFocusNode,
      controller: controller,
      border: Utils.outlinedInputBorder(),
      hintText: hintText,
      textStyle: _textFieldTextStyle,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      trailing: const Icon(
        Icons.calendar_month,
        color: AppColors.scoLightThemeColor,
        size: 16,
      ),
      errorText: errorText,
      onChanged: onChanged,
      onTap: onTap,
    );
  }

  // dropdown for scholarship form
  dynamic _scholarshipFormDropdown({
    bool? readOnly,
    required TextEditingController controller,
    required FocusNode currentFocusNode,
    required dynamic menuItemsList,
    required String hintText,
    String? errorText,
    bool? filled,
    required void Function(dynamic value) onChanged,
  }) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return CustomDropdown(
      readOnly: readOnly,
      value: controller.text.isEmpty ? null : controller.text,
      currentFocusNode: currentFocusNode,
      textDirection: getTextDirection(langProvider),
      menuItemsList: menuItemsList ?? [],
      hintText: hintText,
      textColor: AppColors.scoButtonColor,
      filled: filled,
      outlinedBorder: true,
      errorText: errorText,
      onChanged: onChanged,
    );
  }

  // title style which is used to styling Actual Section Heading
  dynamic _sectionTitle({required String title}) {
    return Text(
      title,
      style: AppTextStyles.titleBoldTextStyle(),
    );
  }

  // dashed section divider is used to indicate the difference between the sections
  dynamic _sectionDivider() {
    return Column(
      children: [
        SizedBox(height: kPadding),
        const MyDivider(color: AppColors.scoButtonColor),
        SizedBox(height: kPadding),
      ],
    );
  }

  // Add Remove more section Button
  dynamic _addRemoveMoreSection(
      {required String title,
      required bool add,
      required Function() onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: onChanged,
          color: add ? AppColors.scoThemeColor : AppColors.DANGER,
          height: double.minPositive,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                add ? Icons.add_circle_outline : Icons.remove_circle_outline,
                size: 12,
                weight: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 3),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth / 2),
                // Set maximum width
                child: Text(
                  title,
                  style: AppTextStyles.subTitleTextStyle().copyWith(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  // Adds ellipsis when text overflows
                  softWrap: false,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // *----------------------------------------------------------------------------- Custom Widgets for Scholarship Form only end --------------------------------------------------------------------------------------------------***

  Map<String, dynamic> form = {};

  // the final form which we have to submit
  void _finalForm({bool isUrlEncoded = false}) async {
    form = {
      "applicationData": {
        // 'specialCase' = '',
        "sccTempId": "",
        "acadCareer": _selectedScholarship?.acadmicCareer ?? '',
        // "studentCarNumber": _selectedScholarship?.ca,
        "institution": _selectedScholarship?.institution ?? '',
        "admApplCtr": _selectedScholarship?.admApplicationCenter ?? '',
        "admitType": _selectedScholarship?.admitType ?? '',
        "admitTerm": _selectedScholarship?.admitTerm ?? '',
        "citizenship": _passportNationalityController.text ?? '',
        "acadProgram": _selectedScholarship?.acadmicProgram ?? '',
        "programStatus": _selectedScholarship?.programStatus ?? '',
        "programAction": _selectedScholarship?.programAction ?? '',
        "acadLoadAppr": _selectedScholarship?.acadLoadAppr ?? '',
        "campus": _selectedScholarship?.campus ?? '',
        // "planSequence": null,
        "acadPlan": _selectedScholarship?.acadmicPlan ?? '',
        // "username": "Test Test",
        "scholarshipType": _selectedScholarship?.scholarshipType ?? '',
        // "password": null,
        "country": _passportNationalityController.text,
        // "errorMessage": "",
        "studyCountry": isStudyCountry,
        "dateOfBirth": _dateOfBirthController.text,
        "placeOfBirth": _placeOfBirthController.text,
        "gender": _genderController.text,
        "maritalStatus": _maritalStatusController.text,
        "emailId": _studentEmailController.text,
        "passportId": _passportNumberController.text,
        "passportExpiryDate": _passportExpiryDateController.text,
        "passportIssueDate": _passportIssueDateController.text,
        "passportIssuePlace": _passportPlaceOfIssueController.text,
        "unifiedNo": _passportUnifiedNoController.text,
        "emirateId": _emiratesIdController.text,
        "emirateIdExpiryDate": _emiratesIdExpiryDateController.text,
        "uaeMother": _isMotherUAECheckbox,
        "otherNumber": "",
        "relativeStudyinScholarship": _isRelativeStudyingFromScholarship ?? false,
        // "graduationStatus": null,
        "cohortId": _selectedScholarship?.cohort ?? '',
        "scholarshipSubmissionCode": _selectedScholarship?.configurationKey ?? '',
        // "highestQualification": "UG",
        "havingSponser": havingSponsor,

        "familyNo": _familyInformationEmiratesController.text,
        "town": _familyInformationTownVillageNoController.text,
        "parentName": _familyInformationParentGuardianNameController.text,
        "relationType": _familyInformationRelationTypeController.text,
        "familyNumber": _familyInformationFamilyBookNumberController.text,
        "motherName": _familyInformationMotherNameController.text,

        "militaryService": _militaryServiceController.text,
        "militaryServiceStartDate": _militaryServiceStartDateController.text,
        "militaryServiceEndDate": _militaryServiceEndDateController.text,
        "reasonForMilitarty": _reasonForMilitaryController.text,

        "nameAsPasport": _nameAsPassport.map((element) => element.toJson()).toList(),

        "relativeDetails": _relativeInfoList.map((element) => element.toJson()).toList(),
        "phoneNunbers": _phoneNumberList.map((element) => element.toJson()).toList(),
        "addressList": _addressInformationList.map((element) => element.toJson()).toList(),
        "highSchoolList": _highSchoolList.map((element) => element.toJson()).toList(),
        "graduationList": _graduationDetailsList.map((element) => element.toJson()).toList(),
        "acadProgramDds": _acadProgramDdsController.text,
        "acadProgramPgrd": _acadProgramPgrdController.text,
        "majorWishList": _majorsWishlist.map((element) => element.toJson()).toList(),
        "universtiesPriorityList": _universityPriorityList.map((element) => element.toJson()).toList(),
        "requiredExaminationList": _requiredExaminationList.map((element) => element.toJson()).toList(),
        "employmentStatus": _employmentStatus.toString(),
        "emplymentHistory": _employmentHistoryList.map((element) => element.toJson()).toList(),
        "attachments": _myAttachmentsList.map((element) => element.toJson()).toList(),

        // Rest of the fields...
      }
    };

    log(form.toString());
  }
}
