import 'package:flutter/material.dart';
import 'package:profile_photo/profile_photo.dart';

import '../../app_colors.dart';

class ProfileWithCameraButton extends StatelessWidget {
  double profileSize;
  double cornerRadius;
  String? name;
  bool cameraEnabled;
  final ImageProvider profileImage;
  final IconData cameraIcon;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  ProfileWithCameraButton({
    Key? key,
    this.profileSize = 80,
    this.cornerRadius = 80,
    this.name,
    required this.profileImage,
    this.cameraIcon = Icons.camera_alt,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.blue,
    required this.onTap,
    required this.onLongPress,
    this.cameraEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Ensures elements in the stack are centered
      children: [
        ProfilePhoto(
          totalWidth: profileSize,
          cornerRadius: cornerRadius,
          color: Colors.white,
          outlineColor: AppColors.scoThemeColor,
          outlineWidth: 2,
          textPadding: 0,
          name: name ?? '',
          fontColor: Colors.white,
          nameDisplayOption: NameDisplayOptions.initials,
          fontWeight: FontWeight.w100,
          badgeAlignment: Alignment.bottomRight,
          image: profileImage,
          onTap: onTap,
          onLongPress: onLongPress,

        ),
       cameraEnabled ? Positioned(
          bottom: 0, // Positions the button at the bottom
          right: 0, // Positions the button at the right
          child: Container(
            width: 24, // Adjust size as needed
            height: 24, // Adjust size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.scoButtonColor,
              // Optional background color for contrast
              border: Border.all(
                color: AppColors.scoThemeColor,
                // Matches the outline of the photo
                width: 2,
              ),
            ),
            child: IconButton(
              iconSize: 12, // Adjust icon size
              padding: EdgeInsets.zero, // Remove default padding
              onPressed: onTap,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
