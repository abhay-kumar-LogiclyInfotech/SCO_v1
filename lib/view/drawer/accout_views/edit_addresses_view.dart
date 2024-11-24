import 'dart:developer';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get_it/get_it.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
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

class EditAddressesView extends StatefulWidget {
  const EditAddressesView({super.key});

  @override
  State<EditAddressesView> createState() =>
      _EditAddressesViewState();
}

class _EditAddressesViewState extends State<EditAddressesView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;



  /// address list
  List<Address> _addressInformationList = [];  /// address type dropdown menu Item list
  List<DropdownMenuItem> _addressTypeMenuItemsList = [];
  List<DropdownMenuItem> _nationalityMenuItemsList = [];


  /// populate state dropdown menuItem List
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


  Future _initializeData() async {
    /// fetch student profile Information t prefill the user information
    final studentProfileProvider =
    Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    await studentProfileProvider.getPersonalDetails();

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
    if (Constants.lovCodeMap['ADDRESS_TYPE']?.values != null) {
      _addressTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['ADDRESS_TYPE']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    /// *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

    /// prefill the values of the fields
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;


    /// _languageController.text = user?.language ?? '';

    /// initialize the addresses
    if (userInfo?.addresses != null) {
      _addressInformationList.clear();
      for (int i = 0; i < userInfo!.addresses!.length; i++) {
        _addressInformationList.add(Address.fromJson(userInfo.addresses![i].toJson()));
        _populateStateDropdown(langProvider: langProvider, index: i);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();

      await _initializeData();
    });

    super.initState();
  }


  bool _isProcessing = false;
  setIsProcessing(bool value){
    setState(() {
      _isProcessing = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Edit Addresses",
      ),
      body: Utils.modelProgressHud(processing: _isProcessing,child:  _buildUi()),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
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
              final user = provider.apiResponse.data?.data?.user;
              final userInfo = provider.apiResponse.data?.data?.userInfo;

              return Directionality(
                textDirection: getTextDirection(langProvider),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.all(kPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        /// student contact information
                        if (userInfo?.addresses != null)
                          Column(
                            children: [
                              _addressInformationSection(provider: provider, langProvider: langProvider),
                              /// submit buttons
                              _submitAndBackButton(
                                  langProvider: langProvider,
                                  userInfo: userInfo,
                                  provider: provider),
                            ],
                          ),



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


  ///*------Student Phone Information Section start ------*
  /// add Address
  void _addAddress() {
    setState(() {
      _addressInformationList.add(Address(
          addressTypeController: TextEditingController(),
          addressLine1Controller: TextEditingController(),
          addressLine2Controller: TextEditingController(),
          /// Optional
          cityController: TextEditingController(),
          stateController: TextEditingController(),
          /// Optional
          postalCodeController: TextEditingController(),
          /// Optional
          countryController: TextEditingController(),
          addressTypeFocusNode: FocusNode(),
          addressLine1FocusNode: FocusNode(),
          addressLine2FocusNode: FocusNode(),
          /// Optional
          cityFocusNode: FocusNode(),
          stateFocusNode: FocusNode(),
          /// Optional
          postalCodeFocusNode: FocusNode(),
          /// Optional
          countryFocusNode: FocusNode(),
          countryDropdownMenuItems: _nationalityMenuItemsList,
          stateDropdownMenuItems: []));
    });
  }

  /// remove address
  void _removeAddress(int index) {
    if (index >= 1 && index < _addressInformationList.length) {
      setState(() {
        final addressInformation = _addressInformationList[index];

        /// Dispose controllers and focus nodes
        addressInformation.addressTypeController.dispose();
        addressInformation.addressLine1Controller.dispose();
        addressInformation.addressLine2Controller.dispose(); /// Optional
        addressInformation.cityController.dispose();
        addressInformation.stateController.dispose(); /// Optional
        addressInformation.postalCodeController.dispose(); /// Optional
        addressInformation.countryController.dispose();

        addressInformation.addressTypeFocusNode.dispose();
        addressInformation.addressLine1FocusNode.dispose();
        addressInformation.addressLine2FocusNode.dispose(); /// Optional
        addressInformation.cityFocusNode.dispose();
        addressInformation.stateFocusNode.dispose(); /// Optional
        addressInformation.postalCodeFocusNode.dispose(); /// Optional
        addressInformation.countryFocusNode.dispose();

        addressInformation.countryDropdownMenuItems?.clear();
        addressInformation.stateDropdownMenuItems?.clear();

        /// Remove the address entry from the list
        _addressInformationList.removeAt(index);
      });
    } else {
      print("Invalid index: $index"); /// For debugging invalid index
    }
  }

  Widget _addressInformationSection({required provider,required langProvider}) {
    /// defining langProvider
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
              return Padding(
                padding:  EdgeInsets.only(bottom: kPadding),
                child: SimpleCard(
                  expandedContent: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// phone Type
                      fieldHeading(
                          title: "Address Type",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormDropdown(
                        readOnly: addressInformation.isExisting,
                        filled: addressInformation.isExisting,
                        context:context,
                        controller: addressInformation.addressTypeController,
                        currentFocusNode: addressInformation.addressTypeFocusNode,
                        menuItemsList: _addressTypeMenuItemsList,
                        hintText: "Select Address Type",
                        errorText: addressInformation.addressTypeError,
                        onChanged: (value) {
                          setState(() {
                            addressInformation.addressTypeError = null;

                            final bool isDuplicate = _addressInformationList.any((element){
                             return addressInformation != element && element.addressTypeController.text == value;
                            });

                            if(isDuplicate){
                              addressInformation.addressTypeError = "Address Type already exists";
                            }


                            /// setting the value for address type
                            addressInformation.addressTypeController.text = value!;
                            ///This thing is creating error: don't know how to fix it:
                            Utils.requestFocus(
                                focusNode: addressInformation.addressLine1FocusNode,
                                context: context);
                          });
                        },
                      ),
                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: "Address Line 1",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormTextField(
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

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: "Address Line 2",
                          important: false,
                          langProvider: langProvider),
                      scholarshipFormTextField(
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

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      /// phone Type
                      fieldHeading(
                          title: "Country",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormDropdown(context:context,
                        controller: addressInformation.countryController,
                        currentFocusNode: addressInformation.countryFocusNode,
                        menuItemsList: _nationalityMenuItemsList,
                        hintText: "Select Country",
                        errorText: addressInformation.countryError,
                        onChanged: (value) {
                          addressInformation.countryError = null;
                          setState(() {
                            /// setting the value for address type
                            addressInformation.countryController.text = value!;

                            /// populating the state dropdown
                            addressInformation.stateDropdownMenuItems?.clear();
                            addressInformation.stateController.clear();
                            _populateStateDropdown(langProvider: langProvider, index: index);

                            addressInformation.disableState = addressInformation.stateDropdownMenuItems == null || addressInformation.stateDropdownMenuItems!.isEmpty;

                            ///This thing is creating error: don't know how to fix it:
                            Utils.requestFocus(focusNode: addressInformation.stateFocusNode, context: context);
                          });
                        },
                      ),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      /// phone Type
                      fieldHeading(
                          title: "Emirates/State",
                          important: addressInformation.stateDropdownMenuItems?.isNotEmpty ?? false,
                          langProvider: langProvider),
                      scholarshipFormDropdown(
                        readOnly: addressInformation.disableState || (addressInformation.stateDropdownMenuItems?.isEmpty ?? false || addressInformation.stateDropdownMenuItems == null),
                        filled: addressInformation.disableState || (addressInformation.stateDropdownMenuItems?.isEmpty ?? false || addressInformation.stateDropdownMenuItems == null),
                        context:context,
                        controller: addressInformation.stateController,
                        currentFocusNode: addressInformation.stateFocusNode,
                        menuItemsList: addressInformation.stateDropdownMenuItems,
                        hintText: "Select Emirates/State",
                        errorText: addressInformation.stateError,
                        onChanged: (value) {
                          addressInformation.stateError = null;
                          setState(() {
                            /// setting the value for address type
                            addressInformation.stateController.text = value!;
                            ///This thing is creating error: don't know how to fix it:
                            Utils.requestFocus(focusNode: addressInformation.cityFocusNode, context: context);
                          });
                        },
                      ),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: "City",
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormTextField(
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

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: "PO Box",
                          important: false,
                          langProvider: langProvider),
                      scholarshipFormTextField(
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

                      /// ****************************************************************************************************************************************************

                      /// space based on condition
                      addressInformation.isExisting ? kFormHeight : showVoid,

                      /// Add More Information container
                      (_addressInformationList.isNotEmpty && !addressInformation.isExisting)
                          ? addRemoveMoreSection(
                          title: "Delete Address",
                          add: false,
                          onChanged: () {
                            _removeAddress(index);
                          })
                          : showVoid,

                      /// light color divider
                    if(!addressInformation.isExisting)  const MyDivider(
                        color: AppColors.lightGrey,
                      ),
                      /// ****************************************************************************************************************************************************

                      /// space based on if not last item
                      index != _addressInformationList.length - 1
                          ? kFormHeight
                          : showVoid,
                    ],
                  ),
                ),
              );
            }),

        /// Add more Phones Numbers
        /// Add More Information container
        _addressInformationList.isNotEmpty
            ? addRemoveMoreSection(
            title: "Add Address",
            add: true,
            onChanged: () {
              _addAddress();
            })
            : showVoid,
      ],
    );
  }



  ///*------Student Phone Information Section end ------*

  Widget _submitAndBackButton(
      {required langProvider,
        UserInfo? userInfo,
        GetPersonalDetailsViewModel? provider}) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => UpdatePersonalDetailsViewModel(),
          child: Consumer<UpdatePersonalDetailsViewModel>(
              builder: (context, updateProvider, _) {
                return CustomButton(
                    buttonName: "Update",
                    isLoading: updateProvider?.apiResponse.status == Status.LOADING,
                    borderColor: Colors.transparent,
                    buttonColor: AppColors.scoThemeColor,
                    textDirection: getTextDirection(langProvider),
                    onTap: () async {
                      setIsProcessing(true);
                      bool result = validateForm(langProvider: langProvider, userInfo: userInfo);
                      if (result) {
                        /// Create Form
                        createForm(provider: provider);

                        log(form.toString());
                        bool result = await updateProvider.updatePersonalDetails(form: form);
                        if (result) {
                          /// update and refresh the information
                          await _initializeData();
                        }
                      }
                      setIsProcessing(false);

                    });
              }),
        ),
        kFormHeight,
        CustomButton(
            buttonName: "Go Back",
            isLoading: false,
            borderColor: AppColors.scoThemeColor,
            buttonColor: Colors.white,
            textDirection: getTextDirection(langProvider),
            textColor: AppColors.scoThemeColor,
            onTap: () async {
              _navigationServices.goBack();
            }),
      ],
    );
  }





  //// VALIDATION FUNCTION FOR THE FORM
  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;
  bool validateForm({required langProvider, UserInfo? userInfo}) {
    final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final user = studentProfileProvider.apiResponse.data?.data?.user;
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;
    final userInfoType =
        studentProfileProvider.apiResponse.data?.data?.userInfoType;
    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';

    firstErrorFocusNode = null;

    // / validate Phone Number
    if (userInfo?.addresses != null) {
      /// validate the Address information
      if (_addressInformationList.isNotEmpty) {
        for (var element in _addressInformationList) {

          if (element.addressTypeController.text.isEmpty || element.addressTypeError != null) {
            setState(() {
              element.addressTypeError = "Please Select Unique Address Type";
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

          /// if ( element.stateController.text.isEmpty && element.stateDropdownMenuItems?.isNotEmpty ?? false) {
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
    final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context, listen: false);
    final user = studentProfileProvider.apiResponse.data?.data?.user;
    final userInfo = studentProfileProvider.apiResponse.data?.data?.userInfo;
    final userInfoType = studentProfileProvider.apiResponse.data?.data?.userInfoType;
    bool lifeRay = userInfoType != null && userInfoType == 'LIFERAY';
    bool peopleSoft = userInfoType != null && userInfoType != 'LIFERAY';

    form = {
      "userInfoType": userInfoType,
      if(peopleSoft)"userInfo": {
        "emplId": userInfo?.emplId ?? '',
        "name": userInfo?.name ?? '',
        "phoneNumbers":  userInfo?.phoneNumbers?.map((element){return element.toJson();}).toList() ?? [],
        "addresses": _addressInformationList.map((element){return element.toJson();}).toList() ?? [],
        "scholarships": userInfo?.scholarships ?? '',
        "emails":  userInfo?.emails?.map((element){return element.toJson();}).toList() ?? [],
        "gender": userInfo?.gender,
        "maritalStatus": userInfo?.maritalStatus,
        "maritalStatusOn": userInfo?.maritalStatusOn,
        "highestEduLevel": userInfo?.highestEduLevel,
        "ftStudent": userInfo?.ftStudent,
        "ferpa": userInfo?.ferpa,
        "languageId": '',
        "birthDate": userInfo?.birthDate
      },
      "user": user?.toJson()
    };
  }
}