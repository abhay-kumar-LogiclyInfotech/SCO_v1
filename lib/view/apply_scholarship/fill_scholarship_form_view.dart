import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/account/Custom_inforamtion_container.dart';
import '../../resources/custom_painters/dashLinePainters.dart';
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
      // get selected scholarship
      _getSelectedScholarship();

      // set title and total sections
      _setTitleAndTotalSections(context: context);

      // Initialize filledSections based on the current totalSections
      updateSections(totalSections);
      _notifier.value =
          const AsyncSnapshot.withData(ConnectionState.done, null);
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
                        // return Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('Section ${index + 1}'),
                        //       const SizedBox(height: 16),
                        //       // Placeholder for form fields in each section
                        //       TextFormField(
                        //         decoration: const InputDecoration(labelText: 'Enter some data'),
                        //         onChanged: (value) {
                        //           setState(() {
                        //             filledSections[index] = value.isNotEmpty;
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // );
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
                            if (validateSection(_currentSectionIndex)) {
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
        Row(
          children: [
            GFCheckbox(
              size: 20,
              type: GFCheckboxType.custom,
              onChanged: (value) {
                setState(() {
                  _acceptStudentUndertaking = value;
                  filledSections[step] =
                      _acceptStudentUndertaking; // Update section as filled
                });
              },
              value: _acceptStudentUndertaking,
              inactiveIcon: null,
            ),
            const Expanded(
                child: Text("Accept Scholarship terms and conditions"))
          ],
        ),
      ],
    );
  }

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

  // step-2: student details
  Widget _studentDetailsSection(
      {required int step, required LanguageChangeViewModel langProvider}) {
    return Container(
      padding: EdgeInsets.all(kPadding),
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomInformationContainer(
                title: "Student Details",
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title for arabic name same as passport
                    Text(
                      "Arabic name in passport",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),

                    kFormHeight,
                    //  Arabic name
                    fieldHeading(
                        title: "Name", important: true, langProvider: langProvider),
                    CustomTextField(
                        currentFocusNode: _arabicStudentNameFocusNode,
                        nextFocusNode: _arabicFatherNameFocusNode,
                        controller: _arabicStudentNameController,
                        border: Utils.outlinedInputBorder(),
                        obscureText: false,
                        hintText: "Enter Name",
                        textStyle: _textFieldTextStyle,
                        errorText: _arabicStudentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicStudentNameFocusNode.hasFocus) {
                              _arabicStudentNameError = ErrorText.getArabicNameError(
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
                    CustomTextField(
                        currentFocusNode: _arabicFatherNameFocusNode,
                        nextFocusNode: _arabicGrandFatherNameFocusNode,
                        controller: _arabicFatherNameController,
                        obscureText: false,
                        border: Utils.outlinedInputBorder(),                        textStyle: _textFieldTextStyle,

                        hintText: "Enter Father's Name",
                        errorText: _arabicFatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_arabicFatherNameFocusNode.hasFocus) {
                              _arabicFatherNameError = ErrorText.getArabicNameError(
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
                    CustomTextField(
                        currentFocusNode: _arabicGrandFatherNameFocusNode,
                        nextFocusNode: _arabicFamilyNameFocusNode,
                        controller: _arabicGrandFatherNameController,
                        border: Utils.outlinedInputBorder(),
                        obscureText: false,                        textStyle: _textFieldTextStyle,

                        hintText: "Enter Grandfather's Name",
                        errorText: _arabicGrandFatherNameError,
                        onChanged: (value) {
                          if (_arabicGrandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _arabicGrandFatherNameError = ErrorText.getArabicNameError(
                                  name: _arabicGrandFatherNameController.text,
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
                    CustomTextField(
                        currentFocusNode: _arabicFamilyNameFocusNode,
                        nextFocusNode: _englishStudentNameFocusNode,
                        controller: _arabicFamilyNameController,
                        border: Utils.outlinedInputBorder(),
                        obscureText: false,
                        hintText: "Enter Family Name",                        textStyle: _textFieldTextStyle,

                        errorText: _arabicFamilyNameError,
                        onChanged: (value) {
                          if (_arabicFamilyNameFocusNode.hasFocus) {
                            setState(() {
                              _arabicFamilyNameError = ErrorText.getArabicNameError(
                                  name: _arabicFamilyNameController.text,
                                  context: context);
                            });
                          }
                        }),

                    kFormHeight,

                    const Divider(color: AppColors.scoButtonColor,),

                    kFormHeight,

                    // Title for English name same as passport
                    Text(
                      "English name in passport",
                      style: AppTextStyles.titleBoldTextStyle(),
                    ),

                    kFormHeight,
                    // English student name
                    fieldHeading(
                        title: "Name", important: true, langProvider: langProvider),
                    CustomTextField(
                        currentFocusNode: _englishStudentNameFocusNode,
                        nextFocusNode: _englishFatherNameFocusNode,
                        controller: _englishStudentNameController,
                        border: Utils.outlinedInputBorder(),
                        obscureText: false,
                        hintText: "Enter Name",                        textStyle: _textFieldTextStyle,

                        errorText: _englishStudentNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_englishStudentNameFocusNode.hasFocus) {
                              _englishStudentNameError = ErrorText.getEnglishNameError(
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
                    CustomTextField(
                        currentFocusNode: _englishFatherNameFocusNode,
                        nextFocusNode: _englishGrandFatherNameFocusNode,
                        controller: _englishFatherNameController,
                        obscureText: false,
                        border: Utils.outlinedInputBorder(),
                        hintText: "Enter Father's Name",                        textStyle: _textFieldTextStyle,

                        errorText: _englishFatherNameError,
                        onChanged: (value) {
                          setState(() {
                            if (_englishFatherNameFocusNode.hasFocus) {
                              _englishFatherNameError = ErrorText.getEnglishNameError(
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
                    CustomTextField(
                        currentFocusNode: _englishGrandFatherNameFocusNode,
                        nextFocusNode: _englishFamilyNameFocusNode,
                        controller: _englishGrandFatherNameController,
                        border: Utils.outlinedInputBorder(),
                        obscureText: false,
                        hintText: "Enter Grandfather's Name",                        textStyle: _textFieldTextStyle,

                        errorText: _englishGrandFatherNameError,
                        onChanged: (value) {
                          if (_englishGrandFatherNameFocusNode.hasFocus) {
                            setState(() {
                              _englishGrandFatherNameError = ErrorText.getEnglishNameError(
                                  name: _englishGrandFatherNameController.text,
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
                    CustomTextField(
                        currentFocusNode: _englishFamilyNameFocusNode,
                        controller: _englishFamilyNameController,
                        obscureText: false,
                        border: Utils.outlinedInputBorder(),
                        hintText: "Enter Family Name",                        textStyle: _textFieldTextStyle,

                        errorText: _englishFamilyNameError,
                        onChanged: (value) {
                          if (_englishFamilyNameFocusNode.hasFocus) {
                            setState(() {
                              _englishFamilyNameError = ErrorText.getEnglishNameError(
                                  name: _englishFamilyNameController.text,
                                  context: context);
                            });
                          }
                        }),
                  ],
                )),
          ],
        ),
      ),
    );
  }


  // validate section in accordance with the steps
  bool validateSection(int step) {
    // Validation for the first section (Accept Student Undertaking)
    if (step == 0) {
      // Validate the "Accept Student Undertaking" section
      return _acceptStudentUndertaking;
    }
    // Add additional validation for other sections if needed
    // For now, return true for the rest of the sections
    return true;
  }

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


  final TextStyle _textFieldTextStyle = AppTextStyles.titleTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.scoButtonColor);
}
