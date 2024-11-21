import 'package:flutter/material.dart';

import '../app_colors.dart';





class Destination{
static  Future chooseFilePickerDestination({required context,required dynamic onCameraTap,required dynamic onStorageTap})async{
    return showModalBottomSheet(
      showDragHandle: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
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
              const Text(
                'Choose an Option',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.scoButtonColor
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: onCameraTap
                  ),
                  _buildOption(
                    icon: Icons.storage,
                    label: 'Gallery',
                    onTap: onStorageTap
                  ),
                ],
              ),
            ],
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

