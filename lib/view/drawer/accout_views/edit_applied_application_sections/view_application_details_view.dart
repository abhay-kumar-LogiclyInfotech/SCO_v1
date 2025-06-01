import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';
import 'package:sco_v1/resources/components/custom_dropdown.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/get_submitted_application_details_by_applicaion_number_viewModel.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_text_styles.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_checkbox_tile.dart';
import '../../../../resources/components/myDivider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/media_services.dart';
import '../../../../viewModel/services/navigation_services.dart';
import '../../../../viewModel/services/permission_checker_service.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../apply_scholarship/form_view_Utils.dart';


class ViewApplicationDetailsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  final dynamic configurationKey;
  const ViewApplicationDetailsView({super.key,required this.applicationStatusDetails,required this.configurationKey});

  @override
  State<ViewApplicationDetailsView> createState() => _ViewApplicationDetailsViewState();
}

class _ViewApplicationDetailsViewState extends State<ViewApplicationDetailsView> with MediaQueryMixin{


  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;


  /// Name
  PersonName _arabicName = PersonName(
    nameTypeController: TextEditingController(text: 'PRI'),
    studentNameController: TextEditingController(),
    fatherNameController: TextEditingController(),
    grandFatherNameController: TextEditingController(),
    familyNameController: TextEditingController(),
    nameTypeFocusNode: FocusNode(),
    studentNameFocusNode: FocusNode(),
    fatherNameFocusNode: FocusNode(),
    grandFatherNameFocusNode: FocusNode(),
    familyNameFocusNode: FocusNode(),
  );
  PersonName _englishName = PersonName(
    nameTypeController: TextEditingController(text: 'ENG'),
    studentNameController: TextEditingController(),
    fatherNameController: TextEditingController(),
    grandFatherNameController: TextEditingController(),
    familyNameController: TextEditingController(),
    nameTypeFocusNode: FocusNode(),
    studentNameFocusNode: FocusNode(),
    fatherNameFocusNode: FocusNode(),
    grandFatherNameFocusNode: FocusNode(),
    familyNameFocusNode: FocusNode(),
  );
  final List<PersonName> _nameAsPassport = [];


  /// Passport Details
  final TextEditingController _passportNationalityController = TextEditingController();
  final TextEditingController _passportNumberController = TextEditingController();
  final TextEditingController _passportIssueDateController = TextEditingController();
  final TextEditingController _passportExpiryDateController = TextEditingController();
  final TextEditingController _passportPlaceOfIssueController = TextEditingController();
  final TextEditingController _passportUnifiedNoController = TextEditingController();

  /// Personal Information
  /// Emirates ID
  final TextEditingController _emiratesIdController = TextEditingController(text: "");
  /// Emirates ID Expiry Date
  final TextEditingController _emiratesIdExpiryDateController = TextEditingController();
  /// Date of Birth
  final TextEditingController _dateOfBirthController = TextEditingController();
  /// Place of Birth
  final TextEditingController _placeOfBirthController = TextEditingController();
  /// Gender
  final TextEditingController _genderController = TextEditingController();
  /// Marital Status
  final TextEditingController _maritalStatusController = TextEditingController();
  /// Student Email Address
  final TextEditingController _studentEmailController = TextEditingController();
  /// Is Mother UAE National?
  final TextEditingController _motherUAENationalController = TextEditingController();
  bool _isMotherUAECheckbox = false;
  String havingSponsor = '';
  bool isSpecialCase = false;


  /// Family Information
  final TextEditingController _familyInformationEmiratesController = TextEditingController();
  final TextEditingController _familyInformationTownVillageNoController = TextEditingController();
  final TextEditingController _familyInformationParentGuardianNameController = TextEditingController();
  final TextEditingController _familyInformationRelationTypeController = TextEditingController();
  final TextEditingController _familyInformationFamilyBookNumberController = TextEditingController();
  final TextEditingController _familyInformationMotherNameController = TextEditingController();

  /// Is Relative studying from scholarship
  bool? _isRelativeStudyingFromScholarship;
  /// List of Relative information
  final List<RelativeInfo> _relativeInfoList = [];
  /// Contact information
  final List<PhoneNumber> _phoneNumberList = [];
  /// address list
  final List<Address> _addressInformationList = [];

  /// Military service information
  MilitaryStatus? _isMilitaryService;
  final TextEditingController _militaryServiceController = TextEditingController();
  final TextEditingController _militaryServiceStartDateController = TextEditingController();
  final TextEditingController _militaryServiceEndDateController = TextEditingController();
  final TextEditingController _reasonForMilitaryController = TextEditingController();

  /// final HIGH SCHOOL list
  final List<HighSchool> _highSchoolList = [];

  /// Graduation Details
  final List<GraduationInfo> _graduationDetailsList = [];


  /// controllers, focus nodes and error text variables for Academic program
  final TextEditingController _acadProgramController = TextEditingController();
  final TextEditingController _acadProgramDdsController = TextEditingController();
  final TextEditingController _acadProgramPgrdController = TextEditingController();


  bool isStudyCountry = false;
  List<dynamic> _majorsMenuItemsList = [];
  // _majorsMenuItemsList = getMajors(); /// calling the getMajors method to populate the majors function

  /// Majors
  final List<MajorWishList> _majorsWishlist = [];

  /// University Priority List
  final List<UniversityPriority> _universityPriorityList = [];

  /// Required
 final List<RequiredExaminations> _requiredExaminationList = [];

 /// Employment History
 /// available employment status from lov
 List _employmentStatusItemsList = [];
 /// current Employment status
 String? _employmentStatus;
 final List<EmploymentHistory> _employmentHistoryList = [];



  /// Selected checklist code for attachments full name
   String _selectedChecklistCode = "";
  /// Attachments
  final List<Attachment> _filteredMyAttachmentsList = [];







  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {


      if (Constants.lovCodeMap['EMPLOYMENT_STATUS']?.values != null) {
        _employmentStatusItemsList = populateUniqueSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['EMPLOYMENT_STATUS']!.values!,
            provider: Provider.of<LanguageChangeViewModel>(context,listen: false),
            textColor: AppColors.scoButtonColor);
      }

      /// As we need checklist code to show the full name of document so we need to call the all active scholarship api from where we can match the configuration key and get the checklist code
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(context: context, langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false));
      if(provider.apiResponse.status == Status.COMPLETED){
        final activeScholarships = provider.apiResponse.data;
        final activeScholarship = activeScholarships?.firstWhere((scholarship) => scholarship.configurationKey == widget.configurationKey);
        _selectedChecklistCode = activeScholarship?.checklistCode?? '';
      }


      /// get personal details to show addresses
      final applicationDetailsProvider = Provider.of<GetSubmittedApplicationDetailsByApplicationNumberViewModel>(context, listen: false);
      await applicationDetailsProvider.getSubmittedApplicationDetailsByApplicationNumber(applicationNumber: widget.applicationStatusDetails.admApplicationNumber);



      /// clean the draft application data and prefill the fields
      Map<String, dynamic> cleanedDraft = jsonDecode(cleanDraftXmlToJson(applicationDetailsProvider.apiResponse.data?.applicationData ?? ''));


      isStudyCountry = widget.applicationStatusDetails.scholarshipType == 'INT' ? true : false;
      // isStudyCountry = true;

      /// Name as per passport
      if (cleanedDraft['nameAsPasport'] != null) {
        _nameAsPassport.clear();
        if(cleanedDraft['nameAsPasport'] is List){
          for (var ele in cleanedDraft['nameAsPasport']) {
            final element = PersonName.fromJson(ele);
            if(element.nameTypeController.text == 'PRI'){
              _arabicName = element;
              _nameAsPassport.add(_arabicName);
            }
            if(element.nameTypeController.text == 'ENG'){
              _englishName = element;
              _nameAsPassport.add(_englishName);
            }
          }
        }
      }

      /// passport Data Prefilled
      _passportNationalityController.text = cleanedDraft['country'] ?? '';
      _passportPlaceOfIssueController.text = cleanedDraft['passportIssuePlace'] ?? '';
      _passportNumberController.text = cleanedDraft['passportId'] ?? '';
      _passportIssueDateController.text = formatDateOnly(cleanedDraft['passportIssueDate'].toString() ?? '');
      _passportExpiryDateController.text = formatDateOnly(cleanedDraft['passportExpiryDate'].toString() ?? '');
      _passportUnifiedNoController.text = cleanedDraft['unifiedNo'].toString() ?? '';


      /// Personal Information Prefilled
      _emiratesIdController.text = cleanedDraft['emirateId'].toString();
      _emiratesIdExpiryDateController.text = formatDateOnly(cleanedDraft['emirateIdExpiryDate'].toString() ?? '');
      _dateOfBirthController.text = formatDateOnly(cleanedDraft['dateOfBirth'].toString() ?? '');
      _placeOfBirthController.text = cleanedDraft['placeOfBirth'] ?? '';
      _genderController.text = cleanedDraft['gender'] ?? '';
      _maritalStatusController.text = cleanedDraft['maritalStatus'] ?? '';
      _studentEmailController.text = cleanedDraft['emailId'] ?? '';
      _isMotherUAECheckbox = cleanedDraft["uaeMother"] == 'true'? true : false;


      /// family information
      _familyInformationEmiratesController.text = cleanedDraft['familyNo'] ?? '';
      // _populateTownOnFamilyInformationEmiratesItem(langProvider: langProvider);
      _familyInformationTownVillageNoController.text = cleanedDraft['town'] ?? '';
      _familyInformationParentGuardianNameController.text = cleanedDraft['parentName'] ?? '';
      _familyInformationRelationTypeController.text = cleanedDraft['relationType'] ?? '';
      _familyInformationFamilyBookNumberController.text = cleanedDraft['familyNumber'] ?? '';
      _familyInformationMotherNameController.text = cleanedDraft['motherName'] ?? '';

      /// Relative Details
      _isRelativeStudyingFromScholarship = cleanedDraft['relativeStudyinScholarship'] == 'true';
      if ((_isRelativeStudyingFromScholarship ?? false) && cleanedDraft['relativeDetails'] != null && cleanedDraft['relativeDetails'].toString().trim().isNotEmpty) {

        _relativeInfoList.clear();

        if(cleanedDraft['relativeDetails'] is List)
        {
          for (var element in cleanedDraft['relativeDetails']) {
            _relativeInfoList.add(RelativeInfo.fromJson(element));
          }
        }
        else{
          _relativeInfoList.add(RelativeInfo.fromJson(cleanedDraft['relativeDetails']));
        }

      }

      /// Contact Information
      if (cleanedDraft['phoneNunbers'] != null && cleanedDraft['phoneNunbers'].toString().trim().isNotEmpty) {
        _phoneNumberList.clear();
        for (var element in cleanedDraft['phoneNunbers']) {
          _phoneNumberList.add(PhoneNumber.fromJson(element));
        }
      }


      /// address information
      if (cleanedDraft['addressList'] != null && cleanedDraft['addressList'].toString().trim().isNotEmpty) {
        _addressInformationList.clear(); /// Clear the current list


        if (cleanedDraft['addressList'] is List) {
          for (int index = 0;
          index < cleanedDraft['addressList'].length;
          index++) {
            var element = cleanedDraft['addressList'][index];
            _addressInformationList.add(Address.fromJson(element)); /// Add to the list
          }
        } else {
          _addressInformationList.add(Address.fromJson(cleanedDraft['addressList'])); /// Add to the list
        }
      }


      /// military Services:
      _militaryServiceController.text = cleanedDraft['militaryService'] ?? '';
      switch (_militaryServiceController.text) {
        case 'Y':
          _isMilitaryService = MilitaryStatus.yes;
        case 'N':
          _isMilitaryService = MilitaryStatus.no;
        case 'P':
          _isMilitaryService = MilitaryStatus.postponed;
        case 'R':
          _isMilitaryService = MilitaryStatus.exemption;
      }
      _militaryServiceStartDateController.text =  formatDateOnly(cleanedDraft['militaryServiceStartDate'] ?? '');
      _militaryServiceEndDateController.text =  formatDateOnly(cleanedDraft['militaryServiceEndDate'] ?? '');
      _reasonForMilitaryController.text = cleanedDraft['reasonForMilitarty'] ?? '';


      /// high school
      if (cleanedDraft['highSchoolList'] != null && displayHighSchool()) {
        _highSchoolList.clear(); /// Clear the current list
        if (cleanedDraft['highSchoolList'] is List) {

          for (int index = 0; index < cleanedDraft['highSchoolList'].length; index++) {
            var element = cleanedDraft['highSchoolList'][index];
            _highSchoolList.add( HighSchool(
                hsLevelController: TextEditingController(text: element['hsLevel']),
                hsNameController: TextEditingController(text: element['hsName']),
                hsCountryController: TextEditingController(text: element['hsCountry']),
                hsStateController: TextEditingController(text: element['hsState']),
                yearOfPassingController: TextEditingController(text: formatDateOnly(element['yearOfPassing'])),
                hsTypeController: TextEditingController(text: element['hsType']),
                curriculumTypeController: TextEditingController(text: element['curriculumType']),
                curriculumAverageController: TextEditingController(text: element['curriculumAverage']),
                otherHsNameController: TextEditingController(text: element['otherHsName'] ),
                passingYearController: TextEditingController(text: element['passignYear']),
                maxDateController: TextEditingController(text: formatDateOnly(element['maxDate'])),
                disableStateController: TextEditingController(text: element['disableState']),
                isNewController: TextEditingController(text: element['isNew']),
                highestQualificationController: TextEditingController(text: element['highestQualification']),
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
                hsDetails: (element['hsDetails'] is List
                    ? (element['hsDetails'] as List)
                    .map((e) => HSDetails.fromJson(e))
                    .toList()
                    : []), /// Provide an empty list if hsDetails is not a List

                otherHSDetails: (element['otherHSDetails'] is List
                    ? (element['otherHSDetails'] as List)
                    .map((e) => HSDetails.fromJson(e))
                    .toList()
                    : []), /// Provide an empty list if otherHSDetails is not a List
                schoolStateDropdownMenuItems: [],
                schoolNameDropdownMenuItems: [],
                schoolTypeDropdownMenuItems: [],
                schoolCurriculumTypeDropdownMenuItems: [])); /// Add to the list
          }
        } else {
          _highSchoolList.add(HighSchool.fromJson(cleanedDraft['highSchoolList'])); /// Add to the list
        }
      }

      /// graduation details
      if (cleanedDraft['graduationList'] != null &&  cleanedDraft['graduationList'].toString().trim().isNotEmpty) {
        _graduationDetailsList.clear(); /// Clear the current list
        if(cleanedDraft['graduationList'] is List) {

          for (int index = 0; index < cleanedDraft['graduationList'].length; index++) {
            var element = cleanedDraft['graduationList'][index];
            _graduationDetailsList.add(GraduationInfo.fromJson(element)); /// Add to the list
            /// populate dropdowns
            // _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: index);
            // _populateUniversityMenuItemsList(langProvider: langProvider, index: index);
          }

        }
        else{
          _graduationDetailsList.add(GraduationInfo.fromJson(cleanedDraft['graduationList'])); /// Add to the list
          /// populate dropdowns
          // _populateGraduationLastTermMenuItemsList(langProvider: langProvider, index: 0);
          // _populateUniversityMenuItemsList(langProvider: langProvider, index: 0);
        }
      }

      /// special case
      if(cleanedDraft['isSpecialCase'] != null){
       isSpecialCase = cleanedDraft['isSpecialCase'].toString() == 'true';
      }


      /// academic programs
      _acadProgramDdsController.text = cleanedDraft['acadProgramDds'] ?? '';
      _acadProgramPgrdController.text = cleanedDraft['acadProgramPgrd'] ?? '';

      _majorsMenuItemsList =   getMajors(academicCareer: widget.applicationStatusDetails.acadCareer,
          admitType: widget.applicationStatusDetails.admitType,
          scholarshipType: widget.applicationStatusDetails.scholarshipType,
          isStudyCountry: isStudyCountry,
          isSpecialCase: isSpecialCase);

      /// majors
      if (cleanedDraft['majorWishList'] != null && cleanedDraft['majorWishList'] != 'true' && cleanedDraft['majorWishList'].toString().trim().isNotEmpty) {
        _majorsWishlist.clear(); /// Clear the current list
        if(cleanedDraft['majorWishList'] is List){
          for (int index = 0;
          index < cleanedDraft['majorWishList'].length;
          index++) {
            var element = cleanedDraft['majorWishList'][index];
            _majorsWishlist.add(MajorWishList.fromJson(element)); /// Add to the list
          }
        }
        else{
          _majorsWishlist.add(MajorWishList.fromJson(cleanedDraft['majorWishList'])); /// Add to the list
        }
      }

      /// university Priority
      if (cleanedDraft['universtiesPriorityList'] != null &&  cleanedDraft['universtiesPriorityList'].toString().trim().isNotEmpty) {
        _universityPriorityList.clear(); /// Clear the current list

        if( cleanedDraft['universtiesPriorityList'] is List){

          for (int index = 0; index < cleanedDraft['universtiesPriorityList'].length; index++) {
            var element = cleanedDraft['universtiesPriorityList'][index];
            _universityPriorityList.add(UniversityPriority.fromJson(element)); /// Add to the list
            populateUniversitiesWishList(_universityPriorityList[index]);
          }}
        else{
          _universityPriorityList.add(UniversityPriority.fromJson(cleanedDraft['universtiesPriorityList']));
          populateUniversitiesWishList(_universityPriorityList[0]);
        }
      }

      /// required Examinations
      if (cleanedDraft['requiredExaminationList'] != null && cleanedDraft['requiredExaminationList'].toString().trim().isNotEmpty) { // Make sure we are checking as a string
        _requiredExaminationList.clear(); // Clear the current list
        if (cleanedDraft['requiredExaminationList'] is List) {
          // If it's a list, iterate through it
          for (int index = 0; index < cleanedDraft['requiredExaminationList'].length; index++) {
            var element = cleanedDraft['requiredExaminationList'][index];
            _requiredExaminationList.add(RequiredExaminations.fromJson(element)); // Add to the list
            // populate examination type dropdown
            // _populateExaminationTypeDropdown(langProvider: langProvider, index: index);
          }
        } else {
          // If it's not a list (presumably a single object), handle it here
          _requiredExaminationList.add(RequiredExaminations.fromJson(cleanedDraft['requiredExaminationList'])); // Add to the list
          // _populateExaminationTypeDropdown(langProvider: langProvider, index: 0);
        }
      }

      /// Employment History
      /// employment Status
      _employmentStatus = cleanedDraft['employmentStatus'] ?? '';
      if (cleanedDraft['emplymentHistory'] != null && cleanedDraft['emplymentHistory'] != 'true' &&  displayEmploymentHistory()) {
        _employmentHistoryList.clear(); /// Clear the current list

        if (cleanedDraft['emplymentHistory'] is List) {

          for (int index = 0;
          index < cleanedDraft['emplymentHistory'].length;
          index++) {
            var element = cleanedDraft['emplymentHistory'][index];
            _employmentHistoryList.add(EmploymentHistory.fromJson(
                element)); /// Add to the list
            /// populate examination type dropdown
            // _populateExaminationTypeDropdown(
            //   langProvider: langProvider,
            //   index: index,
            // );
          }
        } else {
          _employmentHistoryList.add(EmploymentHistory.fromJson(
              cleanedDraft['emplymentHistory'])); /// Add to the list
          /// populate examination type dropdown
          // _populateExaminationTypeDropdown(
          //   langProvider: langProvider,
          //   index: 0,
          // );
        }
      }

      /// attachments
      if (cleanedDraft['attachments'] != null && cleanedDraft['attachments'].toString().trim().isNotEmpty) {
        bool hasValidAttachments = true;

        if (cleanedDraft['attachments'] is List) {
          for (var element in cleanedDraft['attachments']) {
            /// Check if processCD or documentCD is empty
            if ((element['processCD'] == null || element['processCD'].toString().trim().isEmpty) ||
                (element['documentCD'] == null || element['documentCD'].toString().trim().isEmpty)) {
              hasValidAttachments = false;
              break;
            }
          }
        } else {
          var element = cleanedDraft['attachments'];
          /// Check if processCD or documentCD is empty for single attachment
          if ((element['processCD'] == null || element['processCD'].toString().trim().isEmpty) ||
              (element['documentCD'] == null || element['documentCD'].toString().trim().isEmpty)) {
            hasValidAttachments = false;
          }
        }

        if (hasValidAttachments) {
          /// Clear and add attachments if valid
          // _myAttachmentsList.clear();
          _filteredMyAttachmentsList.clear();

          if (cleanedDraft['attachments'] is List) {
            for (var element in cleanedDraft['attachments']) {
              // _myAttachmentsList.add(Attachment.fromJson(element));
              _filteredMyAttachmentsList.add(Attachment.fromJson(element));
            }
          } else {
            // _myAttachmentsList.add(Attachment.fromJson(cleanedDraft['attachments']));
            _filteredMyAttachmentsList.add(Attachment.fromJson(cleanedDraft['attachments']));
          }
        }
      }

    });
  }


  /// Functions to check that eligible to show
  bool displayHighSchool(){
    /// We will show High school details option to UG,UGRD ,SCHL and HCHL scholarship types
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    return (academicCareer == 'UG' ||
        academicCareer == 'UGRD' ||
        academicCareer == 'SCHL' ||
        academicCareer == 'HCHL');
  }
  bool isUniversityAndMajorsRequired() {
    return widget.applicationStatusDetails.acadCareer != 'SCHL';
  }
  bool displayEmploymentHistory() {
    final key = widget.configurationKey;
    return (key == 'SCOPGRDINT' || key == 'SCOPGRDEXT' || key == 'SCODDSEXT');
  }

  bool isRequiredExaminationDetailsRequired() {
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    return !(academicCareer == 'SCHL' || academicCareer == 'HCHL');
  }







  /// Helper method for university
  List<Values> populateUniversitiesWishList(UniversityPriority universityInfo)
  {
    String country = universityInfo.countryIdController.text;
    /// Step 1: Fetch initial list of universities based on country
    List<Values> items = fetchListOfValue("UNIVERSITY#$country#UNV");

    /// List to store final items
    List<Values> itemsNew = [];

    // / Step 2: Handle special case
    if (isSpecialCase ?? false) {
      // itemsNew.add(const DropdownMenuItem(
      //     value: "OTH", child: Text("آخر"))); /// "OTH" means "Other"
      itemsNew.add(Values(code: 'OTH',value: 'Other',valueArabic: 'آخر',));
    }

    /// Step 3: Check for different admit types
    if (widget.applicationStatusDetails.admitType?.toUpperCase() == "NLU") {
      /// For "NLU" admit type
      itemsNew = fetchListOfValue("EXTUNIVERSITYNL#$country#UNV");
    } else if (country.toUpperCase() == "GBR") {
      /// For country "GBR"
      // itemsNew.add(const DropdownMenuItem(value: "OTH", child: Text("آخر")));
      itemsNew.add(Values(code: 'OTH',value: 'Other',valueArabic: 'آخر',));
    } else if (country.toUpperCase() != "ARE" && widget.applicationStatusDetails.scholarshipType?.toUpperCase() != "INT") {
      /// For countries not equal to "ARE" and scholarship type not "INT"
      itemsNew = fetchListOfValue("GRAD_UNIVERSITY#$country#UNV");
    } else if (widget.applicationStatusDetails.scholarshipType?.toUpperCase() == "INT" && widget.applicationStatusDetails.admitType?.toUpperCase() == "MET") {
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

    // universityInfo.universityDropdown = itemsNew;
    return itemsNew;
  }


  List<Values> fetchListOfValue(String key) {
    /// Your logic to fetch values goes here
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    if (Constants.lovCodeMap[key]?.values != null) {
      return Constants.lovCodeMap[key]!.values!;

        populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap[key]!.values!,
        provider: langProvider,
        textColor: AppColors.scoButtonColor,
      );
    } else {
      /// Handle the case where the values are null (e.g., return an empty list or log an error)
      return []; /// or any appropriate fallback
    }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();

      await _initializeData();
    });

    super.initState();
  }

  bool _isProcessing = false;
  void setProcessing(bool isProcessing) {
    setState(() {
      _isProcessing = isProcessing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomSimpleAppBar(
          titleAsString: localization.myApplications,
        ),
        body: Utils.pageRefreshIndicator(child: _buildUi(localization), onRefresh: _initializeData)

    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetAllActiveScholarshipsViewModel>(
      builder: (context,getActiveScholarshipProvider,_){
        switch (getActiveScholarshipProvider.apiResponse.status) {
          case Status.LOADING:
        return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return Center(
              child: Text(
                AppLocalizations.of(context)!.somethingWentWrong,
              ),
            );
          case Status.COMPLETED:
            return Consumer<GetSubmittedApplicationDetailsByApplicationNumberViewModel>(
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
                      return SingleChildScrollView(
                        child: Directionality(
                          textDirection: getTextDirection(langProvider),
                          child: Padding(
                            padding:  EdgeInsets.all(kPadding),
                            child: _applicationDetails(langProvider:langProvider,localization: localization),
                          ),
                        ),
                      );

                    case Status.NONE:
                      return showVoid;
                    case null:
                      return showVoid;
                  }
                });

          case Status.NONE:
            return Utils.showOnNone();
          case null:
            return showVoid;
        }
      },
    );
  }


  /// Application Details View
Widget _applicationDetails({required langProvider,required AppLocalizations localization}){
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    return Column(
      children: [
        CustomInformationContainer(
          title: localization.studentInformation,
          expandedContentPadding: EdgeInsets.zero,
          expandedContent: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        /// Arabic Name Information Section
        _sectionsWithPadding(title: localization.arabicNameAsPassport,
            children: [
          CustomInformationContainerField(title: localization.studentNameArabic, description: _arabicName.studentNameController.text,),
          CustomInformationContainerField(title: localization.fatherNameArabic, description: _arabicName.fatherNameController.text,),
          CustomInformationContainerField(title: localization.grandfatherNameArabic, description: _arabicName.grandFatherNameController.text,),
          CustomInformationContainerField(title: localization.familyNameArabic, description: _arabicName.familyNameController.text,isLastItem: true,),
        ]),
        /// ******************************************************************************************************************************
        const MyDivider(color: AppColors.darkGrey),
        /// English Name Information Section
        _sectionsWithPadding(title: localization.englishNameAsPassport, children:
        [
          CustomInformationContainerField(title: localization.studentNameEnglish, description: _englishName.studentNameController.text,),
          CustomInformationContainerField(title: localization.fatherNameEnglish, description: _englishName.fatherNameController.text,),
          CustomInformationContainerField(title: localization.grandfatherNameEnglish, description: _englishName.grandFatherNameController.text,),
          CustomInformationContainerField(title: localization.familyNameEnglish, description: _englishName.familyNameController.text,isLastItem: true,),
        ]),

        /// ******************************************************************************************************************************
        const MyDivider(color: AppColors.darkGrey),
        /// Passport Details Information Section
        _sectionsWithPadding(title: localization.passportInformation, children: [
          CustomInformationContainerField(title: localization.nationality, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code: _passportNationalityController.text)),
          CustomInformationContainerField(title: localization.passportNumber, description:  _passportNumberController.text),
          CustomInformationContainerField(title: localization.passportIssueDate, description:  _passportIssueDateController.text),
          CustomInformationContainerField(title: localization.passportExpireDate, description:  _passportExpiryDateController.text),
          CustomInformationContainerField(title: localization.passportPlaceofIssue, description:  _passportPlaceOfIssueController.text),
          CustomInformationContainerField(title: localization.unifiedNumber, description:  _passportUnifiedNoController.text,isLastItem: true,),
        ]),

        /// ******************************************************************************************************************************
        const MyDivider(color: AppColors.darkGrey),
        /// Personal Information Section
        _sectionsWithPadding(title: localization.personalDetails, children: [
          CustomInformationContainerField(title: localization.emiratesId, description:  _emiratesIdController.text),
          CustomInformationContainerField(title: localization.emirateidExpiryDate, description:  _emiratesIdExpiryDateController.text),
          CustomInformationContainerField(title: localization.brithDate, description:  _dateOfBirthController.text),
          CustomInformationContainerField(title: localization.birthPlace, description:  _placeOfBirthController.text),
          CustomInformationContainerField(title: localization.gender, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'GENDER',code: _genderController.text)),
          CustomInformationContainerField(title: localization.maritalStatus, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'MARITAL_STATUS',code: _maritalStatusController.text)),
          CustomInformationContainerField(title: localization.emailAddress, description: _studentEmailController.text,isLastItem: !(_passportNationalityController.text != "ARE" && widget.applicationStatusDetails.admitType != 'INT'),),
          /// Is mother uae national
          if(_passportNationalityController.text != "ARE" &&
              widget.applicationStatusDetails.admitType != 'INT')
            CustomGFCheckbox(
                value: _isMotherUAECheckbox,
                onChanged: (value) {
                  setState(() {
                    _isMotherUAECheckbox = value ?? false;
                    _motherUAENationalController.text =
                        _isMotherUAECheckbox.toString();
                  });
                },
                text: localization.uaeMother,
                textStyle: AppTextStyles.titleTextStyle()
                    .copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
        ]),

        /// ******************************************************************************************************************************
        /// Family Information
        if(_passportNationalityController.text == 'ARE')
          Column(
            children: [
              const MyDivider(color: AppColors.darkGrey),
              _sectionsWithPadding(title: localization.familyInformation, children: [
                CustomInformationContainerField(title: localization.familyEmirates, description:  getFullNameFromLov(langProvider: langProvider,code: _familyInformationEmiratesController.text,lovCode: 'EMIRATES_ID')),
                CustomInformationContainerField(title: localization.numberOfTown, description:  getFullNameFromLov(langProvider: langProvider,code: _familyInformationTownVillageNoController.text,lovCode: 'VILLAGE_NUM#${_familyInformationEmiratesController.text}')),
                CustomInformationContainerField(title: localization.parentName, description:  _familyInformationParentGuardianNameController.text),
                CustomInformationContainerField(title: localization.relationType, description:  getFullNameFromLov(langProvider: langProvider,code: _familyInformationRelationTypeController.text,lovCode: 'RELATIONSHIP_TYPE')),
                CustomInformationContainerField(title: localization.familyNumber, description:  _familyInformationFamilyBookNumberController.text),
                CustomInformationContainerField(title: localization.motherName, description:  _familyInformationMotherNameController.text,isLastItem: true),
              ])
            ],
          ),

        /// ******************************************************************************************************************************
        const MyDivider(color: AppColors.darkGrey),
        /// Relative Information
        _sectionsWithPadding(title: localization.relativesInfo, children: [
          /// Yes or no : Show round checkboxes
          CustomRadioListTile(
            value: true,
            groupValue: _isRelativeStudyingFromScholarship,
            onChanged: (value) {
            },
            title: localization.yes,
            textStyle: textFieldTextStyle,
          ),

          /// ****************************************************************************************************************************************************
          CustomRadioListTile(
              value: false,
              groupValue: _isRelativeStudyingFromScholarship,
              onChanged: (value) {
              },
              title: localization.no,
              textStyle: textFieldTextStyle),

          _isRelativeStudyingFromScholarship == null
              ? showVoid
              : _isRelativeStudyingFromScholarship! ?

          ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _relativeInfoList.length,
          itemBuilder: (context, index) {
          final relativeInformation = _relativeInfoList[index];
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
        kFormHeight,
        CustomInformationContainerField(title: localization.relativeName, description: relativeInformation.relativeNameController.text,),
        CustomInformationContainerField(title: localization.relationType, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'RELATIONSHIP_TYPE',code: relativeInformation.relationTypeController.text,), ),
        CustomInformationContainerField(title: localization.university, description: relativeInformation.countryUniversityController.text,isLastItem: true,),
        if(index < _relativeInfoList.length -1)  const MyDivider(color: AppColors.lightGrey),
          ]);}) :showVoid
        ]),

        /// ******************************************************************************************************************************
        const MyDivider(color: AppColors.darkGrey),
        /// Contact Information
        _sectionsWithPadding(title: localization.contactInformation, children: [
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
                      CustomInformationContainerField(title: localization.submissionPhoneType, description: phoneNumber.phoneTypeController.text,),
                      CustomInformationContainerField(title: localization.homeNumber, description: phoneNumber.phoneNumberController.text,),
                      CustomInformationContainerField(title: localization.submissionCountryCode, description: phoneNumber.countryCodeController.text,),
                      CustomGFCheckbox(
                        value: phoneNumber.preferred,
                        onChanged: (onChanged) {
                        },
                        text: localization.submissionPreferred,),

                    if(index < _phoneNumberList.length -1)  sectionDivider(color:  AppColors.darkGrey)
                    ]);})

        ]),
          ])),
        kFormHeight,
        /// Address Information
        CustomInformationContainer(title: localization.addressDetails,
            expandedContentPadding: EdgeInsets.zero,
            expandedContent: Column(
          children: [
            /// ******************************************************************************************************************************
            /// Address Information
            ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(kPadding),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _addressInformationList.length,
                itemBuilder: (context, index) {
                  final addressInformation = _addressInformationList[index];
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        sectionTitle(title: localization.addressDetails + (index +1).toString() ),
                        kFormHeight,
                        CustomInformationContainerField(title: localization.addressType, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'ADDRESS_TYPE',code:  addressInformation.addressTypeController.text)),
                        CustomInformationContainerField(title: localization.addressLine1, description: addressInformation.addressLine1Controller.text,),
                        CustomInformationContainerField(title: localization.addressLine2, description: addressInformation.addressLine2Controller.text,),
                        CustomInformationContainerField(title: localization.country, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code:  addressInformation.countryController.text)),
                        CustomInformationContainerField(title: localization.emirates, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'STATE#${addressInformation.countryController.text}',code:  addressInformation.stateController.text)),
                        CustomInformationContainerField(title: localization.city, description: addressInformation.cityController.text,),
                        CustomInformationContainerField(title: localization.poBox, description: addressInformation.postalCodeController.text,isLastItem: true,),
                        if(index < _addressInformationList.length -1)  sectionDivider(color:  AppColors.darkGrey)
                      ]);})
          ],
        )),
        kFormHeight,
        /// Military Service Information
       if(_passportNationalityController.text.isNotEmpty && _passportNationalityController.text == "ARE") CustomInformationContainer(title: localization.militaryServicePanel,
            expandedContentPadding: EdgeInsets.zero,
            expandedContent: Column(
          children: [
            /// ******************************************************************************************************************************
            /// Military Service Information
            _sectionsWithPadding(title: localization.militaryService, children: [
              CustomRadioListTile(
                value: MilitaryStatus.yes,
                groupValue: _isMilitaryService,
                onChanged: (value) {
                },
                title: localization.yes,
                textStyle: textFieldTextStyle,
              ),

              /// ****************************************************************************************************************************************************
              CustomRadioListTile(
                  value: MilitaryStatus.no,
                  groupValue: _isMilitaryService,
                  onChanged: (value) {
                  },
                  title: localization.no,
                  textStyle: textFieldTextStyle),

              /// ****************************************************************************************************************************************************
              CustomRadioListTile(
                  value: MilitaryStatus.postponed,
                  groupValue: _isMilitaryService,
                  onChanged: (value) {
                  },
                  title: localization.postpond,
                  textStyle: textFieldTextStyle),

              /// ****************************************************************************************************************************************************
              CustomRadioListTile(
                  value: MilitaryStatus.exemption,
                  groupValue: _isMilitaryService,
                  onChanged: (value) {
                  },
                  title: localization.relief,
                  textStyle: textFieldTextStyle),

              kFormHeight,
              if(_isMilitaryService == MilitaryStatus.yes)
                Column(
                  children: [
                    CustomInformationContainerField(title: localization.militaryServiceStartDate,description: _militaryServiceStartDateController.text,),
                    CustomInformationContainerField(title: localization.militaryServiceEndDate,description: _militaryServiceEndDateController.text,)
                  ],
                ),
              if(_isMilitaryService == MilitaryStatus.no) showVoid,
              if(_isMilitaryService == MilitaryStatus.postponed) CustomInformationContainerField(title: localization.militaryReason,description: _reasonForMilitaryController.text,),
              if(_isMilitaryService == MilitaryStatus.exemption) CustomInformationContainerField(title: localization.militaryReason,description: _reasonForMilitaryController.text,),
            ])

          ],
        )),

        kFormHeight,
        /// High School Information
        if(displayHighSchool())CustomInformationContainer(
              title: localization.highSchoolDetails,
              expandedContent: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _highSchoolList.length,
                      itemBuilder: (context, index) {
                        final highSchoolInfo = _highSchoolList[index];
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              sectionTitle(title: "${localization.highSchoolDetails} ${index + 1}"),
                              kFormHeight,
                              CustomInformationContainerField(title: localization.hsLevel,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'HIGH_SCHOOL_LEVEL',code: highSchoolInfo.hsLevelController.text),),
                              CustomInformationContainerField(title: localization.schoolCountry,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code: highSchoolInfo.hsCountryController.text),),
                              CustomInformationContainerField(title: localization.emirates,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'STATE#${highSchoolInfo.hsCountryController.text}',code: highSchoolInfo.hsStateController.text),),
                              if (highSchoolInfo.hsCountryController.text == 'ARE')CustomInformationContainerField(title: localization.hsName,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'SCHOOL_CD#${highSchoolInfo.hsStateController.text}', code: highSchoolInfo.hsNameController.text,),),
                              if (highSchoolInfo.hsCountryController.text != 'ARE' || highSchoolInfo.hsNameController.text == 'OTH')CustomInformationContainerField(title: highSchoolInfo.hsCountryController.text == 'ARE' ? localization.hsnameOther : localization.hsName,description:  highSchoolInfo.otherHsNameController.text,),
                              CustomInformationContainerField(title: localization.hsType,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'HIGH_SCHOOL_TYPE',code: highSchoolInfo.hsTypeController.text),),
                              CustomInformationContainerField(title: localization.curriculumTypes,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'CURRICULM_TYPE#${highSchoolInfo.hsTypeController.text}',code: highSchoolInfo.curriculumTypeController.text),),
                              CustomInformationContainerField(title: localization.curriculumAverage,description: highSchoolInfo.curriculumAverageController.text,),
                              CustomInformationContainerField(title: localization.hsYearOfPassing,description: highSchoolInfo.yearOfPassingController.text,),
                              CustomInformationContainerField(title: localization.hsDateOfGraduation,description: highSchoolInfo.passingYearController.text,),
                              sectionTitle(title: localization.highschoolSubjects),
                              kFormHeight,
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: highSchoolInfo.hsDetails.length,
                                  itemBuilder: (context, index) {
                                    var element = highSchoolInfo.hsDetails[index];
                                    return Column(
                                      children: [
                                        CustomInformationContainerField(
                                          title: getFullNameFromLov(langProvider: langProvider,lovCode: 'SUBJECT',code: element.subjectTypeController.text),
                                          description: element.gradeController.text,
                                        ),
                                      ],
                                    );
                                  }),
                             // sectionDivider(),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: highSchoolInfo.otherHSDetails.length,
                                  itemBuilder: (context, index) {
                                    var element = highSchoolInfo.otherHSDetails[index];
                                    return Column(
                                        children: [
                                          CustomInformationContainerField(
                                            title: element.otherSubjectNameController.text,
                                            description: element.gradeController.text,
                                          ),
                                        ]);}),
                              // CustomInformationContainerField(title: localization.curriculumTypes,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'HIGH_SCHOOL_TYPE',code: highSchoolInfo.curriculumTypeController.text),),
                              if(index < _highSchoolList.length -1) sectionDivider(color: AppColors.darkGrey)
                            ]);})
                ],
          )),

        kFormHeight,
        /// Graduation Information
        if(academicCareer != 'SCHL' && academicCareer != 'HCHL')
          Column(
            children: [
              CustomInformationContainer(title: academicCareer == 'DDS' ? localization.ddsGraduationTitle : localization.graduationDetails,
                  expandedContent: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _graduationDetailsList.length,
                          itemBuilder: (context, index) {
                            final graduationInfo = _graduationDetailsList[index];
                            var graduationRecord = _graduationDetailsList.map((element){return element.toJson();}).toList();
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  sectionTitle(title: academicCareer == 'DDS' ? '${localization.ddsGraduationTitle} ${index + 1}' : "${localization.graduationDetails} ${index + 1}"),
                                  // if(graduationInfo.showCurrentlyStudying)
                                  if( graduationInfo.levelController.text == markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecord))
                                    Column(
                                    children: [
                                      kFormHeight,
                                      CustomInformationContainerField(title: localization.currentlyStudying,isLastItem: true,),
                                      CustomRadioListTile(
                                        value: true,
                                        groupValue: graduationInfo.currentlyStudying,
                                        onChanged: (value) {},
                                        title: localization.yes,
                                        textStyle: textFieldTextStyle,
                                      ),
                                      CustomRadioListTile(
                                          value: false,
                                          groupValue: graduationInfo
                                              .currentlyStudying,
                                          onChanged: (value) {},
                                          title: localization.no,
                                          textStyle: textFieldTextStyle),
                                    ],
                                  ),
                                    Column(
                                    children: [
                                      if(graduationInfo.currentlyStudying && graduationInfo.showCurrentlyStudying)
                                      CustomInformationContainerField(title: localization.lastTerm,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'LAST_TERM',code:graduationInfo.lastTermController.text ),),
                                      (academicCareer == 'UGRD') ? (graduationInfo.currentlyStudying ?

                                      /// copy paste full below code
                                      /// for "UGRD" Specially We are not willing to provide add more graduation information. so we will give static option to fill graduation details for bachelor
                                      _graduationInformation(
                                          index: index,
                                          langProvider: langProvider,
                                          graduationInfo: graduationInfo)
                                          : showVoid)
                                          : Column(
                                            children: [
                                              kFormHeight,
                                              _graduationInformation(
                                              index: index,
                                              langProvider: langProvider,
                                              graduationInfo: graduationInfo),
                                            ],
                                          ),
                                    ],
                                  ),

                                  if(index < _graduationDetailsList.length-1) sectionDivider()
                                ]);
                          })

                    ],
                  ))

            ],
          ),
        kFormHeight,

        /// University and majors
        if(isUniversityAndMajorsRequired())Column(
          children: [
            /// majors
            CustomInformationContainer(title: academicCareer == 'PGRD'
                ? localization.pgrdMajorWishlist
                : localization.majorWishlist, expandedContent: Column(
              children: [
                /// PGRD Academic Career
                if(academicCareer == 'PGRD' && academicCareer != 'DDS')CustomInformationContainerField(title: localization.pgrdAdacProgram,
                  description: getFullNameFromLov(langProvider: langProvider,lovCode: 'ACAD_PROG_PGRD',code: _acadProgramPgrdController.text),
                ),
                /// Major Selection
                if(academicCareer != 'DDS')
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _majorsWishlist.length,
                      itemBuilder: (context, index) {
                        final majorInfo = _majorsWishlist[index];
                        return Column(children: [
                          CustomInformationContainerField(title: index == 0
                              ? localization.majorsWish1
                              : index == 1
                              ? localization.majorsWish2
                              : localization.majorsWish3,
                            description: getFullNameForMajor(majorInfo.majorController.text).toString(),
                          ),
                          if(academicCareer != 'DDS' && majorInfo.majorController.text == 'OTH')
                            CustomInformationContainerField(title: localization.otherMajor,
                              description: majorInfo.otherMajorController.text,
                            ),
                        ]);
                      }),
                /// DDS Major Selection
                if(academicCareer == 'DDS')CustomInformationContainerField(title: localization.ddsMajor1,
                  description: getFullNameFromLov(langProvider: langProvider,lovCode: 'ACAD_PROG_DDS',code: _acadProgramDdsController.text),

                )
              ],
            )),
            kFormHeight,

            /// University priority List
            if(academicCareer != 'HCHL')
              CustomInformationContainer(title: academicCareer == 'DDS' ? localization.ddsWishlist : localization.universityWishList,
                expandedContent:  Column(
                  children: [if (academicCareer != 'HCHL') Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _universityPriorityList.length,
                          itemBuilder: (context, index) {
                            final universityInfo = _universityPriorityList[index];
                            return Column(children: [
                              CustomInformationContainerField(title: localization.country, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code:universityInfo.countryIdController.text, ),),
                              if(academicCareer != 'DDS')
                                Column(
                                  children: [
                                    CustomInformationContainerField(title: localization.majors,
                                      description: getFullNameForMajor(universityInfo.majorsController.text).toString(),
                                    ),
                                    if(universityInfo.majorsController.text == 'OTH' || academicCareer == 'DDS')
                                      CustomInformationContainerField(title: academicCareer != 'DDS' ? localization.otherMajor : localization.ddsMajor,
                                        description: universityInfo.otherMajorsController.text,
                                      ),
                                    if(academicCareer != "DDS")
                                      CustomInformationContainerField(title: localization.university,
                                        description: getFullNameForUniversity(value: universityInfo.universityIdController.text, universityInfo: universityInfo)   /// TODO: UNIVERSITY FULL NAME IS PENDING TO CALCULATE
                                      ),
                                    if((universityInfo.universityIdController.text == 'OTH' ||  academicCareer == 'DDS'))
                                      CustomInformationContainerField(title: academicCareer != 'DDS'
                                          ? localization.universityNameIfOther
                                          : localization.ddsUniversity,
                                          description: universityInfo.otherUniversityNameController.text),
                                    CustomInformationContainerField(title: localization.universityStatus,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'UNIVERSITY_STATUS' ,code: universityInfo.statusController.text,),isLastItem: true,),
                                    if(index < _universityPriorityList.length - 1)  sectionDivider(color: AppColors.darkGrey)
                                  ],
                                )
                            ]);
                          })
                    ],
                  )],
                )



                ,),

            kFormHeight,
          ],
        ),

        /// Required Examination

       if(isRequiredExaminationDetailsRequired())
        Column(
          children: [
            CustomInformationContainer(
              title: academicCareer == 'DDS'
                  ? localization.ddsExams
                  : localization.examinationForUniversities,
              expandedContent: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _requiredExaminationList.length,
                      itemBuilder: (context, index) {
                        final requiredExamInfo = _requiredExaminationList[index];
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomInformationContainerField(title: localization.examination,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'EXAMINATION#$academicCareer',code:  requiredExamInfo.examinationController.text),),
                              CustomInformationContainerField(title: localization.examinationType,description:getFullNameFromLov(langProvider: langProvider,lovCode: 'EXAMINATION_TYPE#${requiredExamInfo.examinationController.text}',code: requiredExamInfo.examinationTypeIdController.text,)),
                              CustomInformationContainerField(title: academicCareer != 'DDS' ? localization.examinationGrade : localization.examinationDdsGrade,description:requiredExamInfo.examinationGradeController.text,),
                              CustomInformationContainerField(title: localization.dateExam, description:requiredExamInfo.examDateController.text,isLastItem: true,),
                              if(index < _requiredExaminationList.length - 1)  sectionDivider(color: AppColors.darkGrey)

                            ]);
                      })
                ],
              ),
            ),
            kFormHeight,
          ],
        ),

        /// Employment History
        if(displayEmploymentHistory())
          Column(
            children: [
              CustomInformationContainer(
                title: localization.employmentHistory,
                expandedContent: Column(
                  children: [
                    CustomInformationContainerField(title: localization.previouslyEmployed,isLastItem: true,),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _employmentStatusItemsList.length,
                        itemBuilder: (context, index) {
                          final element = _employmentStatusItemsList[index];
                          return CustomRadioListTile(
                            value: element.code,
                            groupValue: _employmentStatus,
                            onChanged: (value){},
                            title: getTextDirection(langProvider) ==
                                TextDirection.ltr
                                ? element.value
                                : element.valueArabic,
                            textStyle: textFieldTextStyle,
                          );
                        }),
                    kFormHeight,
                    if(_employmentStatus != null && _employmentStatus != '' && _employmentStatus != 'N')
                      Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _employmentHistoryList.length,
                              itemBuilder: (context, index) {
                                final employmentHistInfo = _employmentHistoryList[index];
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomInformationContainerField(title: localization.emphistEmployerName, description: employmentHistInfo.employerNameController.text,),
                                      CustomInformationContainerField(title: localization.emphistTitleName, description: employmentHistInfo.titleController.text,),
                                      CustomInformationContainerField(title: localization.emphistOccupationName, description: employmentHistInfo.occupationController.text,),
                                      CustomInformationContainerField(title: localization.emphistPlace, description: employmentHistInfo.placeController.text,),
                                      CustomInformationContainerField(title: localization.employmentStartDate, description: employmentHistInfo.startDateController.text,),
                                      CustomInformationContainerField(title: localization.employmentEndDate, description: employmentHistInfo.endDateController.text,),
                                      CustomInformationContainerField(title: localization.emphistReportingManager, description: employmentHistInfo.reportingManagerController.text,),
                                      CustomInformationContainerField(title: localization.emphistMgrContactNo, description: employmentHistInfo.contactNumberController.text,),
                                      CustomInformationContainerField(title: localization.managerEmail, description: employmentHistInfo.contactEmailController.text,isLastItem: true,),
                                      if(index < _employmentHistoryList.length - 1)  sectionDivider(color: AppColors.darkGrey)

                                    ]);
                              })
                        ],
                      )
                  ],
                ),
              ),
              kFormHeight,
            ],
          ),

        /// attachments
        CustomInformationContainer(
          title: localization.attachments,
          expandedContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Use the filtered lists for the ListView
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredMyAttachmentsList.length,
                    // Use filtered length
                    itemBuilder: (context, index) {
                      // final attachment = _filteredAttachmentsList[index]; // From filtered list
                      final myAttachment = _filteredMyAttachmentsList[index]; // From filtered list
                      final required = myAttachment.requiredController.text.toString();

                      return Column(
                       children: [
                         CustomInformationContainerField(title: localization.sr,description: (index + 1).toString(),),
                         CustomInformationContainerField(title: localization.requestAttachfile,

                           // description:  getFullNameFromLov(langProvider: langProvider,lovCode: _selectedChecklistCode,code: myAttachment.attachmentNameController.text).replaceAll('\n', ''),
                             descriptionAsWidget:
                             RichText(
                                 text: TextSpan(children: [
                                   TextSpan(
                                     text:  getFullNameFromLov(langProvider: langProvider,lovCode: _selectedChecklistCode,code: myAttachment.attachmentNameController.text).replaceAll('\n', ''),
                                     style: AppTextStyles.normalTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.scoButtonColor),
                                   ),
                                   TextSpan(text: (required == 'XMRL' || required == 'MRL' || required == 'NMRL') ? "*" : "", style: AppTextStyles.titleBoldTextStyle().copyWith(fontWeight: FontWeight.w600, color: Colors.red),),
                                 ]))
                         ),
                         CustomInformationContainerField(title: localization.fileName,description: myAttachment.userFileNameController.text,),
                         CustomInformationContainerField(title: localization.comment,description: myAttachment.commentController.text,isLastItem: true,),
                         if(index < _filteredMyAttachmentsList.length - 1)  sectionDivider(color: AppColors.darkGrey)
                       ],
                     );

                    })
              ]),
        )
      ],
    );
}



/// Graduation Information
Widget _graduationInformation({required int index,
        required LanguageChangeViewModel langProvider,
        required GraduationInfo graduationInfo}) {
    final academicCareer = widget.applicationStatusDetails.acadCareer;
    final localization = AppLocalizations.of(context)!;
    return Column(
        children: [
          (index > 0 && academicCareer != 'UGRD' && academicCareer != 'DDS')
              ?
              CustomInformationContainerField(title: localization.hsGraduationLevel,
              description: getFullNameFromLov(langProvider: langProvider,
                  lovCode: 'GRADUATION_LEVEL',
                  code: graduationInfo.levelController.text
              ),)
              :  (index == 0 || academicCareer == 'UGRD') ? _showBachelorScholarshipByDefault(
        index: index,
        langProvider: langProvider,
        graduationInfo: graduationInfo)  : showVoid,

          /// for dds graduation level
          if(index != 0 && academicCareer == 'DDS')
            CustomInformationContainerField(title: localization.ddsGraduationTitle2,description: getFullNameFromLov(langProvider: langProvider,
                lovCode: 'DDS_GRAD_LEVEL#SIS_GRAD_LEVEL',
                code: graduationInfo.levelController.text
            ),),

          /// Country
          CustomInformationContainerField(title: localization.country,description: getFullNameFromLov(langProvider: langProvider,
              lovCode: 'COUNTRY',
              code: graduationInfo.countryController.text,
          ),),

          /// Graduation University
          if(academicCareer != 'DDS')
            CustomInformationContainerField(title: localization.hsUniversity,description: getFullNameFromLov(langProvider: langProvider,
              lovCode: 'GRAD_UNIVERSITY#${graduationInfo.countryController.text}#UNV',
              code: graduationInfo.universityController.text,
            ),),

          /// other university
          if(graduationInfo.universityController.text == 'OTH')
            CustomInformationContainerField(title: academicCareer != 'DDS' ? localization.hsOtherUniversity
        : localization.ddsUniversity,description: graduationInfo.otherUniversityController.text,),

          /// major
          CustomInformationContainerField(title: academicCareer != 'DDS'
              ? localization.hsMajor
              : localization.ddsMajor,description: graduationInfo.majorController.text,),

          /// cgpa
          CustomInformationContainerField(title: localization.cgpa,description: graduationInfo.cgpaController.text,),

          /// start date
          CustomInformationContainerField(title: localization.hsGraducationStartDate,description: graduationInfo.graduationStartDateController.text,),

          /// end date
          CustomInformationContainerField(title: localization.hsGraducationEndDate,description: graduationInfo.graduationEndDateController.text,),

          /// question if AcademicCareer  == DDS
          if(academicCareer == 'DDS') Column(
            children: [
              CustomInformationContainerField(title: localization.ddsGradQuestion,isLastItem: true,),
              /// Yes or no : Show round radio
              CustomRadioListTile(
                value: 'Y',
                groupValue: havingSponsor,
                onChanged: (value) {},
                title: localization.yes,
                textStyle: textFieldTextStyle,
              ),
              CustomRadioListTile(
                  value: "N",
                  groupValue: havingSponsor,
                  onChanged: (value) {},
                  title: localization.no,
                  textStyle: textFieldTextStyle),

            ],
          ),

          /// Sponsorship
          if((havingSponsor == 'Y') || academicCareer != 'DDS')CustomInformationContainerField(title: localization.hsSponsorship,
            description: graduationInfo.sponsorShipController.text,),

          /// case study
          if(graduationInfo.levelController.text == 'PGRD' || graduationInfo.levelController.text == 'PG' || graduationInfo.levelController.text == 'DDS')
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(title: localization.caseStudy),
              const SizedBox(height: 5,),
              CustomInformationContainerField(title: localization.caseStudyTitle,
              description: graduationInfo.caseStudyTitleController.text,),
              CustomInformationContainerField(title: localization.caseStudyStartYear,
                description: graduationInfo.caseStudyStartYearController.text,),
              CustomInformationContainerField(title: localization.caseStudyDescription,
                description: graduationInfo.caseStudyDescriptionController.text,),
            ],
          )
        ]);
  }


  Widget _showBachelorScholarshipByDefault(
      {required int index,
        required LanguageChangeViewModel langProvider,
        required GraduationInfo graduationInfo}) {
    final localization = AppLocalizations.of(context)!;
    /// setting bachelor by default
    graduationInfo.levelController.text = 'UG';
    return Column(
      children: [
        CustomInformationContainerField(title: localization.hsGraduationLevel,
        description: getFullNameFromLov(langProvider: langProvider,
        lovCode: 'GRADUATION_LEVEL',
          code: graduationInfo.levelController.text
        ),
        )
      ],
    );
  }


/// Function to get full name for majors
String getFullNameForMajor(value){
  _majorsMenuItemsList =   getMajors(academicCareer: widget.applicationStatusDetails.acadCareer, admitType: widget.applicationStatusDetails.admitType, scholarshipType: widget.applicationStatusDetails.scholarshipType, isStudyCountry: isStudyCountry, isSpecialCase: isSpecialCase);
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    bool  isLTR =  getTextDirection(langProvider) == TextDirection.ltr;
    for(var i in _majorsMenuItemsList){
      if(i.code.toString() == value.trim()){
        if(isLTR){
          return i.value.toString();
        }
        return i.valueArabic.toString();
      }
    }
    return '';
  }


/// Function to get full name from university list
dynamic getFullNameForUniversity({required value,required universityInfo}){
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    bool  isLTR =  getTextDirection(langProvider) == TextDirection.ltr;
    final listOfValues = populateUniversitiesWishList(universityInfo);
    for(var i in listOfValues){
      if(i.code.toString() == value.trim()){
        if(isLTR){
          return i.value.toString();
        }
        return i.valueArabic.toString();
      };
    }
    return null;
  }


Widget _sectionsWithPadding({required String title,required List<Widget> children }) {
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title: title),
        kFormHeight,
        ...children
      ],
      ),
    );
}
}

/// Get majors function
List<dynamic> getMajors({
  required String academicCareer,
  required String? admitType,
  required String? scholarshipType,
  required bool isStudyCountry,
  required bool isSpecialCase,
  String? configurationKey,
})
{

  // Step 1: Define the majorCriteria based on academic career
  String majorCriteria = (academicCareer.toUpperCase() == "PGRD")
      ? "MAJORSPGRD#$academicCareer#${isStudyCountry ? 'N' : 'Y'}"
      : "MAJORS#$academicCareer#${isStudyCountry ? 'N' : 'Y'}";

  // Step 2: Fetch items based on majorCriteria
  List<dynamic> items = Constants.lovCodeMap[majorCriteria]?.values ?? [];

  // Step 3: Handle admit types and scholarship types
  if (admitType?.toUpperCase() == "ACT") {
    majorCriteria = "MAJORSACT#$academicCareer#${isStudyCountry ? 'N' : 'Y'}";
    items = Constants.lovCodeMap[majorCriteria]?.values ?? [];
  }
  else if (admitType?.toUpperCase() == "NLU") {
    majorCriteria = "MAJORSNL#$academicCareer#${isStudyCountry ? 'N' : 'Y'}";
    items = Constants.lovCodeMap[majorCriteria]?.values ?? [];
  }
  else if (scholarshipType?.toUpperCase() == "INT" && admitType?.toUpperCase() != "MET") {
    items = _filterItemsForINT(items, admitType, configurationKey);
  }
  else if (scholarshipType?.toUpperCase() == "EXT") {
    // Items remain unchanged for "EXT" scholarship type
  } else {
    // Default case to filter only "BAM" items
    items = items.where((item) => item.code?.toUpperCase() == "BAM").toList();
  }
  // Step 4: Handle special cases
  if (isSpecialCase) {
    items.add({'value': 'OTH', 'label': 'آخر'}); // Append special case "OTH"
  }
  // Return the final list of dropdown menu items
  // return populateCommonDataDropdown(menuItemsList: items, provider: langProvider);
  return items;
}

/// Helper method to filter items for "INT" scholarship type
List<dynamic> _filterItemsForINT(List<dynamic> items, String? admitType, String? configurationKey) {
  return items.where((item) {
    if (item.code?.toUpperCase() == "OTH") {
      return _isValidAdmitTypeForINT(admitType, configurationKey);
    }
    return true; // Include other items
  }).toList();
}

/// Helper method to validate "INT" admit type
bool _isValidAdmitTypeForINT(String? admitType, String? configurationKey) {
  return ["MOP", "MOS"].contains(admitType?.toUpperCase()) ||
      configurationKey?.toUpperCase() == "SCOUGRDINTHH";
}
