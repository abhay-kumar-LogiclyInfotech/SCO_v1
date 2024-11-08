import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/utils.dart';
import '../app_colors.dart';

class PickedAttachmentCard extends StatefulWidget {
  final File file;
  final VoidCallback onRemoveAttachment;

  const PickedAttachmentCard({super.key,required this.file,required this.onRemoveAttachment});

  @override
  State<PickedAttachmentCard> createState() => _PickedAttachmentCardState();
}

class _PickedAttachmentCardState extends State<PickedAttachmentCard> {

  String fileSize = "";
  String fileName = "";

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((callback)async{
       fileSize =  await Utils.getFileSize(file: widget.file);
       fileName = Utils.getFileName(file: widget.file);
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
