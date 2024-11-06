import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePicture extends StatelessWidget {
  final File? profileImageFile;
  final String? profileImageUrl;

  const ProfilePicture({
    Key? key,
    this.profileImageFile,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(180),
      color: Colors.grey,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(360)),
        child: profileImageFile != null
            ? Image.file(
          profileImageFile!,
          height: 100,
          width: 100,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            // Fallback in case of error loading the file image
            return SvgPicture.asset("assets/personal_details/dummy_profile_pic.svg");
          },
        )
            :
        FadeInImage(
          height: 100,
          width: 100,
          fit: BoxFit.fill,
          placeholder: const AssetImage("assets/personal_details/Picture.png"), // Placeholder image
          imageErrorBuilder: (context, error, stackTrace) {
            // Fallback if network image fails to load
            return Image.asset(
              "assets/personal_details/edit_profile_pic.png",
              height: 100,
              width: 100,
              // fit: BoxFit.cover,
            );
          },
          image: profileImageUrl != null && profileImageUrl!.isNotEmpty
              ? NetworkImage(profileImageUrl!)
              : const AssetImage("assets/personal_details/Picture.png"), // Use placeholder if no profileImageUrl
        ),
      ),
    );
  }
}
