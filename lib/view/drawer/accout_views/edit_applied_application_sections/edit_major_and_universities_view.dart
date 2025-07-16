import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/view/apply_scholarship/form_views/required_examinations_view.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/edit_application/edit_application_sections_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_button.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../resources/components/kButtons/kReturnButton.dart';
import '../../../../resources/validations_and_errorText.dart';
import '../../../../utils/constants.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import '../../../../viewModel/services/alert_services.dart';
import '../../../apply_scholarship/form_view_Utils.dart';

class EditMajorsAndUniversityView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  final String configurationKey;

  const EditMajorsAndUniversityView({super.key, required this.applicationStatusDetails,required this.configurationKey});

  @override
  State<EditMajorsAndUniversityView> createState() => _EditMajorsAndUniversityViewState();}

class _EditMajorsAndUniversityViewState
    extends State<EditMajorsAndUniversityView> with MediaQueryMixin{
  late AlertServices _alertServices;


  PsApplication? peopleSoftApplication;

  @override
  void initState() {

    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _refreshView();
    });

    super.initState();
  }

  _refreshView()async{
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);

      _universityPriorityList.clear();
      _majorsMenuItemsList.clear();
      _majorsWishlist.clear();
      _nationalityMenuItemsList.clear();


      isStudyCountry = widget.applicationStatusDetails.scholarshipType == 'INT';

      /// Check and populate dropdowns only if the values exist
      if (Constants.lovCodeMap['COUNTRY']?.values != null) {
        _nationalityMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }
      if (Constants.lovCodeMap['ACAD_PROG_PGRD']?.values != null) {
        _acadProgramPgrdMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['ACAD_PROG_PGRD']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }
      if (Constants.lovCodeMap['UNIVERSITY_STATUS']?.values != null) {
        _universityPriorityStatus = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['UNIVERSITY_STATUS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['ACAD_PROG_DDS']?.values != null) {
        _acadProgramDdsMenuItemsList = populateCommonDataDropdown(
            menuItemsList: Constants.lovCodeMap['ACAD_PROG_DDS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }
      _majorsMenuItemsList = getMajors();

      /// calling the getMajors method to populate the majors function


      /// Making api call to ps-application
      final psApplicationProvider = Provider.of<GetApplicationSectionViewModel>(
          context, listen: false);
      await psApplicationProvider.getApplicationSections(
          applicationNumber: widget.applicationStatusDetails
              .admApplicationNumber);

      if (psApplicationProvider.apiResponse.status == Status.COMPLETED &&
          psApplicationProvider.apiResponse.data?.data.psApplication
              .emplymentHistory != null) {

        /// setting peoplesoft application to get the full application
        peopleSoftApplication =
            psApplicationProvider.apiResponse.data?.data.psApplication;

        final majors = psApplicationProvider.apiResponse.data?.data
            .psApplication.majorWishList;
        final universityWishlist = psApplicationProvider.apiResponse.data?.data
            .psApplication.universtiesPriorityList;

        if (majors?.isNotEmpty ?? false) {
          // If it's a list, iterate through it
          for (int index = 0; index < majors!.length!; index++) {
            var element = majors[index];
            _majorsWishlist.add(element); // Add to the list
          }
        }
        if (universityWishlist?.isNotEmpty ?? false) {
          // If it's a list, iterate through it
          for (int index = 0; index < universityWishlist!.length!; index++) {
            var element = universityWishlist[index];
            _universityPriorityList.add(element); // Add to the list
          }
        }

        setState(() {});
      }
    });}

  List<DropdownMenuItem> _nationalityMenuItemsList = [];

  final List<MajorWishList> _majorsWishlist = [];



  bool _isProcessing = false;

  resetProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LanguageChangeViewModel langProvider = context.read<LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustomSimpleAppBar(
          titleAsString: localization.universityAndMajor,
        ),
        body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildUi()),
        ));
  }


  /// controllers, focus nodes and error text variables for Academic program
  final TextEditingController _acadProgramController = TextEditingController();
  final TextEditingController _acadProgramDdsController = TextEditingController();
  final TextEditingController _acadProgramPgrdController = TextEditingController();

  final FocusNode _acadProgramFocusNode = FocusNode();
  final FocusNode _acadProgramDdsFocusNode = FocusNode();
  final FocusNode _acadProgramPgrdFocusNode = FocusNode();

  String? _acadProgramErrorText;
  String? _acadProgramDdsErrorText;
  String? _acadProgramPgrdErrorText;

  /// list of Academic Program PGRD
  List<DropdownMenuItem> _acadProgramPgrdMenuItemsList = [];

  /// list of Academic Program DDS
  List<DropdownMenuItem> _acadProgramDdsMenuItemsList = [];

   final isSpecialCase = false;



  List<DropdownMenuItem> getMajors() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    final admitType = widget.applicationStatusDetails.admitType;
    final scholarshipType = widget.applicationStatusDetails.scholarshipType;

    /// Step 1: Check for postgraduate academic career ("PGRD")
    if (academicCareer?.toUpperCase() == "PGRD") {
      String majorCriteria = "MAJORSPGRD#${academicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      print(majorCriteria);
      return populateCommonDataDropdown(
        menuItemsList: populateUniqueSimpleValuesFromLOV(menuItemsList:  Constants.lovCodeMap[majorCriteria]?.values ?? []),
        provider: langProvider,
      );
    }

    /// Step 2: Default major criteria for non-PGRD
    String majorCriteria = "MAJORS#${academicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
    List<dynamic> items =  populateUniqueSimpleValuesFromLOV(menuItemsList:  Constants.lovCodeMap[majorCriteria]?.values ?? []);

    /// Step 3: Check for different admit types
    if (admitType?.toUpperCase() == "ACT") {
      /// For "ACT" admit type
      majorCriteria = "MAJORSACT#${academicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      items = populateUniqueSimpleValuesFromLOV(menuItemsList:  Constants.lovCodeMap[majorCriteria]?.values ?? []);
    } else if (admitType?.toUpperCase() == "NLU") {
      /// For "NLU" admit type
      majorCriteria = "MAJORSNL#${academicCareer?.toUpperCase()}#${isStudyCountry ? 'N' : 'Y'}";
      items = populateUniqueSimpleValuesFromLOV(menuItemsList:  Constants.lovCodeMap[majorCriteria]?.values ?? []);
    } else if (scholarshipType?.toUpperCase() == "INT" && admitType?.toUpperCase() != "MET") {
      /// Handle "INT" admit type with specific filtering for "OTH"
      List<dynamic> filteredItems = [];
      for (var item in items) {
        if (item.code?.toUpperCase() == "OTH") {
          if (_isValidAdmitTypeForINT(admitType,
              widget?.configurationKey)) {
            filteredItems.add(item);
          }
        } else {
          filteredItems.add(item); /// Add other items directly
        }
      }
      items = filteredItems; /// Update items with filtered items
    } else if (scholarshipType?.toUpperCase() == "EXT") {
      /// For "EXT" scholarship type, items already fetched
    } else {
      /// Default case to only add "BAM" items
      List<dynamic> filteredItems = [];
      for (var item in items) {
        if (item.code?.toUpperCase() == "BAM") {
          filteredItems.add(item);
        }
      }
      items = filteredItems; /// Update items with filtered items
    }

    /// Step 4: Handle special cases
    if (isSpecialCase ?? false) {
      items.add({'value': 'OTH', 'label': 'آخر'}); /// Append special case "OTH"
    }

    /// Return the final list of majors
    return populateCommonDataDropdown(
        menuItemsList: items, provider: langProvider);
  }

  /// Helper method to validate INT admit type
  bool _isValidAdmitTypeForINT(String? admitType, String? configurationKey) {
    return ["MOP", "MOS"].contains(admitType?.toUpperCase()) ||
        configurationKey?.toUpperCase() == "SCOUGRDINTHH";
  }

  /// major dropdown menu items list
  List<DropdownMenuItem> _majorsMenuItemsList = [];

  bool isStudyCountry = false;





  /// Function to add a new MajorWishList item
  void addMajorWishList() {
    /// Create a new MajorWishList instance
    MajorWishList newWishList = MajorWishList(
      majorController: TextEditingController(),
      otherMajorController: TextEditingController(),
      errorMessageController: TextEditingController(),
      sequenceNumberController: TextEditingController(),
      isNewController: TextEditingController(),
      majorFocusNode: FocusNode(),
      otherMajorFocusNode: FocusNode(),
      errorMessageFocusNode: FocusNode(),
      isNewFocusNode: FocusNode(),
    );

    /// Add the new instance to the list
    _majorsWishlist.add(newWishList);
  }

  /// Function to remove a MajorWishList item by index
  void removeMajorWishList(int index) {
    if (index >= 0 && index < _majorsWishlist.length) {
      /// Dispose the controllers and focus nodes to avoid memory leaks
      _majorsWishlist[index].majorController.dispose();
      _majorsWishlist[index].errorMessageController.dispose();
      _majorsWishlist[index].isNewController.dispose();
      _majorsWishlist[index].majorFocusNode.dispose();
      _majorsWishlist[index].errorMessageFocusNode.dispose();
      _majorsWishlist[index].isNewFocusNode.dispose();

      /// Remove the item from the list
      _majorsWishlist.removeAt(index);
    }
  }

  /// university priority list
  /// List to store UniversityPriority items
  final List<UniversityPriority> _universityPriorityList = [];

  List<DropdownMenuItem> populateUniversitiesWishList(UniversityPriority universityInfo)
  {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    final admitType = widget.applicationStatusDetails.admitType;
    final scholarshipType = widget.applicationStatusDetails.scholarshipType;
    
    
    String _country = universityInfo.countryIdController.text;
    /// Step 1: Fetch initial list of universities based on country
    List<DropdownMenuItem> items = fetchListOfValue("UNIVERSITY#$_country#UNV");

    /// List to store final items
    List<DropdownMenuItem> itemsNew = [];

    /// Step 2: Handle special case
    if (isSpecialCase ?? false) {
      itemsNew.add(const DropdownMenuItem(
          value: "OTH", child: Text("آخر"))); /// "OTH" means "Other"
    }

    /// Step 3: Check for different admit types
    if (admitType?.toUpperCase() == "NLU") {
      /// For "NLU" admit type
      itemsNew = fetchListOfValue("EXTUNIVERSITYNL#$_country#UNV");
    } else if (_country.toUpperCase() == "GBR") {
      /// For country "GBR"
      itemsNew.add(const DropdownMenuItem(value: "OTH", child: Text("آخر")));
    } else if (_country.toUpperCase() != "ARE" && scholarshipType?.toUpperCase() != "INT") {
      /// For countries not equal to "ARE" and scholarship type not "INT"
      itemsNew = fetchListOfValue("GRAD_UNIVERSITY#$_country#UNV");
    } else if (scholarshipType?.toUpperCase() == "INT" &&
        admitType?.toUpperCase() == "MET") {
      /// For "INT" scholarship type with "MET" admit type
      for (var item in items) {
        if (item.value.toString().toUpperCase() == "00000105") {
          itemsNew.add(item);
        }
      }
    } else {
      /// Default case, add all items
      itemsNew.addAll(items);
    }

    universityInfo.universityDropdown = itemsNew;
    return itemsNew;
  }

  /// Helper function to mimic fetchListOfValue, should return a list of DropdownMenuItem
  List<DropdownMenuItem> fetchListOfValue(String key) {
    /// Your logic to fetch values goes here
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    if (Constants.lovCodeMap[key]?.values != null) {
      return populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap[key]!.values!,
        provider: langProvider,
        textColor: AppColors.scoButtonColor,
      );
    } else {
      /// Handle the case where the values are null (e.g., return an empty list or log an error)
      return []; /// or any appropriate fallback
    }
  }

   List<DropdownMenuItem> _universityPriorityStatus = [];

  /// Function to add a new UniversityPriority item with only countryId provided
  void addUniversityPriority(String sequenceNumber) {
    /// Create a new UniversityPriority instance with only countryId set
    UniversityPriority newPriority = UniversityPriority(
      /// countryIdController: TextEditingController(text: _selectedScholarship?.acadmicCareer == 'UGRD' ? "ARE" : ''),
      countryIdController: TextEditingController(text: isStudyCountry ? "ARE" : ''),
      universityIdController: TextEditingController(),
      otherUniversityNameController: TextEditingController(),
      majorsController: TextEditingController(),
      otherMajorsController: TextEditingController(),
      statusController: TextEditingController(),
      errorMessageController: TextEditingController(),
      isNewController: TextEditingController(text: 'true'),
      sequenceNumberController: TextEditingController(text: sequenceNumber),
      countryIdFocusNode: FocusNode(),
      universityIdFocusNode: FocusNode(),
      otherUniversityNameFocusNode: FocusNode(),
      majorsFocusNode: FocusNode(),
      otherMajorsFocusNode: FocusNode(),
      statusFocusNode: FocusNode(),
      startDateController: TextEditingController(),
      endDateController: TextEditingController(),
      startDateFocusNode: FocusNode(),
      endDateFocusNode: FocusNode(),
    );

    /// Add the new instance to the list
    _universityPriorityList.add(newPriority);
    populateUniversitiesWishList(newPriority);
  }

  /// Function to remove a UniversityPriority item by index
  void removeUniversityPriority(int index) {
    if (index >= 0 && index < _universityPriorityList.length) {
      /// Dispose the controllers and focus nodes to avoid memory leaks
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

      /// Remove the item from the list
      _universityPriorityList.removeAt(index);
    }
  }




  Widget _buildUi() {

    final LanguageChangeViewModel langProvider = context.read<LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return Consumer<GetApplicationSectionViewModel>(
      builder: (context, provider, _) {
        switch (provider.apiResponse.status) {
          case Status.LOADING:
            return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return Utils.showOnError();
          case Status.COMPLETED:
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: kPadding - 5,vertical: 5),
                child: Column(
                  children: [
                    _majorAndUniversityView(langProvider),
                    _submitAndBackButton(localization: localization, langProvider: langProvider)
                  ],
                ),
              ),
            );
          case Status.NONE:
            return Utils.showOnNone();
          case null:
            return Utils.showOnNone();
        }
      },
    );
  }
  
  
  Widget _majorAndUniversityView(langProvider){
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomInformationContainer(
            title: academicCareer == 'PGRD' ? localization.pgrdMajorWishlist : localization.majorWishlist,
            expandedContent:

                sectionBackground(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // /// dropdown for pgrd students academic program
                      // if(academicCareer == 'PGRD' && academicCareer != 'DDS')
                      //   Column(
                      //     children: [
                      //       fieldHeading(
                      //         title: localization.pgrdAdacProgram,
                      //         important: true,
                      //         langProvider: langProvider,
                      //       ),
                      //       scholarshipFormDropdown(context:context,
                      //         controller: _acadProgramPgrdController,
                      //         currentFocusNode: _acadProgramPgrdFocusNode,
                      //         menuItemsList: _acadProgramPgrdMenuItemsList,
                      //         hintText: localization.select,
                      //         errorText: _acadProgramPgrdErrorText,
                      //         onChanged: (value) {
                      //           _acadProgramPgrdErrorText = null;
                      //
                      //           setState(() {
                      //             _acadProgramPgrdController.text = value!;
                      //
                      //             /// TODO: Pending implementation of the academic program next focus request
                      //             /// /// Move focus to the next field
                      //             /// Utils.requestFocus(
                      //             ///   focusNode: requiredExamInfo
                      //             ///       .examinationGradeFocusNode,
                      //             ///   context: context,
                      //             /// );
                      //           });
                      //         },
                      //       )
                      //     ],
                      //   ),
                      //
                      // kFormHeight,

                      /// Select Majors wishlist
                      academicCareer != 'DDS'
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
                                        ? localization.majorsWish1
                                        : index == 1
                                        ? localization.majorsWish2
                                        : localization.majorsWish3,
                                    important: academicCareer != 'DDS' && index == 0,
                                    langProvider: langProvider),
                                scholarshipFormDropdown(context:context,
                                    controller: majorInfo.majorController,
                                    currentFocusNode: majorInfo.majorFocusNode,
                                    menuItemsList: _majorsMenuItemsList ?? [],
                                    hintText: localization.select,
                                    errorText: majorInfo.majorError,
                                    onChanged: (value) {
                                      majorInfo.majorError = null;

                                      // Check if the major is already selected
                                      bool alreadySelected = value.trim().isNotEmpty &&
                                          _majorsWishlist.any((info) {
                                            return info != majorInfo && info.majorController.text.trim() == value.trim();
                                          });


                                      if (alreadySelected) {
                                        // If the major is already selected, reset the field and show a message
                                        setState(() {
                                          majorInfo.majorError = localization.duplicateWishUniversity;
                                          majorInfo.majorController.clear();
                                          // majorInfo.isNewController.text = "false";


                                        });
                                      } else {
                                        // If the major is valid, update the field and show a success message
                                        setState(() {
                                          majorInfo.majorController.text = value!;
                                          // majorInfo.isNewController.text = "true"; // Mark entry as valid
                                          // Optionally, display a success toast
                                        });
                                      }
                                    }
                                ),
                                kFormHeight,
                                /// other major if major is selected as other
                                if(academicCareer != 'DDS' && majorInfo.majorController.text == 'OTH')
                                  Column(
                                    children: [
                                      fieldHeading(
                                          title: localization.otherMajor,
                                          important: academicCareer != 'DDS' && index == 0,
                                          langProvider: langProvider),
                                      scholarshipFormTextField(currentFocusNode: majorInfo.otherMajorFocusNode, controller: majorInfo.otherMajorController, hintText: localization.otherMajorWatermark,errorText: majorInfo.otherMajorError, onChanged: (value){
                                        if(majorInfo.otherMajorFocusNode.hasFocus && academicCareer != 'DDS' && majorInfo.majorController.text == 'OTH'){
                                          setState(() {
                                            majorInfo.otherMajorError = ErrorText.getEmptyFieldError(name: majorInfo.otherMajorController.text, context: context);
                                          });
                                        }
                                      })
                                    ],
                                  ),

                                kFormHeight,
                              ],
                            );
                          })
                          : showVoid,



                      // /// major when academic program is dds
                      // academicCareer == 'DDS'
                      //     ? Column(
                      //   children: [
                      //     fieldHeading(
                      //       title: localization.ddsMajor1,
                      //       important: true,
                      //       langProvider: langProvider,
                      //     ),
                      //     scholarshipFormDropdown(context:context,
                      //       controller: _acadProgramDdsController,
                      //       currentFocusNode: _acadProgramDdsFocusNode,
                      //       menuItemsList: _acadProgramDdsMenuItemsList,
                      //       hintText: localization.select,
                      //       errorText: _acadProgramDdsErrorText,
                      //       onChanged: (value) {
                      //         _acadProgramDdsErrorText = null;
                      //
                      //         setState(() {
                      //           _acadProgramDdsController.text = value!;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // )
                      //     : showVoid
                    ]))

            ),
        kFormHeight,

        if(academicCareer != 'HCHL')
          CustomInformationContainer(
              title: academicCareer == 'DDS'
                  ? localization.ddsWishlist
                  : localization.universityWishList,
              expandedContent: sectionBackground(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Select Majors wishlist
                    if(academicCareer != 'HCHL')
                      Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _universityPriorityList.length,
                              itemBuilder: (context, index) {
                                final universityInfo = _universityPriorityList[index];
                                return Column(
                                  children: [
                                    /// ****************************************************************************************************************************************************
                                    fieldHeading(
                                        title: localization.country,
                                        important: true,
                                        langProvider: langProvider),

                                    //// Show only united states if applying for INT scholarship therefore we have made it selectable on the basis of study country i.e. INT Scholarship
                                    scholarshipFormDropdown(context:context,
                                      readOnly: isStudyCountry,
                                      filled: isStudyCountry,
                                      controller: universityInfo.countryIdController,
                                      currentFocusNode: universityInfo.universityIdFocusNode,
                                      menuItemsList: _nationalityMenuItemsList ?? [],
                                      hintText: localization.countryWatermark,
                                      errorText: universityInfo.countryIdError,
                                      onChanged: (value) {
                                        /// Clear the error initially
                                        setState(() {
                                          universityInfo.countryIdError = null;
                                          /// Set the major value if no duplicates are found
                                          universityInfo.countryIdController.text = value!;
                                          populateUniversitiesWishList(universityInfo);
                                        });
                                      },
                                    ),
                                    /// ********************************************************************
                                    kFormHeight,
                                    /// major
                                    academicCareer != 'DDS'
                                        ? Column(
                                      children: [
                                        fieldHeading(
                                            title: localization.majors,
                                            important: false,
                                            langProvider: langProvider),
                                        scholarshipFormDropdown(context:context,
                                          controller: universityInfo.majorsController,
                                          currentFocusNode: universityInfo.majorsFocusNode,
                                          menuItemsList: _majorsMenuItemsList ?? [],
                                          hintText: localization.select,
                                          errorText: universityInfo.majorsError,
                                          onChanged: (value) {
                                            /// Clear the error initially
                                            setState(() {
                                              universityInfo.majorsError = null;

                                              /// /// Check if the selected major is already in the wishlist
                                              /// bool alreadySelected =
                                              /// _universityPriorityList.any((info) {
                                              ///   /// Make sure we're not checking against the current item and compare the selected value
                                              ///   return info != universityInfo &&
                                              ///       info.majorsController.text ==
                                              ///           value;
                                              /// });
                                              ///
                                              /// if (alreadySelected) {
                                              ///   /// If the major is already selected, show a toast message and set an error
                                              ///   _alertServices.showToast(
                                              ///     context: context,
                                              ///     message:
                                              ///     "This  has already been selected. Please choose another one.",
                                              ///   );
                                              ///   universityInfo.majorsError =
                                              ///   "Please choose another";
                                              ///
                                              ///   /// Clear the selected major value in the controller
                                              ///   universityInfo.majorsController
                                              ///       .clear();
                                              ///   universityInfo.isNewController.text =
                                              ///   "false"; /// Reset to indicate it's not a valid entry
                                              /// } else {
                                              /// Set the major value if no duplicates are found
                                              universityInfo
                                                  .majorsController
                                                  .text = value!;
                                              /// }
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                        : showVoid,

                                    /// ****************************************************************************************************************************************************
                                    kFormHeight,

                                    if(universityInfo.majorsController.text == 'OTH' || academicCareer == 'DDS')
                                      Column(
                                        children: [
                                          fieldHeading(
                                              title: academicCareer != 'DDS' ? localization.otherMajor : localization.ddsMajor,
                                              important: academicCareer != 'DDS' && universityInfo.majorsController.text == 'OTH' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty),
                                              langProvider: langProvider),
                                          scholarshipFormTextField(
                                              currentFocusNode: universityInfo.otherMajorsFocusNode,
                                              nextFocusNode: universityInfo.universityIdFocusNode,
                                              controller: universityInfo.otherMajorsController,
                                              hintText: academicCareer != 'DDS' ? localization.otherMajorWatermark : localization.ddsMajorWatermark,
                                              maxLength: 30,
                                              errorText: universityInfo.otherMajorsError,
                                              onChanged: (value) {;
                                              if (universityInfo.otherMajorsFocusNode.hasFocus) {
                                                setState(() {
                                                  universityInfo.otherMajorsError = academicCareer != 'DDS' && universityInfo.majorsController.text == 'OTH' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty)
                                                      ? ErrorText.getEmptyFieldError(name: universityInfo.otherMajorsController.text, context: context)
                                                      : null;
                                                });
                                              }
                                              }),
                                          // kFormHeight,
                                        ],
                                      ),


                                    /// ****************************************************************************************************************************************************

                                    academicCareer != "DDS"
                                        ? Column(
                                      children: [
                                        fieldHeading(
                                            title: localization.university,
                                            important: false,
                                            langProvider: langProvider),
                                        scholarshipFormDropdown(context:context,
                                          controller: universityInfo.universityIdController,
                                          currentFocusNode: universityInfo.majorsFocusNode,
                                          menuItemsList: universityInfo.universityDropdown ?? [],
                                          hintText: localization.select,
                                          errorText: universityInfo.universityIdError,
                                          onChanged: (value) {
                                            /// Clear the error initially
                                            setState(() {
                                              universityInfo.universityIdError = null;
                                              /// Check if the selected university is already in the wishlist
                                              bool alreadySelected = _universityPriorityList.any((info) {
                                                /// Skip the current item, and ensure the selected value is not empty or "OTH"
                                                return info != universityInfo &&
                                                    info.universityIdController.text.trim().isNotEmpty &&
                                                    info.universityIdController.text.trim() != "OTH" &&
                                                    info.universityIdController.text.trim() == value?.trim();
                                              });

                                              if (alreadySelected) {

                                                universityInfo.universityIdError = localization.duplicateWishUniversity;

                                                /// Clear the selected university value in the controller
                                                universityInfo.universityIdController.clear();
                                              } else {
                                                /// Set the university value if no duplicates are found
                                                universityInfo.universityIdController.text = value!;
                                              }

                                              // universityInfo.universityIdController.text = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                        : showVoid,
                                    /// ****************************************************************************************************************************************************

                                    kFormHeight,
                                    // universityInfo.universityIdController.text == 'OTH' || academicCareer == 'DDS'
                                    ( universityInfo.universityIdController.text == 'OTH' ||  academicCareer == 'DDS')
                                        ? Column(
                                      children: [
                                        fieldHeading(
                                            title: academicCareer != 'DDS'
                                                ? localization.universityNameIfOther
                                                : localization.ddsUniversity,
                                            important: (academicCareer != 'DDS' && universityInfo.universityIdController.text ==
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
                                        scholarshipFormTextField(
                                            currentFocusNode: universityInfo
                                                .otherUniversityNameFocusNode,
                                            nextFocusNode: universityInfo
                                                .statusFocusNode,
                                            controller: universityInfo
                                                .otherUniversityNameController,
                                            hintText: academicCareer != 'DDS'
                                                ? localization.hsOtherUniversityWatermark
                                                : localization.ddsUniversityWatermark,
                                            errorText: universityInfo
                                                .otherUniversityNameError,
                                            onChanged: (value) {
                                              if (universityInfo
                                                  .otherUniversityNameFocusNode
                                                  .hasFocus) {
                                                setState(() {
                                                  universityInfo.otherUniversityNameError = (academicCareer !=
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
                                        kFormHeight,
                                      ],
                                    )
                                        : showVoid,
                                    /// ****************************************************************************************************************************************************

                                    /// University Status
                                    /// kFormHeight,
                                    fieldHeading(
                                        title: localization.universityStatus,
                                        important: academicCareer !=
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

                                    scholarshipFormDropdown(context:context,
                                      controller: universityInfo.statusController,
                                      currentFocusNode: universityInfo.statusFocusNode,
                                      menuItemsList: _universityPriorityStatus ?? [],
                                      hintText: localization.universityStatusWatermark,
                                      errorText: universityInfo.statusError,
                                      onChanged: (value) {
                                        /// Clear the error initially
                                        universityInfo.statusError = null;
                                        setState(() {
                                          universityInfo.statusController.text = value!;
                                        });
                                      },
                                    ),

                                    index != 0
                                        ? addRemoveMoreSection(
                                        title: localization.deleteRowUniversity,
                                        add: false,
                                        onChanged: () {
                                          setState(() {
                                            removeUniversityPriority(index);
                                          });
                                        })
                                        : showVoid,

                                    kFormHeight,
                                    const Divider(
                                      color: AppColors.lightGrey,
                                    ),
                                    kFormHeight,
                                  ],
                                );
                              }),
                          addRemoveMoreSection(
                              title: localization.addRowUniversity,
                              add: true,
                              onChanged: () {
                                setState(() {
                                  addUniversityPriority((_universityPriorityList.length +1).toString());
                                });
                              }),
                        ],
                      )
                  ]))

              ),

      ],
    );
  }
  
  
  

  Widget _submitAndBackButton({required AppLocalizations localization,required LanguageChangeViewModel langProvider}) {
    /// SubmitButton
    return  Column(
      children: [
        kFormHeight,
        Consumer<EditApplicationSectionsViewModel>(
          builder: (context,provider,_){
            return CustomButton(buttonName: localization.update, isLoading:
                provider.apiResponse.status == Status.LOADING
                , textDirection: getTextDirection(langProvider), onTap: ()
            async{
              final logger =  Logger();
              if(validateUniversityAndMajorsDetails(langProvider)){
                dynamic form = peopleSoftApplication?.toJson();
                form['majorWishList'] = _majorsWishlist.map((element){return element.editMajorsListToJson();}).toList();
                form['universtiesPriorityList'] = _universityPriorityList.map((element){return element.editUniversityListToJson();}).toList();
                log(jsonEncode(form));

                await provider.editApplicationSections(sectionType: EditApplicationSection.universityPriority, applicationNumber: widget.applicationStatusDetails.admApplicationNumber, form: form);
                await _refreshView();
              }
            });

          },
        ),


        kFormHeight,
        const KReturnButton(),
      ],
    );
  }

  bool validateUniversityAndMajorsDetails(langProvider) {
    final localization = AppLocalizations.of(context)!;
    firstErrorFocusNode = null;

    final academicCareer = widget.applicationStatusDetails.acadCareer;

    // /// academic program pgrd
    // if (academicCareer == 'PGRD' &&
    //     academicCareer != 'DDS') {
    //   if (_acadProgramPgrdController.text.isEmpty || _acadProgramErrorText != null) {
    //     setState(() {
    //       _acadProgramPgrdErrorText = localization.pgrdAdacProgramRequired;
    //       firstErrorFocusNode ??= _acadProgramPgrdFocusNode;
    //     });
    //   }}

    /// #################################################################
    /// major
    /// applicationForm.applicationData.acadCareer ne 'DDS' and rowIndex.index eq 0
    if( academicCareer != 'DDS'){
      for (int i = 0; i < _majorsWishlist.length; i++) {
        var element = _majorsWishlist[i];
        if (i == 0 && (element.majorController.text.isEmpty || element.majorError != null) ) {
          setState(() {
            element.majorError = localization.majorsValidate;
            firstErrorFocusNode ??= element.majorFocusNode;
          });
        }
        if (element.majorError != null) {
          setState(() {
            element.majorError = localization.majorsValidate;
            firstErrorFocusNode ??= element.majorFocusNode;
          });
          if(element.majorController.text == 'OTH'){
            if(element.otherMajorController.text.isEmpty || element.otherMajorError != null){
              setState(() {
                element.otherMajorError = localization.otherMajorValidate;
                firstErrorFocusNode ??= element.otherMajorFocusNode;
              });
            }
          }
        }

      }
    }

    /// #################################################################

    // /// academic program dds
    // if (academicCareer == 'DDS') {
    //   if (_acadProgramDdsController.text.isEmpty || _acadProgramDdsErrorText != null) {
    //     setState(() {
    //       _acadProgramDdsErrorText = localization.ddsMajorRequired;
    //       firstErrorFocusNode ??= _acadProgramDdsFocusNode;
    //     });
    //   }
    // }

    /// #################################################################

    /// university wishlish validation
    if (academicCareer != 'HCHL') {
      for (int i = 0; i < _universityPriorityList.length; i++) {
        var element = _universityPriorityList[i];
        if (!isStudyCountry && element.countryIdController.text.isEmpty) {
          setState(() {
            element.countryIdError = localization.countryRequired;
            firstErrorFocusNode ??= element.countryIdFocusNode;
          });
        }

        /// #################################################################
        /// On Web is paused also
        // if (academicCareer != 'DDS') {
        //   if (element.majorsController.text.isEmpty) {
        //     setState(() {
        //       element.majorsError = "Please Select Your Major";
        //       firstErrorFocusNode ??= element.majorsFocusNode;
        //     });
        //   }
        // }
        /// #################################################################
        /// validate other major
        if(element.majorsController.text == 'OTH'){
          if (academicCareer != 'DDS' &&
              element.majorsController.text == 'OTH' &&
              (element.countryIdController.text.isNotEmpty ||
                  element.otherMajorsController.text.isNotEmpty ||
                  element.otherUniversityNameController.text.isNotEmpty ||
                  element.statusController.text.isNotEmpty)) {
            if (element.majorsController.text.isEmpty) {
              setState(() {
                element.otherMajorsError = localization.ddsOtherMajorRequired;
                firstErrorFocusNode ??= element.otherMajorsFocusNode;
              });
            }
          }
        }
        /// #################################################################
//         / validate university
//         / Also paused validation for university on web
        if (academicCareer != 'DDS') {
          if (element.universityIdController.text.isEmpty || element.universityIdError != null) {
            setState(() {
              element.universityIdError = localization.universityValidate;
              firstErrorFocusNode ??= element.universityIdFocusNode;
            });
          }
        }
        /// #################################################################
        /// validate other university
        if(element.universityIdController.text == 'OTH'){
          if (academicCareer != 'DDS' &&
              (element.countryIdController.text.isNotEmpty ||
                  element.otherMajorsController.text.isNotEmpty ||
                  element.otherUniversityNameController.text.isNotEmpty ||
                  element.statusController.text.isNotEmpty)) {
            if (element.otherUniversityNameController.text.isEmpty) {
              setState(() {
                element.otherUniversityNameError = localization.ddsOtherUniversityRequired;
                firstErrorFocusNode ??= element.otherUniversityNameFocusNode;
              });
            }
          }
        }


        /// #################################################################
        if (academicCareer != 'DDS' &&
            (element.countryIdController.text.isNotEmpty ||
                element.otherMajorsController.text.isNotEmpty ||
                element.otherUniversityNameController.text.isNotEmpty ||
                element.statusController.text.isNotEmpty)) {
          if (element.statusController.text.isEmpty) {
            setState(() {
              element.statusError = localization.universityStatusRequired;
              firstErrorFocusNode ??= element.statusFocusNode;
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
      // await saveDraft();
      return true;
    }
  }


  FocusNode? firstErrorFocusNode;
}
