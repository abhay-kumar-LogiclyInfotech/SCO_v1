

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



// "SERVICE_TYPE#AA": [
// {"code": "AA", "value": "Academic Advisement", "valueArabic": "الإرشاد الأكاديمي"},
// {"code": "FR", "value": "Financial Requests", "valueArabic": "الطلبات المالية"},
// {"code": "OL", "value": "Official Letter Request", "valueArabic": "طلب رسالة رسمية"}
// ],
// "SERVICE_TYPE#AL": [
// {"code": "AR", "value": "Administrative requests", "valueArabic": "Administrative requests"},
// {"code": "FR2", "value": "Financial Requests", "valueArabic": "Financial Requests"}
// ],
// "SERVICE_TYPE#EI": [
// {"code": "AA1", "value": "Academic Advisement", "valueArabic": "تسجيل ساعات أقل من المطلوب"},
// {"code": "FR1", "value": "Financial Requests", "valueArabic": "Financial Requests"}
// ]


// "SERVICE_CATEGORY": [
// {"code": "AA", "value": "Academic Advisement", "valueArabic": "الإرشاد الأكاديمي"},
// {"code": "AL", "value": "Alumni", "valueArabic": "شؤون الخريجين"},
// {"code": "EI", "value": "Educational initiatives", "valueArabic": "المبادرات التعليمية"}
// ]

// final serviceSubType ={
// "SERVICE_SUBTYPE#FR": [
// {"code": "1", "value": "Compensation for companion allowance", "valueArabic": "تعويض بدل مرافق"},
// {"code": "2", "value": "Tuition fee compensation", "valueArabic": "تعويض رسوم دراسية"},
// {"code": "3", "value": "Medical treatment compensation", "valueArabic": "تعويض علاجي"},
// {"code": "4", "value": "Compensation for study visit allowance (Part Time)", "valueArabic": "تعويض بدل زيارة دراسية (الطلبة الدارسين بالنظام ال"},
// {"code": "5", "value": "Payment of a marriage allowance", "valueArabic": "صرف علاوة زواج"}
// ],
// "SERVICE_SUBTYPE#AA1": [
// {"code": "1", "value": "Logging hours less than required", "valueArabic": "تسجيل ساعات أقل من المطلوب"},
// {"code": "2", "value": "Permission to travel/leave to the country of schl", "valueArabic": "Permission to travel/leave to the country of schl"}
// ],
// "SERVICE_SUBTYPE#OL": [
// {"code": "1", "value": "Student visa request letter", "valueArabic": "رسالة طلب تأشيرة دراسية visa Request letter"},
// {"code": "2", "value": "Financial guarantee letter", "valueArabic": "رسالة ضمان مالي"},
// {"code": "3", "value": "National service letter", "valueArabic": "رسالة خدمة وطنية"},
// {"code": "4", "value": "to whom it may concern letter", "valueArabic": "رسالة الى من يهمه الامر"}
// ],
// "SERVICE_SUBTYPE#FR1": [
// {"code": "1", "value": "Request to issue a ticket / exchange a cash ticket", "valueArabic": "طلب اصدار تذكرة / صرف بدل تذكرة نقدي"},
// {"code": "2", "value": "Add / change the bank account number", "valueArabic": "إضافة / تغيير رقم الحساب البنكي"}
// ],
// "SERVICE_SUBTYPE#FR2": [
// {"code": "1", "value": "Cert equivalency letter from higher education", "valueArabic": "رسالة معادلة الشهادة من التعليم العالي"},
// {"code": "2", "value": "Graduation award payment", "valueArabic": "صرف مكافأة التخرج"}
// ],
// "SERVICE_SUBTYPE#AA": [
// {"code": "1", "value": "Suspension from a semester", "valueArabic": "ايقاف من فصل دراسي"},
// {"code": "10", "value": "Meeting Request", "valueArabic": "طلب اجتماع"}, ///TODO: Add one by default from your side: Added by me
// {"code": "2", "value": "Academic extension", "valueArabic": "تمديد دراسي"},
// {"code": "3", "value": "Permission to travel/leave to the country of schl", "valueArabic": "إذن سفر/المغادرة الى بلد الابتعاث"},
// {"code": "4", "value": "Postpone a semester", "valueArabic": "تأجيل فصل دراسي"},
// {"code": "5", "value": "Withdrawing from the scholarship", "valueArabic": "انسحاب من البعثة/المنحة"},
// {"code": "6", "value": "University change", "valueArabic": "تغيير جامعة"},
// {"code": "7", "value": "major change", "valueArabic": "تغيير تخصص"},
// {"code": "8", "value": "Change major and university", "valueArabic": "تغيير التخصص والجامعة"},
// {"code": "9", "value": "Study subjects at another university", "valueArabic": "دراسة مواد دراسية بجامعة أخرى"}
// ],
// "SERVICE_SUBTYPE#AR": [
// {"code": "1", "value": "Assistance in finding job", "valueArabic": "طلب مساعدة للحصول على وظيفة"}
// ]
// }





import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/models/services/RequestStructureModel.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/get_employment_status_viewModel.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../models/services/GetAllRequestsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/attachment_add_file_button.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/create_update_employment_status_viewModel.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class CreateRequestView extends StatefulWidget {
  const CreateRequestView({super.key});

  @override
  State<CreateRequestView> createState() => _CreateRequestViewState();
}

class _CreateRequestViewState extends State<CreateRequestView>
    with MediaQueryMixin {



  
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

 List<RequestStructureModel> _requestStructureList = [];

  Future _initializeData() async {

    /// convert all requestStructure to list of type model
    for(var element in Constants.requestStructureList){
      _requestStructureList.add(RequestStructureModel.fromJson(element));
    }




    /// fetch student profile Information t prefill the user information
    // final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context,listen: false);
    // await studentProfileProvider.getPersonalDetails();

    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);

    /// Check and populate dropdowns only if the values exist
    if (Constants.lovCodeMap['SERVICE_CATEGORY']?.values != null) {
      _requestCategoryMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['SERVICE_CATEGORY']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }


    /// *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

    final getEmploymentStatusProvider = Provider.of<GetEmploymentStatusViewModel>(context, listen: false);
    await getEmploymentStatusProvider.getEmploymentStatus();

    if (getEmploymentStatusProvider.apiResponse.status == Status.COMPLETED) {
      final status = getEmploymentStatusProvider.apiResponse.data?.data?.employmentStatus;

      /// prefilling the form
      // _employmentStatusController.text = status?.employmentStatus ?? '';
      // _employerController.text = status?.employerName ?? '';
      // _commentsController.text = status?.comment ?? '';

      // if (status?.listOfFiles != null && status?.listOfFiles != []) {
      //   _attachmentsList.clear();
      //   for (int i = 0; i < status!.listOfFiles!.length; i++) {
      //     _attachmentsList
      //         .add(ListOfFiles.fromJson(status!.listOfFiles![i].toJson()));
      //   }
      // }

      /// To refresh the page
      setState(() {});
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
      _authService = getIt.get<AuthService>();

      await _initializeData();
    });

    super.initState();
  }
  @override
void dispose(){


    _requestCategoryController.dispose();
    _requestTypeController.dispose();
    _requestSubtypeController.dispose();

    _requestCategoryFocusNode.dispose();
    _requestTypeFocusNode.dispose();
    _requestSubtypeFocusNode.dispose();

    _requestStructureList.clear();
    showDataControllers.clear();
    focusNodes.clear();

    super.dispose();
  }


  bool isProcessing = false;

  setProcessing(bool value) {
    setState(() {
      isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Create Request",
      ),
      body: Utils.modelProgressHud(
          processing: isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetEmploymentStatusViewModel>(
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
                        ///  create request card
                        _createRequestCard(provider: provider, langProvider: langProvider),

                        /// submit buttons
                        _submitAndBackButton(
                            langProvider: langProvider,
                            employmentStatusProvider: provider),
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



/// Create Request Mandatory Fields
  /// TextEditingControllers
  final TextEditingController _requestCategoryController = TextEditingController();
  final TextEditingController _requestTypeController = TextEditingController();
  final TextEditingController _requestSubtypeController = TextEditingController();

  /// FocusNodes
  final FocusNode _requestCategoryFocusNode = FocusNode();
  final FocusNode _requestTypeFocusNode = FocusNode();
  final FocusNode _requestSubtypeFocusNode = FocusNode();

  /// Error texts
  String? _requestCategoryErrorText;
  String? _requestTypeErrorText;
  String? _requestSubTypeErrorText;

  /// Dropdowns
  List<DropdownMenuItem> _requestCategoryMenuItemsList = [];
  List<DropdownMenuItem> _requestTypeMenuItemsList = [];
  List<DropdownMenuItem> _requestSubTypeMenuItemsList = [];

  /// POPULATE REQUEST TYPE DROPDOWN
  _populateRequestType(langProvider){
    if (Constants.lovCodeMap['SERVICE_TYPE#${_requestCategoryController.text.toUpperCase().trim()}']?.values != null) {
      _requestTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['SERVICE_TYPE#${_requestCategoryController.text.toUpperCase().trim()}']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
      setState(() {});

    }
  }
  /// POPULATE REQUEST TYPE DROPDOWN
  _populateRequestSubType(langProvider){
    if (Constants.lovCodeMap['SERVICE_SUBTYPE#${_requestTypeController.text.toUpperCase().trim()}']?.values != null) {
      _requestSubTypeMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['SERVICE_SUBTYPE#${_requestTypeController.text.toUpperCase().trim()}']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
      setState(() {});
    }
  }


  /// This is my model which holds the values which we have to show to the end user
  RequestStructureModel? showData;

  Widget _createRequestCard(
      {required GetEmploymentStatusViewModel provider,
        required LanguageChangeViewModel langProvider}) {
    return CustomInformationContainer(
        leading: SvgPicture.asset("assets/services/request_list.svg"),
        title: "Create Request",
        expandedContent: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// First name
            fieldHeading(
                title: "Request Category",
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _requestCategoryFocusNode,
                controller: _requestCategoryController,
                menuItemsList: _requestCategoryMenuItemsList,
                hintText: "Select Request Category",
                errorText: _requestCategoryErrorText,
                onChanged: (value) {
                  setState(() {
                    _requestCategoryErrorText = null;
                    _requestCategoryController.text = value;

                    /// clear the dependent dropdowns
                    _requestTypeController.clear();
                    _requestSubtypeController.clear();
                    /// clear the dropdowns list
                    _requestTypeMenuItemsList.clear();
                    _requestSubTypeMenuItemsList.clear();
                    showDataControllers.clear();
                    showData = null;



                    /// POPULATE THE REQUEST TYPE DROPDOWN
                    _populateRequestType(langProvider);

                    Utils.requestFocus(focusNode: _requestTypeFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Request Type", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
              filled: _requestTypeMenuItemsList.isEmpty,
                currentFocusNode: _requestTypeFocusNode,
                controller: _requestTypeController,
                menuItemsList: _requestTypeMenuItemsList,
                hintText: "Request Type",
                errorText: _requestTypeErrorText,
                onChanged: (value) {
                  setState(() {
                    _requestTypeErrorText = null;
                    _requestTypeController.text = value;
                    /// CLEAR THE DEPENDENT REQUEST SUB-TYPE DROPDOWN
                    _requestSubtypeController.clear();
                    _requestSubTypeMenuItemsList.clear();
                    showDataControllers.clear();
                    showData = null;


                    /// POPULATE THE REQUEST SUB-TYPE DROPDOWN
                    _populateRequestSubType(langProvider);


                    Utils.requestFocus(focusNode: _requestSubtypeFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Request Sub Type", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                filled: _requestSubTypeMenuItemsList.isEmpty,
                currentFocusNode: _requestSubtypeFocusNode,
                controller: _requestSubtypeController,
                menuItemsList: _requestSubTypeMenuItemsList,
                hintText: "Request Sub Type",
                errorText: _requestSubTypeErrorText,
                onChanged: (value) {
                  setState(() {
                    _requestSubTypeErrorText = null;
                    _requestSubtypeController.text = value;


                    /// NOW WE HAVE ALL REQUIRED VALUES TO SHOW THE FIELDS TO END USER BASED ON COMBINATION
                    ///  "requestCategory": "AA",
                    //       "requestType": "AA",
                    //       "requestSubType": "1",
                    showDataControllers.clear();
                     showData = _requestStructureList.firstWhere((element) {
                      return element.requestCategory == _requestCategoryController.text.trim() &&
                          element.requestType == _requestTypeController.text.trim() &&
                          element.requestSubType == _requestSubtypeController.text.trim();
                    });

                    // Utils.requestFocus(focusNode: _requestSubtypeFocusNode, context: context);
                  });
                },
                context: context),

            buildFieldWidgets(langProvider),


            // scholarshipFormTextField(
            //     currentFocusNode: _commentsFocusNode,
            //     controller: _commentsController,
            //     hintText: "Enter Your Comments",
            //     textInputType: TextInputType.text,
            //     errorText: _commentsError,
            //     maxLines: 3,
            //     onChanged: (value) {
            //       if (_commentsFocusNode.hasFocus) {
            //         setState(() {});
            //       }
            //     }),

            /// ****************************************************************
            kFormHeight,
            const MyDivider(color: AppColors.lightGrey),
            /// ****************************************************************
            ///
           showData != null && showData?.conditions != null && showData!.conditions!.isNotEmpty ? Column(
              children: [
                kFormHeight,
                _showBullets(langProvider),
                kFormHeight,
                /// ****************************************************************
                const MyDivider(color: AppColors.lightGrey),
                /// ****************************************************************
              ],
            ) : const SizedBox.shrink(),



            // This section is to add file
            AttachmentAddFileButton(addFile: () async {
              await _addFile();
            }),
            /// ****************************************************************
            _showRequiredAttachmentTitle(langProvider),
            kFormHeight,
            /// ****************************************************************


            // /// attachments
            _attachmentsUploadSection(),
          ],
        ));
  }


  /// *-------------------------------- THIS IS SECTION WHERE WE SHOWS THE FIELDS BASED ON THE USER SELECTIONS START --------------------------------*

  /// LIST TO HOLD THE TEXT EDITING CONTROLLERS
  List<TextEditingController> showDataControllers = [];
  List<FocusNode> focusNodes = [];


  /// To show fields based on the type of service request
  Widget buildFieldWidgets(langProvider) {
    if (showData == null) {
      return const Center(child: Text('')); // Fallback if `showData` is null
    }

    // Initialize controllers for each field
    if (showDataControllers.isEmpty && showData?.fields != null) {
      for (var _ in showData!.fields!) {
        showDataControllers.add(TextEditingController());
        focusNodes.add(FocusNode());
      }
    }

    return ListView.builder(
      shrinkWrap: true, // To wrap content if inside another scrollable widget
      physics: const NeverScrollableScrollPhysics(),
      itemCount: showData?.fields?.length ?? 0,
      itemBuilder: (context, index) {
        final element = showData!.fields![index];
        final controller = showDataControllers[index];
        final focusNode = focusNodes[index];
        // Determine the next focus node
        final nextFocusNode = index < (showData?.fields?.length ?? 0) - 1 ? focusNodes[index + 1] // Assign the next focus node
        : null; // If it's the last field, there's no next focus node
        if (element.type == "file") {
          return Container(); // Handle "file" type separately if needed
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kFormHeight,
            fieldHeading(
              title: element.title ?? '',
              important: element.required ?? false,
              langProvider: langProvider,
            ),
            if (element.type == "text" || element.type == "number" || element.type == "textArea")
              scholarshipFormTextField(
                currentFocusNode: focusNode,
                nextFocusNode: nextFocusNode,
                controller: controller, // Assign the appropriate controller
                textInputType: element.type == "textArea"
                    ? TextInputType.multiline
                    : element.type == "number"
                    ? TextInputType.number
                    : TextInputType.text,
                maxLines: element.type == "textArea" ? 3 : null,
                hintText: "Enter ${element.title}",
                onChanged: (value) {
                  // Optionally handle the text change

                },
              ),
            if (element.type == "date")
              scholarshipFormDateField(
                currentFocusNode: focusNode,
                controller: controller, // Assign the appropriate controller
                hintText: "Enter ${element.title}",
                onChanged: (value) {
                  // Optionally handle the date change
                },
                onTap: () async{
                  // Handle date picker logic

                    // Example: Show a date picker and await the result
                   final selectedDate =   await showDatePickerDialog(context: context, maxDate: DateTime(2099), minDate: DateTime(1930));
                    if (selectedDate != null) {
                      // Do something with the selected date
                      controller.text = formatDateOnly(selectedDate.toString());
                      setState(() {
                        Utils.requestFocus(focusNode: focusNode, context: context);
                      });

                    }

                },
              ),
            if (element.type == "time")
              scholarshipFormTimeField(
                currentFocusNode: focusNode,
                controller: controller, // Assign the appropriate controller
                hintText: "Enter ${element.title}",
                onChanged: (value) {
                  // Optionally handle the time change
                },
                onTap: () async{
                  // Handle time picker logic
                  final selectedTime =   await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (selectedTime != null) {
                    // Do something with the selected date
                    controller.text =selectedTime.format(context).toString();
                    setState(() {
                      Utils.requestFocus(focusNode: focusNode, context: context);
                    });

                  }
                },
              ),
          ],
        );
      },
    );
  }

  /// *-------------------------------- THIS IS SECTION WHERE WE SHOWS THE FIELDS BASED ON THE USER SELECTIONS END --------------------------------*





  /// *-------------------------------- SHOW BULLETS TO USER START --------------------------------*
 Widget _showBullets(langProvider){
    return  ListView.builder(
        shrinkWrap: true, // To wrap content if inside another scrollable widget
        physics: const  NeverScrollableScrollPhysics(),
        itemCount: showData?.conditions?.length ?? 0,
        itemBuilder: (context, index) {
          final element = showData!.conditions![index];
          return bulletTermsText(text: element);

        });
 }
  /// *-------------------------------- SHOW BULLETS TO USER END --------------------------------*

  Widget _showRequiredAttachmentTitle(langProvider){
    return   ListView.builder(
        shrinkWrap: true, // To wrap content if inside another scrollable widget
        physics: const NeverScrollableScrollPhysics(),
        itemCount: showData?.fields?.length ?? 0,
        itemBuilder: (context, index) {
          final element = showData!.fields![index];

          if(element.type == "file") {
            return bulletTermsText(text: element.title ?? '');
          }else{
            return const SizedBox.shrink();
          }

        });
  }



  //// *-------------------------------- ATTACHMENTS SECTION IF NEEDED THEN SHOW TO THE USER TO UPLOAD ATTACHMENT --------------------------------*


  final List<ListAttachment> _attachmentsList = [];

  Widget _attachmentsUploadSection() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _attachmentsList.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          final attachment = _attachmentsList[index];
          return Column(
            children: [

              /// to show the card and also remove function is implemented
              PickedAttachmentCard(
                  attachmentType: AttachmentType.request,
                  index: index,
                  attachment: attachment,
                  onRemoveAttachment: () {
                    setState(() {
                      _attachmentsList.removeAt(index);
                    });
                  }),
              SizedBox.square(dimension: kPadding),
              // scholarshipFormTextField(
              //     maxLines: 2,
              //     textInputType: TextInputType.multiline,
              //     currentFocusNode: attachment.fileDescriptionFocusNode,
              //     controller: attachment.fileDescriptionController,
              //     hintText: "Comment",
              //     onChanged: (value) {}),
              // kFormHeight,
              // const MyDivider(
              //   color: AppColors.lightGrey,
              // ),
              // kFormHeight,
            ],
          );
        });
  }

  /// Function to add Attachment to the list
  _addFile() async {
    /// kindly check for permissions
    final permitted = await _permissionServices.checkAndRequestPermission(
        Platform.isIOS ? Permission.storage : Permission.manageExternalStorage,
        context);
    if (permitted) {
      /// TODO: PLEASE ADD ALLOWED EXTENSIONS
      final file = await _mediaServices.getSingleFileFromPicker();

      if (file != null) {
        setState(() {
          _attachmentsList.add(ListAttachment(
              attachmentSeqNumberController: TextEditingController(),
              fileDescriptionController: TextEditingController(),
              userAttachmentFileController: TextEditingController(),
              attachmentSysFileNameController:
              TextEditingController(text: file.path
                  .split('/')
                  .last),
              base64StringController: TextEditingController(
                  text: base64Encode(file.readAsBytesSync())),
              viewByAdviseeController: TextEditingController(text: 'Y'),
              attachmentSeqNumberFocusNode: FocusNode(),
              fileDescriptionFocusNode: FocusNode(),
              userAttachmentFileFocusNode: FocusNode(),
              attachmentSysFileNameFocusNode: FocusNode(),
              base64StringFocusNode: FocusNode(),
              viewByAdviseeFocusNode: FocusNode(),
              newlyAded: true,
              isLoading: false));
        });
      }
    }
  }

  Widget _submitAndBackButton(
      {required langProvider,
        UserInfo? userInfo,
        GetEmploymentStatusViewModel? employmentStatusProvider}) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => CreateUpdateEmploymentStatusViewModel(),
          child: Consumer<CreateUpdateEmploymentStatusViewModel>(
              builder: (context, createUpdateProvider, _) {
                return CustomButton(
                    buttonName: "Update",
                    isLoading:
                    createUpdateProvider.apiResponse.status == Status.LOADING,
                    borderColor: Colors.transparent,
                    buttonColor: AppColors.scoThemeColor,
                    textDirection: getTextDirection(langProvider),
                    onTap: () async {
                      setProcessing(true);

                      bool result = validateForm(langProvider: langProvider, userInfo: userInfo);

                      print(result);

                      // for(var ele in showDataControllers){
                      //   print(ele.text);
                      // }
                      // for(var ele in _attachmentsList){
                      //   log(ele.toJson().toString());
                      // }
                      if (result) {
                        // /// Create Form
                        // // createForm(provider: employmentStatusProvider);
                        //
                        // // log(createEmploymentStatusForm.toString());
                        // log(updateEmploymentStatusForm.toString());
                        // bool result = employmentStatusProvider
                        //     ?.apiResponse?.data?.data?.employmentStatus !=
                        //     null
                        //     ? await createUpdateProvider
                        //     .createUpdateEmploymentStatus(
                        //     form: updateEmploymentStatusForm,
                        //     updating: true)
                        //     : await createUpdateProvider
                        //     .createUpdateEmploymentStatus(
                        //     form: createEmploymentStatusForm,
                        //     updating: false);
                        // if (result) {
                        //   /// update and refresh the information
                        //   await _initializeData();
                        // }
                      }
                      setProcessing(false);
                    });
              }),
        ),
      ],
    );
  }



  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode ;

  bool validateForm({required langProvider, UserInfo? userInfo}) {
    firstErrorFocusNode = null;

    if (_requestCategoryController.text.isEmpty) {
      setState(() {
        _requestCategoryErrorText = "Please Select Request Category";
        firstErrorFocusNode ??= _requestCategoryFocusNode;
      });
    }

    if (_requestTypeController.text.isEmpty) {
      setState(() {
        _requestTypeErrorText = "Please Select Request Category";
        firstErrorFocusNode ??= _requestTypeFocusNode;
      });
    }
    if (_requestSubtypeController.text.isEmpty) {
      setState(() {
        _requestSubTypeErrorText = "Please Select Request Category";
        firstErrorFocusNode ??= _requestSubtypeFocusNode;
      });
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

  // void createForm(
  //     {GetEmploymentStatusViewModel? provider,
  //       GetPersonalDetailsViewModel? personalDetails}) {
  //   /// create Employment status form it uses post method
  //   createEmploymentStatusForm = {
  //     // "sequanceNumber": "2",
  //     "employmentStatus": _employmentStatusController.text,
  //     "employerName": _employerController.text,
  //     "currentFlag": "Y",
  //     "comment": _commentsController.text
  //   };
  //
  //   /// update Employment status form it uses put method
  //   updateEmploymentStatusForm = {
  //     "emplId": provider?.apiResponse?.data?.data?.employmentStatus?.emplId,
  //     "sequanceNumber":
  //     provider?.apiResponse?.data?.data?.employmentStatus?.sequanceNumber,
  //     "employmentStatus": _employmentStatusController.text,
  //     "employerName": _employerController.text,
  //     "currentFlag": "N",
  //     "comment": _commentsController.text,
  //     "listOfFiles": _attachmentsList.map((element) {
  //       return element.toJson();
  //     }).toList()
  //   };
  // }
}











