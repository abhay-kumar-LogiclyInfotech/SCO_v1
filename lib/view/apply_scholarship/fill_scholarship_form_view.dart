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
      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.done, null);

      // *----------------------------- Initialize dropdowns start --------------------------------*
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

      // *----------------------------- Initialize dropdowns end --------------------------------*
    });
  }

  // *------------Init State of the form start-------*
  @override
  void initState() {
    // initialize the services
    _initializeServices();
    // calling initializer to initialize the data
    _initializer();
    super.initState();
  }

  // *------------Init State of the form end-------*

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
                        Container(
                          width: double.infinity,
                          height: 30,
                          decoration: const BoxDecoration(
                              color: AppColors.bgColor,
                              border: Border(
                                  bottom:
                                      BorderSide(color: AppColors.darkGrey))),
                          child: CustomPaint(
                              painter: DashedLinePainter(),
                              child: Text(
                                _scholarshipTitle,
                                style: AppTextStyles.titleBoldTextStyle(),
                              )),
                        ),

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
                          filledSections[index] = true;
                          return _studentDetailsSection(
                              step: index, langProvider: langProvider);
                        }
                        if (index == 2) {
                          filledSections[index] = true;
                          return Text("education details");
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
                            if (validateSection(
                                step: _currentSectionIndex,
                                langProvider: langProvider)) {
                              nextSection(); // Only move to the next section if validation passes
                            } else {
                              // Optionally show a validation error message (like a SnackBar)
                              _alertService.flushBarErrorMessages(
                                  message:
                                      'Please complete the required fields.',
                                  context: context,
                                  provider: langProvider);
                            }
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
              filledSections[step] = _acceptStudentUndertaking; // Update section as filled
            });
          },
          text: "Accept Scholarship terms and conditions",
        ),
      ],
    );
  }

  // *-------------------------------------------------- Name as Passport data start ------------------------------------------*

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

  // *-------------------------------------------------- Name as Passport data end ------------------------------------------*

  // *-------------------------------------------------- passport data start ------------------------------------------*
  List<DropdownMenuItem> _nationalityMenuItemsList = [];

  // Private TextEditingControllers
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _placeOfIssueController = TextEditingController();
  final TextEditingController _unifiedNoController = TextEditingController();

  // Private FocusNodes
  final FocusNode _nationalityFocusNode = FocusNode();
  final FocusNode _passportNumberFocusNode = FocusNode();
  final FocusNode _issueDateFocusNode = FocusNode();
  final FocusNode _expiryDateFocusNode = FocusNode();
  final FocusNode _placeOfIssueFocusNode = FocusNode();
  final FocusNode _unifiedNoFocusNode = FocusNode();

  // Error texts for validation
  String? _nationalityError;
  String? _passportNumberError;
  String? _issueDateError;
  String? _expiryDateError;
  String? _placeOfIssueError;
  String? _unifiedNoError;

  // *-------------------------------------------------- passport data end ------------------------------------------*

  // *-------------------------------------------------- personal details data start ------------------------------------------*

  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _maritalStatusMenuItemsList = [];

  // Emirates ID
  final TextEditingController _emiratesIdController = TextEditingController();

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

  // *-------------------------------------------------- personal details data end ------------------------------------------*

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
                    //*-------------------------------------------- Arabic Name Section start --------------------------------------------*/
                    // Title for arabic name same as passport
                    Text(
                      "Arabic name in passport",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),

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

                    //*-------------------------------------------- Arabic Name Section end --------------------------------------------*/

                    kFormHeight,
                    const Divider(color: AppColors.scoButtonColor),
                    kFormHeight,

                    //*-------------------------------------------- English Name Section Start --------------------------------------------*/
                    // Title for English name same as passport
                    Text(
                      "English name in passport",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),

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
                    kFormHeight,
                    // English Family name
                    fieldHeading(
                        title: "Family Name",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _englishFamilyNameFocusNode,
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
                    //*-------------------------------------------- English Name Section end --------------------------------------------*/

                    kFormHeight,
                    const Divider(color: AppColors.scoButtonColor),
                    kFormHeight,

                    //*-------------------------------------------- Passport Data Section Start --------------------------------------------*/
                    // passport data heading
                    Text(
                      "Passport Data",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),
                    kFormHeight,

                    // Nationality
                    fieldHeading(
                        title: "Nationality",
                        important: true,
                        langProvider: langProvider),
                    CustomDropdown(
                      currentFocusNode: _nationalityFocusNode,
                      textDirection: getTextDirection(langProvider),
                      menuItemsList: _nationalityMenuItemsList,
                      onChanged: (value) {
                        setState(() {
                          _nationalityController.text = value!;
                          //This thing is creating error: don't know how to fix it:
                          FocusScope.of(context)
                              .requestFocus(_passportNumberFocusNode);
                        });
                      },
                      hintText: "Select Nationality",
                      textColor: AppColors.scoButtonColor,
                      outlinedBorder: true,
                    ),

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

                    kFormHeight,

                    // Issue Date
                    fieldHeading(
                        title: "Issue Date",
                        important: true,
                        langProvider: langProvider),
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _issueDateFocusNode,
                      nextFocusNode: _expiryDateFocusNode,
                      controller: _issueDateController,
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
                      onChanged: (value) async {},
                      onTap: () async {
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
                                focusNode: _expiryDateFocusNode,
                                context: context);
                            _issueDateController.text =
                                DateFormat('dd/MM/yyyy').format(dob).toString();
                          });
                        }
                      },
                    ),

                    kFormHeight,
                    // Expiry Date
                    fieldHeading(
                        title: "Expiry Date",
                        important: true,
                        langProvider: langProvider),
                    CustomTextField(
                      readOnly: true,
                      currentFocusNode: _expiryDateFocusNode,
                      nextFocusNode: _placeOfIssueFocusNode,
                      controller: _expiryDateController,
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
                      onChanged: (value) async {},
                      onTap: () async {
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
                                focusNode: _placeOfIssueFocusNode,
                                context: context);
                            _expiryDateController.text =
                                DateFormat('dd/MM/yyyy').format(dob).toString();
                          });
                        }
                      },
                    ),

                    kFormHeight,
                    // place of issue
                    fieldHeading(
                        title: "Place Of Issue",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _placeOfIssueFocusNode,
                        nextFocusNode: _unifiedNoFocusNode,
                        controller: _placeOfIssueController,
                        hintText: "Enter Place Of Issue",
                        errorText: _placeOfIssueError,
                        onChanged: (value) {
                          if (_placeOfIssueFocusNode.hasFocus) {
                            setState(() {
                              _placeOfIssueError = ErrorText.getEmptyFieldError(
                                  name: _placeOfIssueController.text,
                                  context: context);
                            });
                          }
                        }),

                    kFormHeight,
                    // passport unified number
                    fieldHeading(
                        title: "Passport Unified Number",
                        important: true,
                        langProvider: langProvider),
                    _scholarshipFormTextField(
                        currentFocusNode: _unifiedNoFocusNode,
                        nextFocusNode: _emiratesIdFocusNode,
                        controller: _unifiedNoController,
                        hintText: "Unified number is on the last page",
                        errorText: _unifiedNoError,
                        onChanged: (value) {
                          if (_unifiedNoFocusNode.hasFocus) {
                            setState(() {
                              _unifiedNoError = ErrorText.getUnifiedNumberError(
                                  unifiedNumber: _unifiedNoController.text,
                                  context: context);
                            });
                          }
                        }),
                    // *-------------------------------------------- Passport Data Section end --------------------------------------------*/

                    kFormHeight,
                    const Divider(color: AppColors.scoButtonColor),
                    kFormHeight,

                    // *-------------------------------------------- Personal Details Section start --------------------------------------------*/
                    // personal Details heading
                    Text(
                      "Personal Details",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),
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
                      onChanged: (value) async {},
                      onTap: () async {
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
                      onChanged: (value) async {},
                      onTap: () async {
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
                              _placeOfBirthError = ErrorText.getEmptyFieldError(
                                  name: _placeOfBirthController.text,
                                  context: context);
                            });
                          }
                        }),

                    kFormHeight,
                    // Gender
                    fieldHeading(
                        title: "Gender",
                        important: true,
                        langProvider: langProvider),
                    CustomDropdown(
                      value: _genderController.text.isEmpty
                          ? null
                          : _genderController.text,
                      currentFocusNode: _genderFocusNode,
                      textDirection: getTextDirection(langProvider),
                      menuItemsList: _genderMenuItemsList,
                      onChanged: (value) {
                        setState(() {
                          _genderController.text = value!;
                          //This thing is creating error: don't know how to fix it:
                          Utils.requestFocus(
                              focusNode: _maritalStatusFocusNode,
                              context: context);
                        });
                      },
                      hintText: "Select Gender",
                      textColor: AppColors.scoButtonColor,
                      outlinedBorder: true,
                    ),

                    kFormHeight,
                    // Gender
                    fieldHeading(
                        title: "Marital Status",
                        important: true,
                        langProvider: langProvider),
                    CustomDropdown(
                      value: _maritalStatusController.text.isEmpty
                          ? null
                          : _maritalStatusController.text,
                      currentFocusNode: _maritalStatusFocusNode,
                      textDirection: getTextDirection(langProvider),
                      menuItemsList: _maritalStatusMenuItemsList,
                      onChanged: (value) {
                        setState(() {
                          _maritalStatusController.text = value!;
                          //This thing is creating error: don't know how to fix it:
                          Utils.requestFocus(
                              focusNode: _studentEmailFocusNode,
                              context: context);
                        });
                      },
                      hintText: "Select Marital Status",
                      textColor: AppColors.scoButtonColor,
                      outlinedBorder: true,
                    ),

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
                    
                    kFormHeight,
                    // is mother UAE
                    CustomGFCheckbox(
                      value: _isMotherUAECheckbox,
                      onChanged: (value) {
                        setState(() {
                          _isMotherUAECheckbox = value ?? false;
                          _motherUAENationalController.text = _isMotherUAECheckbox.toString();
                        });
                      },
                      text: "Sons of citizens",
                      textStyle:AppTextStyles.titleTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500)
                    ),
                    

                    // *-------------------------------------------- Personal Details Section end --------------------------------------------*/
                  ],
                )),
            kFormHeight,
          ],
        ),
      ),
    );
  }

  // *-------------------------------------------- validate section in accordance with the steps start --------------------------------------------*
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

  // *-------------------------------------------- validate section in accordance with the steps end --------------------------------------------*

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
    super.dispose();
  }

  // *---------------------------------------------------------------- Custom Widgets for Scholarship Form only start ----------------------------------------------------------------***

  // text field style which is used to styling hing and actual text
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
        errorText: errorText,
        onChanged: onChanged);
  }

  // *---------------------------------------------------------------- Custom Widgets for Scholarship Form only end ----------------------------------------------------------------***

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
      "country": "ARE",
      "errorMessage": "",
      "studyCountry": true,
      "dateOfBirth": "1990-01-01",
      "placeOfBirth": "pune",
      "gender": "F",
      "maritalStatus": "M",
      "emailId": "784199068696840@gmail.com",
      "passportId": "62627277272",
      "passportExpiryDate": "2020-01-01",
      "passportIssueDate": "2020-01-01",
      "passportIssuePlace": "pune",
      "unifiedNo": "846464",
      "emirateId": "784199068696840",
      "emirateIdExpiryDate": "2020-01-01",
      "otherNumber": "",
      "relativeStudyinScholarship": true,
      "graduationStatus": null,
      "cohortId": "2019",
      "scholarshipSubmissionCode": "SCO2019UGRDINT",
      "highestQualification": "UG",
      "employmentStatus": "N",
      "admApplicationNumber": "00000000",
      "familyNo": 1,
      "town": 2,
      "parentName": "vidya",
      "relationType": 2,
      "militaryService": "Y",
      "militaryServiceStartDate": "2020-01-01",
      "militaryServiceEndDate": "2021-01-01",
      "reasonForMilitary": null,
      // For URL encoding, no jsonEncode is needed
      "nameAsPassport": _nameAsPassport,
      "englishName": _englishName,
      "arabicName": _arabicName,
      "phoneNumbers": [
        {
          "countryCode": "+971",
          "phoneNumber": "0515516161",
          "phoneType": "CELL",
          "preferred": true
        }
      ],
      "addressList": [
        {
          "addressType": "ABR",
          "addressLine1": "Test",
          "addressLine2": "Test",
          "city": "pune",
          "country": "ARE",
          "postalCode": "455184848181"
        }
      ],
      "relativeDetails": [
        {
          "relativeName": "vitthal",
          "relativeRelationType": 1,
          "relativeUniversity": "000229"
        }
      ],
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
