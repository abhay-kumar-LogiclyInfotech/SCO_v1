import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/bottom_sheets/storage_or_camera_destination.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/kButtons/kReturnButton.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_profile_picture_viewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_urls.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/account/profile_with_camera_button.dart';
import '../../../resources/components/custom_checkbox_tile.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/date_picker_dialog.dart';
import '../../../resources/components/myDivider.dart';
import '../../../resources/input_formatters/emirates_id_input_formatter.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../viewModel/services/media_services.dart';
import '../../../viewModel/services/navigation_services.dart';

class EditPersonalDetailsView extends StatefulWidget {
  const EditPersonalDetailsView({super.key});

  @override
  State<EditPersonalDetailsView> createState() =>
      _EditPersonalDetailsViewState();
}

class _EditPersonalDetailsViewState extends State<EditPersonalDetailsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late AlertServices _alertServices;
  late MediaServices _mediaServices;

  List<DropdownMenuItem> _nationalityMenuItemsList = [];
  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _maritalStatusMenuItemsList = [];
  List<DropdownMenuItem> _phoneNumberTypeMenuItemsList = [];
  List<DropdownMenuItem> _emailTypeMenuItemsList = [];

  final List<PhoneNumber> _phoneNumberDetailsList = [];
  final List<EmailDetail> _emailDetailsList = [];

  Future _initializeData() async {
    /// fetch student profile Information t prefill the user information
    // fetch student profile Information t prefill the user information
    final studentProfileProvider =
        Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final studentProfilePictureProvider =
        Provider.of<GetProfilePictureUrlViewModel>(context, listen: false);

    await Future.wait<dynamic>([
      studentProfileProvider.getPersonalDetails(),
      studentProfilePictureProvider.getProfilePictureUrl()
    ]);

    // /// Fetching the Profile picture.....
    // if (studentProfilePictureProvider.apiResponse.status == Status.COMPLETED) {
    //   setState(() {
    //     _profilePictureUrl = studentProfilePictureProvider.apiResponse.data?.url?.toString() ?? '';
    //   });
    // }
    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);

    /// Check and populate dropdowns only if the values exist
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

    if (Constants.lovCodeMap['PHONE_TYPE']?.values != null) {
      _phoneNumberTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['PHONE_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    if (Constants.lovCodeMap['EMAIL_TYPE']?.values != null) {
      _emailTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['EMAIL_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    /// *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

    /// prefill the values of the fields
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

    /// _languageController.text = user?.language ?? '';

    /// initialize phone numbers
    if (userInfo?.phoneNumbers != null) {
      _phoneNumberDetailsList.clear();
      for (var element in userInfo!.phoneNumbers!) {
        _phoneNumberDetailsList.add(PhoneNumber.fromJson(element.toJson()));
      }
    }

    /// initialize Email Details
    if (userInfo?.emails != null) {
      _emailDetailsList.clear();
      for (var element in userInfo!.emails!) {
        _emailDetailsList.add(EmailDetail.fromJson(element.toJson()));
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _alertServices = getIt.get<AlertServices>();
      _mediaServices = getIt.get<MediaServices>();
      await _initializeData();
    });
    super.initState();
  }

  bool _isProcessing = false;

  setIsProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  File? _profileImageFile;

  setProfilePictureFile(File? file) async {
    if (file != null) {
      try {
        /// close the choose option sheet
        _navigationServices.goBack();

        setIsProcessing(true);

        bool canUpload = await Utils.compareFileSize(file: file, maxSizeInBytes: 200);

        if (canUpload) {
          _profileImageFile = file;
          final myFile = await Utils.saveFileToLocal(file);
          final base64String = base64Encode(myFile.readAsBytesSync());

          final updateProfilePictureProvider = Provider.of<UpdateProfilePictureViewModel>(context, listen: false);
          await updateProfilePictureProvider.updateProfilePicture(base64String: base64String);
          setIsProcessing(false);
          await _initializeData();
          setState(() {});
          setIsProcessing(false);
        } else {
          _alertServices.showCustomSnackBar("File Size must be under 200KB");
          setIsProcessing(false);
        }
      } catch (e) {
        log("Error converting file to Base64: $e");
      }
    } else {
      log("No file provided.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomSimpleAppBar(
        titleAsString: localization.personalDetails,
      ),
      body:
          Utils.modelProgressHud(processing: _isProcessing, child: _buildUi()),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Consumer<GetPersonalDetailsViewModel>(
        builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator(context: context);

        case Status.ERROR:
          return Center(
            child: Text(
              AppLocalizations.of(context)!.somethingWentWrong,
            ),
          );
        case Status.COMPLETED:
          final userInfo = provider.apiResponse.data?.data?.userInfo;

          return Directionality(
            textDirection: getTextDirection(
              langProvider,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<GetProfilePictureUrlViewModel>(
                        builder: (context, provider, _) {
                      return ProfileWithCameraButton(
                          profileImage: _profileImageFile != null
                              ? FileImage(_profileImageFile!)
                              : provider.apiResponse.data?.data?.url != null ? NetworkImage(AppUrls.domainUrl + provider.apiResponse.data!.data!.url!.toString()) : const AssetImage('assets/personal_details/Picture.png'),
                          onTap: () async {
                            Destination.chooseFilePickerDestination(
                                context: context,
                                onCameraTap: () async {
                                  // bool cameraPermission =
                                  //     await _permissionServices
                                  //         .checkAndRequestPermission(
                                  //             Permission.camera, context);
                                  if (true) {
                                    File? file = await _mediaServices.getSingleImageFromCamera();setProfilePictureFile(file);
                                  }
                                },
                                onStorageTap: () async {
                                  // bool storagePermission =
                                  //     await _permissionServices
                                  //         .checkAndRequestPermission(
                                  //             Platform.isAndroid
                                  //                 ? Permission
                                  //                     .manageExternalStorage
                                  //                 : Permission.storage,
                                  //             context);
                                  if (true) {
                                    File? file = await _mediaServices.getSingleImageFromGallery();setProfilePictureFile(file);
                                  }
                                });
                          },
                          onLongPress: () {});
                    }),

                    /// ProfilePicture(),
                    kFormHeight,

                    /// Student common information
                    _studentInformationSection(
                        provider: provider,
                        langProvider: langProvider,
                        localization: localization),

                    /// student contact information
                    if (userInfo?.phoneNumbers != null)
                      Column(
                        children: [
                          kFormHeight,
                          kFormHeight,
                          _studentPhoneInformationSection(
                              provider: provider,
                              langProvider: langProvider,
                              localization: localization),
                        ],
                      ),

                    /// student email contact information
                    if (userInfo?.emails != null)
                      Column(
                        children: [
                          kFormHeight,
                          kFormHeight,
                          _studentEmailInformationSection(
                              provider: provider,
                              langProvider: langProvider,
                              localization: localization),
                        ],
                      ),

                    /// submit buttons
                    _submitAndBackButton(
                        langProvider: langProvider,
                        userInfo: userInfo,
                        provider: provider,
                        localization: localization),
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

  ///*------Student Information Section------*

  /// FocusNodes
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

  /// TextEditingControllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _thirdOrFourthNameController =
      TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _emiratesIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  /// Error texts
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

  Widget _studentInformationSection(
      {required GetPersonalDetailsViewModel provider,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    final studentProfileProvider =
        Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final userInfoType =
        studentProfileProvider.apiResponse.data?.data?.userInfoType;

    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';

    return CustomInformationContainer(
        title: localization.studentInformation,
        leading:
            SvgPicture.asset("assets/personal_details/student_information.svg"),
        expandedContent: Column(
          children: [
            /// First name
            fieldHeading(
              title: localization.registrationFirstName,
              important: true,
              langProvider: langProvider,
            ),
            scholarshipFormTextField(
                readOnly: peopleSoft,
                filled: peopleSoft,
                currentFocusNode: _firstNameFocusNode,
                nextFocusNode: _secondNameFocusNode,
                controller: _firstNameController,
                hintText: localization.registrationFirstNameWatermark,
                errorText: _firstNameError,
                onChanged: (value) {
                  if (_firstNameFocusNode.hasFocus) {
                    setState(() {
                      _firstNameError =
                          ErrorText.getNameArabicEnglishValidationError(
                              name: _firstNameController.text,
                              context: context);
                    });
                  }
                }),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.registrationMiddleName,
              important: false,
              langProvider: langProvider,
            ),
            scholarshipFormTextField(
                readOnly: peopleSoft,
                filled: peopleSoft,
                currentFocusNode: _secondNameFocusNode,
                nextFocusNode: _thirdOrFourthNameFocusNode,
                controller: _secondNameController,
                hintText: localization.registrationMiddleNameWatermark,
                errorText: _secondNameError,
                onChanged: (value) {
                  if (_secondNameFocusNode.hasFocus) {
                    setState(() {
                      _secondNameError =
                          ErrorText.getNameArabicEnglishValidationError(
                              name: _secondNameController.text,
                              context: context);
                    });
                  }
                }),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.thirdFourthName,
              important: false,
              langProvider: langProvider,
            ),
            scholarshipFormTextField(
                readOnly: peopleSoft,
                filled: peopleSoft,
                currentFocusNode: _thirdOrFourthNameFocusNode,
                nextFocusNode: _familyNameFocusNode,
                controller: _thirdOrFourthNameController,
                hintText: localization.registrationThirdNameWatermark,
                errorText: _thirdOrFourthNameError,
                onChanged: (value) {
                  if (_thirdOrFourthNameFocusNode.hasFocus) {
                    setState(() {
                      _thirdOrFourthNameError =
                          ErrorText.getNameArabicEnglishValidationError(
                              name: _thirdOrFourthNameController.text,
                              context: context);
                    });
                  }
                }),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.registrationLastName,
              important: true,
              langProvider: langProvider,
            ),
            scholarshipFormTextField(
                readOnly: peopleSoft,
                filled: peopleSoft,
                currentFocusNode: _familyNameFocusNode,
                nextFocusNode: _emailFocusNode,
                controller: _familyNameController,
                hintText: localization.registrationLastNameWatermark,
                errorText: _familyNameError,
                onChanged: (value) {
                  if (_familyNameFocusNode.hasFocus) {
                    setState(() {
                      _familyNameError =
                          ErrorText.getNameArabicEnglishValidationError(
                              name: _familyNameController.text,
                              context: context);
                    });
                  }
                }),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.emiratesId,
              important: false,
              langProvider: langProvider,
            ),
            scholarshipFormTextField(
                readOnly: true,
                filled: true,
                currentFocusNode: _emiratesIdFocusNode,
                nextFocusNode: _emailFocusNode,
                controller: _emiratesIdController,
                hintText: localization.emiratesIdWatermark,
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
                }),

            /// ****************************************************************
            if (lifeRay)
              Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                    title: localization.emailAddress,
                    important: true,
                    langProvider: langProvider,
                  ),
                  scholarshipFormTextField(
                      currentFocusNode: _emailFocusNode,
                      nextFocusNode: _nationalityFocusNode,
                      controller: _emailController,
                      hintText: localization.emailAddressWatermark,
                      textInputType: TextInputType.emailAddress,
                      errorText: _emailError,
                      onChanged: (value) {
                        if (_emailFocusNode.hasFocus) {
                          setState(() {
                            _emailError = ErrorText.getEmailError(
                                email: _emailController.text, context: context);
                          });
                        }
                      })
                ],
              ),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.country,
              important: true,
              langProvider: langProvider,
            ),
            scholarshipFormDropdown(
                currentFocusNode: _nationalityFocusNode,
                controller: _nationalityController,
                menuItemsList: _nationalityMenuItemsList,
                hintText: localization.countryWatermark,
                errorText: _nationalityError,
                onChanged: (value) {
                  setState(() {
                    _nationalityError = null;
                    _nationalityController.text = value;
                    Utils.requestFocus(
                        focusNode: _mobileNumberFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            if (lifeRay)
              Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                    title: localization.phoneNo,
                    important: true,
                    langProvider: langProvider,
                  ),
                  scholarshipFormTextField(
                      currentFocusNode: _mobileNumberFocusNode,
                      nextFocusNode: _genderFocusNode,
                      controller: _mobileNumberController,
                      hintText: localization.registrationMobileNumberWatermark,
                      textInputType: TextInputType.phone,
                      errorText: _mobileNumberError,
                      onChanged: (value) {
                        if (_mobileNumberFocusNode.hasFocus) {
                          setState(() {
                            _mobileNumberError = ErrorText.getPhoneNumberError(
                                phoneNumber: _mobileNumberController.text,
                                context: context);
                          });
                        }
                      }),
                ],
              ),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.gender,
              important: true,
              langProvider: langProvider,
            ),
            scholarshipFormDropdown(
                currentFocusNode: _genderFocusNode,
                controller: _genderController,
                menuItemsList: _genderMenuItemsList,
                hintText: localization.genderWatermark,
                errorText: _genderError,
                onChanged: (value) {
                  setState(() {
                    _genderError = null;
                    _genderController.text = value;
                    Utils.requestFocus(
                        focusNode: _maritalStatusFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            if (peopleSoft)
              Column(
                children: [
                  kFormHeight,
                  fieldHeading(
                    title: localization.maritalStatus,
                    important: true,
                    langProvider: langProvider,
                  ),
                  scholarshipFormDropdown(
                      currentFocusNode: _maritalStatusFocusNode,
                      controller: _maritalStatusController,
                      menuItemsList: _maritalStatusMenuItemsList,
                      hintText: localization.maritalStatusWatermark,
                      errorText: _maritalStatusError,
                      onChanged: (value) {
                        setState(() {
                          _maritalStatusError = null;
                          _maritalStatusController.text = value;
                          Utils.requestFocus(
                              focusNode: _dobFocusNode, context: context);
                        });
                      },
                      context: context),
                ],
              ),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(
              title: localization.brithDate,
              important: true,
              langProvider: langProvider,
            ),
            scholarshipFormDateField(
                currentFocusNode: _dobFocusNode,
                controller: _dobController,
                hintText: localization.brithDateWatermark,
                errorText: _dobError,
                onChanged: (value) {
                  setState(() {
                    _dobError = null;
                    Utils.requestFocus(
                        focusNode: _languageFocusNode, context: context);
                  });
                },
                onTap: () async {
                  _dobError = null;
                  final date = await myDatePickerDialog(context);
                  _dobController.text = formatDateOnly(date.toString());

                  /// To format and get the date only
                }),

            /// ****************************************************************
            false
                ? Column(
                    children: [
                      kFormHeight,
                      fieldHeading(
                        title: "Default Interface Language",
                        important: true,
                        langProvider: langProvider,
                      ),
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
                    ],
                  )
                : showVoid,

            /// ****************************************************************
            kFormHeight
          ],
        ));
  }

  ///*------Student Phone Information Section start ------*
  /// Method to add a new phone number to the contact information list
  void _addPhoneNumber() {
    setState(() {
      _phoneNumberDetailsList.add(PhoneNumber(
          countryCodeController: TextEditingController(),
          phoneNumberController: TextEditingController(),
          phoneTypeController: TextEditingController(),
          preferred: false,
          isExisting: false,
          countryCodeFocusNode: FocusNode(),
          phoneNumberFocusNode: FocusNode(),
          phoneTypeFocusNode: FocusNode(),
          phoneNumberError: null,
          phoneTypeError: null,
          countryCodeError: null));
    });
  }

  /// Method to add a new phone number to the contact information list
  void _removePhoneNumber(int index) {
    if (index >= 2 && index < _phoneNumberDetailsList.length) {
      /// Check if index is valid
      setState(() {
        final phoneNumber = _phoneNumberDetailsList[index];

        phoneNumber.countryCodeController.dispose();

        /// Dispose the controllers
        phoneNumber.phoneNumberController.dispose();
        phoneNumber.phoneTypeController.dispose();
        phoneNumber.preferred = false;
        phoneNumber.countryCodeFocusNode.dispose();

        /// Dispose the controllers
        phoneNumber.phoneNumberFocusNode.dispose();
        phoneNumber.phoneTypeFocusNode.dispose();
        _phoneNumberDetailsList.removeAt(index);
      });
    } else {
      // print("Invalid index: $index");

      /// Debugging print to show invalid index
    }
  }

  Widget _studentPhoneInformationSection(
      {required GetPersonalDetailsViewModel provider,
      required langProvider,
      required AppLocalizations localization}) {
    return CustomInformationContainer(
        title: localization.contactInformation,
        leading: SvgPicture.asset("assets/personal_details/phone_details.svg"),
        expandedContent: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _phoneNumberDetailsList.length,
                itemBuilder: (context, index) {
                  final phoneNumber = _phoneNumberDetailsList[index];
                  return Column(
                    children: [
                      /// phone Type
                      fieldHeading(
                        title: localization.submissionPhoneType,
                        important: true,
                        langProvider: langProvider,
                      ),
                      scholarshipFormDropdown(
                        context: context,
                        readOnly: phoneNumber.isExisting,
                        filled: true,
                        fillColor: phoneNumber.isExisting ? AppColors.lightGrey : Colors.white,
                        controller: phoneNumber.phoneTypeController,
                        currentFocusNode: phoneNumber.phoneTypeFocusNode,
                        menuItemsList: _phoneNumberTypeMenuItemsList,
                        hintText: localization.select,
                        errorText: phoneNumber.phoneTypeError,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber.phoneTypeError = null;

                            final isDuplicate =
                                _phoneNumberDetailsList.any((element) {
                              return element != phoneNumber &&
                                  element.phoneTypeController.text == value;
                            });

                            if (isDuplicate) {
                              phoneNumber.phoneTypeError =
                                  "Phone Type already exists";
                            } else {
                              /// setting the value for relation type
                              phoneNumber.phoneTypeController.text = value!;

                              ///This thing is creating error: don't know how to fix it:
                              Utils.requestFocus(
                                  focusNode: phoneNumber.phoneNumberFocusNode,
                                  context: context);
                            }
                          });
                        },
                      ),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                        title: localization.studentMobileNumber,
                        important: true,
                        langProvider: langProvider,
                      ),
                      scholarshipFormTextField(
                          currentFocusNode: phoneNumber.phoneNumberFocusNode,
                          nextFocusNode: phoneNumber.countryCodeFocusNode,
                          controller: phoneNumber.phoneNumberController,
                          hintText:
                              localization.registrationMobileNumberWatermark,
                          errorText: phoneNumber.phoneNumberError,
                          onChanged: (value) {
                            /// no validation has been provided
                            if (phoneNumber.phoneNumberFocusNode.hasFocus) {
                              setState(() {
                                final isDuplicate =
                                    _phoneNumberDetailsList.any((element) {
                                  return element != phoneNumber &&
                                      element.phoneNumberController.text ==
                                          value;
                                });
                                if (isDuplicate) {
                                  phoneNumber.phoneNumberError =
                                      "Phone Number already exists";
                                } else {
                                  phoneNumber.phoneNumberController.text =
                                      value!;
                                  phoneNumber.phoneNumberError =
                                      ErrorText.getPhoneNumberError(
                                          phoneNumber: phoneNumber
                                              .phoneNumberController.text,
                                          context: context);
                                }
                              });
                            }
                          }),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                        title: localization.countryCode,
                        important: false,
                        langProvider: langProvider,
                      ),
                      scholarshipFormTextField(
                          currentFocusNode: phoneNumber.countryCodeFocusNode,
                          nextFocusNode:
                              index < _phoneNumberDetailsList.length - 1
                                  ? _phoneNumberDetailsList[index + 1]
                                      .phoneTypeFocusNode
                                  : null,
                          controller: phoneNumber.countryCodeController,
                          hintText: localization.submissionCountryCode,
                          errorText: phoneNumber.countryCodeError,
                          onChanged: (value) {
                            /// no validation has been provided
                            if (phoneNumber.countryCodeFocusNode.hasFocus) {
                              setState(() {
                                phoneNumber.countryCodeError =
                                    ErrorText.getEmptyFieldError(
                                        name: phoneNumber
                                            .countryCodeController.text,
                                        context: context);
                              });
                            }
                          }),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,

                      /// Preferred
                      CustomGFCheckbox(
                          value: phoneNumber.preferred,
                          onChanged: (onChanged) {
                            setState(() {
                              // setting all as false
                              for (var ele in _phoneNumberDetailsList) {
                                ele.preferred = false;
                              }
                              // setting new as selected
                              phoneNumber.preferred = true;
                            });
                          },
                          text: localization.submissionPreferred),

                      /// ****************************************************************************************************************************************************

                      /// space based on condition
                      phoneNumber.isExisting ? kFormHeight : showVoid,

                      /// Add More Information container
                      (_phoneNumberDetailsList.isNotEmpty &&
                              !phoneNumber.isExisting)
                          ? addRemoveMoreSection(
                              title: localization.deleteRowPhone,
                              add: false,
                              onChanged: () {
                                _removePhoneNumber(index);
                              })
                          : showVoid,

                      const MyDivider(color: AppColors.lightGrey),

                      /// ****************************************************************************************************************************************************

                      /// space based on if not last item
                      index != _phoneNumberDetailsList.length - 1
                          ? kFormHeight
                          : showVoid,
                    ],
                  );
                }),

            /// Add more Phones Numbers
            _phoneNumberDetailsList.isNotEmpty
                ? addRemoveMoreSection(
                    title: localization.addRowPhone,
                    add: true,
                    onChanged: () {
                      _addPhoneNumber();
                    })
                : showVoid,
          ],
        ));
  }

  ///*------Student Phone Information Section end ------*

  /// Method to add a new email to the contact information list
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

  /// Method to remove an email from the contact information list
  void _removeEmail(int index) {
    if (index >= 0 && index < _emailDetailsList.length) {
      /// Check if index is valid
      setState(() {
        final emailDetail = _emailDetailsList[index];

        emailDetail.emailTypeController.dispose();

        /// Dispose controllers
        emailDetail.emailIdController.dispose();
        emailDetail.emailTypeFocusNode.dispose();

        /// Dispose focus nodes
        emailDetail.emailIdFocusNode.dispose();

        _emailDetailsList.removeAt(index);
      });
    } else {
      // print("Invalid index: $index");

      /// Debugging print to show invalid index
    }
  }

  Widget _studentEmailInformationSection(
      {required GetPersonalDetailsViewModel provider,
      required langProvider,
      required AppLocalizations localization}) {
    return CustomInformationContainer(
        title: localization.emailInformation,
        leading: SvgPicture.asset("assets/personal_details/email.svg"),
        expandedContent: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _emailDetailsList.length,
                itemBuilder: (context, index) {
                  final email = _emailDetailsList[index];
                  return Column(
                    children: [
                      kFormHeight,

                      /// phone Type
                      fieldHeading(
                        title: localization.emailType,
                        important: true,
                        langProvider: langProvider,
                      ),
                      scholarshipFormDropdown(
                        context: context,
                        readOnly: email.existing,
                        filled: true,
                        fillColor: email.existing ? AppColors.lightGrey : Colors.white,
                        controller: email.emailTypeController,
                        currentFocusNode: email.emailTypeFocusNode,
                        menuItemsList: _emailTypeMenuItemsList,
                        hintText: localization.select,
                        errorText: email.emailTypeError,
                        onChanged: (value) {
                          setState(() {
                            // Reset the error state
                            email.emailTypeError = null;

                            // Check if the selected email type is already used in the list
                            bool isDuplicate = _emailDetailsList.any(
                                (element) =>
                                    element != email &&
                                    element.emailTypeController.text == value);

                            if (isDuplicate) {
                              // Display an error if the email type is already selected
                              email.emailTypeError =
                                  "Email Type already selected";
                            } else {
                              // Update the email type and request focus for the next field
                              email.emailTypeController.text = value!;
                              Utils.requestFocus(
                                  focusNode: email.emailIdFocusNode,
                                  context: context);
                            }
                          });
                        },
                      ),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                        title: localization.emailAddress,
                        important: true,
                        langProvider: langProvider,
                      ),
                      scholarshipFormTextField(
                        currentFocusNode: email.emailIdFocusNode,
                        nextFocusNode: index < _emailDetailsList.length - 1
                            ? email.emailTypeFocusNode
                            : null,
                        controller: email.emailIdController,
                        hintText: localization.emailAddressWatermark,
                        errorText: email.emailIdError,
                        onChanged: (value) {
                          setState(() {
                            // Reset the error state
                            email.emailIdError = null;

                            // Check if the entered email ID is already used in the list
                            bool isDuplicate = _emailDetailsList.any(
                                (element) =>
                                    element != email &&
                                    element.emailIdController.text == value);

                            if (isDuplicate) {
                              // Display an error if the email ID is already in use
                              email.emailIdError =
                                  localization.emailAddressExists;
                            } else {
                              // Validate the email format only if no duplicates are found
                              email.emailIdController.text = value!.trim();
                              email.emailIdError = ErrorText.getEmailError(
                                email: value!,
                                context: context,
                              );
                            }
                          });
                        },
                      ),

                      /// ****************************************************************************************************************************************************
                      kSmallSpace,

                      /// Preferred
                      CustomGFCheckbox(
                          value: email.prefferd,
                          onChanged: (onChanged) {
                            setState(() {
                              for (var ele in _emailDetailsList) {
                                ele.prefferd = false;
                              }
                              email.prefferd = true;
                            });
                          },
                          text: localization.submissionPreferred),

                      /// ****************************************************************************************************************************************************

                      /// space based on condition
                      email.existing ? kFormHeight : showVoid,

                      /// Add More Information container
                      (_emailDetailsList.isNotEmpty &&
                              (index != 0) &&
                              !email.existing)
                          ? addRemoveMoreSection(
                              title: localization.deleteRow,
                              add: false,
                              onChanged: () {
                                _removeEmail(index);
                              })
                          : showVoid,

                      const MyDivider(color: AppColors.lightGrey),

                      /// ****************************************************************************************************************************************************

                      /// space based on if not last item
                      index != _phoneNumberDetailsList.length - 1
                          ? kFormHeight
                          : showVoid,
                    ],
                  );
                }),

            /// Add more Phones Numbers
            /// Add More Information container
            _phoneNumberDetailsList.isNotEmpty
                ? addRemoveMoreSection(
                    title: localization.addEmail,
                    add: true,
                    onChanged: () {
                      _addEmail();
                    })
                : showVoid,
          ],
        ));
  }

  Widget _submitAndBackButton(
      {required langProvider,
      UserInfo? userInfo,
      GetPersonalDetailsViewModel? provider,
      required AppLocalizations localization}) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => UpdatePersonalDetailsViewModel(),
          child: Consumer<UpdatePersonalDetailsViewModel>(
              builder: (context, updateProvider, _) {
            return CustomButton(
                buttonName: localization.updateProfile,
                isLoading: updateProvider?.apiResponse.status == Status.LOADING,
                borderColor: Colors.transparent,
                // buttonColor: AppColors.scoThemeColor,
                textDirection: getTextDirection(
                  langProvider,
                ),
                onTap: () async {
                  bool result = validateForm(
                      langProvider: langProvider,
                      userInfo: userInfo,
                      localization: localization);
                  if (result) {
                    setIsProcessing(true);

                    /// Create Form
                    createForm(provider: provider);
                    bool upResult =
                        await updateProvider.updatePersonalDetails(form: form);
                    if (upResult) {
                      setIsProcessing(false);

                      /// update and refresh the information
                      await _initializeData();
                    }
                  }
                  setIsProcessing(false);
                });
          }),
        ),
        kFormHeight,
        const KReturnButton(),
      ],
    );
  }

  //// VALIDATION FUNCTION FOR THE FORM
  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm(
      {required langProvider,
      UserInfo? userInfo,
      required AppLocalizations localization}) {
    final studentProfileProvider =
        Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final user = studentProfileProvider.apiResponse.data?.data?.user;
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;
    final userInfoType =
        studentProfileProvider.apiResponse.data?.data?.userInfoType;
    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';

    firstErrorFocusNode = null;

    if (_firstNameController.text.isEmpty ||
        !Validations.isNameArabicEnglishValid(_firstNameController.text)) {
      setState(() {
        _firstNameError = localization.registrationFirstNameValidate;
        firstErrorFocusNode ??= _firstNameFocusNode;
      });
    }

    if (_familyNameController.text.isEmpty ||
        !Validations.isNameArabicEnglishValid(_familyNameController.text)) {
      setState(() {
        _familyNameError = localization.registrationLastNameValidate;
        firstErrorFocusNode ??= _familyNameFocusNode;
      });
    }
    if (lifeRay &&
        (_emailController.text.isEmpty ||
            !Validations.isEmailValid(_emailController.text))) {
      setState(() {
        _emailError = localization.emailAddressValidate;
        firstErrorFocusNode ??= _firstNameFocusNode;
      });
    }
    if (_nationalityController.text.isEmpty) {
      setState(() {
        _nationalityError = localization.countryValidate;
        firstErrorFocusNode ??= _nationalityFocusNode;
      });
    }
    if (lifeRay &&
        (_mobileNumberController.text.isEmpty ||
            !Validations.isPhoneNumberValid(_mobileNumberController.text))) {
      setState(() {
        _mobileNumberError = localization.registrationMobileNumberValidate;
        firstErrorFocusNode ??= _mobileNumberFocusNode;
      });
    }
    if (_genderController.text.isEmpty) {
      setState(() {
        _genderError = localization.genderValidate;
        firstErrorFocusNode ??= _genderFocusNode;
      });
    }

    if (_maritalStatusController.text.isEmpty && peopleSoft) {
      setState(() {
        _maritalStatusError = localization.maritalStatusValidate;
        firstErrorFocusNode ??= _maritalStatusFocusNode;
      });
    }

    if (_dobController.text.isEmpty ||
        !isFourteenYearsOld(_dobController.text)) {
      setState(() {
        _dobError = localization.brithDateValidate;
        firstErrorFocusNode ??= _dobFocusNode;
      });
    }

    // if (_languageController.text.isEmpty) {
    //   setState(() {
    //     _languageError = "Please Select Preferred Language";
    //     firstErrorFocusNode ??= _languageFocusNode;
    //   });
    // }

    /// validate Phone Number
    if (userInfo?.phoneNumbers != null) {
      for (int i = 0; i < _phoneNumberDetailsList.length; i++) {
        var element = _phoneNumberDetailsList[i];
        if (element.phoneTypeController.text.isEmpty ||
            element.phoneTypeError != null) {
          setState(() {
            element.phoneTypeError = localization.submissionPhoneTypeRequired;
            firstErrorFocusNode ??= element.phoneTypeFocusNode;
          });
        }
        if (element.phoneNumberController.text.isEmpty ||
            element.phoneNumberError != null ||
            !Validations.isPhoneNumberValid(
                element.phoneNumberController.text)) {
          setState(() {
            element.phoneNumberError =
                localization.registrationMobileNumberValidate;
            firstErrorFocusNode ??= element.phoneNumberFocusNode;
          });
        }
      }
    }

    /// validate Email Details
    if (userInfo?.emails != null) {
      for (int i = 0; i < _emailDetailsList.length; i++) {
        var element = _emailDetailsList[i];
        if (element.emailTypeController.text.isEmpty ||
            element.emailTypeError != null) {
          setState(() {
            element.emailTypeError = localization.emailTypeRequired;
            firstErrorFocusNode ??= element.emailTypeFocusNode;
          });
        }
        if (element.emailIdController.text.isEmpty ||
            element.emailIdError != null) {
          setState(() {
            element.emailIdError = localization.emailAddressValidate;
            firstErrorFocusNode ??= element.emailIdFocusNode;
          });
        }
      }
    }

    /// checking for fist error node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      return true;
    }
  }

  /// My Final Submission form
  Map<String, dynamic> form = {};

  void createForm({GetPersonalDetailsViewModel? provider}) {
    final studentProfileProvider =
        Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final user = studentProfileProvider.apiResponse.data?.data?.user;
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;
    final userInfoType =
        studentProfileProvider.apiResponse.data?.data?.userInfoType;
    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';

    form = {
      "userInfoType": userInfoType,
      if (peopleSoft)
        "userInfo": {
          "emplId": userInfo?.emplId ?? '',
          "name": userInfo?.name ?? '',
          "phoneNumbers": _phoneNumberDetailsList.isNotEmpty
              ? _phoneNumberDetailsList
                  .map((element) => element.toJson())
                  .toList()
              : [],
          "addresses": userInfo?.addresses ?? [],
          "scholarships": userInfo?.scholarships ?? '',
          "emails": _emailDetailsList.isNotEmpty
              ? _emailDetailsList.map((element) => element.toJson()).toList()
              : [],
          "gender": _genderController.text,
          "maritalStatus": _maritalStatusController.text,
          "maritalStatusOn": userInfo?.maritalStatusOn,
          "highestEduLevel": userInfo?.highestEduLevel,
          "ftStudent": userInfo?.ftStudent,
          "ferpa": userInfo?.ferpa,
          "languageId": '',
          "birthDate": _dobController.text
        },
      "user": {
        "userId": user?.userId,
        "firstName": _firstNameController.text,
        "lastName": _familyNameController.text,
        "middleName": _secondNameController.text,
        "middleName2": _thirdOrFourthNameController.text,
        "emailAddress": _emailController.text,
        "lockout": user?.lockout ?? false,
        "companyId": user?.companyId,
        "username": user?.username,
        "role": user?.role ?? '',
        "birthDate": _dobController.text,
        "gender": _genderController.text,
        "phoneNumber": user?.phoneNumber,
        "nationality": _nationalityController.text,
        "emirateId": _emiratesIdController.text.replaceAll('-', '').trim(),
        "uaePassUuid": user?.uaePassUuid ?? ''
      }
    };
    print(form);
  }
}
