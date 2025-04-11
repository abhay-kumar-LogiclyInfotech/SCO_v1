import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../app_colors.dart';


import '../../l10n/app_localizations.dart';



class Destination{
static  Future chooseFilePickerDestination({required context,required dynamic onCameraTap,required dynamic onStorageTap})async{
   final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
   final localization = AppLocalizations.of(context)!;

    return showModalBottomSheet(
      showDragHandle: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Directionality(
          textDirection: getTextDirection(langProvider),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.vertical(
                  top: Radius.circular(20)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  localization.chooseOption,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.scoButtonColor
                  ),
                ),
                 Text(localization.imageSizeLimit,style: const TextStyle(fontSize: 10),),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOption(
                      icon: Icons.camera_alt,
                      label: localization.camera,
                      onTap: onCameraTap
                    ),
                    _buildOption(
                      icon: Icons.storage,
                      label: localization.gallery,
                      onTap: onStorageTap
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



Widget _buildOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.lightGrey,
          child: Icon(icon, size: 30, color: AppColors.scoThemeColor,),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

