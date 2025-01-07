import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
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
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/media_services.dart';
import '../../../../viewModel/services/navigation_services.dart';
import '../../../../viewModel/services/permission_checker_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../apply_scholarship/form_view_Utils.dart';


class ViewApplicationDetailsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  const ViewApplicationDetailsView({super.key,required this.applicationStatusDetails});

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
  List<PersonName> _nameAsPassport = [];


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
  /// final HIGH SCHOOL list
  final List<HighSchool> _highSchoolList = [];


  /// Military service information
  MilitaryStatus? _isMilitaryService;
  final TextEditingController _militaryServiceController = TextEditingController();
  final TextEditingController _militaryServiceStartDateController = TextEditingController();
  final TextEditingController _militaryServiceEndDateController = TextEditingController();
  final TextEditingController _reasonForMilitaryController = TextEditingController();




  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// get personal details to show addresses
      final applicationDetailsProvider = Provider.of<GetSubmittedApplicationDetailsByApplicationNumberViewModel>(context, listen: false);
      await applicationDetailsProvider.getSubmittedApplicationDetailsByApplicationNumber(applicationNumber: widget.applicationStatusDetails.admApplicationNumber);

      /// clean the draft application data and prefill the fields
      Map<String, dynamic> cleanedDraft = jsonDecode(cleanDraftXmlToJson(applicationDetailsProvider.apiResponse.data?.applicationData ?? ''));


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
        body: Utils.modelProgressHud(
            processing: _isProcessing,
            child: _buildUi(localization)
        )

    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
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
  }


  /// Application Details View
Widget _applicationDetails({required langProvider,required AppLocalizations localization}){
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
       if(_passportNationalityController.text.isNotEmpty &&
           _passportNationalityController.text == "ARE") CustomInformationContainer(title: localization.militaryServicePanel,
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
              if(_isMilitaryService == MilitaryStatus.postponed) showVoid,
              if(_isMilitaryService == MilitaryStatus.exemption) CustomInformationContainerField(title: localization.militaryReason,description: _reasonForMilitaryController.text,),
            ])

          ],
        )),

        kFormHeight,
        /// High School Information
        if(displayHighSchool())
          CustomInformationContainer(
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
                              CustomInformationContainerField(title: localization.hsType,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'HIGH_SCHOOL_TYPE',code: highSchoolInfo.hsTypeController.text),),
                              // CustomInformationContainerField(title: localization.curriculumTypes,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'HIGH_SCHOOL_TYPE',code: highSchoolInfo.curriculumTypeController.text),),

                              if(index < _highSchoolList.length -1) sectionDivider(color: AppColors.darkGrey)

                            ]);})
                ],
          ))
      ],
    );
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
