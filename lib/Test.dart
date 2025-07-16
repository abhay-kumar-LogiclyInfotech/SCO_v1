// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:sco_v1/l10n/app_localizations.dart';
// import 'package:sco_v1/resources/app_colors.dart';
// import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
// import 'package:sco_v1/resources/validations_and_errorText.dart';
// import 'package:sco_v1/utils/utils.dart';
// import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
// import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
// import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
//
// import 'models/splash/commonData_model.dart';
//
// class TestView extends StatefulWidget {
//   const TestView({super.key});
//
//   @override
//   State<TestView> createState() => _TestViewState();
// }
//
// class _TestViewState extends State<TestView> with MediaQueryMixin {
//   @override
//   Widget build(BuildContext context) {
//
//     final localization = AppLocalizations.of(context)!;
//     final langProvider = Provider.of<LanguageChangeViewModel>(context);
//
//     final academicCareer = "";
//     final academicProgram = "";
//     final admitType = "";
//     final scholarshipType = "";
//     final majorWishList = [];
//     final universityList = [];
//     bool isStudyCountry = false;
//     final List<DropdownMenuItem> majorMenuItemsList = [];
//
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: kPadding),
//         color: Colors.grey.shade200,
//         child: SingleChildScrollView(
//             child: Column(children: [
//
//               /// university list
//               if(academicCareer != 'HCHL')
//                 CustomInformationContainer(
//                     title: academicCareer == 'DDS'
//                         ? localization.ddsWishlist
//                         : localization.universityWishList,
//                     expandedContent: sectionBackground(child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           /// Select Majors wishlist
//                           if(academicCareer != 'HCHL')
//                             Column(
//                               children: [
//                                 ListView.builder(
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.zero,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemCount: universityList.length,
//                                     itemBuilder: (context, index) {
//                                       final universityInfo = universityList[index];
//                                       return Column(
//                                         children: [
//                                           /// ****************************************************************************************************************************************************
//                                           fieldHeading(
//                                               title: localization.country,
//                                               important: true,
//                                               langProvider: langProvider),
//
//                                           //// Show only united states if applying for INT scholarship therefore we have made it selectable on the basis of study country i.e. INT Scholarship
//                                           scholarshipFormDropdown(context:context,
//                                             readOnly: isStudyCountry,
//                                             filled: true,
//                                             fillColor: isStudyCountry ? AppColors.lightGrey : Colors.white,
//                                             controller: universityInfo.countryIdController,
//                                             currentFocusNode: universityInfo.universityIdFocusNode,
//                                             menuItemsList: _nationalityMenuItemsList,
//                                             hintText: localization.countryWatermark,
//                                             errorText: universityInfo.countryIdError,
//                                             onChanged: (value) {
//                                               /// Clear the error initially
//                                               setState(() {
//                                                 universityInfo.countryIdError = null;
//                                                 /// Set the major value if no duplicates are found
//                                                 universityInfo.countryIdController.text = value!;
//                                                 populateUniversitiesWishList(context: context,country: universityInfo.countryIdController.text,admitType: admitType,scholarshipType: scholarshipType);
//                                               });
//                                             },
//                                           ),
//                                           /// ********************************************************************
//                                           kFormHeight,
//                                           /// major
//                                           academicCareer != 'DDS' || admitType == 'AHC' /// TODO : new added
//                                               ? Column(
//                                             children: [
//                                               fieldHeading(
//                                                   title: localization.majors,
//                                                   important: false,
//                                                   langProvider: langProvider),
//                                               scholarshipFormDropdown(context:context,
//                                                 controller: universityInfo.majorsController,
//                                                 currentFocusNode: universityInfo.majorsFocusNode,
//                                                 menuItemsList: majorMenuItemsList,
//                                                 hintText: localization.select,
//                                                 errorText: universityInfo.majorsError,
//                                                 onChanged: (value) {
//                                                   /// Clear the error initially
//                                                   setState(() {
//                                                     universityInfo.majorsError = null;
//
//                                                     /// /// Check if the selected major is already in the wishlist
//                                                     /// bool alreadySelected =
//                                                     /// universityList.any((info) {
//                                                     ///   /// Make sure we're not checking against the current item and compare the selected value
//                                                     ///   return info != universityInfo &&
//                                                     ///       info.majorsController.text ==
//                                                     ///           value;
//                                                     /// });
//                                                     ///
//                                                     /// if (alreadySelected) {
//                                                     ///   /// If the major is already selected, show a toast message and set an error
//                                                     ///   _alertService.showToast(
//                                                     ///     context: context,
//                                                     ///     message:
//                                                     ///     "This  has already been selected. Please choose another one.",
//                                                     ///   );
//                                                     ///   universityInfo.majorsError =
//                                                     ///   "Please choose another";
//                                                     ///
//                                                     ///   /// Clear the selected major value in the controller
//                                                     ///   universityInfo.majorsController
//                                                     ///       .clear();
//                                                     ///   universityInfo.isNewController.text =
//                                                     ///   "false"; /// Reset to indicate it's not a valid entry
//                                                     /// } else {
//                                                     /// Set the major value if no duplicates are found
//                                                     universityInfo
//                                                         .majorsController
//                                                         .text = value!;
//                                                     /// }
//                                                   });
//                                                 },
//                                               ),
//                                             ],
//                                           )
//                                               : showVoid,
//
//                                           /// ****************************************************************************************************************************************************
//                                           /// other major
//                                           kFormHeight,
//                                           if(universityInfo.majorsController.text == 'OTH')
//                                             Column(
//                                               children: [
//                                                 fieldHeading(
//                                                     title: academicCareer != 'DDS' ? localization.otherMajor : localization.ddsMajor,
//                                                     important: academicCareer != 'DDS' && universityInfo.majorsController.text == 'OTH' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty),
//                                                     langProvider: langProvider),
//                                                 scholarshipFormTextField(
//                                                     currentFocusNode: universityInfo.otherMajorsFocusNode,
//                                                     nextFocusNode: universityInfo.universityIdFocusNode,
//                                                     controller: universityInfo.otherMajorsController,
//                                                     hintText: academicCareer != 'DDS' ? localization.otherMajorWatermark : localization.ddsMajorWatermark,
//                                                     maxLength: 30,
//                                                     errorText: universityInfo.otherMajorsError,
//                                                     onChanged: (value) {
//                                                       if (universityInfo.otherMajorsFocusNode.hasFocus) {
//                                                         setState(() {
//                                                           universityInfo.otherMajorsError = academicCareer != 'DDS' && universityInfo.majorsController.text == 'OTH' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty)
//                                                               ? ErrorText.getEmptyFieldError(name: universityInfo.otherMajorsController.text, context: context)
//                                                               : null;
//                                                         });
//                                                       }
//                                                     }),
//                                                 // kFormHeight,
//                                               ],
//                                             ),
//                                           /// ****************************************************************************************************************************************************
//
//                                           /// university
//                                           academicCareer != "DDS"
//                                               ? Column(
//                                             children: [
//                                               fieldHeading(
//                                                   title: localization.university,
//                                                   important: false,
//                                                   langProvider: langProvider),
//                                               scholarshipFormDropdown(context:context,
//                                                 controller: universityInfo.universityIdController,
//                                                 currentFocusNode: universityInfo.majorsFocusNode,
//                                                 menuItemsList: universityInfo.universityDropdown ?? [],
//                                                 hintText: localization.select,
//                                                 errorText: universityInfo.universityIdError,
//                                                 onChanged: (value) {
//                                                   /// Clear the error initially
//                                                   setState(() {
//                                                     universityInfo.universityIdError = null;
//                                                     /// Check if the selected university is already in the wishlist
//                                                     bool alreadySelected = universityList.any((info) {
//                                                       /// Skip the current item, and ensure the selected value is not empty or "OTH"
//                                                       return info != universityInfo &&
//                                                           info.universityIdController.text.trim().isNotEmpty &&
//                                                           info.universityIdController.text.trim() != "OTH" &&
//                                                           info.universityIdController.text.trim() == value?.trim();
//                                                     });
//
//                                                     if (alreadySelected) {
//                                                       /// If the university is already selected, show a toast message and set an error
//                                                       // _alertService.showToast(
//                                                       //   // context: context,
//                                                       //   message: "This university has already been selected. Please choose another one.",
//                                                       // );
//                                                       universityInfo.universityIdError = localization.duplicateWishUniversity;
//
//                                                       /// Clear the selected university value in the controller
//                                                       universityInfo.universityIdController.clear();
//                                                     } else {
//                                                       /// Set the university value if no duplicates are found
//                                                       universityInfo.universityIdController.text = value!;
//                                                     }
//
//                                                     // universityInfo.universityIdController.text = value!;
//                                                   });
//                                                 },
//                                               ),
//                                             ],
//                                           )
//                                               : showVoid,
//                                           /// ****************************************************************************************************************************************************
//
//                                           /// other university
//                                           (universityInfo.universityIdController.text == 'OTH')
//                                               ? Column(
//                                             children: [
//                                               kFormHeight,
//                                               fieldHeading(
//                                                   title: academicCareer != 'DDS' ? localization.universityNameIfOther : localization.ddsUniversity,
//                                                   important: (academicCareer != 'DDS' && universityInfo.universityIdController.text ==
//                                                       'OTH' &&
//                                                       (universityInfo
//                                                           .countryIdController
//                                                           .text
//                                                           .isNotEmpty ||
//                                                           universityInfo
//                                                               .otherMajorsController
//                                                               .text
//                                                               .isNotEmpty ||
//                                                           universityInfo
//                                                               .otherUniversityNameController
//                                                               .text
//                                                               .isNotEmpty ||
//                                                           universityInfo
//                                                               .statusController
//                                                               .text
//                                                               .isNotEmpty)),
//                                                   langProvider: langProvider),
//                                               scholarshipFormTextField(
//                                                   currentFocusNode: universityInfo.otherUniversityNameFocusNode,
//                                                   nextFocusNode: universityInfo
//                                                       .statusFocusNode,
//                                                   controller: universityInfo
//                                                       .otherUniversityNameController,
//                                                   hintText: academicCareer != 'DDS'
//                                                       ? localization.hsOtherUniversityWatermark
//                                                       : localization.ddsUniversityWatermark,
//                                                   errorText: universityInfo
//                                                       .otherUniversityNameError,
//                                                   onChanged: (value) {
//                                                     if (universityInfo
//                                                         .otherUniversityNameFocusNode
//                                                         .hasFocus) {
//                                                       setState(() {
//                                                         universityInfo.otherUniversityNameError = (academicCareer !=
//                                                             'DDS' &&
//                                                             universityInfo
//                                                                 .universityIdController
//                                                                 .text ==
//                                                                 'OTH' &&
//                                                             (universityInfo
//                                                                 .countryIdController
//                                                                 .text
//                                                                 .isNotEmpty ||
//                                                                 universityInfo
//                                                                     .otherMajorsController
//                                                                     .text
//                                                                     .isNotEmpty ||
//                                                                 universityInfo
//                                                                     .otherUniversityNameController
//                                                                     .text
//                                                                     .isNotEmpty ||
//                                                                 universityInfo
//                                                                     .statusController
//                                                                     .text
//                                                                     .isNotEmpty))
//                                                             ? ErrorText.getEmptyFieldError(
//                                                             name: universityInfo
//                                                                 .otherUniversityNameController
//                                                                 .text,
//                                                             context: context)
//                                                             : null;
//                                                       });
//                                                     }
//                                                   }),
//                                             ],
//                                           )
//                                               : showVoid,
//                                           /// ****************************************************************************************************************************************************
//                                           /// Start Date
//                                           if(admitType == 'AHC')
//                                             Column(
//                                               children: [
//                                                 kFormHeight,
//                                                 fieldHeading(title: localization.militaryServiceStartDate, important: false, langProvider: langProvider),
//                                                 scholarshipFormDateField(
//                                                   currentFocusNode: universityInfo.startDateFocusNode,
//                                                   controller:  universityInfo.startDateController,
//                                                   hintText: localization.select,
//                                                   errorText: universityInfo.startDateError,
//                                                   onChanged: (value) async {
//                                                     setState(() {
//                                                       if (universityInfo.startDateFocusNode.hasFocus) {
//                                                         universityInfo.startDateError = null;
//                                                       }
//                                                     });
//                                                   },
//                                                   onTap: () async {
//                                                     /// Clear the error if a date is selected
//                                                     universityInfo.startDateError = null;
//                                                     /// Define the initial date (e.g., today's date)
//                                                     final DateTime initialDate = DateTime.now();
//
//                                                     /// Define the start date (10 years ago from today)
//                                                     final DateTime firstDate = DateTime.now().subtract(const Duration(days: 20 * 365));
//
//                                                     /// Define the last date (10 years in the future from today)
//                                                     final DateTime lastDate = DateTime.now().add(const Duration(days: 20 * 365));
//
//                                                     DateTime? date = await showDatePicker(
//                                                       context: context,
//                                                       barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
//                                                       barrierDismissible: false,
//                                                       locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
//                                                       initialDate: initialDate,
//                                                       firstDate: firstDate,
//                                                       lastDate: lastDate,
//                                                     );
//
//                                                     if (date != null) {
//                                                       setState(() {
//                                                         universityInfo.startDateController.text = DateFormat('yyyy-MM-dd').format(date).toString();
//                                                         /// Optionally, request focus on the next field
//                                                       });
//                                                     }
//                                                   },
//                                                 ),
//
//                                               ],
//                                             ),
//                                           /// ****************************************************************************************************************************************************
//                                           /// End Date
//                                           if(admitType == 'AHC')
//                                             Column(
//                                               children: [
//                                                 kFormHeight,
//                                                 fieldHeading(title: localization.militaryServiceEndDate, important: false, langProvider: langProvider),
//                                                 scholarshipFormDateField(
//                                                   currentFocusNode: universityInfo.endDateFocusNode,
//                                                   controller:  universityInfo.endDateController,
//                                                   hintText: localization.select,
//                                                   errorText: universityInfo.endDateError,
//                                                   onChanged: (value) async {
//                                                     setState(() {
//                                                       if (universityInfo.endDateFocusNode.hasFocus) {
//                                                         universityInfo.endDateError = null;
//                                                       }
//                                                     });
//                                                   },
//                                                   onTap: () async {
//                                                     /// Clear the error if a date is selected
//                                                     universityInfo.startDateError = null;
//                                                     /// Define the initial date (e.g., today's date)
//                                                     final DateTime initialDate = DateTime.now();
//
//                                                     /// Define the start date (10 years ago from today)
//                                                     final DateTime firstDate = DateTime.now().subtract(const Duration(days: 20 * 365));
//
//                                                     /// Define the last date (10 years in the future from today)
//                                                     final DateTime lastDate = DateTime.now().add(const Duration(days: 20 * 365));
//
//                                                     DateTime? date = await showDatePicker(
//                                                       context: context,
//                                                       barrierColor: AppColors.scoButtonColor.withOpacity(0.1),
//                                                       barrierDismissible: false,
//                                                       locale: Provider.of<LanguageChangeViewModel>(context, listen: false).appLocale,
//                                                       initialDate: initialDate,
//                                                       firstDate: firstDate,
//                                                       lastDate: lastDate,
//                                                     );
//
//                                                     if (date != null) {
//                                                       setState(() {
//                                                         universityInfo.endDateController.text = DateFormat('yyyy-MM-dd').format(date).toString();
//                                                         /// Optionally, request focus on the next field
//                                                       });
//                                                     }
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           /// ****************************************************************************************************************************************************
//                                           kFormHeight,
//                                           /// University Status
//                                           fieldHeading(title: localization.universityStatus,
//                                               important: false,
//                                               // important: academicCareer != 'DDS' && (universityInfo.countryIdController.text.isNotEmpty || universityInfo.otherMajorsController.text.isNotEmpty || universityInfo.otherUniversityNameController.text.isNotEmpty || universityInfo.statusController.text.isNotEmpty),
//                                               langProvider: langProvider),
//                                           scholarshipFormDropdown(context:context,
//                                             controller: universityInfo.statusController,
//                                             currentFocusNode: universityInfo.statusFocusNode,
//                                             menuItemsList: _universityPriorityStatus,
//                                             hintText: localization.universityStatusWatermark,
//                                             errorText: universityInfo.statusError,
//                                             onChanged: (value) {
//                                               /// Clear the error initially
//                                               universityInfo.statusError = null;
//                                               setState(() {
//                                                 universityInfo.statusController.text = value!;
//                                               });
//                                             },
//                                           ),
//                                           /// ****************************************************************************************************************************************************
//
//                                           /// add remove sections
//                                           index != 0 ? addRemoveMoreSection(
//                                               title: localization.deleteRowUniversity,
//                                               add: false,
//                                               onChanged: () {
//                                                 setState(() {
//                                                   removeUniversityPriority(index);
//                                                 });
//                                               })
//                                               : showVoid,
//
//                                           kFormHeight,
//                                           const Divider(),
//                                           kFormHeight,
//                                         ],
//                                       );
//                                     }),
//                                 addRemoveMoreSection(
//                                     title: localization.addRowUniversity,
//                                     add: true,
//                                     onChanged: () {
//                                       setState(() {
//                                         addUniversityPriority();
//                                       });
//                                     }),
//                               ],
//                             )
//                         ]))),
//               const SizedBox(height: 100,),
//               // draftPrevNextButtons(langProvider)
//             ])));
// }

