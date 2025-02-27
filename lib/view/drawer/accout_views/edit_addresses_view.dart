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
import 'package:sco_v1/resources/components/kButtons/kReturnButton.dart';
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
  final List<Address> _addressInformationList = [];  /// address type dropdown menu Item list
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
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: localization.editAddresses,
      ),
      body: Utils.modelProgressHud(processing: _isProcessing,child:  _buildUi(localization)),
    );
  }

  Widget _buildUi(AppLocalizations localization) {
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
                              _addressInformationSection(provider: provider, langProvider: langProvider,localization: localization),
                              /// submit buttons
                              _submitAndBackButton(
                                  langProvider: langProvider,
                                  userInfo: userInfo,
                                  provider: provider,
                              localization: localization),
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
      // print("Invalid index: $index"); /// For debugging invalid index
    }
  }

  Widget _addressInformationSection({required provider,required langProvider,required AppLocalizations localization}) {
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
                          title: localization.addressType,
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormDropdown(
                        readOnly: addressInformation.isExisting,
                        filled: addressInformation.isExisting,
                        context:context,
                        controller: addressInformation.addressTypeController,
                        currentFocusNode: addressInformation.addressTypeFocusNode,
                        menuItemsList: _addressTypeMenuItemsList,
                        hintText: localization.addressTypeWatermark,
                        errorText: addressInformation.addressTypeError,
                        onChanged: (value) {
                          setState(() {
                            addressInformation.addressTypeError = null;

                            final bool isDuplicate = _addressInformationList.any((element){
                             return addressInformation != element && element.addressTypeController.text == value;
                            });

                            if(isDuplicate){
                              addressInformation.addressTypeError = localization.duplicateAddresstypeMessage;
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
                          title: localization.addressLine1,
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormTextField(
                          currentFocusNode:
                          addressInformation.addressLine1FocusNode,
                          nextFocusNode: addressInformation.addressLine2FocusNode,
                          controller: addressInformation.addressLine1Controller,
                          hintText: localization.addressLine1Watermark,
                          errorText: addressInformation.addressLine1Error,
                          onChanged: (value) {
                            if (addressInformation.addressLine1FocusNode.hasFocus) {
                              setState(() {
                                addressInformation.addressLine1Error =
                                    ErrorText.getEmptyFieldError(
                                        name: addressInformation
                                            .addressLine1Controller.text,
                                        context: context);
                              });
                            }
                          }),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      fieldHeading(
                          title: localization.addressLine2,
                          important: false,
                          langProvider: langProvider),
                      scholarshipFormTextField(
                          currentFocusNode:
                          addressInformation.addressLine2FocusNode,
                          nextFocusNode: addressInformation.countryFocusNode,
                          controller: addressInformation.addressLine2Controller,
                          hintText: localization.addressLine2Watermark,
                          errorText: addressInformation.addressLine2Error,
                          onChanged: (value) {
                            if (addressInformation.addressLine2FocusNode.hasFocus) {
                              setState(() {
                                // addressInformation.addressLine2Error =
                                //     ErrorText.get(
                                //         name: addressInformation
                                //             .addressLine2Controller.text,
                                //         context: context);
                              });
                            }
                          }),

                      /// ****************************************************************************************************************************************************
                      kFormHeight,
                      /// phone Type
                      fieldHeading(
                          title: localization.country,
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormDropdown(context:context,
                        controller: addressInformation.countryController,
                        currentFocusNode: addressInformation.countryFocusNode,
                        menuItemsList: _nationalityMenuItemsList,
                        hintText: localization.select,
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
                          title: localization.emirates,
                          important: addressInformation.stateDropdownMenuItems?.isNotEmpty ?? false,
                          langProvider: langProvider),
                      scholarshipFormDropdown(
                        readOnly: addressInformation.disableState || (addressInformation.stateDropdownMenuItems?.isEmpty ?? false || addressInformation.stateDropdownMenuItems == null),
                        filled: addressInformation.disableState || (addressInformation.stateDropdownMenuItems?.isEmpty ?? false || addressInformation.stateDropdownMenuItems == null),
                        context:context,
                        controller: addressInformation.stateController,
                        currentFocusNode: addressInformation.stateFocusNode,
                        menuItemsList: addressInformation.stateDropdownMenuItems,
                        hintText: localization.emiratesWatermark,
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
                          title: localization.city,
                          important: true,
                          langProvider: langProvider),
                      scholarshipFormTextField(
                          currentFocusNode: addressInformation.cityFocusNode,
                          nextFocusNode: addressInformation.postalCodeFocusNode,
                          controller: addressInformation.cityController,
                          hintText: localization.cityWatermark,
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
                          title: localization.poBox,
                          important: false,
                          langProvider: langProvider),
                      scholarshipFormTextField(
                          currentFocusNode: addressInformation.postalCodeFocusNode,
                          controller: addressInformation.postalCodeController,
                          hintText: localization.poboxWatermark,
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
                          title: localization.deleteRowAddress,
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
            title: localization.addRowAddress,
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
                    buttonName: localization.update,
                    isLoading: updateProvider?.apiResponse.status == Status.LOADING,
                    borderColor: Colors.transparent,
                    // buttonColor: AppColors.scoThemeColor,
                    textDirection: getTextDirection(langProvider),
                    onTap: () async {
                      setIsProcessing(true);
                      bool result = validateForm(langProvider: langProvider, userInfo: userInfo,localization: localization);
                      if (result) {
                        /// Create Form
                        createForm(provider: provider);

                        log(form.toString());
                        bool result = await updateProvider.updatePersonalDetails(form: form);
                        if (result) {
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
  bool validateForm({required langProvider, UserInfo? userInfo,required AppLocalizations localization}) {
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
              element.addressTypeError = localization.duplicateAddresstypeMessage;
              firstErrorFocusNode ??= element.addressTypeFocusNode;
            });
          }

          if (element.addressLine1Controller.text.isEmpty || element.addressLine1Error != null) {
            setState(() {
              element.addressLine1Error = localization.addressLine1Validate;
              firstErrorFocusNode ??= element.addressLine1FocusNode;
            });
          }
          if (element.addressLine2Controller.text.isNotEmpty && element.addressLine2Error != null) {
            setState(() {
              element.addressLine2Error = localization.addressLine2Validate;
              firstErrorFocusNode ??= element.addressLine2FocusNode;
            });
          }

          if (element.countryController.text.isEmpty) {
            setState(() {
              element.countryError = localization.countryValidate;
              firstErrorFocusNode ??= element.countryFocusNode;
            });
          }

          /// if ( element.stateController.text.isEmpty && element.stateDropdownMenuItems?.isNotEmpty ?? false) {
          if ( element.stateController.text.isEmpty && (element.stateDropdownMenuItems?.isNotEmpty ?? false)) {

            setState(() {
              element.stateError = localization.emiratesValidate;
              firstErrorFocusNode ??= element.stateFocusNode;
            });
          }

          if (element.cityController.text.isEmpty || element.cityError != null) {
            setState(() {
              element.cityError = localization.cityValidate;
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
