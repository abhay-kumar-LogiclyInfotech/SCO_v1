import 'package:flutter/cupertino.dart';

import '../../view/apply_scholarship/form_view_Utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AttachmentAddFileButton extends StatefulWidget {
  final dynamic addFile;
  const AttachmentAddFileButton({super.key,required this.addFile});

  @override
  State<AttachmentAddFileButton> createState() => _AttachmentAddFileButtonState();
}

class _AttachmentAddFileButtonState extends State<AttachmentAddFileButton> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(localization.attachments),
        addRemoveMoreSection(
            title: localization.addAttachment,
            add: true,
            onChanged: widget.addFile)
      ],
    );
  }
}
