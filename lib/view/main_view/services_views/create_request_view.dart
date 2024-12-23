

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' hide TextDirection;
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
import 'package:sco_v1/viewModel/services_viewmodel/create_request_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../models/services/GetAllRequestsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/attachment_add_file_button.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/kButtons/kReturnButton.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/create_update_employment_status_viewModel.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/alert_services.dart';
import '../../../viewModel/services/navigation_services.dart';

class CreateRequestView extends StatefulWidget {
 String? requestCategory,requestType,requestSubType;
   CreateRequestView({super.key,this.requestCategory,this.requestType,this.requestSubType});

  @override
  State<CreateRequestView> createState() => _CreateRequestViewState();
}

class _CreateRequestViewState extends State<CreateRequestView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;
  late AlertServices _alertServices;

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

    /// If user is asking for meeting request then
    if(widget.requestCategory !=null && widget.requestType != null && widget.requestSubType != null)
{

  _requestCategoryController.text = widget.requestCategory!.toUpperCase();
  _populateRequestType(langProvider);
  _requestTypeController.text = widget.requestType!.toUpperCase();
  _populateRequestSubType(langProvider);
  _requestSubtypeController.text = widget.requestSubType!.toUpperCase();
  _populateAllFields();
}


      /// To refresh the page
      setState(() {});

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
      _alertServices = getIt.get<AlertServices>();

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
    showDataRecordList.clear();
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
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: localization.createRequest,
      ),
      body: Utils.modelProgressHud(
          processing: isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
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
              _createRequestCard(langProvider: langProvider,localization: localization),

              /// submit buttons
              _submitAndBackButton(langProvider: langProvider,localization: localization),
            ],
          ),
        ),
      ),
    );
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
  _populateAllFields(){
  showData = _requestStructureList.firstWhere((element) {
  return element.requestCategory == _requestCategoryController.text.trim() &&
  element.requestType == _requestTypeController.text.trim() &&
  element.requestSubType == _requestSubtypeController.text.trim();
  });
}

  Widget _createRequestCard(
      {required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomInformationContainer(
        leading: SvgPicture.asset("assets/services/request_list.svg"),
        title: localization.createRequest,
        expandedContent: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// First name
            fieldHeading(
                title: localization.category,
                important: true,
                langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _requestCategoryFocusNode,
                controller: _requestCategoryController,
                menuItemsList: _requestCategoryMenuItemsList,
                hintText: localization.select,
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
                    showDataRecordList.clear();
                    showData = null;



                    /// POPULATE THE REQUEST TYPE DROPDOWN
                    _populateRequestType(langProvider);

                    Utils.requestFocus(focusNode: _requestTypeFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: localization.requestType, important: true, langProvider: langProvider),
            scholarshipFormDropdown(
              filled: _requestTypeMenuItemsList.isEmpty,
                currentFocusNode: _requestTypeFocusNode,
                controller: _requestTypeController,
                menuItemsList: _requestTypeMenuItemsList,
                hintText: localization.select,
                errorText: _requestTypeErrorText,
                onChanged: (value) {
                  setState(() {
                    _requestTypeErrorText = null;
                    _requestTypeController.text = value;
                    /// CLEAR THE DEPENDENT REQUEST SUB-TYPE DROPDOWN
                    _requestSubtypeController.clear();
                    _requestSubTypeMenuItemsList.clear();
                    showDataRecordList.clear();
                    showData = null;


                    /// POPULATE THE REQUEST SUB-TYPE DROPDOWN
                    _populateRequestSubType(langProvider);


                    Utils.requestFocus(focusNode: _requestSubtypeFocusNode, context: context);
                  });
                },
                context: context),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: localization.requestSubType, important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                filled: _requestSubTypeMenuItemsList.isEmpty,
                currentFocusNode: _requestSubtypeFocusNode,
                controller: _requestSubtypeController,
                menuItemsList: _requestSubTypeMenuItemsList,
                hintText: localization.select,
                errorText: _requestSubTypeErrorText,
                onChanged: (value) {
                  setState(() {
                    _requestSubTypeErrorText = null;
                    _requestSubtypeController.text = value;


                    /// NOW WE HAVE ALL REQUIRED VALUES TO SHOW THE FIELDS TO END USER BASED ON COMBINATION
                    ///  "requestCategory": "AA",
                    //       "requestType": "AA",
                    //       "requestSubType": "1",
                    showDataRecordList.clear();
                     _populateAllFields();

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
  List<ShowDataRecord> showDataRecordList = [];
  List<FocusNode> focusNodes = [];


  /// To show fields based on the type of service request
  Widget buildFieldWidgets(langProvider) {
    if (showData == null) {
      return const Center(child: Text('')); // Fallback if `showData` is null
    }
    // Initialize controllers for each field
    /// With the help of model given below we will convert our user response to the api request response
    if (showDataRecordList.isEmpty && showData?.fields != null) {
      for (var field in showData!.fields!) {
        showDataRecordList.add(
          ShowDataRecord(
            titleController: TextEditingController(text: field.title),
            titleArController: TextEditingController(text: field.titleAr),
            valueController: TextEditingController(), // Assuming field.title exists and is the field name
            typeController: TextEditingController(text: field.type?.trim() ??''),
            required: field.required ?? false,
            index: showData!.fields!.indexOf(field), // Get the index of the current field
          ),
        );
        focusNodes.add(FocusNode());
      }

    }

    /// getting the textDirection
   bool ltrDirection = getTextDirection(langProvider) == TextDirection.ltr;

    return ListView.builder(
      shrinkWrap: true, // To wrap content if inside another scrollable widget
      physics: const NeverScrollableScrollPhysics(),
      itemCount: showData?.fields?.length ?? 0,
      itemBuilder: (context, index) {
        final element = showData!.fields![index];
        final controllers = showDataRecordList[index];
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
              title: ltrDirection ? element.title ?? '' : element.titleAr ??'',
              important: element.required ?? false,
              langProvider: langProvider,
            ),
            if (element.type == "text" || element.type == "number" || element.type == "textArea")
              scholarshipFormTextField(
                currentFocusNode: focusNode,
                nextFocusNode: nextFocusNode,
                controller: controllers.valueController, // Assign the appropriate controller
                textInputType: element.type == "textArea"
                    ? TextInputType.multiline
                    : element.type == "number"
                    ? TextInputType.number
                    : TextInputType.text,
                maxLines: element.type == "textArea" ? 3 : null,
                hintText: ltrDirection ? element.title ?? '' : element.titleAr ??'',
                onChanged: (value) {
                  // Optionally handle the text change

                },
              ),
            if (element.type == "date")
              scholarshipFormDateField(
                currentFocusNode: focusNode,
                controller: controllers.valueController, // Assign the appropriate controller
                hintText: ltrDirection ? element.title ?? '' : element.titleAr ??'',
                onChanged: (value) {
                  // Optionally handle the date change
                },
                onTap: () async{
                  // Handle date picker logic

                    // Example: Show a date picker and await the result
                   final selectedDate =   await showDatePickerDialog(context: context, maxDate: DateTime(2099), minDate: DateTime(1930));
                    if (selectedDate != null) {
                      // Do something with the selected date
                      controllers.valueController.text = formatDateOnly(selectedDate.toString());
                      setState(() {
                        Utils.requestFocus(focusNode: focusNode, context: context);
                      });

                    }

                },
              ),
            if (element.type == "time")
              scholarshipFormTimeField(
                currentFocusNode: focusNode,
                controller: controllers.valueController, // Assign the appropriate controller
                hintText: ltrDirection ? element.title ?? '' : element.titleAr ??'',
                onChanged: (value) {
                  // Optionally handle the time change
                },
                onTap: () async{
                  // Handle time picker logic
                  final selectedTime =   await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (selectedTime != null) {
                    // Do something with the selected date
                    controllers.valueController.text =selectedTime.format(context).toString();
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
    bool ltrDirection = getTextDirection(langProvider) == TextDirection.ltr;

    return   ListView.builder(
        shrinkWrap: true, // To wrap content if inside another scrollable widget
        physics: const NeverScrollableScrollPhysics(),
        itemCount: showData?.fields?.length ?? 0,
        itemBuilder: (context, index) {
          final element = showData!.fields![index];

          if(element.type == "file") {
            /// getting the textDirection
            return bulletTermsText(text: ltrDirection ? element.title ?? '' : element.titleAr ?? '');
          }else{
            return const SizedBox.shrink();
          }

        });
  }



  //// *-------------------------------- ATTACHMENTS SECTION IF NEEDED THEN SHOW TO THE USER TO UPLOAD ATTACHMENT START --------------------------------*
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



  _addFile() async {
    /// kindly check for permissions
    // final permitted = await _permissionServices.checkAndRequestPermission(
    //     Platform.isIOS ? Permission.storage : Permission.manageExternalStorage,
    //     context);
    if (true) {
      /// TODO: PLEASE ADD ALLOWED EXTENSIONS
      final file = await _mediaServices.getSingleFileFromPicker();

      if (file != null) {
        setState(() {
          _attachmentsList.add(ListAttachment(
              attachmentSeqNumberController: TextEditingController(),
              fileDescriptionController: TextEditingController(),
              userAttachmentFileController:    TextEditingController(text: file.path.split('/').last),
              attachmentSysFileNameController: TextEditingController(text: file.path.split('/').last),
              base64StringController: TextEditingController(text: base64Encode(file.readAsBytesSync())),
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

  //// *-------------------------------- ATTACHMENTS SECTION IF NEEDED THEN SHOW TO THE USER TO UPLOAD ATTACHMENT END --------------------------------*



  String enData = "";
  String arData = "";
  Widget _submitAndBackButton(
      {required langProvider,
        UserInfo? userInfo,
        GetEmploymentStatusViewModel? employmentStatusProvider,
      required AppLocalizations localization
      }) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => CreateRequestViewModel(),
          child: Consumer<CreateRequestViewModel>(
              builder: (context, createRequestProvider, _) {
                return CustomButton(
                    buttonName: localization.createRequest,
                    isLoading: createRequestProvider.apiResponse.status == Status.LOADING,
                    borderColor: Colors.transparent,
                    // buttonColor: AppColors.scoThemeColor,
                    textDirection: getTextDirection(langProvider),
                    onTap: () async {
                      setProcessing(true);

                      bool result = validateForm(langProvider: langProvider,localization: localization);

                      // for(var ele in _attachmentsList){
                      //   log(ele.toJson().toString());
                      // }
                      if (result) {
                        for(var ele in showDataRecordList){
                          // print(ele.collectedDataEn);
                          if(ele.typeController.text != "file"){
                            enData += ele.collectedDataEn;
                            arData += ele.collectedDataAr;
                          }
                        }
                        /// Create Form
                        createForm();

                        // log(createEmploymentStatusForm.toString());
                        log(form.toString());
                        try {
                          bool apiResult = await createRequestProvider.createRequest(form: form);
                          if (apiResult) {
                            setProcessing(false);
                            /// Update and refresh the information
                            // await _initializeData();
                            ///calling get all requests and navigate back to all requests screen
                            _navigationServices.goBack();
                            Provider.of<GetAllRequestsViewModel>(context,listen: false).getAllRequests();
                          } else {
                            setProcessing(false);

                            log("API call failed: No data returned or request unsuccessful.");
                          }
                          setProcessing(false);

                        } catch (error) {
                          setProcessing(false);

                          log("Error during API call: $error");
                        }
                      }
                      setProcessing(false);
                    });
              }),
        ),
        kFormHeight,
        const KReturnButton(),

      ],
    );
  }



  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode ;

  bool validateForm({required langProvider,required AppLocalizations localization}) {
    firstErrorFocusNode = null;
    enData = '';
    arData = '';

    if (_requestCategoryController.text.isEmpty) {
      setState(() {
        _requestCategoryErrorText = localization.pleaseSelectRequestCategory;
        firstErrorFocusNode ??= _requestCategoryFocusNode;
      });
    }

    if (_requestTypeController.text.isEmpty) {
      setState(() {
        _requestTypeErrorText = localization.pleaseSelectRequestType;
        firstErrorFocusNode ??= _requestTypeFocusNode;
      });
    }
    if (_requestSubtypeController.text.isEmpty) {
      setState(() {
        _requestSubTypeErrorText = localization.pleaseSelectRequestSubType;
        firstErrorFocusNode ??= _requestSubtypeFocusNode;
      });
    }

    /// Validations based on conditions Not available on web but implemented in mobile
    if(showData != null){
      for(var showFields in showDataRecordList){
        if(showFields.valueController.text.isEmpty && showFields.typeController.text.trim() != 'file' && showFields.required){
          final index = showDataRecordList.indexOf(showFields);
          setState(() {
            firstErrorFocusNode = focusNodes[index];
            _alertServices.showErrorSnackBar(localization.pleaseFillAllRequiredFields);
          });
          break;
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

  void createForm() async{
    final currentDate = DateTime.now();

    // Example formats
    String formattedDate1 = DateFormat('yyyy-MM-dd').format(currentDate); // 2024-11-24

   form = {
    "requestCategory": _requestCategoryController.text.trim(),
    "requestType": _requestTypeController.text.trim(),
    "requestSubType": _requestSubtypeController.text,
    // "ssrRsReqSeqHeader": 0,
    // "serviceRequestId": 0,
    // "requestDate": formattedDate1.toString(),
    // "status": null,
    "details": [
  {
    // "ssrRsReqSeq": null,
    "ssrRsDescription": arData.trim(),
    "displayToUser": "Y",
    "newlyAded": true
  }
    ],
    "listAttachment": _attachmentsList.map((element){return element.toJson();}).toList()
  };
  }
}






/// This model has been created to let append all the information in one section i.e. ssrDescription
class ShowDataRecord {
  final TextEditingController titleController;
  final TextEditingController titleArController;
  final TextEditingController typeController;
  final TextEditingController valueController;
  final bool required;
  final int index;

  ShowDataRecord({
    required this.titleController,
    required this.titleArController,
    required this.typeController,
    required this.valueController,
    required this.required,
    required this.index,
  });

  /// Converts object to a JSON-like map.
  Map<String, dynamic> toJson() {
    return {
      'title': titleController.text,
      'titleAr': titleArController.text,
      'type': typeController.text,
      'value': valueController.text,
      'required': required,
      'index': index,
    };
  }

  /// Collects data in English format.
  String get collectedDataEn => "${titleController.text} ${valueController.text}<br/>";

  /// Collects data in Arabic format.
  String get collectedDataAr => "${titleArController.text}${valueController.text}<br/>";
}









