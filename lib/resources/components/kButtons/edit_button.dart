import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../../l10n/app_localizations.dart';

import '../../../view/drawer/accout_views/edit_personal_details_view.dart';
import '../../app_colors.dart';

class EditButton extends StatefulWidget {
  final VoidCallback onTap;
  const EditButton({super.key,required this.onTap});

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> with MediaQueryMixin{
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: AppColors.scoThemeColor,
            visualDensity: VisualDensity.compact,
            height: 30,
            minWidth: 80,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),
            onPressed: widget.onTap,
            child: Row(
              children: [
                SvgPicture.asset("assets/personal_details/edit_pencil.svg",height: 12,width: 12,),
                const SizedBox(width: 5),
                 Text(localization.edit,style: const  TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
