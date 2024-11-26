import 'package:flutter/material.dart';

import '../app_colors.dart';

class SimpleCard extends StatelessWidget {
  final Widget expandedContent;
  dynamic onTap;
   EdgeInsetsGeometry? contentPadding;
  Color? cardColor;
   SimpleCard({super.key,this.contentPadding ,required this.expandedContent,this.cardColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(

        color: cardColor ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          width: double.maxFinite,
          padding: contentPadding ??  const EdgeInsets.all(20),
          decoration:  BoxDecoration(
            // color: Colors.white,
            border: Border.all(color: AppColors.lightGrey),
            borderRadius: const BorderRadius.all(
              Radius.circular(15)
            ),
          ),
          child: expandedContent,
        ),
      ),
    );
  }
}
