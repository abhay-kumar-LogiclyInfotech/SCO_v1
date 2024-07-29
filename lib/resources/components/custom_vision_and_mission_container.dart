
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_expansion_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

class CustomVisionAndMissionContainer extends StatelessWidget {
  final String text;
  const CustomVisionAndMissionContainer({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen:false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
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
              child: Padding(
                padding: const EdgeInsets.only(right:15,left: 15,top: 10,bottom: 10),
                child: Text(text),
              ),
            ),
          ),
        ],
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
