import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';

class CustomMaterialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isEnabled;
  final ShapeBorder shape;
  VisualDensity? visualDensity;

   CustomMaterialButton(
      {super.key,
      this.isEnabled = false,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.textColor = Colors.black,
      this.shape = const RoundedRectangleBorder(),
      this.visualDensity,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isEnabled ? () {} : onPressed,
      elevation: 0.3,
      color: backgroundColor,
      textColor: textColor,
      enableFeedback: true,
      splashColor: AppColors.scoThemeColor.withOpacity(0.2),
      shape: shape,
      visualDensity:  visualDensity,
      child: child,
    );
  }
}
