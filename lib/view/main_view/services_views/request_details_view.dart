import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/services/GetAllRequestsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/attachment_add_file_button.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/services_views/request_view.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/updateRequestViewModel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class RequestDetailsView extends StatefulWidget {
  ListOfRequest? request;

  RequestDetailsView({super.key, this.request});

  @override
  State<RequestDetailsView> createState() => _RequestDetailsViewState();
}

class _RequestDetailsViewState extends State<RequestDetailsView> with MediaQueryMixin
{
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  List<DropdownMenuItem> _employmentStatusMenuItemsList = [];
  List<DropdownMenuItem> _employerMenuItemsList = [];

  Future _initializeData() async {
    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider =
    Provider.of<LanguageChangeViewModel>(context, listen: false);

    final request = widget.request;


    /// fetching the request comments list
    if (request?.details != null && request?.details != []) {
      _requestCommentsList.clear();
      for (int i = 0; i < request!.details!.length; i++) {
        _requestCommentsList.add(
            Details.fromJson(request!.details![i].toJson()));
      }
    }



    /// Fetching the list of attachments and initializing the mh list:
    if (request?.listAttachment != null && request?.listAttachment != []) {
      _attachmentsList.clear();
      for (int i = 0; i < request!.listAttachment!.length; i++) {
        _attachmentsList
            .add(ListAttachment.fromJson(request!.listAttachment![i].toJson()));
      }
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

      await _initializeData();
    });

    super.initState();
  }

  @override
  void dispose() {
    _attachmentsList.clear();
    _requestCommentsList.clear();
    _newCommentController.dispose();
    _newCommentFocusNode.dispose();
    super.dispose();
  }

  bool _isProcessing = false;

  setProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Request",
      ),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi() {
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

              /// Request Details card
              _requestDetailsCard(
                  request: widget.request, langProvider: langProvider),

              /// submit buttons
              _submitAndBackButton(
                  langProvider: langProvider, request: widget.request),
            ],
          ),
        ),
      ),
    );
  }

  //// *----------------------- COMPLETE INFORMATION SECTION START ------------------------*
  Widget _requestDetailsCard(
      {ListOfRequest? request, required LanguageChangeViewModel langProvider}) {
    return CustomInformationContainer(
        leading: SvgPicture.asset("assets/services/request_details.svg"),
        title: "Request Details",
        expandedContentPadding: EdgeInsets.zero,
        expandedContent: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            /// ****************************************************************
            kFormHeight,

            /// Basic information of request
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: _requestBasicInformation(
                  request: request, langProvider: langProvider),
            ),

            /// ****************************************************************
            kFormHeight,

            _existingComments(request: request, langProvider: langProvider),

            kFormHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child:
              _addNewComment(request: request, langProvider: langProvider),
            ),
            kFormHeight,

            /// ****************************************************************
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  const MyDivider(color: AppColors.lightGrey),

                  // This section is to add file
                  AttachmentAddFileButton(addFile: () async {
                    await _addFile();
                  }),

                  /// attachments
                  _attachmentsUploadSection(),
                ],
              ),
            )
          ],
        ));
  }

  //// *----------------------- COMPLETE INFORMATION SECTION START ------------------------*

  //// *----------------------- BASIC INFORMATION SECTION START ------------------------*
  Widget _requestBasicInformation(
      {ListOfRequest? request, required LanguageChangeViewModel langProvider}) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      CustomInformationContainerField(
          title: "S. No.", description: request?.serviceRequestId.toString()),
      CustomInformationContainerField(
          title: "Request Id",
          description: request?.ssrRsReqSeqHeader.toString()),
      CustomInformationContainerField(
          title: "Category",
          description: getFullNameFromLov(
              langProvider: langProvider,
              lovCode: "SERVICE_CATEGORY",
              code: request?.requestCategory.toString())),
      CustomInformationContainerField(
          title: "Request Type",
          description: getFullNameFromLov(
              langProvider: langProvider,
              lovCode: 'SERVICE_TYPE#${request?.requestCategory.toString()}',
              code: request?.requestType.toString())),
      CustomInformationContainerField(
          title: "Request Sub Type",
          description: getFullNameFromLov(
              langProvider: langProvider,
              lovCode: 'SERVICE_SUBTYPE#${request?.requestType.toString()}',
              code: request?.requestSubType.toString())),
      CustomInformationContainerField(
          title: "Request Date", description: request?.requestDate ?? ''),
      CustomInformationContainerField(
          title: "Request Status",
          description: getFullNameFromLov(
              langProvider: langProvider,
              code: request?.status.toString(),
              lovCode: 'SERVICE_STATUS'),
          isLastItem: true),
    ]);
  }

  //// *----------------------- BASIC INFORMATION SECTION END ------------------------*

  //// *----------------------- EXISTING COMMENTS SECTION START ------------------------*
  Widget _existingComments(
      {ListOfRequest? request, required LanguageChangeViewModel langProvider}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(kPadding - 10),
        decoration: const BoxDecoration(color: AppColors.lightBlue0),
        child: Column(
            children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: request?.details?.length ?? 0,
              itemBuilder: (context, index) {
                final comment = request?.details![index];
                return Text(
                  // "${(index+1).toString()}) "
                      "${comment?.ssrRsDescription
                            .toString()
                            .replaceAll('<br/>', '')
                      }" ??
                      '',
                  style: AppTextStyles.bold15ScoButtonColorTextStyle(),
                  textAlign: TextAlign.start,
                );
              }),
        ]));
  }

//// *----------------------- EXISTING COMMENTS SECTION END ------------------------*

//// *----------------------- ADD NEW COMMENTS SECTION START ------------------------*
  final TextEditingController _newCommentController = TextEditingController();
  final FocusNode _newCommentFocusNode = FocusNode();
  final List<Details?> _requestCommentsList = [];

  Widget _addNewComment(
      {ListOfRequest? request, required LanguageChangeViewModel langProvider}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Comment",
          style: AppTextStyles.titleTextStyle(),
        ),
        const SizedBox.square(dimension: 5),
        scholarshipFormTextField(
            maxLines: 3,
            textInputType: TextInputType.multiline,
            currentFocusNode: _newCommentFocusNode,
            controller: _newCommentController,
            hintText: "Enter your view",
            onChanged: (value) => {})
      ],
    );
  }

//// *----------------------- ADD NEW COMMENTS SECTION END ------------------------*

//// *----------------------- ADD ATTACHMENTS SECTION START ------------------------*
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
              viewByAdviseeController: TextEditingController(),
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

//// *----------------------- ADD ATTACHMENTS SECTION END ------------------------*

  //// *----------------------- SUBMIT AND BACK BUTTON SECTION START ------------------------*
  Widget _submitAndBackButton(
      {required langProvider, required ListOfRequest? request}) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(create: (context)=>UpdateRequestViewModel(),

        child:Consumer<UpdateRequestViewModel>(builder: (context,updateRequestProvider,_){
          return  CustomButton(
              buttonName: "Update",
              isLoading: updateRequestProvider.apiResponse.status == Status.LOADING,
              borderColor: Colors.transparent,
              buttonColor: AppColors.scoThemeColor,
              textDirection: getTextDirection(langProvider),
              onTap: () async {
                setProcessing(true);
                bool result = validateForm(langProvider: langProvider, request: request);
                if (result) {
                  /// Create Form
                  createForm(request: request);

                  log(form.toString());
                  bool result = await updateRequestProvider.updateRequest(form: form);
                  print(result);
                  if (updateRequestProvider.apiResponse.status == Status.COMPLETED) {
                    /// update and refresh the information
                    // await _initializeData();
                    _navigationServices.pushReplacementCupertino(CupertinoPageRoute(builder: (context)=>const RequestView()));
                  }
                }
                setProcessing(false);
              });
        })
        ),


      ],
    );
  }

  //// *----------------------- SUBMIT AND BACK BUTTON SECTION END ------------------------*

  //// *----------------------- VALIDATION SECTION START ------------------------*
  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm({required langProvider, required ListOfRequest? request}) {
    firstErrorFocusNode = null;

    /// checking for fist error node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      return true;
    }
  }

  //// *----------------------- VALIDATION SECTION END ------------------------*

  //// *----------------------- FORM SECTION START ------------------------*
  /// My Final Submission form
  Map<String, dynamic> form = {};

  _addCommentToList(){
    setState(() {
      _requestCommentsList.add(Details(
        ssrRsDescription:  _newCommentController.text,
        displayToUser: 'Y',
        newlyAded: true,
      ));
    });
  }

  void createForm({required ListOfRequest? request}) {

    //// USING LOGIC TO ADD AND REMOVE LAST ITEM:
   final newComment = _newCommentController.text.trim();
    if (newComment.isNotEmpty) {
      if(_requestCommentsList.isEmpty && newComment.isNotEmpty){
        _addCommentToList();
      }
      if(_requestCommentsList.last?.newlyAded == false && _requestCommentsList.isNotEmpty){
        _addCommentToList();
      }
    }
    if(newComment.isEmpty && _requestCommentsList.isNotEmpty){
      if(_requestCommentsList.last?.newlyAded == true && _requestCommentsList.isNotEmpty){
        _requestCommentsList.removeLast();
      }
    }


    /// add comment and attachments form
    form = {
      "details": _requestCommentsList.map((element){return element?.toJson();}).toList(),
      "listAttachment": _attachmentsList.map((element){return element.toJson();}).toList(),
      "requestCategory": request?.requestCategory,
      "requestDate": request?.requestDate,
      "requestSubType": request?.requestSubType,
      "requestType": request?.requestType,
      "serviceRequestId": request?.serviceRequestId,
      "ssrRsReqSeqHeader": request?.ssrRsReqSeqHeader,
      "status": request?.status
    };
  }
//// *----------------------- FORM SECTION END ------------------------*
}