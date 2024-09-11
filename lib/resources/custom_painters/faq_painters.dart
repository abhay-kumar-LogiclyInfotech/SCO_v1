

import 'package:flutter/material.dart';

import '../app_colors.dart';

class FaqSmallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1
    paint.color = AppColors.lightBlue2;
    path = Path();
    path.lineTo(0, size.height * 0.35);
    path.cubicTo(size.width * 0.08, size.height / 4, size.width * 0.18, size.height / 5, size.width / 4, size.height / 5);
    path.cubicTo(size.width * 0.37, size.height * 0.22, size.width / 2, size.height * 0.3, size.width * 0.64, size.height / 4);
    path.cubicTo(size.width * 0.78, size.height / 5, size.width * 0.91, 0, size.width, 0);
    path.cubicTo(size.width, size.height * 0.12, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.35, 0, size.height * 0.35);
    path.cubicTo(0, size.height * 0.35, 0, size.height * 0.40, 0, size.height * 0.35);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



class FaqBigPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = AppColors.lightBlue1.withOpacity(0.5);
    path = Path();
    path.lineTo(0, size.height * 0.51);
    path.cubicTo(size.width * 0.08, size.height * 0.36, size.width * 0.16, size.height * 0.3, size.width * 0.24, size.height * 0.29);
    path.cubicTo(size.width * 0.41, size.height * 0.28, size.width * 0.49, size.height * 0.46, size.width * 0.63, size.height * 0.38);
    path.cubicTo(size.width * 0.78, size.height * 0.3, size.width * 0.91, 0, size.width, 0);
    path.cubicTo(size.width, size.height * 0.19, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.51, 0, size.height * 0.51);
    path.cubicTo(0, size.height * 0.51, 0, size.height * 0.51, 0, size.height * 0.51);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



