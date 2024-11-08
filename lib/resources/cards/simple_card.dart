import 'package:flutter/material.dart';

import '../app_colors.dart';

class SimpleCard extends StatelessWidget {
  final Widget expandedContent;
  Color? cardColor;
   SimpleCard({super.key,required this.expandedContent,this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor ?? Colors.white,
      borderRadius: const BorderRadius.all(
     Radius.circular(15),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        decoration:  BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: const BorderRadius.all(
            Radius.circular(15)
          ),
        ),
        child: expandedContent,
      ),
    );

  }
}
