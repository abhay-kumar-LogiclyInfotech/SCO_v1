import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/widgets/show_error_text.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';

import '../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/myDivider.dart';
import '../../viewModel/services/permission_checker_service.dart';
import 'form_view_Utils.dart';
import '../../l10n/app_localizations.dart';



class AttachFile extends StatefulWidget {

  String selectedCheckListCode;
  final Attachment myAttachment; // This is the actual attachment which holds the base 64 string and other parameters also
  final dynamic onPressed;
  final dynamic onAction;
   int? attachmentNumber;
   bool? isValid;
   AttachFile({super.key,
     this.attachmentNumber,
     required this.selectedCheckListCode,
    required  this.myAttachment,
     required this.onPressed,
     required this.onAction,
     this.isValid = false,
 });

  @override
  State<AttachFile> createState() => _AttachFileState();
}

class _AttachFileState extends State<AttachFile> with MediaQueryMixin {


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
      RichText(
          text: TextSpan(children: [
            TextSpan(
              text:  "${widget.attachmentNumber}.  ${getFullNameFromLov(langProvider: langProvider,lovCode: widget.selectedCheckListCode,code: widget.myAttachment.attachmentNameController.text).replaceAll('\n', '')}",

    // getTextDirection(langProvider) == TextDirection.ltr
    //               ?  widget.attachment.value.toString().replaceAll('\n', '')
    //               : widget.attachment.valueArabic.toString().replaceAll('\n', ''),
              style: AppTextStyles.titleBoldTextStyle()
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: (required == 'XMRL' || required == 'MRL' || required == 'NMRL') ? "*" : "", style: AppTextStyles.titleBoldTextStyle().copyWith(fontWeight: FontWeight.w600, color: Colors.red),),
          ])),

      kFormHeight,
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
      kFormHeight,


     if(widget.isValid ?? false) Column(
       children: [
         const Text("Invalid Document Uploaded. Please Re-Upload.",style: TextStyle(color: AppColors.DANGER),),
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

      kMinorSpace,
      // light grey divider
      const Divider(
        color: AppColors.lightGrey,
      ),

      kMinorSpace,
      // Action
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            localization.action,
            style: const TextStyle(fontSize: 14, color: AppColors.scoButtonColor),
          ),
          GestureDetector(
              onTap: widget.onAction,
              child: SvgPicture.asset("assets/action.svg"))
        ],
      ),
      
      kFormHeight,
      const Divider(color: AppColors.scoButtonColor,),
      kFormHeight
    ]);
  }
}






