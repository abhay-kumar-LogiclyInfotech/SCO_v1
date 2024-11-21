import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/models/apply_scholarship/AttachFileModel.dart';
import 'package:sco_v1/models/services/GetAllRequestsModel.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/viewModel/account/get_base64String_viewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../data/response/status.dart';
import '../../utils/utils.dart';
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

class _PickedAttachmentCardState extends State<PickedAttachmentCard> {

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
    if(widget.attachmentType == AttachmentType.employment)
    {
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

    if(widget.attachmentType == AttachmentType.request){
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

  // Future<void> _fetchFileFromApi() async {
  //
  //   /// Maintaining the state separately
  //   setState(() {
  //     widget.attachment.isLoading = true;
  //   });
  //   final provider = Provider.of<GetBase64StringViewModel>(context, listen: false);
  //   final form = {
  //     "uniqueFileName": widget.attachment.attachSysfileNameController.text,
  //     "userFileName": widget.attachment.attachUserFileController.text,
  //   };
  //
  //   await provider.getEmploymentStatusBase64String(form: form);
  //
  //   if (provider.apiResponse.status == Status.COMPLETED) {
  //     file = await convertBase64ToFile(
  //         provider.apiResponse.data?.data?.fileData?.base64String ?? '',
  //         widget.attachment.attachSysfileNameController.text);
  //   }
  //   setState(() {
  //     widget.attachment.isLoading = false;
  //   });
  // }

  Future<void> _fetchFileFromApi() async {
    try {
      /// Show loading state
      setState(() {
        widget.attachment.isLoading = true;
      });

      /// Handle API calls based on the attachment type
      switch (widget.attachmentType) {
        case AttachmentType.employment:
          await _fetchEmploymentFile();
          break;
        case AttachmentType.request:
          await _fetchRequestFile();
          break;
        default:
          debugPrint("Unsupported attachment type.");
      }
    } catch (e, stackTrace) {
      // Log the error and show user feedback
      debugPrint("Error in _fetchFileFromApi: $e");
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("An unexpected error occurred. Please try again later.");
    } finally {
      // Hide loading state
      setState(() {
        widget.attachment.isLoading = false;
      });
    }
  }


  Future<void> _fetchEmploymentFile() async {
    final provider = Provider.of<GetBase64StringViewModel>(context, listen: false);

    final form = {
      "uniqueFileName": widget.attachment.attachSysfileNameController.text,
      "userFileName": widget.attachment.attachUserFileController.text,
    };

    await provider.getBase64String(form: form,attachmentType: AttachmentType.employment );

    if (provider.apiResponse.status == Status.COMPLETED) {
      final base64String = provider.apiResponse.data?.data?.fileData?.base64String ?? '';
      if (base64String.isNotEmpty) {
        file = await convertBase64ToFile(base64String, widget.attachment.attachSysfileNameController.text);
      } else {
        _alertServices.showCustomSnackBar("Invalid file data received for employment attachment.");
      }
    } else if (provider.apiResponse.status == Status.ERROR) {
      _alertServices.showCustomSnackBar(provider.apiResponse.message ?? "Error fetching employment file.");
    }
  }


  Future<void> _fetchRequestFile() async {
    final provider = Provider.of<GetBase64StringViewModel>(context, listen: false);

    final form = {
      "uniqueFileName": widget.attachment.attachmentSysFileNameController.text,
      "userFileName": widget.attachment.userAttachmentFileController.text,
    };

    await provider.getBase64String(form: form,attachmentType: AttachmentType.request);

    if (provider.apiResponse.status == Status.COMPLETED) {
      final base64String = provider.apiResponse.data?.data?.fileData?.base64String ?? '';
      if (base64String.isNotEmpty) {
        file = await convertBase64ToFile(base64String, widget.attachment.attachmentSysFileNameController.text);
      } else {
        debugPrint("Invalid file data received for request attachment.");
      }
    } else if (provider.apiResponse.status == Status.ERROR) {
      debugPrint(provider.apiResponse.message ?? "Error fetching request file.");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Consumer<GetBase64StringViewModel>(
          builder: (context, provider, _) {
            return ListTile(
              onTap: () async {
                if (file != null) {
                  await Utils.openFile(file!);
                } else {
                  _alertServices.showCustomSnackBar("File not available to open.");
                }
              },
              leading: Image.asset("assets/document.png"),
              contentPadding: EdgeInsets.zero,
              title: widget.attachment.isLoading
                  ? const Text("loading...")
                  : Text(
                "${widget.index}) ${fileName.split('_').last}",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              subtitle: fileSize.isNotEmpty
                  ? Text(fileSize, style: const TextStyle(fontSize: 12))
                  : const Text("Fetching file size..."),
              trailing: widget.attachment.newRecord || widget.attachment.newlyAded
                  ? IconButton(
                onPressed: widget.onRemoveAttachment,
                icon: const Icon(Icons.cancel_outlined, color: AppColors.scoButtonColor),
              )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
