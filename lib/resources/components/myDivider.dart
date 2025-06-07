import 'package:flutter/material.dart';

import '../app_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}


class NoMarginDivider extends StatelessWidget {
  final Color color;
  const NoMarginDivider({super.key,this.color = AppColors.darkGrey});

  @override
  Widget build(BuildContext context) {
    return   Divider(
      indent: 0,
      endIndent: 0,
      color: color, // or AppColors.darkGrey
      thickness: 1,
      height: 1, // eliminates top and bottom margin
    );
  }
}
