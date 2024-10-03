import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/components/form/form_field/widgets/gf_formdropdown.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/resources/input_formatters/emirates_id_input_formatter.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/account/Custom_inforamtion_container.dart';
import '../../resources/components/custom_dropdown.dart';
import '../../resources/components/myDivider.dart';
import '../../utils/constants.dart';
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
  late AlertServices _alertService;

  // initialize the services
  void _initializeServices() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertService = getIt.get<AlertServices>();
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

  // Function to check if a section is filled
  bool isSectionFilled(int index) {
    return filledSections[index];
  }

  // Function to save draft
  void saveDraft() {
    // Save draft logic here
    // cleanXmlToJson(draftString);
    // print("Draft saved");
    _finalForm();
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
    WidgetsBinding.instance.addPostFrameCallback((callback) {
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
      _nationalityMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _genderMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['GENDER']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _maritalStatusMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['MARITAL_STATUS']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _relationshipTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['RELATIONSHIP_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _phoneNumberTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['PHONE_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _familyInformationEmiratesMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['EMIRATES_ID']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _addressTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['ADDRESS_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _highSchoolLevelMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['HIGH_SCHOOL_LEVEL']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      _highSchoolTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['HIGH_SCHOOL_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // not used for dropdown
      _highSchoolSubjectsItemsList = populateSimpleValuesFromLOV(
          menuItemsList: Constants.lovCodeMap['SUBJECT']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // for dds graduation level
      _graduationLevelDDSMenuItems = populateCommonDataDropdown(
          menuItemsList:
              Constants.lovCodeMap['DDS_GRAD_LEVEL#SIS_GRAD_LEVEL']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // for other graduation level
      _graduationLevelMenuItems = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['GRADUATION_LEVEL']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // case Study Year dropdown
      _caseStudyYearDropdownMenuItems = populateCommonDataDropdown(
          menuItemsList: Constants
              .lovCodeMap['BATCH#${_selectedScholarship?.acadmicCareer}']!
              .values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // case Study Year dropdown
      _requiredExaminationDropdownMenuItems = populateCommonDataDropdown(
          menuItemsList: Constants
              .lovCodeMap['EXAMINATION#${_selectedScholarship?.acadmicCareer}']!
              .values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // employment Status
      // not used for dropdown just list of values
      _employmentStatusItemsList = populateSimpleValuesFromLOV(
          menuItemsList: Constants.lovCodeMap['EMPLOYMENT_STATUS']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);

      // *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

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
      // TODO: "add high school Conditions";
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
          isNewController: TextEditingController(),
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
          isNewController: TextEditingController(),
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

      //
      // if (highSchoolJsonList['highSchoolList'] != null) {
      //   log(highSchoolJsonList['highSchoolList'].toString());
      //
      //   for (var highSchoolJson in highSchoolJsonList['highSchoolList']) {
      //     try {
      //       // Parse each highSchool entry
      //       HighSchool highSchool = HighSchool.fromJson(highSchoolJson);
      //       _highSchoolList.add(highSchool);
      //       _populateHighSchoolStateDropdown(langProvider: langProvider,index: index);
      //       _populateHighSchoolNameDropdown(langProvider: langProvider,index: index);
      //       _populateHighSchoolCurriculumTypeDropdown(langProvider: langProvider,index: index);
      //     } catch (e) {
      //       log("Error parsing high school entry: $e");
      //     }
      //   }
      // } else {
      //   log('highSchoolList not found in the JSON data.');
      // }

      // String cleanJson = cleanXmlToJson(draftString);

      // Map<String,dynamic> draft = jsonDecode(cleanJson);
      // log("Draft Print: ${cleanJson.toString()}");
      //
      //
      // if (draft['highSchoolList'] is List) {
      //   log(draft['highSchoolList'].toString());
      //
      //   highSchoolJsonList['highSchoolList'].asMap().forEach((index, highSchoolJson) {
      //     try {
      //       // Parse each highSchool entry
      //       HighSchool highSchool = HighSchool.fromJson(highSchoolJson);
      //       _highSchoolList.add(highSchool);
      //
      //       // Populate dropdowns for the high school
      //       _populateHighSchoolStateDropdown(langProvider: langProvider, index: index);
      //       _populateHighSchoolNameDropdown(langProvider: langProvider, index: index);
      //       _populateHighSchoolCurriculumTypeDropdown(langProvider: langProvider, index: index);
      //
      //     } catch (e) {
      //       log("Error parsing high school entry: $e - Entry: $highSchoolJson");
      //     }
      //   });
      // } else {
      //   log('highSchoolList not found or is not a list in the JSON data.');
      // }

      // add graduation detail
      _addGraduationDetail();

      // add Required Examination
      _addRequiredExamination();

      // add employment history
      _addEmploymentHistory();

      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.done, null);
    });
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
                        const SizedBox(height: 8),

                        // Progress Indicator for now but soon going to change this
                        Row(
                          children: [
                            Text(
                                'Progress: ${(_currentSectionIndex + 1)}/$totalSections'),
                            Expanded(
                              child: LinearProgressIndicator(
                                value:
                                    (_currentSectionIndex + 1) / totalSections,
                              ),
                            ),
                          ],
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
                        // check if index is zero then show accept pledge section
                        if (index == 0) {
                          filledSections[index] = _acceptStudentUndertaking;
                          return _studentUndertakingSection(step: index);
                        }
                        if (index == 1) {
                          return _studentDetailsSection(
                              step: index, langProvider: langProvider);
                        }
                        if (index == 2) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                _highSchoolDetailsSection(
                                    step: index, langProvider: langProvider),
                                _graduationDetailsSection(
                                    step: index, langProvider: langProvider)
                              ],
                            ),
                          );
                        }
                        if (index == 4) {
                          return _requiredExaminationsDetailsSection(
                              step: index, langProvider: langProvider);
                        }
                        if (index == 5) {
                          return _employmentHistoryDetailsSection(
                              step: index, langProvider: langProvider);
                        }
                      },
                    ),
                  ),

                  // Buttons Section (Previous, Next, Save Draft)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: saveDraft,
                          child: Text('Save Draft'),
                        ),
                        ElevatedButton(
                          onPressed:
                              _currentSectionIndex > 0 ? previousSection : null,
                          child: Text('Previous'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // if (validateSection(
                            //     step: _currentSectionIndex,
                            //     langProvider: langProvider)) {
                            nextSection(); // Only move to the next section if validation passes
                            // } else {
                            // Optionally show a validation error message (like a SnackBar)
                            _alertService.flushBarErrorMessages(
                                message: 'Please complete the required fields.',
                                context: context,
                                provider: langProvider);
                            // }
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  // *--------------------------------------------------------------- Accept terms and conditions start ----------------------------------------------------------------------------*

  // student undertaking check:
  bool _acceptStudentUndertaking = false;

  // step-1: student undertaking
  Widget _studentUndertakingSection({required int step}) {
    return Column(
      children: [
        // Accept Pledge

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
      ],
    );
  }

  // *--------------------------------------------------------------- Accept terms and conditions end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Name as Passport data start ----------------------------------------------------------------------------*

  // Text controllers for Arabic name fields
  final TextEditingController _arabicStudentNameController =
      TextEditingController();
  final TextEditingController _arabicFatherNameController =
      TextEditingController();
  final TextEditingController _arabicGrandFatherNameController =
      TextEditingController();
  final TextEditingController _arabicFamilyNameController =
      TextEditingController();

  // Text controllers for English name fields
  final TextEditingController _englishStudentNameController =
      TextEditingController();
  final TextEditingController _englishFatherNameController =
      TextEditingController();
  final TextEditingController _englishGrandFatherNameController =
      TextEditingController();
  final TextEditingController _englishFamilyNameController =
      TextEditingController();

  // Focus nodes for Arabic name fields
  final FocusNode _arabicStudentNameFocusNode = FocusNode();
  final FocusNode _arabicFatherNameFocusNode = FocusNode();
  final FocusNode _arabicGrandFatherNameFocusNode = FocusNode();
  final FocusNode _arabicFamilyNameFocusNode = FocusNode();

// Focus nodes for English name fields
  final FocusNode _englishStudentNameFocusNode = FocusNode();
  final FocusNode _englishFatherNameFocusNode = FocusNode();
  final FocusNode _englishGrandFatherNameFocusNode = FocusNode();
  final FocusNode _englishFamilyNameFocusNode = FocusNode();

  // Error text variables for Arabic name fields
  String? _arabicStudentNameError;
  String? _arabicFatherNameError;
  String? _arabicGrandFatherNameError;
  String? _arabicFamilyNameError;

// Error text variables for English name fields
  String? _englishStudentNameError;
  String? _englishFatherNameError;
  String? _englishGrandFatherNameError;
  String? _englishFamilyNameError;

  late Map<String, dynamic> _arabicName;
  late Map<String, dynamic> _englishName;
  late List<Map<String, dynamic>> _nameAsPassport;

  void _initializeStudentDetailsModels() {
    _arabicName = PersonName(
            nameType: 'PRI',
            studentName: _arabicStudentNameController.text,
            fatherName: _arabicFatherNameController.text,
            grandFatherName: _arabicGrandFatherNameController.text,
            familyName: _arabicFamilyNameController.text)
        .toJson();

    _englishName = PersonName(
            nameType: 'ENG',
            studentName: _englishStudentNameController.text,
            fatherName: _englishFatherNameController.text,
            grandFatherName: _englishGrandFatherNameController.text,
            familyName: _englishFamilyNameController.text)
        .toJson();

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

// Focus Nodes for Family Information
  final FocusNode _familyInformationEmiratesFocusNode = FocusNode();
  final FocusNode _familyInformationTownVillageNoFocusNode = FocusNode();
  final FocusNode _familyInformationParentGuardianNameFocusNode = FocusNode();
  final FocusNode _familyInformationRelationTypeFocusNode = FocusNode();
  final FocusNode _familyInformationFamilyBookNumberFocusNode = FocusNode();

// Error texts for validation
  String? _familyInformationEmiratesErrorText;
  String? _familyInformationTownVillageNoErrorText;
  String? _familyInformationParentGuardianNameErrorText;
  String? _familyInformationRelationTypeErrorText;
  String? _familyInformationFamilyBookNumberErrorText;

  // emirates menuItem List
  List<DropdownMenuItem> _familyInformationEmiratesMenuItemsList = [];

  // village or town menuItem List
  List<DropdownMenuItem> _familyInformationTownMenuItemsList = [];

  _populateTownOnFamilyInformationEmiratesItem(
      {required LanguageChangeViewModel langProvider}) {
    setState(() {
      _familyInformationTownMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants
              .lovCodeMap[
                  'VILLAGE_NUM#${_familyInformationEmiratesController.text}']!
              .values!,
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
            kFormHeight,
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
                        currentFocusNode: _arabicStudentNameFocusNode,
                        nextFocusNode: _arabicFatherNameFocusNode,
                        controller: _arabicStudentNameController,
                        hintText: "Enter Name",
                        errorText: _arabicStudentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicStudentNameFocusNode.hasFocus) {
                              _arabicStudentNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicStudentNameController.text,
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
                        currentFocusNode: _arabicFatherNameFocusNode,
                        nextFocusNode: _arabicGrandFatherNameFocusNode,
                        controller: _arabicFatherNameController,
                        hintText: "Enter Father's Name",
                        errorText: _arabicFatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicFatherNameFocusNode.hasFocus) {
                              _arabicFatherNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicFatherNameController.text,
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
                        currentFocusNode: _arabicGrandFatherNameFocusNode,
                        nextFocusNode: _arabicFamilyNameFocusNode,
                        controller: _arabicGrandFatherNameController,
                        hintText: "Enter Grandfather's Name",
                        errorText: _arabicGrandFatherNameError,
                        onChanged: (value) {
                          if (_arabicGrandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _arabicGrandFatherNameError =
                                  ErrorText.getArabicNameError(
                                      name:
                                          _arabicGrandFatherNameController.text,
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
                        currentFocusNode: _arabicFamilyNameFocusNode,
                        nextFocusNode: _englishStudentNameFocusNode,
                        controller: _arabicFamilyNameController,
                        hintText: "Enter Family Name",
                        errorText: _arabicFamilyNameError,
                        onChanged: (value) {
                          if (_arabicFamilyNameFocusNode.hasFocus) {
                            setState(() {
                              _arabicFamilyNameError =
                                  ErrorText.getArabicNameError(
                                      name: _arabicFamilyNameController.text,
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
                        currentFocusNode: _englishStudentNameFocusNode,
                        nextFocusNode: _englishFatherNameFocusNode,
                        controller: _englishStudentNameController,
                        hintText: "Enter Name",
                        errorText: _englishStudentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_englishStudentNameFocusNode.hasFocus) {
                              _englishStudentNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishStudentNameController.text,
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
                        currentFocusNode: _englishFatherNameFocusNode,
                        nextFocusNode: _englishGrandFatherNameFocusNode,
                        controller: _englishFatherNameController,
                        hintText: "Enter Father's Name",
                        errorText: _englishFatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_englishFatherNameFocusNode.hasFocus) {
                              _englishFatherNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishFatherNameController.text,
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
                        currentFocusNode: _englishGrandFatherNameFocusNode,
                        nextFocusNode: _englishFamilyNameFocusNode,
                        controller: _englishGrandFatherNameController,
                        hintText: "Enter Grandfather's Name",
                        errorText: _englishGrandFatherNameError,
                        onChanged: (value) {
                          if (_englishGrandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _englishGrandFatherNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishGrandFatherNameController
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
                        currentFocusNode: _englishFamilyNameFocusNode,
                        nextFocusNode: _passportNationalityFocusNode,
                        controller: _englishFamilyNameController,
                        hintText: "Enter Family Name",
                        errorText: _englishFamilyNameError,
                        onChanged: (value) {
                          if (_englishFamilyNameFocusNode.hasFocus) {
                            setState(() {
                              _englishFamilyNameError =
                                  ErrorText.getEnglishNameError(
                                      name: _englishFamilyNameController.text,
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
                                DateFormat('dd/MM/yyyy').format(dob).toString();
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
                                DateFormat('dd/MM/yyyy').format(dob).toString();
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
                                DateFormat('dd/MM/yyyy').format(dob).toString();
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
                                DateFormat('dd/MM/yyyy').format(dob).toString();
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
                                      important: true,
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
                                          setState(() {
                                            _familyInformationFamilyBookNumberErrorText =
                                                ErrorText.getEmptyFieldError(
                                                    name:
                                                        _familyInformationFamilyBookNumberController
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
                                          nextFocusNode: relativeInformation
                                              .familyBookNumberFocusNode,
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
                                      kFormHeight,
                                      fieldHeading(
                                          title: "Family Book Number",
                                          important: true,
                                          langProvider: langProvider),
                                      _scholarshipFormTextField(
                                          currentFocusNode: relativeInformation
                                              .familyBookNumberFocusNode,
                                          nextFocusNode: index <
                                                  _relativeInfoList.length - 1
                                              ? _relativeInfoList[index + 1]
                                                  .relativeNameFocusNode
                                              : null,
                                          controller: relativeInformation
                                              .familyBookNumberController,
                                          errorText: relativeInformation
                                              .familyBookNumberError,
                                          hintText: "Enter Family Book Number",
                                          onChanged: (value) {
                                            if (relativeInformation
                                                .familyBookNumberFocusNode
                                                .hasFocus) {
                                              setState(() {
                                                relativeInformation
                                                        .familyBookNumberError =
                                                    ErrorText.getEnglishArabicNumberError(
                                                        input: _relativeInfoList[
                                                                index]
                                                            .familyBookNumberController
                                                            .text,
                                                        context: context);
                                              });
                                            }
                                          }),

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
            kFormHeight,
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
                      important:
                          addressInformation.stateDropdownMenuItems!.isNotEmpty,
                      langProvider: langProvider),
                  _scholarshipFormDropdown(
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
                        DateFormat('dd/MM/yyyy').format(date).toString();
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
                        DateFormat('dd/MM/yyyy').format(date).toString();
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
          isNewController: TextEditingController(),
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

          // if selected scholarship matches the condition then high school details section else don't
          (_selectedScholarship?.acadmicCareer == 'UG' ||
                  _selectedScholarship?.acadmicCareer == 'UGRD' ||
                  _selectedScholarship?.acadmicCareer == 'SCHL' ||
                  _selectedScholarship?.acadmicCareer == 'HCHL')
              ? CustomInformationContainer(
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
                                        title:
                                            "High School Detail ${index + 1}"),

                                    kFormHeight,
                                    // title
                                    fieldHeading(
                                        title: "High School Level",
                                        important: true,
                                        langProvider: langProvider),

                                    // dropdowns on the basis of selected one
                                    ((_selectedScholarship?.admitType ==
                                                        'MOS' ||
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
                                              controller: highSchoolInfo
                                                  .hsLevelController,
                                              currentFocusNode: highSchoolInfo
                                                  .hsLevelFocusNode,
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
                                                  // setting the value for address type
                                                  highSchoolInfo
                                                      .hsLevelController
                                                      .text = value!;

                                                  // populating the state dropdown

                                                  _populateStateDropdown(
                                                      langProvider:
                                                          langProvider,
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
                                                currentFocusNode: highSchoolInfo
                                                    .hsLevelFocusNode,
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
                                                        _highSchoolList
                                                            .any((info) {
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
                                                      highSchoolInfo
                                                              .hsLevelError =
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
                                        setState(() {
                                          // setting the value for address type
                                          highSchoolInfo.hsCountryController
                                              .text = value!;

                                          highSchoolInfo.hsStateController
                                              .clear();
                                          highSchoolInfo.hsNameController
                                              .clear();
                                          highSchoolInfo
                                              .schoolStateDropdownMenuItems
                                              ?.clear();
                                          highSchoolInfo
                                              .schoolNameDropdownMenuItems
                                              ?.clear();
                                          // populating the high school state dropdown
                                          _populateHighSchoolStateDropdown(
                                              langProvider: langProvider,
                                              index: index);

                                          //This thing is creating error: don't know how to fix it:
                                          Utils.requestFocus(
                                              focusNode: highSchoolInfo
                                                  .hsStateFocusNode,
                                              context: context);
                                        });
                                      },
                                    ),

                                    kFormHeight,
                                    // ****************************************************************************************************************************************************

                                    // state
                                    fieldHeading(
                                        title: "State",
                                        important: true,
                                        // important: highSchoolInfo
                                        //     .schoolStateDropdownMenuItems!.isNotEmpty,
                                        langProvider: langProvider),

                                    _scholarshipFormDropdown(
                                      controller:
                                          highSchoolInfo.hsStateController,
                                      currentFocusNode:
                                          highSchoolInfo.hsStateFocusNode,
                                      menuItemsList: highSchoolInfo
                                              .schoolStateDropdownMenuItems ??
                                          [],
                                      hintText: "Select State",
                                      errorText: highSchoolInfo.hsStateError,
                                      onChanged: (value) {
                                        highSchoolInfo.hsStateError = null;
                                        setState(() {
                                          // setting the value for address type
                                          highSchoolInfo
                                              .hsStateController.text = value!;

                                          highSchoolInfo.hsNameController
                                              .clear();
                                          highSchoolInfo
                                              .schoolNameDropdownMenuItems
                                              ?.clear();

                                          // populating the high school state dropdown
                                          _populateHighSchoolNameDropdown(
                                              langProvider: langProvider,
                                              index: index);

                                          //This thing is creating error: don't know how to fix it:
                                          Utils.requestFocus(
                                              focusNode: highSchoolInfo
                                                  .hsNameFocusNode,
                                              context: context);
                                        });
                                      },
                                    ),

                                    kFormHeight,
                                    // ****************************************************************************************************************************************************

                                    if (highSchoolInfo
                                            .hsCountryController.text ==
                                        'ARE')
                                      Column(
                                        children: [
// school name from dropdown
                                          fieldHeading(
                                              title: "School Name",
                                              important: true,
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
                                            errorText:
                                                highSchoolInfo.hsNameError,
                                            onChanged: (value) {
                                              highSchoolInfo.hsNameError = null;
                                              setState(() {
                                                // setting the value for address type
                                                highSchoolInfo.hsNameController
                                                    .text = value!;

                                                // highSchoolInfo.hsNameController.clear();
                                                // highSchoolInfo.schoolNameDropdownMenuItems?.clear();
                                                //
                                                // // populating the high school state dropdown
                                                // _populateHighSchoolNameDropdown(langProvider: langProvider, index: index);

                                                //This thing is creating error: don't know how to fix it:
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
                                    if (highSchoolInfo
                                                .hsCountryController.text !=
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
                                                          .hsCountryController
                                                          .text ==
                                                      'ARE'
                                                  ? highSchoolInfo
                                                      .otherHsNameFocusNode
                                                  : highSchoolInfo
                                                      .hsNameFocusNode,
                                              nextFocusNode: highSchoolInfo
                                                  .hsTypeFocusNode,
                                              controller: highSchoolInfo
                                                          .hsCountryController
                                                          .text ==
                                                      'ARE'
                                                  ? highSchoolInfo
                                                      .otherHsNameController
                                                  : highSchoolInfo
                                                      .hsNameController,
                                              hintText: highSchoolInfo
                                                          .hsCountryController
                                                          .text ==
                                                      'ARE'
                                                  ? "Enter Other School Name"
                                                  : "Enter School Name",
                                              errorText: highSchoolInfo
                                                          .hsCountryController
                                                          .text ==
                                                      'ARE'
                                                  ? highSchoolInfo
                                                      .otherHsNameError
                                                  : highSchoolInfo.hsNameError,
                                              onChanged: (value) {
                                                // live error display for  high school name
                                                if (highSchoolInfo
                                                    .hsNameFocusNode.hasFocus) {
                                                  setState(() {
                                                    highSchoolInfo.hsNameError =
                                                        ErrorText.getNameArabicEnglishValidationError(
                                                            name: highSchoolInfo
                                                                .hsNameController
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
                                                        ErrorText.getNameArabicEnglishValidationError(
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
                                      controller:
                                          highSchoolInfo.hsTypeController,
                                      currentFocusNode:
                                          highSchoolInfo.hsTypeFocusNode,
                                      menuItemsList:
                                          _highSchoolTypeMenuItemsList ?? [],
                                      hintText: "Select School Type",
                                      errorText: highSchoolInfo.hsTypeError,
                                      onChanged: (value) {
                                        highSchoolInfo.hsTypeError = null;
                                        setState(() {
                                          // setting the value for high school type
                                          highSchoolInfo.hsTypeController.text =
                                              value!;

                                          highSchoolInfo
                                              .curriculumTypeController
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
                                      controller: highSchoolInfo
                                          .curriculumTypeController,
                                      currentFocusNode: highSchoolInfo
                                          .curriculumTypeFocusNode,
                                      menuItemsList: highSchoolInfo
                                              .schoolCurriculumTypeDropdownMenuItems ??
                                          [],
                                      hintText: "Select Curriculum Type",
                                      errorText:
                                          highSchoolInfo.curriculumTypeError,
                                      onChanged: (value) {
                                        highSchoolInfo.curriculumTypeError =
                                            null;
                                        setState(() {
                                          // setting the value for high school type
                                          highSchoolInfo
                                              .curriculumTypeController
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
                                        nextFocusNode: highSchoolInfo
                                            .yearOfPassingFocusNode,
                                        controller: highSchoolInfo
                                            .curriculumAverageController,
                                        hintText: "Enter Curriculum Average",
                                        maxLength: highSchoolInfo
                                                    .curriculumTypeController
                                                    .text !=
                                                'BRT'
                                            ? 4
                                            : 6,
                                        errorText: highSchoolInfo
                                            .curriculumAverageError,
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
                                        important: true,
                                        langProvider: langProvider),
                                    _scholarshipFormDateField(
                                      // Prevent manual typing
                                      currentFocusNode:
                                          highSchoolInfo.yearOfPassingFocusNode,
                                      controller: highSchoolInfo
                                          .yearOfPassingController,
                                      hintText: "Select Year of Passing",
                                      errorText:
                                          highSchoolInfo.yearOfPassingError,
                                      // Display error text if any
                                      onChanged: (value) {
                                        setState(() {
                                          if (highSchoolInfo
                                              .yearOfPassingFocusNode
                                              .hasFocus) {
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
                                        highSchoolInfo.yearOfPassingError =
                                            null;

                                        // Define the initial date as today's date (for year selection)
                                        final DateTime initialDate =
                                            DateTime.now();

                                        // Use a specific max date if required (like schoolPassingDate from your controller)
                                        // If no schoolPassingDate is available, use the current date as a fallback

                                        // Todo: No Max date is given
                                        final DateTime maxDate = DateTime.now();

                                        // Define the valid date range for "Year of Passing"
                                        final DateTime firstDate =
                                            maxDate.subtract(const Duration(
                                                days:
                                                    20 * 365)); // Last 20 years
                                        final DateTime lastDate = maxDate.add(
                                            const Duration(
                                                days:
                                                    365)); // Limit up to the maxDate (e.g., current year or schoolPassingDate)

                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          barrierColor: AppColors.scoButtonColor
                                              .withOpacity(0.1),
                                          barrierDismissible: false,
                                          locale: Provider.of<
                                                      LanguageChangeViewModel>(
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
                                                    .yearOfPassingController
                                                    .text =
                                                DateFormat("dd/MM/yyyy")
                                                    .format(date)
                                                    .toString();

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
                                        color: AppColors.lightBlue1
                                            .withOpacity(0.4),
                                        child: Row(children: [
                                          _sectionTitle(
                                              title: "Year of Graduation"),
                                          kFormHeight,
                                          const Expanded(
                                              child: Text("2016-2025"))
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          highSchoolInfo.hsDetails.length,
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
                                              controller:
                                                  element.gradeController,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          highSchoolInfo.otherHSDetails.length,
                                      itemBuilder: (context, index) {
                                        var element = highSchoolInfo
                                            .otherHSDetails[index];
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
                                              nextFocusNode:
                                                  element.gradeFocusNode,
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
                                                                context:
                                                                    context);
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
                                              controller:
                                                  element.gradeController,
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
                                                _selectedScholarship
                                                        ?.admitType ==
                                                    'MOP') ||
                                            (_selectedScholarship
                                                        ?.acadmicCareer ==
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
              : showVoid
        ])));
  }

  // *--------------------------------------------------------------- High School Section end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Graduation Details Section start ----------------------------------------------------------------------------*

  List<GraduationInfo> _graduationDetailsList = [];

  List<DropdownMenuItem> _graduationLevelMenuItems = [];
  List<DropdownMenuItem> _graduationLevelDDSMenuItems = [];
  List<DropdownMenuItem> _caseStudyYearDropdownMenuItems = [];

  // sponsorship question for dds
  bool? _sponsorshipQuestion = null;

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
  }

  Widget _graduationDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          kFormHeight,

          // if selected scholarship matches the condition then high school details section else don't
          (_selectedScholarship?.acadmicCareer != 'SCHL' &&
                  _selectedScholarship?.acadmicCareer != 'HCHL'
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

                                    kFormHeight,
                                    // title
                                    fieldHeading(
                                        title: "Currently Studying",
                                        important: true,
                                        langProvider: langProvider),

                                    // radiobuttons for yes or no

                                    // ****************************************************************************************************************************************************

                                    // Yes or no : Show round radio
                                    CustomRadioListTile(
                                      value: true,
                                      groupValue:
                                          graduationInfo.showCurrentlyStudying,
                                      onChanged: (value) {
                                        setState(() {
                                          graduationInfo.showCurrentlyStudying =
                                              value;

                                          // populate LAST term
                                          _populateGraduationLastTermMenuItemsList(
                                              langProvider: langProvider,
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
                                            .showCurrentlyStudying,
                                        onChanged: (value) {
                                          setState(() {
                                            graduationInfo
                                                .showCurrentlyStudying = value;
                                            // clear the relatives list
                                            // _relativeInfoList.clear();
                                          });
                                        },
                                        title: "No",
                                        textStyle: _textFieldTextStyle),
                                    // ****************************************************************************************************************************************************

                                    kFormHeight,

                                    // last term
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
                                        ? (graduationInfo.showCurrentlyStudying
                                            ?

                                            // copy paste full below code
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
              : showVoid),
        ])));
  }

  // graduation detail information
  Widget _graduationInformation(
      {required int index,
      required LanguageChangeViewModel langProvider,
      required GraduationInfo graduationInfo}) {
    return Column(
      children: [
        kFormHeight,
        // ****************************************************************************************************************************************************
        // graduation level
        (index > 0 &&
                _selectedScholarship?.acadmicCareer != 'UGRD' &&
                _selectedScholarship?.acadmicCareer != 'DDS')
            ? Column(
                children: [
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
              if (graduationInfo.graduationStartDateFocusNode.hasFocus) {
                setState(() {
                  graduationInfo.cgpaError = ErrorText.getCGPAValidationError(
                      cgpa: graduationInfo.majorController.text,
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
                    DateFormat('dd/MM/yyyy').format(date).toString();
              });
            }
          },
        ),

        // ****************************************************************************************************************************************************

        // start date
        kFormHeight,
        fieldHeading(
            title: "End Date",
            important: !graduationInfo.showCurrentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty,
            langProvider: langProvider),
        _scholarshipFormDateField(
          filled: !(!graduationInfo.showCurrentlyStudying &&
              graduationInfo.levelController.text.isNotEmpty),
          currentFocusNode: graduationInfo.graduationEndDateFocusNode,
          controller: graduationInfo.graduationEndDateController,
          hintText: "Select End Date",
          errorText: graduationInfo.graduationEndDateError,
          onChanged: (value) async {
            setState(() {
              if (graduationInfo.graduationEndDateFocusNode.hasFocus) {
                graduationInfo.graduationStartDateError =
                    ErrorText.getEmptyFieldError(
                        name: graduationInfo.graduationStartDateController.text,
                        context: context);
              }
            });
          },
          onTap: () async {
            if (!graduationInfo.showCurrentlyStudying &&
                graduationInfo.levelController.text.isNotEmpty) {
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
                      DateFormat('dd/MM/yyyy').format(date).toString();
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
                    value: true,
                    groupValue: _sponsorshipQuestion,
                    onChanged: (value) {
                      setState(() {
                        _sponsorshipQuestion = value;
                      });
                    },
                    title: "Yes",
                    textStyle: _textFieldTextStyle,
                  ),

                  // ****************************************************************************************************************************************************
                  CustomRadioListTile(
                      value: false,
                      groupValue: _sponsorshipQuestion,
                      onChanged: (value) {
                        setState(() {
                          _sponsorshipQuestion = value;
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
        ((_sponsorshipQuestion != null && _sponsorshipQuestion!) ||
                _selectedScholarship?.acadmicCareer != 'DDS')
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

  // *--------------------------------------------------------------- Required Examinations start ----------------------------------------------------------------------------*

  List<RequiredExaminations> _requiredExaminationList = [];

  List<DropdownMenuItem>? _requiredExaminationDropdownMenuItems = [];

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

  _addRequiredExamination() {
    setState(() {
      _requiredExaminationList.add(RequiredExaminations(
        examinationController: TextEditingController(),
        examinationTypeIdController: TextEditingController(),
        examinationGradeController: TextEditingController(),
        minScoreController: TextEditingController(),
        maxScoreController: TextEditingController(),
        examDateController: TextEditingController(),
        isNewController: TextEditingController(),
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

  Widget _requiredExaminationsDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
            child: Column(children: [
          kFormHeight,

          // if selected scholarship matches the condition then high school details section else don't
          !(_selectedScholarship?.acadmicCareer == 'SCHL' ||
                  _selectedScholarship?.acadmicCareer == 'HCHL')
              ? CustomInformationContainer(
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
                                      controller: requiredExamInfo
                                          .examinationController,
                                      currentFocusNode:
                                          requiredExamInfo.examinationFocusNode,
                                      menuItemsList:
                                          _requiredExaminationDropdownMenuItems ??
                                              [],
                                      hintText: "Select Examination",
                                      errorText:
                                          requiredExamInfo.examinationError,
                                      onChanged: (value) {
                                        requiredExamInfo.examinationError =
                                            null;

                                        setState(() {
                                          // checking for existing selected
                                          bool alreadySelected =
                                              _requiredExaminationList
                                                  .any((info) {
                                            return info != requiredExamInfo &&
                                                info.examinationController
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
                                            requiredExamInfo.examinationError =
                                                "Please choose another";
                                          } else {
                                            // Assign the value only if it's not already selected
                                            requiredExamInfo
                                                .examinationController
                                                .text = value!;

                                            // clearing dependent dropdowns values
                                            requiredExamInfo
                                                .examinationTypeIdController
                                                .clear();
                                            requiredExamInfo
                                                .examinationTypeDropdown
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
                                      errorText: requiredExamInfo
                                          .examinationTypeIdError,
                                      onChanged: (value) {
                                        requiredExamInfo
                                            .examinationTypeIdError = null;

                                        setState(() {
                                          // Assign the value only if it's not already selected
                                          requiredExamInfo
                                              .examinationTypeIdController
                                              .text = value!;

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
                                        title: _selectedScholarship
                                                    ?.acadmicCareer !=
                                                'DDS'
                                            ? 'examination.grade'
                                            : 'examination.dds.grade',
                                        important: true,
                                        langProvider: langProvider),
                                    _scholarshipFormTextField(
                                        currentFocusNode: requiredExamInfo
                                            .examinationGradeFocusNode,
                                        nextFocusNode:
                                            requiredExamInfo.examDateFocusNode,
                                        controller: requiredExamInfo
                                            .examinationGradeController,
                                        hintText: _selectedScholarship
                                                    ?.acadmicCareer !=
                                                'DDS'
                                            ? 'Enter examination.grade'
                                            : 'Enter examination.dds.grade',
                                        errorText: requiredExamInfo
                                            .examinationGradeError,
                                        onChanged: (value) {
                                          if (requiredExamInfo
                                              .examinationGradeFocusNode
                                              .hasFocus) {
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
                                        final DateTime initialDate =
                                            DateTime.now();

                                        // Use a specific max date if required (like schoolPassingDate from your controller)
                                        // If no schoolPassingDate is available, use the current date as a fallback
                                        final DateTime maxDate = DateTime.now();

                                        // Define the valid date range for "Year of Passing"
                                        final DateTime firstDate =
                                            maxDate.subtract(const Duration(
                                                days:
                                                    20 * 365)); // Last 20 years
                                        final DateTime lastDate = maxDate.add(
                                            const Duration(
                                                days: 20 *
                                                    365)); // Limit up to the maxDate (e.g., current year or schoolPassingDate)

                                        DateTime? date = await showDatePicker(
                                          context: context,
                                          barrierColor: AppColors.scoButtonColor
                                              .withOpacity(0.1),
                                          barrierDismissible: false,
                                          locale: Provider.of<
                                                      LanguageChangeViewModel>(
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
                                                DateFormat("dd/MM/yyyy")
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
                                                _deleteRequiredExamination(
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
                      ]))
              : showVoid
        ])));
  }

  // *--------------------------------------------------------------- Required Examinations end ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Employment history section start ----------------------------------------------------------------------------*

  // *--------------------------------------------------------------- Employment history section start ----------------------------------------------------------------------------*

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
          kFormHeight,
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
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _employmentHistoryList.length,
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
                                            currentFocusNode: employmentHistInfo.employerNameFocusNode,
                                            nextFocusNode: employmentHistInfo.designationFocusNode,
                                            controller: employmentHistInfo
                                                .employerNameController,
                                            hintText: 'Enter Employer Name',
                                            errorText: employmentHistInfo.employerNameError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .contactNumberFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                      .employerNameError =
                                                      ErrorText.getNameArabicEnglishValidationError(
                                                          name: employmentHistInfo
                                                              .employerNameController
                                                              .text,
                                                          context: context);
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
                                            currentFocusNode: employmentHistInfo.designationFocusNode,
                                            nextFocusNode: employmentHistInfo.occupationFocusNode,
                                            controller: employmentHistInfo
                                                .designationController,
                                            hintText: 'Enter Designation',
                                            errorText: employmentHistInfo.designationError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .designationFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                      .designationError =
                                                      ErrorText.getNameArabicEnglishValidationError(
                                                          name: employmentHistInfo
                                                              .designationController
                                                              .text,
                                                          context: context);
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
                                            currentFocusNode: employmentHistInfo
                                                .occupationFocusNode,
                                            nextFocusNode: employmentHistInfo
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
                                                          context: context);
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
                                            currentFocusNode: employmentHistInfo
                                                .placeFocusNode,
                                            nextFocusNode: employmentHistInfo
                                                .startDateFocusNode,
                                            controller: employmentHistInfo
                                                .placeController,
                                            hintText: 'Enter Work Place',
                                            errorText:
                                                employmentHistInfo.placeError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .placeFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                          .placeError =
                                                      ErrorText.getEmptyFieldError(
                                                          name: employmentHistInfo
                                                              .placeController
                                                              .text,
                                                          context: context);
                                                });
                                              }
                                            }),

                                        // ****************************************************************************************************************************************************

                                        kFormHeight,
                                        // start date
                                        fieldHeading(
                                            title: 'Employment Start Date',
                                            important: true,
                                            langProvider: langProvider),
                                        _scholarshipFormDateField(
                                          currentFocusNode: employmentHistInfo
                                              .startDateFocusNode,
                                          controller: employmentHistInfo
                                              .startDateController,
                                          hintText: "Select Employment Start Date",
                                          errorText:
                                              employmentHistInfo.startDateError,
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
                                                      .startDateController.text,
                                                  context: context,
                                                );
                                              }
                                            });
                                          },
                                          onTap: () async {
                                            // Clear the error message when a date is selected
                                            employmentHistInfo.startDateError =
                                                null;

                                            // Define the initial date as today's date (for year selection)
                                            final DateTime initialDate =
                                                DateTime.now();
                                            final DateTime maxDate =
                                                DateTime.now();

                                            final DateTime firstDate =
                                                maxDate.subtract(const Duration(
                                                    days: 10 *
                                                        365));
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
                                              lastDate: initialDate, // Limit up to the maxDate or current year
                                            );

                                            if (date != null) {
                                              setState(() {
                                                employmentHistInfo
                                                        .startDateController
                                                        .text =
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(date)
                                                        .toString();

                                                Utils.requestFocus(
                                                    focusNode: employmentHistInfo.endDateFocusNode,
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
                                            important: _employmentStatus == 'P',
                                            langProvider: langProvider),
                                        _scholarshipFormDateField(
                                          currentFocusNode: employmentHistInfo.endDateFocusNode,
                                          controller: employmentHistInfo.endDateController,
                                          hintText: "Select Employment End Date",
                                          errorText:
                                          employmentHistInfo.endDateError,
                                          onChanged: (value) {
                                            setState(() {
                                              if (employmentHistInfo.endDateFocusNode.hasFocus) {
                                                employmentHistInfo.endDateError =
                                                    ErrorText.getEmptyFieldError(
                                                      name: employmentHistInfo
                                                          .endDateController.text,
                                                      context: context,
                                                    );
                                              }
                                            });
                                          },
                                          onTap: () async {
                                            // Clear the error message when a date is selected
                                            employmentHistInfo.endDateError =
                                            null;

                                            // Define the initial date as today's date (for year selection)
                                            final DateTime initialDate =
                                            DateTime.now();
                                            final DateTime maxDate =
                                            DateTime.now();

                                            final DateTime firstDate =
                                            maxDate.subtract(const Duration(
                                                days: 10 *
                                                    365));
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
                                              lastDate: initialDate, // Limit up to the maxDate or current year
                                            );

                                            if (date != null) {
                                              setState(() {
                                                employmentHistInfo
                                                    .endDateController
                                                    .text =
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(date)
                                                        .toString();

                                                Utils.requestFocus(
                                                    focusNode: employmentHistInfo.reportingManagerFocusNode,
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
                                            currentFocusNode: employmentHistInfo
                                                .reportingManagerFocusNode,
                                            nextFocusNode: employmentHistInfo
                                                .contactNumberFocusNode,
                                            controller: employmentHistInfo
                                                .reportingManagerController,
                                            hintText: 'Enter Reporting Manager',
                                            errorText:
                                            employmentHistInfo.reportingManagerError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .reportingManagerFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                      .reportingManagerError =
                                                      ErrorText.getNameArabicEnglishValidationError(
                                                          name: employmentHistInfo
                                                              .reportingManagerController
                                                              .text,
                                                          context: context);
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
                                            currentFocusNode: employmentHistInfo.contactNumberFocusNode,
                                            nextFocusNode: employmentHistInfo.contactEmailFocusNode,
                                            controller: employmentHistInfo
                                                .contactNumberController,
                                            hintText: 'Enter Contact Number',
                                            errorText: employmentHistInfo.contactNumberError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .contactNumberFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                      .contactNumberError =
                                                      ErrorText.getPhoneNumberError(
                                                          phoneNumber: employmentHistInfo
                                                              .contactNumberController
                                                              .text,
                                                          context: context);
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
                                            currentFocusNode: employmentHistInfo.contactEmailFocusNode,
                                            controller: employmentHistInfo.contactEmailController,
                                            nextFocusNode: index < _employmentHistoryList.length -1 ? _employmentHistoryList[index+1].employerNameFocusNode : null,
                                            hintText: 'Enter Manager Email',
                                            errorText: employmentHistInfo.contactEmailError,
                                            onChanged: (value) {
                                              if (employmentHistInfo
                                                  .contactEmailFocusNode.hasFocus) {
                                                setState(() {
                                                  employmentHistInfo
                                                      .contactEmailError =
                                                      ErrorText.getEmailError(
                                                          email: employmentHistInfo
                                                              .contactEmailController
                                                              .text,
                                                          context: context);
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
                                  })
                              : showVoid,
                          // ****************************************************************************************************************************************************
                          _addRemoveMoreSection(
                              title: "Add",
                              add: true,
                              onChanged: () {
                                setState(() {
                                  _addEmploymentHistory();
                                });
                              })
                          // ****************************************************************************************************************************************************
                          ,
                        ])
                  ]))
        ])));
  }

  // *--------------------------------------------------------- validate section in accordance with the steps start ------------------------------------------------------------------------------*

  // if section is already fulfilling the requirements then move forward to next step:
  bool validateSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    // To request focus where field needs to adjust:
    FocusNode? firstErrorFocusNode;

    // Step 0: Validate "Accept Student Undertaking" section
    if (step == 0) {
      if (!_acceptStudentUndertaking) {
        _alertService.flushBarErrorMessages(
            message: 'Please accept the scholarship terms and conditions.',
            context: context,
            provider: langProvider);
        return false;
      }
      return true;
    }

    // Step 1: Validate "Student Details" section
    if (step == 1) {
      // Validate Arabic Name fields
      if (_arabicStudentNameController.text.isEmpty ||
          !Validations.isArabicNameValid(_arabicStudentNameController.text)) {
        setState(() {
          _arabicStudentNameError = 'Please enter the student name in Arabic.';
          firstErrorFocusNode ??=
              _arabicStudentNameFocusNode; // Set firstErrorFocusNode if it's null
        });
      }

      if (_arabicFatherNameController.text.isEmpty ||
          !Validations.isArabicNameValid(_arabicFatherNameController.text)) {
        setState(() {
          _arabicFatherNameError = 'Please enter the father\'s name in Arabic.';
          firstErrorFocusNode ??=
              _arabicFatherNameFocusNode; // Set firstErrorFocusNode if it's null
        });
      }

      if (_arabicGrandFatherNameController.text.isEmpty ||
          !Validations.isArabicNameValid(
              _arabicGrandFatherNameController.text)) {
        setState(() {
          _arabicGrandFatherNameError =
              'Please enter the grandfather\'s name in Arabic.';
          firstErrorFocusNode ??= _arabicGrandFatherNameFocusNode;
        });
      }

      if (_arabicFamilyNameController.text.isEmpty ||
          !Validations.isArabicNameValid(_arabicFamilyNameController.text)) {
        setState(() {
          _arabicFamilyNameError = 'Please enter the family name in Arabic.';
          firstErrorFocusNode ??= _arabicFamilyNameFocusNode;
        });
      }

      // Validate English Name fields
      if (_englishStudentNameController.text.isEmpty ||
          !Validations.isEnglishNameValid(_englishStudentNameController.text)) {
        setState(() {
          _englishStudentNameError =
              'Please enter the student name in English.';
          firstErrorFocusNode ??= _englishStudentNameFocusNode;
        });
      }

      if (_englishFatherNameController.text.isEmpty ||
          !Validations.isEnglishNameValid(_englishFatherNameController.text)) {
        setState(() {
          _englishFatherNameError =
              'Please enter the father\'s name in English.';
          firstErrorFocusNode ??= _englishFatherNameFocusNode;
        });
      }

      if (_englishGrandFatherNameController.text.isEmpty ||
          !Validations.isEnglishNameValid(
              _englishGrandFatherNameController.text)) {
        setState(() {
          _englishGrandFatherNameError =
              'Please enter the grandfather\'s name in English.';
          firstErrorFocusNode ??= _englishGrandFatherNameFocusNode;
        });
      }

      if (_englishFamilyNameController.text.isEmpty ||
          !Validations.isEnglishNameValid(_englishFamilyNameController.text)) {
        setState(() {
          _englishFamilyNameError = 'Please enter the family name in English.';
          firstErrorFocusNode ??= _englishFamilyNameFocusNode;
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
            firstErrorFocusNode ??=
                _familyInformationParentGuardianNameFocusNode;
          });
        }

        if (_familyInformationRelationTypeController.text.isEmpty) {
          setState(() {
            _familyInformationRelationTypeErrorText =
                'Please Select Relation Type';
            firstErrorFocusNode ??= _familyInformationRelationTypeFocusNode;
          });
        }

        if (_familyInformationFamilyBookNumberController.text.isEmpty) {
          setState(() {
            _familyInformationFamilyBookNumberErrorText =
                'Please Enter Family Book Number';
            firstErrorFocusNode ??= _familyInformationFamilyBookNumberFocusNode;
          });
        }
      }

      // validate the Relative information
      if (_isRelativeStudyingFromScholarship == null) {
        setState(() {
          firstErrorFocusNode ??=
              _isRelativeStudyingFromScholarshipYesFocusNode;
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

          if (element.familyBookNumberController.text.isEmpty) {
            setState(() {
              element.familyBookNumberError =
                  "Please Enter your family book number";
              firstErrorFocusNode ??= element.familyBookNumberFocusNode;
            });
          }
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

          if (element.phoneNumberController.text.isEmpty) {
            setState(() {
              element.phoneNumberError = "Please Enter your phone number";
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

          if (element.stateDropdownMenuItems!.isNotEmpty &&
              element.stateController.text.isEmpty) {
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

            break;

          case MilitaryStatus.no:
            break;

          case (MilitaryStatus.exemption || MilitaryStatus.postponed):
            setState(() {
              _reasonForMilitaryErrorText = 'Please Enter Reason';
              firstErrorFocusNode ??= _reasonForMilitaryFocusNode;
            });
            break;
        }
      }

      // If any error found, move to the first error focus node
      if (firstErrorFocusNode != null) {
        FocusScope.of(context).requestFocus(firstErrorFocusNode);
        return false;
      } else {
        // No errors found, return true

        // initialize the models also
        _initializeStudentDetailsModels();
        _finalForm(isUrlEncoded: true);

        return true;
      }
    }

    // Step 2: Validate High School
    if (step == 2) {
      // If any error found, move to the first error focus node
      if (firstErrorFocusNode != null) {
        FocusScope.of(context).requestFocus(firstErrorFocusNode);
        return false;
      } else {
        // No errors found, return true

        // initialize the models also
        _initializeStudentDetailsModels();
        _finalForm(isUrlEncoded: true);

        return true;
      }
    }

    // Default to true for other sections
    return true;
  }

  // *--------------------------------------------------------- validate section in accordance with the steps end ------------------------------------------------------------------------------*

  @override
  void dispose() {
    // Dispose of controllers
    _arabicStudentNameController.dispose();
    _arabicFatherNameController.dispose();
    _arabicGrandFatherNameController.dispose();
    _arabicFamilyNameController.dispose();
    _englishStudentNameController.dispose();
    _englishFatherNameController.dispose();
    _englishGrandFatherNameController.dispose();
    _englishFamilyNameController.dispose();

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

  dynamic _scholarshipFormDateField({
    required FocusNode currentFocusNode,
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    required Function(String? value) onChanged,
    required Function()? onTap,
    bool? filled
  }) {
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

  String cleanXmlToJson(String xmlString) {
    // Parse the XML string
    final document = XmlDocument.parse(xmlString);

    // Create a map to hold the cleaned data
    Map<String, dynamic> cleanedData = {};

    // Helper function to extract values from the XML and clean keys
    dynamic extractData(XmlElement element) {
      Map<String, dynamic> data = {};

      for (var child in element.children) {
        if (child is XmlElement) {
          // print(child.toString());
          String key = child.name.local;
          // print(key.toString());

          // Remove unwanted prefixes
          // key = key.replaceAll(RegExp(r'(com\.mopa\.sco\.application\.|com\.mopa\.sco\.bean\.)'), '');

          // Recursively extract child data
          var childData = extractData(child);
          print(childData.toString());

          // Check if this child has multiple values (is a list)
          if (data.containsKey(key)) {
            if (data[key] is! List) {
              data[key] = [data[key]]; // Convert to list if not already
            }
            data[key].add(childData);
          } else if (childData is Map<String, dynamic> &&
              childData.length == 1 &&
              childData.containsKey(key)) {
            // Flatten the structure if the child has a single key matching the parent's key
            data[key] = childData[key];
          } else {
            // Store child data
            data[key] = childData;
          }
        }
      }

      // If there's only text content, return the text instead of a map
      return data.isEmpty ? element.text.trim() : data;
    }

    // Start processing from the root element
    cleanedData = extractData(document.rootElement);

    // Convert the map to JSON string
    String jsonString = jsonEncode(cleanedData);

    return jsonString;
  }

  // the final form which we have to submit
  void _finalForm({bool isUrlEncoded = false}) {
    Map<String, dynamic> form = {
      // "sccTempId": "",
      // "acadCareer": _selectedScholarship?.acadmicCareer ?? '',
      // "studentCarNumber": "0",
      // "institution": _selectedScholarship?.institution ?? '',
      // "admApplCtr": "AD",
      // "admitType": _selectedScholarship?.admitType ?? '',
      // "admitTerm": _selectedScholarship?.admitTerm ?? '',
      // "citizenship": "ARE",
      // "acadProgram": _selectedScholarship?.acadmicProgram ?? '',
      // "programStatus": _selectedScholarship?.programStatus ?? '',
      // "programAction": _selectedScholarship?.programAction ?? '',
      // "acadLoadAppr": _selectedScholarship?.acadLoadAppr ?? '',
      // "campus": _selectedScholarship?.campus ?? '',
      // "planSequence": null,
      // "acadPlan": _selectedScholarship?.acadmicPlan ?? '',
      // "username": "Test Test",
      // "scholarshipType": _selectedScholarship?.scholarshipType ?? '',
      // "password": null,
      // "country": _passportNationalityController.text,
      // "errorMessage": "",
      // "studyCountry": true,
      // "dateOfBirth": _dateOfBirthController.text,
      // "placeOfBirth": _placeOfBirthController.text,
      // "gender": _genderController.text,
      // "maritalStatus": _maritalStatusController.text,
      // "emailId": _studentEmailController.text,
      // "passportId": _passportNumberController.text,
      // "passportExpiryDate": _passportExpiryDateController.text,
      // "passportIssueDate": _passportIssueDateController.text,
      // "passportIssuePlace": _passportPlaceOfIssueController.text,
      // "unifiedNo": _passportUnifiedNoController.text,
      // "emirateId": _emiratesIdController.text,
      // "emirateIdExpiryDate": _emiratesIdExpiryDateController.text,
      // "otherNumber": "",
      // "relativeStudyinScholarship": _isRelativeStudyingFromScholarship ?? false,
      // "graduationStatus": null,
      // "cohortId": "2019",
      // "scholarshipSubmissionCode": "SCO2019UGRDINT",
      // "highestQualification": "UG",
      // "employmentStatus": "N",
      // "admApplicationNumber": "00000000",
      // "familyNo": _familyInformationEmiratesController.text,
      // "town": _familyInformationTownVillageNoController.text,
      // "parentName": _familyInformationParentGuardianNameController.text,
      // "relationType": _familyInformationRelationTypeController.text,
      // "militaryService": _militaryServiceController.text,
      // "militaryServiceStartDate": _militaryServiceStartDateController.text,
      // "militaryServiceEndDate": _militaryServiceEndDateController.text,
      // "reasonForMilitary": _reasonForMilitaryController.text,
      // "nameAsPassport": _nameAsPassport,
      // "englishName": _englishName,
      // "arabicName": _arabicName,
      // "phoneNumbers":
      //     _phoneNumberList.map((element) => element.toJson()).toList(),
      // "addressList":
      //     _addressInformationList.map((element) => element.toJson()).toList(),
      // "relativeDetails":
      //     _relativeInfoList.map((element) => element.toJson()).toList(),
      // "highSchoolList":
      // _highSchoolList.map((element) => element.toJson()).toList(),
      // "graduationList": _graduationDetailsList.map((element) => element.toJson()).toList(),
      // Rest of the fields...
    };

    log("My Form: $form");
  }
}
