import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: 40,
              width: 350,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))
              ),
            ),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: AppColors.darkGrey, width: 1)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: CustomPaint(
                painter: DashedBottomBorderPainter(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const  Text("Hello World"),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintWithColor = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const double dashWidth = 4;
    const double dashGap = 4;
    double startX = 9;

    while (startX < size.width-9) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX + dashWidth, size.height),
        paintWithColor,
      );
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
