import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/services/notes_models/GetSpecificNoteDetailsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/services_views/guidance_notes.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/add_comment_to_note_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/get_all_notes_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/get_specific_note_details_view_Model.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/upload_attachment_to_note_viewModel.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetEmploymentStatusModel.dart';
import '../../../../models/services/GetAllRequestsModel.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/cards/picked_attachment_card.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/attachment_add_file_button.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../resources/components/kButtons/kReturnButton.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/navigation_services.dart';

class UpdateNoteView extends StatefulWidget {
  final String noteId;

  const UpdateNoteView({super.key, required this.noteId});

  @override
  State<UpdateNoteView> createState() => _UpdateNoteViewState();
}

class _UpdateNoteViewState extends State<UpdateNoteView> with MediaQueryMixin {
  late MediaServices _mediaServices;

  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// fetch my application with approved
      final provider = Provider.of<GetSpecificNoteDetailsViewModel>(context, listen: false);
      await provider.getSpecificNoteDetails(noteId: widget.noteId);

      final commentsList = provider.apiResponse.data?.data?.adviseeNote?.noteDetailList ?? [];
      if (commentsList.isNotEmpty) {
        _commentsDetailsList.clear();
        for (var element in commentsList) {
          _commentsDetailsList.add(NoteDetailList.fromJson(element.toJson()));
        }
      }

      final attachmentsList = provider.apiResponse.data?.data?.adviseeNote?.listOfAttachments ?? [];

      /// Fetching the list of attachments and initializing the mh list:
      if (attachmentsList.isNotEmpty) {
        _attachmentsList.clear();
        for (int i = 0; i < attachmentsList.length; i++) {
          _attachmentsList
              .add(ListOfFiles.fromJson(attachmentsList![i].toJson()));
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _commentsDetailsList.clear();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _mediaServices = getIt.get<MediaServices>();

      await _initializeData();
    });

    super.initState();
  }

  bool _isProcessing = false;

  setIsProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: localization.updateAdvisorNote),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi(localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetSpecificNoteDetailsViewModel>(
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
          final listDetails = provider.apiResponse.data?.data?.adviseeNote?.noteDetailList ?? [];
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
                    listDetails.isNotEmpty
                        ? _listDetails(
                            provider: provider, langProvider: langProvider,localization: localization)
                        : Utils.showOnNoDataAvailable(context: context),
                    kSmallSpace,
                    _listComments(langProvider: langProvider,localization: localization),
                    kSmallSpace,
                    SimpleCard(
                        expandedContent: Column(
                      children: [
                        _attachmentsUploadSection(),

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
                      ],
                    )),
                    kSmallSpace,
                    _submitAndBackButton(
                        langProvider: langProvider,
                        getSpecificNoteDetailsProvider: provider,localization: localization),
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

  //// *----------------------- BASIC INFO SECTION START ------------------------*
  Widget _listDetails(
      {required GetSpecificNoteDetailsViewModel provider,
      required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    final noteInfo = provider.apiResponse.data?.data?.adviseeNote;
    return CustomInformationContainer(
        title: localization.noteDetails,
        leading: SvgPicture.asset("assets/services/request_details.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(
                title: localization.institution,
                description: noteInfo?.institution ?? '- -'),
            CustomInformationContainerField(
                title: localization.type,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: "CATEGORY",
                    code: noteInfo?.noteType ?? '- -')),
            CustomInformationContainerField(
                title: localization.subType,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: 'SUB_CATEGORY#${noteInfo?.noteType}',
                    code: noteInfo?.noteSubType ?? '- -')),
            CustomInformationContainerField(
                title: localization.contactType,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: "CONTACT_TYPE",
                    code: noteInfo?.contactType)),
            CustomInformationContainerField(
                title:localization.noteStatus,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: "NOTE_STATUS",
                    code: noteInfo?.noteStatus)),
            CustomInformationContainerField(
                title: localization.canAdviseeView,
                description: getFullNameFromLov(
                    langProvider: langProvider,
                    lovCode: "NOTE_ACCESS",
                    code: noteInfo?.access)),
            CustomInformationContainerField(
                title: localization.createdOn,
                description: noteInfo?.createdOn?.toString() ?? '- -'),
            CustomInformationContainerField(
                title: localization.subject,
                description: noteInfo?.subject ?? '- -',
                isLastItem: true),
          ],
        ));
  }

  //// *----------------------- BASIC INFO SECTION END ------------------------*

  //// *----------------------- COMMENTS SECTION START ------------------------*
  /// Comments Details Sections and also option to add comment
  final List<NoteDetailList> _commentsDetailsList = [];

  _addComment() {final date = DateTime.now().millisecondsSinceEpoch;
    _commentsDetailsList.add(NoteDetailList(
        itemSeqController: TextEditingController(),
        noteItemLongTextController: TextEditingController(),
        craetedOnController: TextEditingController(text: date.toString()),
        desc2Controller: TextEditingController(),
        itemSeqFocusNode: FocusNode(),
        noteItemLongTextFocusNode: FocusNode(),
        craetedOnFocusNode: FocusNode(),
        desc2FocusNode: FocusNode(),
        newRecord: true,
        isLoading: false));
    setState(() {});
  }

  _deleteComment(index) {
    if (_commentsDetailsList.isNotEmpty) {
      _commentsDetailsList.removeAt(index);
    }
  }

  Widget _listComments({required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    return SimpleCard(
        expandedContent: _commentsDetailsList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _commentsDetailsList.length,
                itemBuilder: (context, index) {
                  final comment = _commentsDetailsList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInformationContainerField(
                          title: localization.sr,
                          description: (index + 1).toString() ?? '- -'),
                      CustomInformationContainerField(
                          title: localization.createdBy,
                          description: comment.desc2Controller.text ?? '- -'),
                      CustomInformationContainerField(
                        title: localization.createdOn,
                        description: convertTimestampToDate(int.tryParse(
                                comment.craetedOnController.text.toString() ??
                                    '- -') ??
                            0),
                        bottomPadding: const EdgeInsets.only(bottom: 10),
                      ),
                      !(comment.newRecord ?? false)
                          ? CustomInformationContainerField(
                              title: localization.comment,
                              description:
                                  comment.noteItemLongTextController.text ??
                                      '- -',
                              isLastItem: true,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(localization.comment,
                                    style: AppTextStyles.subTitleTextStyle()),
                                const SizedBox(
                                  height: 5,
                                ),
                                scholarshipFormTextField(
                                    readOnly: !(comment.newRecord ?? false),
                                    filled: !(comment.newRecord ?? false),
                                    maxLines: 2,
                                    currentFocusNode:
                                        comment.noteItemLongTextFocusNode,
                                    controller:
                                        comment.noteItemLongTextController,
                                    hintText: localization.commentsWatermark,
                                    onChanged: (value) {}),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                      if (comment.newRecord)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(
                              localization.actions,
                              style: AppTextStyles.subTitleTextStyle()
                                  .copyWith(height: 2),
                            ),
                            // kFormHeight,

                            //// Add new comment button
                            actionButton(
                                assetAddress: "assets/services/bin.svg",
                                text: localization.delete,
                                onTap: () {
                                  setState(() {
                                    _deleteComment(index);
                                  });
                                }),
                          ],
                        ),
                      Column(
                        children: [
                          kFormHeight,
                          const MyDivider(
                            color: AppColors.darkGrey,
                          ),
                          kFormHeight,
                        ],
                      ),
                      if (index == _commentsDetailsList.length - 1)
                        addRemoveMoreSection(
                            title: localization.addComment,
                            add: true,
                            onChanged: () {
                              setState(() {
                                _addComment();
                              });
                            })
                    ],
                  );
                })
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
                child: Utils.showOnNoDataAvailable(context: context),
              ));
  }

  //// *----------------------- COMMENTS SECTION END ------------------------*

  //// *----------------------- ADD ATTACHMENTS SECTION START ------------------------*
  final List<ListOfFiles> _attachmentsList = [];

  Widget _attachmentsUploadSection() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _attachmentsList.length,
        shrinkWrap: true,
        reverse: false,
        itemBuilder: (context, index) {
          final attachment = _attachmentsList[index];
          return Column(
            children: [
              /// to show the card and also remove function is implemented
              PickedAttachmentCard(
                  index: index,
                  attachmentType: AttachmentType.updateNote,
                  attachment: attachment,
                  onRemoveAttachment: () {
                    setState(() {
                      _attachmentsList.removeAt(index);
                    });
                  }),
               SizedBox.square(dimension: kCardSpace),
            ],
          );
        });
  }

  /// Function to add Attachment to the list
  _addFile() async {
    /// kindly check for permissions
    // final permitted = await _permissionServices.checkAndRequestPermission(
    //     Platform.isIOS ? Permission.storage : Permission.manageExternalStorage,
    //     context);
    if (true) {
      /// TODO: PLEASE ADD ALLOWED EXTENSIONS
      final file = await _mediaServices.getSingleFileFromPicker();
      final date = DateTime.now().millisecondsSinceEpoch;

      if (file != null) {
        setState(() {
          _attachmentsList.add(ListOfFiles(
            attachmentSeqNumberController: TextEditingController(),
            descriptionController: TextEditingController(),
            dateController: TextEditingController(text: date.toString()),
            attachSysfileNameController:
                TextEditingController(text: file.path.split('/').last),
            attachUserFileController:
                TextEditingController(text: file.path.split('/').last),
            base64StringController: TextEditingController(
                text: base64Encode(file.readAsBytesSync())),
            attachmentSeqNumberFocusNode: FocusNode(),
            descriptionFocusNode: FocusNode(),
            dateFocusNode: FocusNode(),
            attachSysfileNameFocusNode: FocusNode(),
            attachUserFileFocusNode: FocusNode(),
            base64StringFocusNode: FocusNode(),
            newRecord: true,
          ));
        });
      }
    }
  }

//// *----------------------- ADD ATTACHMENTS SECTION END ------------------------*

  Widget _submitAndBackButton({
    required langProvider,
    required GetSpecificNoteDetailsViewModel getSpecificNoteDetailsProvider,
    required AppLocalizations localization
  }) {
    final uploadAttachmentProvider =
        Provider.of<UploadAttachmentToNoteViewModel>(context, listen: false);

    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => AddCommentToNoteViewModel(),
          child: Consumer<AddCommentToNoteViewModel>(
            builder: (context, updateProvider, _) {
              return CustomButton(
                buttonName: localization.update,
                isLoading: _isProcessing,
                borderColor: Colors.transparent,
                // buttonColor: AppColors.scoThemeColor,
                textDirection: getTextDirection(langProvider),
                onTap: () async {
                  try {
                    bool hasUpdates = false; // Track if updates are made
                    setIsProcessing(true); // Start processing

                    // Upload comments
                    for (var comment in _commentsDetailsList) {
                      if (comment.newRecord &&
                          comment.noteItemLongTextController.text
                              .trim()
                              .isNotEmpty) {
                        hasUpdates = true;
                        createCommentForm(
                          getSpecificNoteDetailsProvider:
                              getSpecificNoteDetailsProvider,
                          description: comment.noteItemLongTextController.text,
                        );
                        await updateProvider.addCommentToNote(
                          form: updateCommentForm,
                          noteId: widget.noteId,
                        );
                      }
                    }

                    // Upload attachments
                    for (var attachment in _attachmentsList) {
                      if (attachment.newRecord) {
                        hasUpdates = true;
                        createAttachmentForm(
                            getSpecificNoteDetailsProvider:
                                getSpecificNoteDetailsProvider,
                            attachment: attachment);
                        await uploadAttachmentProvider.uploadAttachmentToNote(
                          form: updateAttachmentForm,
                          noteId: widget.noteId,
                        );
                      }
                    }

                    // Reinitialize data if updates were made
                    if (hasUpdates) {
                      await _initializeData();
                    }
                  } catch (e) {
                    // Handle any errors gracefully
                    // print("Error during update: $e");
                  } finally {
                    setIsProcessing(false); // Stop processing
                  }
                },
              );
            },
          ),
        ),
        kFormHeight,
        const KReturnButton(),
      ],
    );
  }

  var updateCommentForm = {};
  var updateAttachmentForm = {};

  createCommentForm(
      {required GetSpecificNoteDetailsViewModel getSpecificNoteDetailsProvider,
      dynamic description,
      ListOfFiles? attachment}) {
    final noteInfo =
        getSpecificNoteDetailsProvider.apiResponse.data?.data?.adviseeNote;
    updateCommentForm = {
      "emplId": noteInfo?.emplId,
      "institution": noteInfo?.institution,
      "access": noteInfo?.access,
      "noteId": noteInfo?.noteId,
      "noteType": noteInfo?.noteType,
      "noteSubType": noteInfo?.noteSubType,
      "advisorId": noteInfo?.advisorId,
      "noteStatus": noteInfo?.noteStatus,
      "contactType": noteInfo?.contactType,
      "subject": noteInfo?.subject,
      "description": description,
    };
  }

  createAttachmentForm(
      {required GetSpecificNoteDetailsViewModel getSpecificNoteDetailsProvider,
      ListOfFiles? attachment}) {
    final noteInfo =
        getSpecificNoteDetailsProvider.apiResponse.data?.data?.adviseeNote;

    updateAttachmentForm = {
      "emplId": noteInfo?.emplId,
      "institution": noteInfo?.institution,
      "noteId": noteInfo?.noteId,
      "listOfAttachments": attachment?.toJson()
    };
  }
}
