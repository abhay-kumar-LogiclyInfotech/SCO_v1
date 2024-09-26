import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';
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
import '../../resources/custom_painters/dashLinePainters.dart';
import '../../utils/constants.dart';
import '../../viewModel/services/alert_services.dart';
import '../../viewModel/services/navigation_services.dart';

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
    print("Draft saved");
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

      // *--------------------------------------------------------------------------------------------------------------------- Initialize dropdowns start ------------------------------------------------------------------------------------------------------------------------*
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

      // *--------------------------------------------------------------------------------------------------------------------- Initialize dropdowns end ------------------------------------------------------------------------------------------------------------------------*

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
          hsDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'BIO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'CHEM'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ECO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ENG'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'GS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'HS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'MATH'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'PHY'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'SCI'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
          ],
          otherHSDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH1'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH2'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH3'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH4'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH5'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
          ]));
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
          hsDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'BIO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'CHEM'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ECO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ENG'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'GS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'HS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'MATH'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'PHY'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'SCI'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
          ],
          otherHSDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH1'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH2'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH3'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH4'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH5'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
          ]));

      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.done, null);
    });
  }

  // *---------------------------------------------------------------------------------------------------- Init State of the form start ----------------------------------------------------------------------------------------*
  @override
  void initState() {
    // initialize the services
    _initializeServices();
    // calling initializer to initialize the data
    _initializer();
    super.initState();
  }

  // *---------------------------------------------------------------------------------------------------- Init State of the form end -----------------------------------------------------------------------------------------------*

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
                          return _highSchoolDetailsSection(
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

  // *------------------------------------------------------------------------------------------------------------------------------------------ Accept terms and conditions start ----------------------------------------------------------------------------------------------------------------------------------*

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

  // *------------------------------------------------------------------------------------------------------------------------------------------ Accept terms and conditions end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ Name as Passport data start ----------------------------------------------------------------------------------------------------------------------------------*

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

  // *------------------------------------------------------------------------------------------------------------------------------------------ Name as Passport data end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ passport data start ----------------------------------------------------------------------------------------------------------------------------------*
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

  // *------------------------------------------------------------------------------------------------------------------------------------------ passport data end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ personal details data start ----------------------------------------------------------------------------------------------------------------------------------*

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

  // *------------------------------------------------------------------------------------------------------------------------------------------ personal details data end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ Family Information data start ----------------------------------------------------------------------------------------------------------------------------------*

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

  // *------------------------------------------------------------------------------------------------------------------------------------------ Family Information data end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------Relative Information data start----------------------------------------------------------------------------------------------------------------------------------*
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

  // *------------------------------------------------------------------------------------------------------------------------------------------Relative Information data end----------------------------------------------------------------------------------------------------------------------------------*

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
                    //*------------------------------------------------------------------------------------------------------------------------------------ Arabic Name Section start ------------------------------------------------------------------------------------------------------------------------------------*/
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

                    // *------------------------------------------------------------------------------------------------------------------------------------ Arabic Name Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ English Name Section Start ------------------------------------------------------------------------------------------------------------------------------------*/
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
                    //*------------------------------------------------------------------------------------------------------------------------------------ English Name Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    //*------------------------------------------------------------------------------------------------------------------------------------ Passport Data Section Start ------------------------------------------------------------------------------------------------------------------------------------*/
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
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _passportIssueDateFocusNode,
                      nextFocusNode: _passportExpiryDateFocusNode,
                      controller: _passportIssueDateController,
                      border: Utils.outlinedInputBorder(),
                      obscureText: false,
                      hintText: "Enter Issue Date",
                      textStyle: _textFieldTextStyle,
                      textInputType: TextInputType.datetime,
                      textCapitalization: true,
                      trailing: const Icon(
                        Icons.calendar_month,
                        color: AppColors.scoLightThemeColor,
                        size: 16,
                      ),
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
                            Utils.requestFocus(
                                focusNode: _passportExpiryDateFocusNode,
                                context: context);
                            _passportIssueDateController.text =
                                DateFormat('dd/MM/yyyy').format(dob).toString();
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
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _passportExpiryDateFocusNode,
                      nextFocusNode: _passportPlaceOfIssueFocusNode,
                      controller: _passportExpiryDateController,
                      border: Utils.outlinedInputBorder(),
                      obscureText: false,
                      hintText: "Enter Expiry Date",
                      textStyle: _textFieldTextStyle,
                      textInputType: TextInputType.datetime,
                      textCapitalization: true,
                      trailing: const Icon(
                        Icons.calendar_month,
                        color: AppColors.scoLightThemeColor,
                        size: 16,
                      ),
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
                    // *------------------------------------------------------------------------------------------------------------------------------------ Passport Data Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Personal Details Section start ------------------------------------------------------------------------------------------------------------------------------------*/
                    // personal Details heading
                    _sectionTitle(title: "Personal Details"),
                    // ****************************************************************************************************************************************************

                    kFormHeight,
                    // emirates id
                    fieldHeading(
                        title: "Emirates ID",
                        important: true,
                        langProvider: langProvider),
                    CustomTextField(
                      readOnly: true,
                      textStyle: _textFieldTextStyle,
                      border: Utils.outlinedInputBorder(),
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
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _emiratesIdExpiryDateFocusNode,
                      controller: _emiratesIdExpiryDateController,
                      nextFocusNode: _dateOfBirthFocusNode,
                      border: Utils.outlinedInputBorder(),
                      hintText: "Enter Emirates ID Expiry Date",
                      textStyle: _textFieldTextStyle,
                      textInputType: TextInputType.datetime,
                      textCapitalization: true,
                      trailing: const Icon(
                        Icons.calendar_month,
                        color: AppColors.scoLightThemeColor,
                        size: 16,
                      ),
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
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _dateOfBirthFocusNode,
                      nextFocusNode: _placeOfBirthFocusNode,
                      controller: _dateOfBirthController,
                      border: Utils.outlinedInputBorder(),
                      hintText: "Enter Date Of Birth",
                      textStyle: _textFieldTextStyle,
                      textInputType: TextInputType.datetime,
                      textCapitalization: true,
                      trailing: const Icon(
                        Icons.calendar_month,
                        color: AppColors.scoLightThemeColor,
                        size: 16,
                      ),
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
                                  // *------------------------------------------------------------------------------------------------------------------------------------ Family Information Section start ------------------------------------------------------------------------------------------------------------------------------------*/

                                  _sectionDivider(),

                                  // *------------------------------------------------------------------------------------------------------------------------------------ Family Information Section end ------------------------------------------------------------------------------------------------------------------------------------*/
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
                            : const SizedBox.shrink(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Personal Details Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Relative Information Section Start ------------------------------------------------------------------------------------------------------------------------------------*/
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
                        ? const SizedBox.shrink()
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
                                          : const SizedBox.shrink(),
                                    ],
                                  );
                                })
                            : const SizedBox.shrink(),

                    // ****************************************************************************************************************************************************
                    // Add More Information container
                    _relativeInfoList.isNotEmpty
                        ? _addRemoveMoreSection(
                            title: "Add Relative Info",
                            add: true,
                            onChanged: () {
                              _addRelative();
                            })
                        : const SizedBox.shrink(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Relative Information Section end ------------------------------------------------------------------------------------------------------------------------------------*/
                    _sectionDivider(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Contact Information Section start ------------------------------------------------------------------------------------------------------------------------------------*/

                    // ****************************************************************************************************************************************************
                    // Title for Contact Information
                    _sectionTitle(title: "Contact Information"),
                    kFormHeight,
                    // ****************************************************************************************************************************************************

                    _phoneNumberSection(),
                    // *------------------------------------------------------------------------------------------------------------------------------------ Contact Information Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    _sectionDivider(),

                    // *------------------------------------------------------------------------------------------------------------------------------------ Address Information Section start ------------------------------------------------------------------------------------------------------------------------------------*/

                    // ****************************************************************************************************************************************************
                    // Title for Address Information
                    _sectionTitle(title: "Address Data"),
                    kFormHeight,
                    // ****************************************************************************************************************************************************
                    _addressInformationSection(),
                    // *------------------------------------------------------------------------------------------------------------------------------------ Address Information Section end ------------------------------------------------------------------------------------------------------------------------------------*/

                    (_passportNationalityController.text.isNotEmpty &&
                            _passportNationalityController.text == "ARE")
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionDivider(),

                              // *------------------------------------------------------------------------------------------------------------------------------------ Military Services Information Section start ------------------------------------------------------------------------------------------------------------------------------------*/

                              // ****************************************************************************************************************************************************
                              // Title for Address Information
                              _sectionTitle(title: "Military Services"),
                              kFormHeight,
                              // ****************************************************************************************************************************************************

                              _militaryServicesSection(),

                              // *------------------------------------------------------------------------------------------------------------------------------------ Military Services  Section end ------------------------------------------------------------------------------------------------------------------------------------*/
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                )),
            kFormHeight,
          ],
        ),
      ),
    );
  }

  // *------------------------------------------------------------------------------------------------------------------------------------------ Phone Number Information data start----------------------------------------------------------------------------------------------------------------------------------*

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
                  (index == 0 || index == 1)
                      ? kFormHeight
                      : const SizedBox.shrink(),

                  // Add More Information container
                  (_phoneNumberList.isNotEmpty && (index != 0 && index != 1))
                      ? _addRemoveMoreSection(
                          title: "Delete Info",
                          add: false,
                          onChanged: () {
                            _removePhoneNumber(index);
                          })
                      : const SizedBox.shrink(),

                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  // ****************************************************************************************************************************************************

                  // space based on if not last item
                  index != _phoneNumberList.length - 1
                      ? kFormHeight
                      : const SizedBox.shrink(),
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
            : const SizedBox.shrink(),
      ],
    );
  }

  // *------------------------------------------------------------------------------------------------------------------------------------------Phone Number Information data end----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ Address Information Section start ----------------------------------------------------------------------------------------------------------------------------------*

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
                  (index == 0) ? kFormHeight : const SizedBox.shrink(),

                  // Add More Information container
                  (_addressInformationList.isNotEmpty && (index != 0))
                      ? _addRemoveMoreSection(
                          title: "Delete Address",
                          add: false,
                          onChanged: () {
                            _removeAddress(index);
                          })
                      : const SizedBox.shrink(),

                  // light color divider
                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  // ****************************************************************************************************************************************************

                  // space based on if not last item
                  index != _addressInformationList.length - 1
                      ? kFormHeight
                      : const SizedBox.shrink(),
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
            : const SizedBox.shrink(),
      ],
    );
  }

  // *------------------------------------------------------------------------------------------------------------------------------------------ Address Information Section end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ Military Information Section start ----------------------------------------------------------------------------------------------------------------------------------*

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
            CustomTextField(
              readOnly: true,
              currentFocusNode: _militaryServiceStartDateFocusNode,
              nextFocusNode: _militaryServiceEndDateFocusNode,
              controller: _militaryServiceStartDateController,
              border: Utils.outlinedInputBorder(),
              hintText: "Select Start Date",
              textStyle: _textFieldTextStyle,
              textInputType: TextInputType.datetime,
              textCapitalization: true,
              trailing: const Icon(
                Icons.calendar_month,
                color: AppColors.scoLightThemeColor,
                size: 16,
              ),
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

            CustomTextField(
              readOnly: true,
              currentFocusNode: _militaryServiceEndDateFocusNode,
              controller: _militaryServiceEndDateController,
              border: Utils.outlinedInputBorder(),
              hintText: "Select End Date",
              textStyle: _textFieldTextStyle,
              textInputType: TextInputType.datetime,
              textCapitalization: true,
              trailing: const Icon(
                Icons.calendar_month,
                color: AppColors.scoLightThemeColor,
                size: 16,
              ),
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
        return const SizedBox.shrink();
      case MilitaryStatus.postponed:
        return _reason(langProvider);
      case MilitaryStatus.exemption:
        return _reason(langProvider);
      case null:
        return const SizedBox.shrink();
    }
    return const SizedBox.shrink();
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

  // *------------------------------------------------------------------------------------------------------------------------------------------ Military Information Section end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------------ High School Section Start ----------------------------------------------------------------------------------------------------------------------------------*
  // step-3: high school details

  List _highSchoolLevelMenuItemsList = [];

  List<HighSchool> _highSchoolList = [];


  // to populate the states based on high school country
  _populateHighSchoolStateDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
          .lovCodeMap['STATE#${_highSchoolList[index].hsCountryController.text}']?.values != null) {
        _highSchoolList[index].schoolStateDropdownMenuItems = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['STATE#${_highSchoolList[index].hsCountryController.text}']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);

      }
    });
  }

  _populateHighSchoolNameDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants.lovCodeMap['SCHOOL_CD#${_highSchoolList[index].hsStateController.text}']?.values != null) {
        _highSchoolList[index].schoolNameDropdownMenuItems = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['SCHOOL_CD#${_highSchoolList[index].hsStateController.text}']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);

      }
    });
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
          hsDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'BIO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'CHEM'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ECO'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'ENG'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'GS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'HS'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'MATH'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'PHY'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'SCI'),
              gradeController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
            ),
          ],
          otherHSDetails: [
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH1'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH2'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH3'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH4'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
            HSDetails(
              subjectTypeController: TextEditingController(text: 'OTH5'),
              gradeController: TextEditingController(),
              otherSubjectNameController: TextEditingController(),
              subjectTypeFocusNode: FocusNode(),
              gradeFocusNode: FocusNode(),
              otherSubjectNameFocusNode: FocusNode(),
            ),
          ]));
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
        highSchool.hsLevelController.dispose();
        highSchool.hsNameController.dispose();
        highSchool.hsCountryController.dispose();
        highSchool.hsStateController.dispose();
        highSchool.yearOfPassingController.dispose();
        highSchool.hsTypeController.dispose();
        highSchool.curriculumTypeController.dispose();
        highSchool.curriculumAverageController.dispose();
        highSchool.otherHsNameController.dispose();
        highSchool.passingYearController.dispose();
        highSchool.maxDateController.dispose();

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
          CustomInformationContainer(
              title: "High School Details",
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _sectionTitle(title: "High School Level"),
                  _highSchoolInformationSection(),
                ],
              ))
        ])));
  }

  // list view of high schools
  Widget _highSchoolInformationSection() {
    // defining langProvider
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Column(children: [
      ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _highSchoolList.length,
          itemBuilder: (context, index) {
            final highSchoolInfo = _highSchoolList[index];
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ****************************************************************************************************************************************************
                  kFormHeight,
                  // title
                  fieldHeading(
                      title: "High School Level",
                      important: true,
                      langProvider: langProvider),

                  // dropdowns on the basis of selected one
                  ((_selectedScholarship?.admitType == 'MOS' ||
                                  _selectedScholarship?.admitType == 'MOP') &&
                              index == 0) ||
                          index <= 1
                      ? Column(children: [
                          _scholarshipFormDropdown(
                            readOnly: true,
                            filled: true,
                            controller: highSchoolInfo.hsLevelController,
                            currentFocusNode: highSchoolInfo.hsLevelFocusNode,
                            menuItemsList: _highSchoolLevelMenuItemsList,
                            hintText: "Select High School Level",
                            errorText: highSchoolInfo.hsLevelError,
                            onChanged: (value) {
                              highSchoolInfo.hsLevelError = null;
                              setState(() {
                                // setting the value for address type
                                highSchoolInfo.hsLevelController.text = value!;

                                // populating the state dropdown

                                _populateStateDropdown(
                                    langProvider: langProvider, index: index);

                                //This thing is creating error: don't know how to fix it:
                                Utils.requestFocus(
                                    focusNode:
                                        highSchoolInfo.hsCountryFocusNode,
                                    context: context);
                              });
                            },
                          )
                        ])
                      : (((_selectedScholarship?.admitType == 'MOS' ||
                                      _selectedScholarship?.admitType ==
                                          'MOP') &&
                                  index > 0) ||
                              (_selectedScholarship?.acadmicCareer == 'HCHL' &&
                                  index >= 1) ||
                              index >= 2)
                          ? _scholarshipFormDropdown(
                              controller: highSchoolInfo.hsLevelController,
                              currentFocusNode: highSchoolInfo.hsLevelFocusNode,
                              menuItemsList: _highSchoolLevelMenuItemsList,
                              hintText: "Select High School Level",
                              errorText: highSchoolInfo.hsLevelError,
                              onChanged: (value) {
                                highSchoolInfo.hsLevelError = null;
                                setState(() {
                                  // setting the value for address type
                                  highSchoolInfo.hsLevelController.text =
                                      value!;

                                  // populating the state dropdown

                                  _populateStateDropdown(
                                      langProvider: langProvider, index: index);

                                  //This thing is creating error: don't know how to fix it:
                                  Utils.requestFocus(
                                      focusNode:
                                          highSchoolInfo.hsCountryFocusNode,
                                      context: context);
                                });
                              },
                            )
                          : const SizedBox.shrink(),

                  kFormHeight,
                  // ****************************************************************************************************************************************************

                  // country
                  fieldHeading(
                      title: "Country",
                      important: true,
                      langProvider: langProvider),

                  _scholarshipFormDropdown(
                    controller: highSchoolInfo.hsCountryController,
                    currentFocusNode: highSchoolInfo.hsCountryFocusNode,
                    menuItemsList: _nationalityMenuItemsList,
                    hintText: "Select Country",
                    errorText: highSchoolInfo.hsCountryError,
                    onChanged: (value) {
                      highSchoolInfo.hsCountryError = null;
                      setState(() {
                        // setting the value for address type
                        highSchoolInfo.hsCountryController.text = value!;

                        highSchoolInfo.hsStateController.clear();
                        highSchoolInfo.hsNameController.clear();
                        highSchoolInfo.schoolStateDropdownMenuItems?.clear();
                        highSchoolInfo.schoolNameDropdownMenuItems?.clear();
                        // populating the high school state dropdown
                        _populateHighSchoolStateDropdown(langProvider: langProvider, index: index);

                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(focusNode: highSchoolInfo.hsStateFocusNode, context: context);
                      });
                    },
                  ),

                  kFormHeight,
                  // ****************************************************************************************************************************************************

                  // state
                  fieldHeading(
                      title: "State",
                      important: true,
                      langProvider: langProvider),

                  _scholarshipFormDropdown(
                    controller: highSchoolInfo.hsStateController,
                    currentFocusNode: highSchoolInfo.hsStateFocusNode,
                    menuItemsList: highSchoolInfo.schoolStateDropdownMenuItems ?? [],
                    hintText: "Select State",
                    errorText: highSchoolInfo.hsStateError,
                    onChanged: (value) {
                      highSchoolInfo.hsStateError = null;
                      setState(() {
                        // setting the value for address type
                        highSchoolInfo.hsStateController.text = value!;


                        highSchoolInfo.hsNameController.clear();
                        highSchoolInfo.schoolNameDropdownMenuItems?.clear();

                        // populating the high school state dropdown
                        _populateHighSchoolNameDropdown(langProvider: langProvider, index: index);

                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(focusNode: highSchoolInfo.hsNameFocusNode, context: context);
                      });
                    },
                  ),

                  kFormHeight,
                  // ****************************************************************************************************************************************************

                  // school name
                  fieldHeading(
                      title: "School Name",
                      important: true,
                      langProvider: langProvider),

                  _scholarshipFormDropdown(
                    controller: highSchoolInfo.hsNameController,
                    currentFocusNode: highSchoolInfo.hsNameFocusNode,
                    menuItemsList: highSchoolInfo.schoolNameDropdownMenuItems ?? [],
                    hintText: "Select School Name",
                    errorText: highSchoolInfo.hsNameError,
                    onChanged: (value) {
                      highSchoolInfo.hsNameError = null;
                      setState(() {
                        // setting the value for address type
                        highSchoolInfo.hsNameController.text =
                        value!;

                        // highSchoolInfo.hsNameController.clear();
                        // highSchoolInfo.schoolNameDropdownMenuItems?.clear();
                        //
                        // // populating the high school state dropdown
                        // _populateHighSchoolNameDropdown(langProvider: langProvider, index: index);

                        //This thing is creating error: don't know how to fix it:
                        Utils.requestFocus(focusNode: highSchoolInfo.hsTypeFocusNode, context: context);
                      });
                    },
                  ),



                  const MyDivider(
                    color: AppColors.lightGrey,
                  ),
                  // ****************************************************************************************************************************************************

                  // if it obeys the constraints of showing dropdown only then it will be visible to the user to delete the item
                  (((_selectedScholarship?.admitType == 'MOS' ||
                      _selectedScholarship?.admitType ==
                          'MOP') &&
                      index > 0) ||
                      (_selectedScholarship?.acadmicCareer == 'HCHL' &&
                          index >= 1) ||
                      index >= 2) ?   _addRemoveMoreSection(
                      title: "delete",
                      add: false,
                      onChanged: () {
                        setState(() {
                          _removeHighSchool(index);
                        });
                      }) : const SizedBox.shrink(),
                ]);
          }),

      _addRemoveMoreSection(
          title: "Add",
          add: true,
          onChanged: () {
            setState(() {
              _addHighSchool();
            });
          }),
    ]);
  }

  // *------------------------------------------------------------------------------------------------------------------------------------------ High School Section end ----------------------------------------------------------------------------------------------------------------------------------*

  // *------------------------------------------------------------------------------------------------------------------------------------ validate section in accordance with the steps start ------------------------------------------------------------------------------------------------------------------------------------*

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

    // Default to true for other sections
    return true;
  }

  // *------------------------------------------------------------------------------------------------------------------------------------ validate section in accordance with the steps end ------------------------------------------------------------------------------------------------------------------------------------*

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

  // *-------------------------------------------------------------------------------------------------------------------------------------------------------- Custom Widgets for Scholarship Form only start --------------------------------------------------------------------------------------------------------------------------------------------------------***

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
    required Function(String? value) onChanged,
  }) {
    return CustomTextField(
        currentFocusNode: currentFocusNode,
        nextFocusNode: nextFocusNode,
        controller: controller,
        obscureText: false,
        border: Utils.outlinedInputBorder(),
        hintText: hintText,
        textStyle: _textFieldTextStyle,
        maxLines: maxLines,
        errorText: errorText,
        onChanged: onChanged);
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
      menuItemsList: menuItemsList,
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

  // *-------------------------------------------------------------------------------------------------------------------------------------------------------- Custom Widgets for Scholarship Form only end --------------------------------------------------------------------------------------------------------------------------------------------------------***

  // the final form which we have to submit
  void _finalForm({bool isUrlEncoded = false}) {
    Map<String, dynamic> form = {
      "sccTempId": "",
      "acadCareer": _selectedScholarship?.acadmicCareer ?? '',
      "studentCarNumber": "0",
      "institution": _selectedScholarship?.institution ?? '',
      "admApplCtr": "AD",
      "admitType": _selectedScholarship?.admitType ?? '',
      "admitTerm": _selectedScholarship?.admitTerm ?? '',
      "citizenship": "ARE",
      "acadProgram": _selectedScholarship?.acadmicProgram ?? '',
      "programStatus": _selectedScholarship?.programStatus ?? '',
      "programAction": _selectedScholarship?.programAction ?? '',
      "acadLoadAppr": _selectedScholarship?.acadLoadAppr ?? '',
      "campus": _selectedScholarship?.campus ?? '',
      "planSequence": null,
      "acadPlan": _selectedScholarship?.acadmicPlan ?? '',
      "username": "Test Test",
      "scholarshipType": _selectedScholarship?.scholarshipType ?? '',
      "password": null,
      "country": _passportNationalityController.text,
      "errorMessage": "",
      "studyCountry": true,
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
      "otherNumber": "",
      "relativeStudyinScholarship": _isRelativeStudyingFromScholarship ?? false,
      "graduationStatus": null,
      "cohortId": "2019",
      "scholarshipSubmissionCode": "SCO2019UGRDINT",
      "highestQualification": "UG",
      "employmentStatus": "N",
      "admApplicationNumber": "00000000",
      "familyNo": _familyInformationEmiratesController.text,
      "town": _familyInformationTownVillageNoController.text,
      "parentName": _familyInformationParentGuardianNameController.text,
      "relationType": _familyInformationRelationTypeController.text,
      "militaryService": _militaryServiceController.text,
      "militaryServiceStartDate": _militaryServiceStartDateController.text,
      "militaryServiceEndDate": _militaryServiceEndDateController.text,
      "reasonForMilitary": _reasonForMilitaryController.text,
      "nameAsPassport": _nameAsPassport,
      "englishName": _englishName,
      "arabicName": _arabicName,
      "phoneNumbers":
          _phoneNumberList.map((element) => element.toJson()).toList(),
      "addressList":
          _addressInformationList.map((element) => element.toJson()).toList(),
      "relativeDetails":
          _relativeInfoList.map((element) => element.toJson()).toList(),
      "highSchoolList": [],
      "graduationList": [
        {
          "currentlyStudying": true,
          "lastTerm": 1921,
          "level": "DP",
          "country": "ARE",
          "university": "000727",
          "major": "Test",
          "cgpa": "10",
          "graduationStartDate": "2020-01-01",
          "sponsorship": "test"
        }
      ],
      // Rest of the fields...
    };

    log("My Form: $form");
  }
}
