import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/view/main_view/services_views/guidance_notes.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';

import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_text_styles.dart';
import '../../../../resources/components/myDivider.dart';
import '../../../apply_scholarship/form_view_Utils.dart';



class UploadUpdateAttachmentFileView extends StatefulWidget {

  String selectedCheckListCode;
  final Attachment myAttachment; // This is the actual attachment which holds the base 64 string and other parameters also
  final dynamic onPressed;
  final dynamic onAction;
  int? attachmentNumber;
  bool? isValid;
  UploadUpdateAttachmentFileView({super.key,
    this.attachmentNumber,
    required this.selectedCheckListCode,
    required  this.myAttachment,
    required this.onPressed,
    required this.onAction,
    this.isValid = false,
  });

  @override
  State<UploadUpdateAttachmentFileView> createState() => _UploadUpdateAttachmentFileViewState();
}

class _UploadUpdateAttachmentFileViewState extends State<UploadUpdateAttachmentFileView> with MediaQueryMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final required = widget.myAttachment.requiredController.text.toString();
    final localization = AppLocalizations.of(context)!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // ****************************************************************************************************************************************************
      // title name for document

      CustomInformationContainerField(title: localization.fileName,
descriptionAsWidget:
RichText(
    text: TextSpan(children: [
      TextSpan(
        text:  "${widget.attachmentNumber}.  ${getFullNameFromLov(langProvider: langProvider,lovCode: widget.selectedCheckListCode,code: widget.myAttachment.attachmentNameController.text).replaceAll('\n', '')}",

        // getTextDirection(langProvider) == TextDirection.ltr
        //               ?  widget.attachment.value.toString().replaceAll('\n', '')
        //               : widget.attachment.valueArabic.toString().replaceAll('\n', ''),
        style: AppTextStyles.normalTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.scoButtonColor),

      ),
      TextSpan(text: (required == 'XMRL' || required == 'MRL' || required == 'NMRL') ? "*" : "", style: AppTextStyles.titleBoldTextStyle().copyWith(fontWeight: FontWeight.w600, color: Colors.red),),
    ]))
      ),
      // container to pick attachment
      Container(
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              // choose file button
              MaterialButton(
                onPressed: widget.onPressed,
                color: AppColors.scoButtonColor,
                enableFeedback: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Text(
                  localization.chooseFile,
                  style: AppTextStyles.titleTextStyle()
                      .copyWith(color: Colors.white),
                ),
              ),

              kFormHeight,
              // file name
              Expanded(
                  child: Text(
                    widget.myAttachment.userFileNameController.text,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          )),

      // show available file type
      Text(
        /// For SEL0006 document code we use images and for other then this we use pdf
          widget.myAttachment.documentCdController.text.toUpperCase() == 'SEL006' ? localization.allowedFileTypeImage : localization.allowedFileTypePdf,
          style: AppTextStyles.normalTextStyle().copyWith(color: Colors.blueGrey, fontSize: 12)),
      // const Divider(),
      kFormHeight,
      if(widget.isValid ?? false) Column(
        children: [
           Text(localization.invalidDocument,style: const TextStyle(color: AppColors.DANGER),),
          kFormHeight,
        ],
      ),

      // comments
      sectionTitle(title: localization.comments),
      // comments box
      scholarshipFormTextField(
          currentFocusNode: FocusNode(),
          controller: widget.myAttachment.commentController,
          maxLines: 3,
          textInputType: TextInputType.multiline,
          maxLength: 30,
          hintText: localization.commentsWatermark,
          onChanged: (value) {}),

      kFormHeight,
      // light grey divider
      const MyDivider(
        color: AppColors.lightGrey,
      ),

      kFormHeight,
      // Action
      Text(localization.action,style: const TextStyle(color: AppColors.darkGrey,fontSize: 12)),
      const SizedBox(height: 2),
      GestureDetector(
        onTap: widget.onAction,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/services/bin.svg" ?? ''),
            const SizedBox.square(dimension: 3),
            Text(
              localization.action ?? '',
              style: AppTextStyles.normalTextStyle().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.scoButtonColor),
            )
          ],
        ),
      ),
      // Row(
      //   mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Text(
      //       localization.action,
      //       style: const TextStyle(fontSize: 14, color: AppColors.scoButtonColor),
      //     ),
      //     GestureDetector(
      //         onTap: widget.onAction,
      //         child: SvgPicture.asset("assets/action.svg"))
      //   ],
      // ),

    ]);
  }
}






