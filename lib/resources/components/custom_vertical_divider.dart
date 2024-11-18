import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  Color color;
  double height;
  CustomVerticalDivider({super.key,  this.color = Colors.grey, this.height = 28});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: height,
        child: VerticalDivider(color: color,width: 10)
    );
  }
}
