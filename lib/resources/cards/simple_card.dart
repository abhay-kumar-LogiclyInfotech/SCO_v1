import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../app_colors.dart';

class SimpleCard extends StatefulWidget {
  final Widget expandedContent;
  dynamic onTap;
   EdgeInsetsGeometry? contentPadding;
  Color? cardColor;
   SimpleCard({super.key,this.contentPadding ,required this.expandedContent,this.cardColor,this.onTap});

  @override
  State<SimpleCard> createState() => _SimpleCardState();
}

class _SimpleCardState extends State<SimpleCard> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Material(

        // color: widget.cardColor ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          width: double.maxFinite,
          padding: widget.contentPadding ??   EdgeInsets.all(kCardPadding),
          decoration:  BoxDecoration(
            // color: Colors.white,
            color: widget.cardColor ?? Colors.white,
            border: Border.all(color: AppColors.lightGrey),
            borderRadius: const BorderRadius.all(
              Radius.circular(15)
            ),
          ),
          child: widget.expandedContent,
        ),
      ),
    );
  }
}
