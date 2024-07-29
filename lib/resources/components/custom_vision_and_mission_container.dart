import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

class CustomVisionAndMissionContainer extends StatelessWidget {
  final String title;
  String? description;
  CustomVisionAndMissionContainer(
      {super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: AppColors.darkGrey, width: 1.5)),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: CustomPaint(
              painter: DashedBottomBorderPainter(),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: description != null
                          ? const TextStyle(color: AppColors.scoThemeColor)
                          : null,
                      textAlign: TextAlign.justify,
                    ),
                    description != null
                        ? Text(description!,textAlign: TextAlign.justify,)
                        : const SizedBox.shrink()
                  ],
                ),
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
      ..strokeWidth = 4;

    const double dashWidth = 4;
    const double dashGap = 4;
    double startX = 5.5;

    while (startX < size.width - 5.5) {
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
