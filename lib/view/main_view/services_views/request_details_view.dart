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
import 'package:sco_v1/models/services/GetAllRequestsModel.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/attachment_add_file_button.dart';
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
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/create_update_employment_status_viewModel.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class RequestDetailsView extends StatefulWidget {

  ListOfRequest? request;
   RequestDetailsView({super.key,this.request});

  @override
  State<RequestDetailsView> createState() => _RequestDetailsViewState();
}

class _RequestDetailsViewState extends State<RequestDetailsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  List<DropdownMenuItem> _employmentStatusMenuItemsList = [];
  List<DropdownMenuItem> _employerMenuItemsList = [];

  Future _initializeData() async {
    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    
      final request = widget.request;


      if (request?.listAttachment != null && request?.listAttachment != []) {
        _attachmentsList.clear();
        for (int i = 0; i < request!.listAttachment!.length; i++) {
          _attachmentsList.add(ListAttachment.fromJson(request!.listAttachment![i].toJson()));
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
      body: Utils.modelProgressHud(processing: _isProcessing,
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
              _requestDetailsCard(provider: widget.request, langProvider: langProvider),

              /// submit buttons
              _submitAndBackButton(langProvider: langProvider, employmentStatusProvider: widget.request),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requestDetailsCard({ ListOfRequest? provider,
    required LanguageChangeViewModel langProvider}) {
    return CustomInformationContainer(
        leading: SvgPicture.asset("assets/services/request_details.svg"),
        title: "Request Details",
        expandedContent: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            /// ****************************************************************
            kFormHeight,

            /// ****************************************************************
            const MyDivider(
              color: AppColors.lightGrey,
            ),

            // This section is to add file
            AttachmentAddFileButton(addFile: () async {
              await _addFile();
            }),

            /// attachments
            _attachmentsUploadSection(),
          ],
        ));
  }

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
              const SizedBox.square(dimension: 5),
              scholarshipFormTextField(maxLines: 3,
                  textInputType: TextInputType.multiline,
                  currentFocusNode: attachment.fileDescriptionFocusNode,
                  controller: attachment.fileDescriptionController,
                  hintText: "Comment", onChanged: (value) {}),
              kFormHeight,
              const MyDivider(
                color: AppColors.lightGrey,
              ),
              kFormHeight,

            ],
          );
        });
  }

  Widget _submitAndBackButton({required langProvider,
    UserInfo? userInfo,
    ListOfRequest? employmentStatusProvider}) {
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
                    isLoading: createUpdateProvider.apiResponse.status ==
                        Status.LOADING,
                    borderColor: Colors.transparent,
                    buttonColor: AppColors.scoThemeColor,
                    textDirection: getTextDirection(langProvider),
                    onTap: () async {
                      setProcessing(true);

                      bool result = validateForm(
                          langProvider: langProvider, userInfo: userInfo);
                      if (result) {
                        /// Create Form
                        // createForm(provider: employmentStatusProvider);

                        // log(createEmploymentStatusForm.toString());
                        log(form.toString());
                        // bool result = await createUpdateProvider.createUpdateEmploymentStatus(form: form,updating: false);
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
              attachmentSysFileNameController: TextEditingController(text: file.path.split('/').last),
              base64StringController: TextEditingController(text: base64Encode(file.readAsBytesSync())),
              viewByAdviseeController: TextEditingController(),
              attachmentSeqNumberFocusNode: FocusNode(),
              fileDescriptionFocusNode: FocusNode(),
              userAttachmentFileFocusNode: FocusNode(),
              attachmentSysFileNameFocusNode: FocusNode(),
              base64StringFocusNode: FocusNode(),
              viewByAdviseeFocusNode: FocusNode(),
            newlyAded: true,
            isLoading: false
          ));
        });
      }
    }
  }

  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm({required langProvider, UserInfo? userInfo}) {
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

  /// My Final Submission form
  Map<String, dynamic> form = {};

  void createForm(
      {GetEmploymentStatusViewModel? provider, GetPersonalDetailsViewModel? personalDetails}) {


    /// update Employment status form it uses put method
    form = {

    };
  }
}
