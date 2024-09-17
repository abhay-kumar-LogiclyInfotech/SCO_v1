import 'package:flutter/material.dart';

class CustomDashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  CustomDashedLinePainter({
    required this.color,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Change to false to avoid unnecessary repainting
  }
}

class CustomDashedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;

  const CustomDashedDivider({
    this.color = Colors.black,
    this.height = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: CustomDashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
        ),
      ),
    );
  }
}
