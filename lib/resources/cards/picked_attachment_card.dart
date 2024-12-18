import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/models/apply_scholarship/AttachFileModel.dart';
import 'package:sco_v1/models/services/GetAllRequestsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/viewModel/account/get_base64String_viewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../data/response/status.dart';
import '../../utils/utils.dart';
import '../../view/apply_scholarship/form_view_Utils.dart';
import '../app_colors.dart';

class PickedAttachmentCard extends StatefulWidget {
  final AttachmentType attachmentType;
  final int index;
  final dynamic attachment;
  final VoidCallback onRemoveAttachment;

  const PickedAttachmentCard(
      {super.key,
      required this.attachmentType,
      required this.index,
      required this.attachment,
      required this.onRemoveAttachment});

  @override
  State<PickedAttachmentCard> createState() => _PickedAttachmentCardState();
}

class _PickedAttachmentCardState extends State<PickedAttachmentCard> with MediaQueryMixin {
  late AlertServices _alertServices;

  File? file;
  String fileSize = "";
  String fileName = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final GetIt getIt = GetIt.instance;
      _alertServices = getIt.get<AlertServices>();

      await _initializeFile();
    });
  }

  Future<void> _initializeFile() async {
    /// Handling attachments types because the models are varying
    if (widget.attachmentType == AttachmentType.employment ||
        widget.attachmentType == AttachmentType.updateNote) {
      if (widget.attachment.base64StringController.text.isNotEmpty) {
        file = await convertBase64ToFile(
          widget.attachment.base64StringController.text,
          widget.attachment.attachSysfileNameController.text,
        );
      } else {
        //// Fetching the data from the api
        await _fetchFileFromApi();
      }

      if (file != null) {
        fileSize = await Utils.getFileSize(file: file);
        fileName = Utils.getFileName(file: file!);
      }
      setState(() {});
    }

    if (widget.attachmentType == AttachmentType.request) {
      if (widget.attachment.base64StringController.text.isNotEmpty) {
        file = await convertBase64ToFile(
          widget.attachment.base64StringController.text,
          widget.attachment.attachmentSysFileNameController.text,
        );
      } else {
        //// Fetching the data from the api
        await _fetchFileFromApi();
      }

      if (file != null) {
        fileSize = await Utils.getFileSize(file: file);
        fileName = Utils.getFileName(file: file!);
      }
      setState(() {});
    }
  }

  Future<void> _fetchFileFromApi() async {
    try {
      /// Show loading state
      setState(() {
        widget.attachment.isLoading = true;
      });

      /// Handle API calls based on the attachment type
      switch (widget.attachmentType) {
        case AttachmentType.employment:
          await _fetchEmploymentFile(attachmentType: AttachmentType.employment);
          break;
        case AttachmentType.updateNote:
          await _fetchEmploymentFile(attachmentType: AttachmentType.updateNote);
          break;
        case AttachmentType.request:
          await _fetchRequestFile();
          break;
        default:
          debugPrint("Unsupported attachment type.");
      }
    } catch (e, stackTrace) {
      // Log the error and show user feedback
      // debugPrint("Error in _fetchFileFromApi: $e");
      debugPrintStack(stackTrace: stackTrace);
      // debugPrint("An unexpected error occurred. Please try again later.");
    } finally {
      // Hide loading state
      setState(() {
        widget.attachment.isLoading = false;
      });
    }
  }

  Future<void> _fetchEmploymentFile(
      {required AttachmentType attachmentType}) async {
    final provider = Provider.of<GetBase64StringViewModel>(context, listen: false);

    final form = {
      "uniqueFileName": widget.attachment.attachSysfileNameController.text,
      "userFileName": widget.attachment.attachUserFileController.text,
    };

    await provider.getBase64String(form: form, attachmentType: attachmentType);

    if (provider.apiResponse.status == Status.COMPLETED) {
      final base64String =
          provider.apiResponse.data?.data?.fileData?.base64String ?? '';
      if (base64String.isNotEmpty) {
        file = await convertBase64ToFile(
            base64String, widget.attachment.attachSysfileNameController.text);
      } else {
        // _alertServices.showCustomSnackBar("Invalid file data received for employment attachment.");
      }
    } else if (provider.apiResponse.status == Status.ERROR) {
      _alertServices.showCustomSnackBar(provider.apiResponse.message ?? "Error fetching employment file.");
    }
  }

  Future<void> _fetchRequestFile() async {
    final provider =
        Provider.of<GetBase64StringViewModel>(context, listen: false);

    final form = {
      "uniqueFileName": widget.attachment.attachmentSysFileNameController.text,
      "userFileName": widget.attachment.userAttachmentFileController.text,
    };

    await provider.getBase64String(form: form, attachmentType: AttachmentType.request);

    if (provider.apiResponse.status == Status.COMPLETED) {
      final base64String =
          provider.apiResponse.data?.data?.fileData?.base64String ?? '';
      if (base64String.isNotEmpty) {
        file = await convertBase64ToFile(base64String,
            widget.attachment.attachmentSysFileNameController.text);
      } else {
        // debugPrint("Invalid file data received for request attachment.");
      }
    } else if (provider.apiResponse.status == Status.ERROR) {
      // debugPrint(provider.apiResponse.message ?? "Error fetching request file.");
    }
  }




// Helper Functions
  FocusNode _getFocusNodeBasedOnAttachmentType(AttachmentType attachmentType)
  {
    switch (attachmentType) {
      case AttachmentType.request:
        return widget.attachment.fileDescriptionFocusNode;
      case AttachmentType.employment:
        return widget.attachment.descriptionFocusNode;
      case AttachmentType.updateNote:
        return widget.attachment.descriptionFocusNode;
      default:
        return FocusNode();
    }
  }

  TextEditingController _getControllerBasedOnAttachmentType(
      AttachmentType attachmentType)
  {
    switch (attachmentType) {
      case AttachmentType.request:
        return widget.attachment.fileDescriptionController;
      case AttachmentType.employment:
        return widget.attachment.descriptionController;
      case AttachmentType.updateNote:
        return widget.attachment.descriptionController;
      default:
        return TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      elevation: 0.2,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Consumer<GetBase64StringViewModel>(
          builder: (context, provider, _) {
            return Column(
              children: [
                ListTile(
                  onTap: () async {
                    if (file != null) {
                      await Utils.openFile(file!);
                    } else {
                      _alertServices
                          .showCustomSnackBar("File not available to open.");
                    }
                  },
                  leading: SvgPicture.asset("assets/attachment_icon.svg"),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: widget.attachment.isLoading
                      ?  Text(localization.loading)
                      : Text(
                          "${widget.index + 1}) ${fileName.split('_').last}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                  subtitle: fileSize.isNotEmpty
                      ? Text(fileSize, style: const TextStyle(fontSize: 12))
                      :  Text(localization.fetchingFileSize),
                  trailing:
                      widget.attachment.newRecord || widget.attachment.newlyAded
                          ? IconButton(
                              onPressed: widget.onRemoveAttachment,
                              icon: const Icon(Icons.cancel_outlined,
                                  color: AppColors.scoButtonColor),
                            )
                          : null,
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localization.comments,
                            style: AppTextStyles.subTitleTextStyle().copyWith(
                                height: 2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          if(widget.attachmentType == AttachmentType.updateNote)  Text(
                          convertTimestampToDate(int.tryParse( widget.attachment.dateController.text ?? "") ?? 0),
                            style: AppTextStyles.subTitleTextStyle().copyWith(
                                height: 2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      // SizedBox(height: 8.0),


                      !(((widget.attachmentType == AttachmentType.updateNote || widget.attachmentType == AttachmentType.employment) && !widget.attachment.newRecord) || (widget.attachmentType == AttachmentType.request && !widget.attachment.newlyAded) ) ? scholarshipFormTextField(
                      maxLines: 3,
                      // readOnly: widget.attachmentType == AttachmentType.updateNote && !widget.attachment.newRecord,
                      // filled: widget.attachmentType == AttachmentType.updateNote && !widget.attachment.newRecord,
                      // filled: true,
                      textInputType: TextInputType.multiline,
                      currentFocusNode: _getFocusNodeBasedOnAttachmentType(widget.attachmentType),
                      controller: _getControllerBasedOnAttachmentType(widget.attachmentType),
                      hintText: localization.commentsWatermark,
                      onChanged: (value) {},
                    ) : Text(
                          _getControllerBasedOnAttachmentType(widget.attachmentType).text,style: textFieldTextStyle,
                      )
              ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
