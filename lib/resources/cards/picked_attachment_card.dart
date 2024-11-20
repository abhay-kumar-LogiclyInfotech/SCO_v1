import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';

import '../../utils/utils.dart';
import '../app_colors.dart';

class PickedAttachmentCard extends StatefulWidget {
  final ListOfFiles attachment;
  final VoidCallback onRemoveAttachment;

  const PickedAttachmentCard({super.key,required this.attachment,required this.onRemoveAttachment});

  @override
  State<PickedAttachmentCard> createState() => _PickedAttachmentCardState();
}

class _PickedAttachmentCardState extends State<PickedAttachmentCard> {

  File? file;
  String fileSize = "";
  String fileName = "";

  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((callback)async{


      // converting base64 to file
      file = await convertBase64ToFile(widget.attachment.base64StringController.text, widget.attachment.attachSysfileNameController.text);

      if(file != null){
        fileSize =  await Utils.getFileSize(file: file);
        fileName = Utils.getFileName(file: file!);
      }
       setState(() {
       });
    });

    super.initState();
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
        decoration:  BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: const BorderRadius.all(Radius.circular(15)
          ),
        ),
        child: ListTile(
          onTap: ()async{

            /// opening file
            if(file != null){
              await Utils.openFile(file!);
            }
          },
          leading: Image.asset("assets/document.png"),
          contentPadding: EdgeInsets.zero,
          title: Text(fileName,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
          subtitle: Text(fileSize,style: const TextStyle(fontSize: 12),),
          trailing: IconButton(onPressed: widget.onRemoveAttachment, icon: const Icon(Icons.cancel_outlined,color: AppColors.scoButtonColor,)),

        ),

      ),
    );

  }
}
