import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get_it/get_it.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_checkbox_tile.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/date_picker_dialog.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/input_formatters/emirates_id_input_formatter.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';


class EditPersonalDetailsView extends StatefulWidget {
  const EditPersonalDetailsView({super.key});

  @override
  State<EditPersonalDetailsView> createState() => _EditPersonalDetailsViewState();
}

class _EditPersonalDetailsViewState extends State<EditPersonalDetailsView> with MediaQueryMixin {
  late NavigationServices _navigationServices;



  List<DropdownMenuItem> _nationalityMenuItemsList = [];
  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _maritalStatusMenuItemsList = [];
  List<DropdownMenuItem> _phoneNumberTypeMenuItemsList = [];
  List<DropdownMenuItem> _emailTypeMenuItemsList = [];

  List<PhoneNumber> _phoneNumberDetailsList = [];
  List<EmailDetail> _emailDetailsList = [];

  Future _initializeData()async{
    // fetch student profile Information t prefill the user information
    final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context,listen: false);
    await studentProfileProvider.getPersonalDetails();

    // *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
    // Check and populate dropdowns only if the values exist
    if (Constants.lovCodeMap['COUNTRY']?.values != null) {_nationalityMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    if (Constants.lovCodeMap['GENDER']?.values != null) {_genderMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['GENDER']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    if (Constants.lovCodeMap['MARITAL_STATUS']?.values != null) {_maritalStatusMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['MARITAL_STATUS']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    if (Constants.lovCodeMap['PHONE_TYPE']?.values != null) {_phoneNumberTypeMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['PHONE_TYPE']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    if (Constants.lovCodeMap['EMAIL_TYPE']?.values != null) {_emailTypeMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['EMAIL_TYPE']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    // *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

    // prefill the values of the fields
    final user = studentProfileProvider.apiResponse.data?.data?.user;
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;

    _firstNameController.text = user?.firstName ?? '';
    _secondNameController.text = user?.middleName ?? '';
    _thirdOrFourthNameController.text = user?.middleName2 ?? '';
    _familyNameController.text = user?.lastName ?? '';
    _emiratesIdController.text = user?.emirateId ?? '';
    _emailController.text = user?.emailAddress ?? '';
    _nationalityController.text = user?.nationality ?? '';
    _mobileNumberController.text = user?.phoneNumber ?? '';
    _genderController.text = user?.gender ?? '';
    _maritalStatusController.text = userInfo?.maritalStatus ?? '';
    _dobController.text = user?.birthDate ?? '';
    // _languageController.text = user?.language ?? '';







    // initialize phone numbers
      if(userInfo?.phoneNumbers != null)
      {
        for (var element in userInfo!.phoneNumbers!) {
          _phoneNumberDetailsList.add(PhoneNumber.fromJson(element.toJson()));
        }
      }

    // initialize Email Details
    if(userInfo?.emails != null)
    {
      for (var element in userInfo!.emails!) {
        _emailDetailsList.add(EmailDetail.fromJson(element.toJson()));
      }
    }










  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      // initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();

      await _initializeData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Personal Details",
      ),
      body: _buildUi(),
    );
  }



  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetPersonalDetailsViewModel>(
        builder: (context, provider, _) {
          switch (provider.apiResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator();

            case Status.ERROR:
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.somethingWentWrong,
                ),
              );
            case Status.COMPLETED:
              final user = provider.apiResponse.data?.data?.user;
              final userInfo = provider.apiResponse.data?.data?.userInfo;

              return Directionality(
                textDirection: getTextDirection(langProvider),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        ProfilePhoto(
                          totalWidth: 80,
                          cornerRadius: 80,
                          color: Colors.blue,
                          outlineColor: Colors.transparent,
                          outlineWidth: 5,
                          textPadding: 0,
                          name: 'Brad V',
                          fontColor: Colors.white,
                          nameDisplayOption: NameDisplayOptions.initials,
                          fontWeight: FontWeight.w100,
                          badgeSize: 30,
                          badgeAlignment: Alignment.bottomRight,
                          image: const AssetImage('assets/personal_details/dummy_profile_pic.png'),
                          // badgeImage: const AssetImage('assets/personal_details/camera_icon.png'),
                          onTap: ()async {
                            // open profile
                          },
                          onLongPress: () {
                            // popup to message user
                          },
                        ),

                        // ProfilePicture(),
                        kFormHeight,
                        _studentInformationSection(provider: provider,langProvider: langProvider),

                        if(userInfo?.phoneNumbers != null)   Column(
                          children: [
                            kFormHeight,
                            kFormHeight,
                            _studentPhoneInformationSection(provider: provider,langProvider: langProvider),
                          ],
                        ),

                        if(userInfo?.emails != null)  Column(
                          children: [
                            kFormHeight,
                            kFormHeight,
                            _studentEmailInformationSection(provider: provider,langProvider: langProvider),
                          ],
                        ),

                        // submit buttons
                        _submitAndBackButton(langProvider: langProvider,userInfo: userInfo,provider: provider),
                      ],
                    ),
                  ),
                ),
              );

            case Status.NONE:
              return showVoid;
            case null:
              return showVoid;
          }
        });
  }





  //*------Student Information Section------*

  // FocusNodes
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _secondNameFocusNode = FocusNode();
  final FocusNode _thirdOrFourthNameFocusNode = FocusNode();
  final FocusNode _familyNameFocusNode = FocusNode();
  final FocusNode _emiratesIdFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nationalityFocusNode = FocusNode();
  final FocusNode _mobileNumberFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _maritalStatusFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _languageFocusNode = FocusNode();

// TextEditingControllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _thirdOrFourthNameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _emiratesIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();


  // Error texts
  String? _firstNameError;
  String? _secondNameError;
  String? _thirdOrFourthNameError;
  String? _familyNameError;
  String? _emiratesIdError;
  String? _emailError;
  String? _nationalityError;
  String? _mobileNumberError;
  String? _genderError;
  String? _maritalStatusError;
  String? _dobError;
  String? _languageError;

  Widget _studentInformationSection({required GetPersonalDetailsViewModel provider,required LanguageChangeViewModel langProvider}) {
    return CustomInformationContainer(
        title: "Student Information",
        leading:
        SvgPicture.asset("assets/personal_details/student_information.svg"),
        expandedContent: Column(
          children: [
            /// First name
            fieldHeading(title: "First Name", important: true, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _firstNameFocusNode,
                nextFocusNode: _secondNameFocusNode,
                controller: _firstNameController,
                hintText: "Enter Your First Name",
                errorText: _firstNameError,
                onChanged: (value) {
                  if ( _firstNameFocusNode.hasFocus) {
                    setState(() {
                      _firstNameError = ErrorText.getNameArabicEnglishValidationError(name: _firstNameController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Second Name", important: false, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _secondNameFocusNode,
                nextFocusNode: _thirdOrFourthNameFocusNode,
                controller: _secondNameController,
                hintText: "Enter Your Second Name",
                errorText: _secondNameError,
                onChanged: (value) {
                  if ( _secondNameFocusNode.hasFocus) {
                    setState(() {
                      _secondNameError = ErrorText.getNameArabicEnglishValidationError(name: _secondNameController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Third/Fourth Name", important: false, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _thirdOrFourthNameFocusNode,
                nextFocusNode: _familyNameFocusNode,
                controller: _thirdOrFourthNameController,
                hintText: "Enter Your Third/Fourth Name",
                errorText: _thirdOrFourthNameError,
                onChanged: (value) {
                  if ( _thirdOrFourthNameFocusNode.hasFocus) {
                    setState(() {
                      _thirdOrFourthNameError = ErrorText.getNameArabicEnglishValidationError(name: _thirdOrFourthNameController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Family Name", important: true, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _familyNameFocusNode,
                nextFocusNode: _emailFocusNode,
                controller: _familyNameController,
                hintText: "Enter Your Family Name",
                errorText: _familyNameError,
                onChanged: (value) {
                  if ( _familyNameFocusNode.hasFocus) {
                    setState(() {
                      _familyNameError = ErrorText.getNameArabicEnglishValidationError(name: _familyNameController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Emirates ID", important: false, langProvider: langProvider),
            scholarshipFormTextField(
                readOnly: true,
                filled: true,
                currentFocusNode: _emiratesIdFocusNode,
                nextFocusNode: _emailFocusNode,
                controller: _emiratesIdController,
                hintText: "Enter Your Emirates ID",
                errorText: _emiratesIdError,
                inputFormat: [EmiratesIDFormatter()],
                onChanged: (value) {
                  if ( _emiratesIdFocusNode.hasFocus) {
                    setState(() {
                      _emiratesIdError = ErrorText.getEmirateIdError(emirateId: _emiratesIdController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Email Address", important: true, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _emailFocusNode,
                nextFocusNode: _nationalityFocusNode,
                controller: _emailController,
                hintText: "Enter Your Email Address",
                textInputType: TextInputType.emailAddress,
                errorText: _emailError,
                onChanged: (value) {
                  if ( _emailFocusNode.hasFocus) {
                    setState(() {
                      _emailError = ErrorText.getEmailError(email: _emailController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Nationality", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _nationalityFocusNode,
                controller: _nationalityController,
                menuItemsList: _nationalityMenuItemsList,
                hintText: "Enter Your Nationality",
                errorText: _nationalityError,
                onChanged: (value) {
                    setState(() {
                      _nationalityError = null;
                      _nationalityController.text = value;
                      Utils.requestFocus(focusNode: _mobileNumberFocusNode, context: context);
                    });

                }, context: context),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Phone Number", important: true, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _mobileNumberFocusNode,
                nextFocusNode: _genderFocusNode,
                controller: _mobileNumberController,
                hintText: "Enter Your Phone Number",
                textInputType: TextInputType.phone,
                errorText: _mobileNumberError,
                onChanged: (value) {
                  if (_mobileNumberFocusNode.hasFocus) {
                    setState(() {
                      _mobileNumberError = ErrorText.getPhoneNumberError(phoneNumber: _mobileNumberController.text, context: context);
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Gender", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _genderFocusNode,
                controller: _genderController,
                menuItemsList: _genderMenuItemsList,
                hintText: "Enter Your Gender",
                errorText: _genderError,
                onChanged: (value) {
                    setState(() {
                      _genderError = null;
                      _genderController.text = value;
                      Utils.requestFocus(focusNode: _maritalStatusFocusNode, context: context);
                    });

                }, context: context),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Marital Status", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _maritalStatusFocusNode,
                controller: _maritalStatusController,
                menuItemsList: _maritalStatusMenuItemsList,
                hintText: "Enter Your Marital Status",
                errorText: _maritalStatusError,
                onChanged: (value) {
                  setState(() {
                    _maritalStatusError = null;
                    _maritalStatusController.text = value;
                    Utils.requestFocus(focusNode: _dobFocusNode, context: context);
                  });

                }, context: context),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Date of Birth", important: true, langProvider: langProvider),
            scholarshipFormDateField(
                currentFocusNode: _dobFocusNode,
                controller: _dobController,
                hintText: "Enter Your Date of Birth",
                errorText: _dobError,
                onChanged: (value) {
                  setState(() {
                    _dobError = null;
                    Utils.requestFocus(focusNode: _languageFocusNode, context: context);
                  });
                },
                onTap: ()async {
                  _dobError = null;
                  final date = await myDatePickerDialog(context);
                  _dobController.text = formatDateOnly( date.toString()); /// To format and get the date only
            }),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Default Interface Language", important: true, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _languageFocusNode,
                controller: _languageController,
                hintText: "Enter Preferred Language",
                errorText: _languageError,
                onChanged: (value) {
                  setState(() {
                    _languageError = null;

                  });

                }),
            /// ****************************************************************
            kFormHeight
          ],
        ));
  }


  //*------Student Phone Information Section start ------*
  // Method to add a new phone number to the contact information list
  void _addPhoneNumber() {
    setState(() {
      _phoneNumberDetailsList.add(PhoneNumber(
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
    if (index >= 2 && index < _phoneNumberDetailsList.length) {
      // Check if index is valid
      setState(() {
        final phoneNumber = _phoneNumberDetailsList[index];

        phoneNumber.countryCodeController.dispose(); // Dispose the controllers
        phoneNumber.phoneNumberController.dispose();
        phoneNumber.phoneTypeController.dispose();
        phoneNumber.preferred = false;
        phoneNumber.countryCodeFocusNode.dispose(); // Dispose the controllers
        phoneNumber.phoneNumberFocusNode.dispose();
        phoneNumber.phoneTypeFocusNode.dispose();
        _phoneNumberDetailsList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); // Debugging print to show invalid index
    }
  }


  Widget _studentPhoneInformationSection(
      {required GetPersonalDetailsViewModel provider,required langProvider}){
    return CustomInformationContainer(
        title: "Phone Details",
        leading: SvgPicture.asset("assets/personal_details/phone_details.svg"),
        expandedContent: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _phoneNumberDetailsList.length,
                itemBuilder: (context,index){
                 final phoneNumber = _phoneNumberDetailsList[index];
              return Column(
                children: [
                  // phone Type
                  fieldHeading(
                      title: "Phone Type",
                      important: true,
                      langProvider: langProvider),
                  scholarshipFormDropdown
                    (context:context,
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
                  scholarshipFormTextField(
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
                      important: false,
                      langProvider: langProvider),
                  scholarshipFormTextField(
                      currentFocusNode: phoneNumber.countryCodeFocusNode,
                      nextFocusNode: index < _phoneNumberDetailsList.length - 1
                          ? _phoneNumberDetailsList[index + 1].phoneTypeFocusNode
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
                  (_phoneNumberDetailsList.isNotEmpty && (index != 0 && index != 1)) ? addRemoveMoreSection(title: "Delete Info", add: false, onChanged: () {_removePhoneNumber(index);}) : showVoid,

                  const MyDivider(color: AppColors.lightGrey),
                  // ****************************************************************************************************************************************************

                  // space based on if not last item
                  index != _phoneNumberDetailsList.length - 1 ? kFormHeight : showVoid,

                ],
              );
            }),
            // Add more Phones Numbers
            // Add More Information container
            _phoneNumberDetailsList.isNotEmpty
                ? addRemoveMoreSection(
                title: "Add Phone Number",
                add: true,
                onChanged: () {
                  _addPhoneNumber();
                })
                : showVoid,
          ],
        )

    );
  }


  //*------Student Phone Information Section end ------*

// Method to add a new email to the contact information list
  void _addEmail() {
    setState(() {
      _emailDetailsList.add(EmailDetail(
        emailTypeController: TextEditingController(),
        emailIdController: TextEditingController(),
        prefferd: false,
        existing: false,
        emailTypeFocusNode: FocusNode(),
        emailIdFocusNode: FocusNode(),
        emailTypeError: null,
        emailIdError: null,
      ));
    });
  }

// Method to remove an email from the contact information list
  void _removeEmail(int index) {
    if (index >= 0 && index < _emailDetailsList.length) {
      // Check if index is valid
      setState(() {
        final emailDetail = _emailDetailsList[index];

        emailDetail.emailTypeController.dispose(); // Dispose controllers
        emailDetail.emailIdController.dispose();
        emailDetail.emailTypeFocusNode.dispose(); // Dispose focus nodes
        emailDetail.emailIdFocusNode.dispose();

        _emailDetailsList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); // Debugging print to show invalid index
    }
  }


  Widget _studentEmailInformationSection(
      {required GetPersonalDetailsViewModel provider,required langProvider}){
    return CustomInformationContainer(
        title: "Email Details",
        leading: SvgPicture.asset("assets/personal_details/email.svg"),
        expandedContent: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _emailDetailsList.length,
                itemBuilder: (context,index){
                  final email = _emailDetailsList[index];
                  return Column(
                    children: [
                      kFormHeight,
                      // phone Type
                      fieldHeading(
                          title: "Email Type",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormDropdown
                        (context:context,
                        readOnly: (index == 0),
                        filled: (index == 0),
                        controller: email.emailTypeController,
                        currentFocusNode: email.emailTypeFocusNode,
                        menuItemsList: _emailTypeMenuItemsList,
                        hintText: "Select Email Type",
                        errorText: email.emailTypeError,
                        onChanged: (value) {
                          email.emailTypeError = null;
                          setState(() {
                            // setting the value for email type
                            email.emailTypeController.text = value!;
                            Utils.requestFocus(focusNode: email.emailIdFocusNode, context: context);
                          });
                        },
                      ),
                      // ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: "Email Address",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormTextField(
                          currentFocusNode: email.emailIdFocusNode,
                          nextFocusNode: index < _emailDetailsList.length -1 ? email.emailTypeFocusNode : null,
                          controller: email.emailIdController,
                          hintText: "Enter Phone Number",
                          errorText: email.emailIdError,
                          onChanged: (value) {
                            // no validation has been provided
                            if (email.emailIdFocusNode.hasFocus) {
                              setState(() {
                                email.emailIdError = ErrorText.getEmailError(email: email.emailIdController.text, context: context);
                              });
                            }
                          }),



                      // ****************************************************************************************************************************************************
                      kFormHeight,
                      // Preferred
                      CustomGFCheckbox(value: email.prefferd, onChanged: (onChanged) {setState(() {email.prefferd = !email.prefferd;});},text: "Favorite Email"),

                      // ****************************************************************************************************************************************************

                      // space based on condition
                      (index == 0) ? kFormHeight : showVoid,

                      // Add More Information container
                      (_emailDetailsList.isNotEmpty && (index != 0)) ? addRemoveMoreSection(title: "Delete", add: false, onChanged: () {_removeEmail(index);}) : showVoid,

                      const MyDivider(color: AppColors.lightGrey),
                      // ****************************************************************************************************************************************************

                      // space based on if not last item
                      index != _phoneNumberDetailsList.length - 1 ? kFormHeight : showVoid,

                    ],
                  );
                }),
            // Add more Phones Numbers
            // Add More Information container
            _phoneNumberDetailsList.isNotEmpty
                ? addRemoveMoreSection(
                title: "Add Email",
                add: true,
                onChanged: () {
                  _addEmail();
                })
                : showVoid,
          ],
        )
    );
  }

  Widget _submitAndBackButton({required langProvider,UserInfo? userInfo,GetPersonalDetailsViewModel? provider}){
    return Column(
      children: [
        kFormHeight,
        kFormHeight,

        ChangeNotifierProvider(create: (context)=>UpdatePersonalDetailsViewModel(),
        child: Consumer<UpdatePersonalDetailsViewModel>(builder: (context,updateProvider,_){
          return CustomButton(buttonName: "Update", isLoading: updateProvider?.apiResponse.status == Status.LOADING,borderColor: Colors.transparent,buttonColor: AppColors.scoThemeColor, textDirection: getTextDirection(langProvider),
              onTap: ()async{
            bool result =  validateForm(langProvider: langProvider, userInfo: userInfo);
            if(result){
              // Create Form
              createForm(provider: provider);

              print(form);
              final result = await updateProvider.updatePersonalDetails(form: form);

            }
          });

        }),

        ),

        kFormHeight,
        CustomButton(buttonName: "Go Back", isLoading: false,borderColor: AppColors.scoThemeColor,buttonColor: Colors.white, textDirection: getTextDirection(langProvider),textColor: AppColors.scoThemeColor, onTap: ()async{}),
      ],
    );
  }


  // To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm({required langProvider,  UserInfo? userInfo}) {

    firstErrorFocusNode = null;

    if (_firstNameController.text.isEmpty || !Validations.isNameArabicEnglishValid(_firstNameController.text)) {
      setState(() {
        _firstNameError = "Please Enter first name";
        firstErrorFocusNode ??= _firstNameFocusNode;
      });
    }

    if (_familyNameController.text.isEmpty || !Validations.isNameArabicEnglishValid(_familyNameController.text)) {
      setState(() {
        _familyNameError = "Please Enter family name";
        firstErrorFocusNode ??= _familyNameFocusNode;
      });
    }
    if (_emailController.text.isEmpty || !Validations.isEmailValid(_emailController.text) ) {
      setState(() {
        _emailError = "Please Enter email address";
        firstErrorFocusNode ??= _firstNameFocusNode;
      });
    }
    if (_nationalityController.text.isEmpty) {
      setState(() {
        _nationalityError = "Please Select Nationality";
        firstErrorFocusNode ??= _nationalityFocusNode;
      });
    }
    if (_mobileNumberController.text.isEmpty || !Validations.isPhoneNumberValid(_mobileNumberController.text)) {
      setState(() {
        _mobileNumberError = "Please Enter correct mobile number";
        firstErrorFocusNode ??= _mobileNumberFocusNode;
      });
    }
    if (_genderController.text.isEmpty) {
      setState(() {
        _genderError = "Please Select Gender";
        firstErrorFocusNode ??= _genderFocusNode;
      });
    }

    if (_maritalStatusController.text.isEmpty) {
      setState(() {
        _maritalStatusError = "Please Select marital status";
        firstErrorFocusNode ??= _maritalStatusFocusNode;
      });
    }

    if (_dobController.text.isEmpty || !isEighteenYearsOld(_dobController.text)) {
      setState(() {
        _dobError = "Please Select Valid Date of Birth";
        firstErrorFocusNode ??= _dobFocusNode;
      });
    }

    if (_languageController.text.isEmpty) {
      setState(() {
        _languageError = "Please Select Preferred Language";
        firstErrorFocusNode ??= _languageFocusNode;
      });
    }


    // validate Phone Number
    if(userInfo?.phoneNumbers != null){
      for (int i = 0; i < _phoneNumberDetailsList.length; i++) {
        var element = _phoneNumberDetailsList[i];
        if (element.phoneTypeController.text.isEmpty) {
          setState(() {
            element.phoneTypeError = "Please Select Phone Type";
            firstErrorFocusNode ??= element.phoneTypeFocusNode;
          });
        }
        if (element.phoneNumberController.text.isEmpty || !Validations.isPhoneNumberValid(element.phoneNumberController.text)) {
          setState(() {
            element.phoneNumberError = "Please Enter Phone Number";
            firstErrorFocusNode ??= element.phoneNumberFocusNode;
          });
        }
      }
    }

    // validate Email Details
    if(userInfo?.emails != null){
      for (int i = 0; i < _emailDetailsList.length; i++) {
        var element = _emailDetailsList[i];
        if (element.emailTypeController.text.isEmpty) {
          setState(() {
            element.emailTypeError = "Please Enter Email Type";
            firstErrorFocusNode ??= element.emailTypeFocusNode;
          });
        }
        if (element.emailIdController.text.isEmpty) {
          setState(() {
            element.emailIdError = "Please Enter Email Type";
            firstErrorFocusNode ??= element.emailIdFocusNode;
          });
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

  Map<String,dynamic> form = {};

  void createForm( {GetPersonalDetailsViewModel? provider}) {
    final overAllInfo = provider?.apiResponse.data?.data;
    final user = provider?.apiResponse.data?.data?.user;
    final userInfo = provider?.apiResponse.data?.data?.userInfo;
    form = {
      "user": {
        "birthDate": _dobController.text,
        "companyId": user?.companyId,
        "emailAddress": _emailController.text,
        "emirateId": _emiratesIdController.text,
        "firstName": _firstNameController.text,
        "gender": _genderController.text,
        "lastName": _familyNameController.text,
        "middleName": _secondNameController.text,
        "middleName2": _thirdOrFourthNameController.text,
        "lockout": user?.lockout,
        "nationality": _nationalityController.text,
        "phoneNumber": user?.phoneNumber,
        "userId": user?.userId,
        "username": user?.username
      },
      "userInfo": {
        // Include emails if the list is not empty
        if (_emailDetailsList.isNotEmpty)
          "emails": _emailDetailsList.map((element) => element.toJson()).toList(),

        "emplId": userInfo?.emplId,
        "name": userInfo?.name,

        // Include phone numbers if the list is not empty
        if (_phoneNumberDetailsList.isNotEmpty)
          "phoneNumbers": _phoneNumberDetailsList.map((element) => element.toJson()).toList(),

        "ferpa": userInfo?.ferpa,
        "ftStudent": userInfo?.ftStudent,
        "gender": _genderController.text,
        "highestEduLevel": userInfo?.highestEduLevel,
        "maritalStatus": _maritalStatusController.text,
        "maritalStatusOn": userInfo?.maritalStatusOn
      },
      "userInfoType": overAllInfo?.userInfoType,
    };
  }

}
