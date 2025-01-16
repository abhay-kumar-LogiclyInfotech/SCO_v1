import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetListOfAttachmentsModel.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/models/notifications/GetAllNotificationsModel.dart';
import 'package:sco_v1/models/services/MyFinanceStatusModel.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/apply_scholarship/form_views/required_examinations_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/upload_update_attachment_file_view.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/edit_application/get_list_of_attachments_viewModel.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/edit_application/upload_update_attachment_view_model.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_text_styles.dart';
import '../../../../resources/components/custom_button.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../resources/components/kButtons/kReturnButton.dart';
import '../../../../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import '../../../../viewModel/apply_scholarship/attach_file_viewmodel.dart';
import '../../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../../viewModel/services/alert_services.dart';
import '../../../apply_scholarship/attach_file.dart';

class AttachmentsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  final String configurationKey;

  const AttachmentsView({super.key,
      required this.applicationStatusDetails,
      required this.configurationKey});

  @override
  State<AttachmentsView> createState() => _AttachmentsViewState();
}

class _AttachmentsViewState extends State<AttachmentsView>
    with MediaQueryMixin {
  late AlertServices _alertServices;
  late MediaServices _mediaServices;

  PsApplication? peopleSoftApplication;

  String? checklistCode;

  final List<Attachment> _myAttachmentsList = [];

  /// List of Attachments:
  List _attachmentsList = [];

  /// to store the lov's

  List<FileList> listOfAttachments = [];

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _mediaServices = getIt.get<MediaServices>();
    _refreshPage();
    super.initState();
  }

  Future<void> _refreshPage()async{
    _attachmentsList.clear();
    listOfAttachments.clear();
    _myAttachmentsList.clear();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      resetProcessing(true);
      final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);



      //// Have to call the get list of attachments also
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(
          context: context,
          langProvider:
          Provider.of<LanguageChangeViewModel>(context, listen: false));

      final GetAllActiveScholarshipsModel? appliedScholarship =
      provider.apiResponse.data?.firstWhere(
            (element) =>
        element.configurationKey ==
            widget.configurationKey, // Provides a null if no match is found
      );

      /// Fetch the checklistCode so then we can show the attachments to the end user
      /// Using the configuration key search for the scholarship in the active scholarships and fetch the approved checklist code, if approved
      /// checklist code is not there then use the checklist code and don't need to parse them. show all the attachments tot the end user
      checklistCode =
      (appliedScholarship?.approvedChecklistCode?.isNotEmpty ?? false)
          ? appliedScholarship!.approvedChecklistCode!
          : (appliedScholarship?.checklistCode?.isNotEmpty ?? false)
          ? appliedScholarship!.checklistCode!
          : 'ATTACH_REQ_Y_N';

      addToMyAttachment(
          {required element, required processCD, required documentCD}) {
        _myAttachmentsList.add(Attachment(
          attachmentNameController: TextEditingController(text: element.code.toString()),
          applictantIdController: TextEditingController(),
          processCdController: TextEditingController(text: processCD),
          documentCdController: TextEditingController(text: documentCD),
          descriptionController: TextEditingController(),
          userFileNameController: TextEditingController(),
          commentController: TextEditingController(),
          base64StringController: TextEditingController(),
          errorMessageController: TextEditingController(),
          requiredController: TextEditingController(text: element.required.toString()),
          fileUploadedController: TextEditingController(),
          heightController: TextEditingController(),
          widthController: TextEditingController(),
          supportedFileTypeController: TextEditingController(),
          maxFileSizeController: TextEditingController(),
          applicationDetailIdController: TextEditingController(),
          emiratesIdController: TextEditingController(),
          isApprovedController: TextEditingController(),
          fileIdController: TextEditingController(),
          fileTypeController: TextEditingController(),
          newFileController: TextEditingController(),

          // Focus Nodes
          processCdFocusNode: FocusNode(),
          documentCdFocusNode: FocusNode(),
          userFileNameFocusNode: FocusNode(),
          commentFocusNode: FocusNode(),
          requiredFocusNode: FocusNode(),
          fileUploadedFocusNode: FocusNode(),
          heightFocusNode: FocusNode(),
          widthFocusNode: FocusNode(),
          errorMessageFocusNode: FocusNode(),
          supportedFileTypeFocusNode: FocusNode(),
          maxFileSizeFocusNode: FocusNode(),
          attachmentNameFocusNode: FocusNode(),
          applicationDetailIdFocusNode: FocusNode(),
          emiratesIdFocusNode: FocusNode(),
          isApprovedFocusNode: FocusNode(),
          fileIdFocusNode: FocusNode(),
          fileTypeFocusNode: FocusNode(),
          newFileFocusNode: FocusNode(),
          applictantIdFocusNode: FocusNode(),
          descriptionFocusNode: FocusNode(),
          base64StringFocusNode: FocusNode(),

          // Error Text Variables
          processCdError: null,
          documentCdError: null,
          userFileNameError: null,
          commentError: null,
          requiredError: null,
          fileUploadedError: null,
          heightError: null,
          widthError: null,
          errorMessageError: null,
          supportedFileTypeError: null,
          maxFileSizeError: null,
          attachmentNameError: null,
          applicationDetailIdError: null,
          emiratesIdError: null,
          isApprovedError: null,
          fileIdError: null,
          fileTypeError: null,
          newFileError: null,
          applictantIdError: null,
          descriptionError: null,
          base64StringError: null,

          emplIdController: TextEditingController(),
          applicationNumberController: TextEditingController(),
        ));
      }




      if (checklistCode != null) {
        // Check if the checklistCode exists in the map and has non-null values
        final lovValues =
            Constants.lovCodeMap[checklistCode.toString()]?.values;
        if (lovValues != null) {
          /// Attachments list
          _attachmentsList = populateSimpleValuesFromLOV(
            menuItemsList: lovValues,
            provider: langProvider,
            textColor: AppColors.scoButtonColor,
          );

          /// Creating attachments list
          for (var element in _attachmentsList) {
            final processCD = element.code.toString().split(':').elementAt(0).toString();
            final documentCD = element.code.toString().split(':').last.toString();
            addToMyAttachment(element: element, documentCD: documentCD, processCD: processCD);
          }
        } else {
          print("Checklist code not found or values are null.");
        }
      }


      /// Getting the uploaded list of attachments
      final getListOfAttachmentProvider = Provider.of<GetListOfAttachmentsViewModel>(context, listen: false);
      await getListOfAttachmentProvider.getListOfAttachments();
      listOfAttachments.clear();
      if (getListOfAttachmentProvider.apiResponse.status == Status.COMPLETED) {
        listOfAttachments = getListOfAttachmentProvider.apiResponse.data?.data?.fileList ?? [];
      }

      setState(() {});
      resetProcessing(false);
    });
    resetProcessing(false);
  }

  bool _isProcessing = false;

  resetProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LanguageChangeViewModel langProvider =
        context.read<LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustomSimpleAppBar(
          titleAsString: localization.attachments,
        ),
        body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildUi()),
        ));
  }

  Widget _buildUi() {
    final LanguageChangeViewModel langProvider =
        context.read<LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return _isProcessing ? Utils.pageLoadingIndicator(context: context) : Consumer<GetAllActiveScholarshipsViewModel>(
      builder: (context, provider, _) {
        switch (provider.apiResponse.status) {
          case Status.LOADING:
            return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return Utils.showOnError();
          case Status.COMPLETED:
            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kPadding-8, vertical: 5),
                child: Column(
                  children: [
                    _buildAttachmentsSection(langProvider),
                    kFormHeight,
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

  Widget _buildAttachmentsSection(langProvider) {
    final localization = AppLocalizations.of(context)!;
    return CustomInformationContainer(leading: SvgPicture.asset("assets/attachments.svg"),title: localization.attachments,
        expandedContentPadding: EdgeInsets.zero,
        expandedContent: Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _myAttachmentsList.length, // Use filtered length
          itemBuilder: (context, index) {
            final myAttachment = _myAttachmentsList[index]; // From filtered list
            File? file;

            return Consumer<AttachFileViewmodel>(
              builder: (context, provider, _) {
                // Check if the attachment is already uploaded and not invalid (IV status)
                bool isAlreadyUploaded = listOfAttachments.any(
                      (i) =>
                  i.processCD == myAttachment.processCdController.text &&
                      i.documentCD == myAttachment.documentCdController.text &&
                      i.attachmentStatus != "IV",
                );

                // Find the already uploaded file if available
                FileList? uploadedFile = isAlreadyUploaded ? listOfAttachments.firstWhere((i) => i.processCD == myAttachment.processCdController.text && i.documentCD == myAttachment.documentCdController.text && i.attachmentStatus != "IV",
                  // Prevent errors if not found
                ) : null;

                // Check if the attachment is already uploaded and not invalid (IV status)
                bool isAlreadyUploadedInValid = listOfAttachments.any(
                      (i) =>
                  i.processCD == myAttachment.processCdController.text &&
                      i.documentCD == myAttachment.documentCdController.text &&
                      i.attachmentStatus == "IV",
                );


                /// Find the Invalid File
                FileList? isAlreadyUploadedFileInValid = isAlreadyUploadedInValid ? listOfAttachments.firstWhere((i) => i.processCD == myAttachment.processCdController.text && i.documentCD == myAttachment.documentCdController.text && i.attachmentStatus == "IV",
                  // Prevent errors if not found
                ) : null;


                final required = myAttachment.requiredController.text.toString();


                return isAlreadyUploaded
                    ?
                /// Don't do anything with this section
                Column(
                  children: [
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Column(
                        children: [
                          CustomInformationContainerField(title: localization.sr ?? '',description: (index+1).toString(),),
                          CustomInformationContainerField(title: localization.fileName ?? '',
                              // description: getFullNameFromLov(langProvider: langProvider,lovCode: checklistCode,code: "${myAttachment.processCdController.text}:${myAttachment.documentCdController.text}").replaceAll('\n', '')
                              descriptionAsWidget:
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:  getFullNameFromLov(langProvider: langProvider,lovCode: checklistCode,code: myAttachment.attachmentNameController.text).replaceAll('\n', ''),
                                      style: AppTextStyles.normalTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.scoButtonColor),
                                    ),
                                    TextSpan(text: (required == 'XMRL' || required == 'MRL' || required == 'NMRL') ? "*" : "", style: AppTextStyles.titleBoldTextStyle().copyWith(fontWeight: FontWeight.w600, color: Colors.red),),
                                  ]))
                          ),
                          CustomInformationContainerField(title: localization.comment ?? '',description: uploadedFile?.description?.toString(),),
                          CustomInformationContainerField(title: localization.status ?? '',description: localization.documentUploaded,isLastItem: true,),
                        ],
                      ),
                    ),
                    if(index < _myAttachmentsList.length -1) sectionDivider()
                  ],
                )
                    :
                Column(
                  children: [
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: UploadUpdateAttachmentFileView(
                        attachmentNumber: index + 1,
                        selectedCheckListCode: checklistCode ?? '',
                        myAttachment: myAttachment,
                        isValid: isAlreadyUploadedInValid,
                        onAction: () {
                          // Reset file and clear fields
                          setState(() {
                            myAttachment.userFileNameController.text = "";
                            myAttachment.base64StringController.text = "";
                            myAttachment.commentController.text = '';
                            myAttachment.descriptionController.text = '';
                            file = null;
                          });
                        },
                        onPressed: () async {
                          // Allowed file extensions based on document code
                          final isPhoto = myAttachment.documentCdController.text.toUpperCase() == 'SEL006';
                          final allowedExtensions = isPhoto ? ['jpg', 'jpeg'] : ['pdf'];

                          // Set file type and supported extensions
                          myAttachment.supportedFileTypeController.text = isPhoto ? ".jpeg|.jpg|.JPEG|.JPG" : ".pdf|.PDF";
                          myAttachment.fileTypeController.text = isPhoto ? "1" : "2";

                          // Pick the file
                          file = await _mediaServices.getSingleFileFromPicker(allowedExtensions: allowedExtensions);

                          if (file != null) {
                            resetProcessing(true);
                            try {
                              // Update filename and base64 content
                              myAttachment.userFileNameController.text = file!.path.split('/').last;
                              myAttachment.base64StringController.text = base64Encode(file!.readAsBytesSync());


                              /// if file already uploaded is invalid
                              if (isAlreadyUploadedInValid) {
                                myAttachment.toUpdateApprovedAttachment = true;
                                // Provide a default value to prevent null assignment
                                myAttachment.emplIdController?.text = isAlreadyUploadedFileInValid?.applictantId ?? ''; // Default to an empty string
                                myAttachment.applicationNumberController?.text = widget.applicationStatusDetails.admApplicationNumber ?? ''; // Default to an empty string
                              }


                              // Optionally, call the provider to upload the file
                              // final result = await provider.attachFile(file: myAttachment.toJson());

                              // On success, update UI or reset fields on failure
                              // setState(() {
                              //   resetProcessing(false);
                              //   if (!result) {
                              //     // Reset file and clear fields
                              //     myAttachment.userFileNameController.text = "";
                              //     myAttachment.base64StringController.text = "";
                              //     myAttachment.commentController.text = '';
                              //     file = null;
                              //   }
                              // });
                            } finally {
                              resetProcessing(false);
                            }
                          }
                          },
                      ),
                    ),
                   if(index < _myAttachmentsList.length -1) sectionDivider()
                  ],
                );
              },
            );
          },

        )
      ],
    ));
  }

  Widget _submitAndBackButton(
      {required AppLocalizations localization,
      required LanguageChangeViewModel langProvider}) {
    final uploadUpdateProvider = Provider.of<UploadUpdateAttachmentViewModel>(context);
    /// SubmitButton
    return Column(
      children: [
        CustomButton(
            buttonName: localization.update,
            isLoading: uploadUpdateProvider.apiResponse.status == Status.LOADING,
            textDirection: getTextDirection(langProvider),
            onTap: ()async {
              bool isUploadingFlag = false;
              // final logger = Logger();
              for(var element in _myAttachmentsList){
                resetProcessing(true);
                if(element.base64StringController.text.isNotEmpty){
                  isUploadingFlag  = true;
                  if(element.toUpdateApprovedAttachment){
                    element.descriptionController.text = element.commentController.text;
                    await uploadUpdateProvider.uploadUpdateFile(fileData: element.updateAttachmentToJson(), isUpdating: true);
                    // log(jsonEncode(element.updateAttachmentToJson()).toString());
                  }
                  else{
                    element.descriptionController.text = element.commentController.text;
                    await uploadUpdateProvider.uploadUpdateFile(fileData: element.uploadAttachmentToJson(), isUpdating: false);
                    // log(jsonEncode(element.uploadAttachmentToJson()).toString());
                  }
                }
                resetProcessing(false);
              }
             if(isUploadingFlag) await _refreshPage();
              resetProcessing(false);
            }),
        kFormHeight,
        const KReturnButton(),
      ],
    );
  }
}
