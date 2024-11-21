import 'package:flutter/cupertino.dart';

import '../../view/apply_scholarship/form_view_Utils.dart';

class AttachmentAddFileButton extends StatelessWidget {
  final dynamic addFile;
  const AttachmentAddFileButton({super.key,required this.addFile});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Attachments"),
        addRemoveMoreSection(
            title: "Add File",
            add: true,
            onChanged: addFile)
      ],
    );
  }
}
