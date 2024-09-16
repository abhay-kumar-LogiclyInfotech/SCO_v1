import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_colors.dart';

class CustomInformationContainer extends StatefulWidget {
  final String title;
  Widget? leading;
  final Widget expandedContent;

  CustomInformationContainer({
    required this.title,
    this.leading,
    required this.expandedContent,
  });

  @override
  _CustomInformationContainerState createState() =>
      _CustomInformationContainerState();
}

class _CustomInformationContainerState extends State<CustomInformationContainer>
    with SingleTickerProviderStateMixin, MediaQueryMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: AppColors.scoButtonColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             widget.leading == null ? const SizedBox.shrink():  widget.leading!,
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          // SizeTransition(

          Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
            child: CustomPaint(
              painter: DashedBottomBorderPainter(),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                    left: 15, top: 10, right: 15, bottom: 10),
                decoration: const BoxDecoration(
                  // color: Colors.white,

                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                child: widget.expandedContent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Outer Area Container Decoration:
class DashedBottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.scoButtonColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint solidPaint = Paint()
      ..color = AppColors.darkGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const double dashWidth = 5;
    const double dashGap = 5;
    double startX = 5;

    // while (startX < size.width - 3) {
    //   canvas.drawLine(
    //     Offset(startX, 0),
    //     Offset(startX + dashWidth, 0),
    //     paint,
    //   );
    //   startX += dashWidth + dashGap;
    // }

    const double radius = 10;

    final rightPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: const Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: const Radius.circular(radius))
      ..lineTo(0, 0);
    canvas.drawPath(rightPath, solidPaint);

    // canvas.drawLine(Offset(size.width-15,size.height), Offset(0, size.height), paint);
    // canvas.drawLine(Offset(0,size.height), Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




//*----------Fields which are used inside the Information Container-------*
class CustomInformationContainerField extends StatelessWidget {
  final String title;
  String? description;
  CustomInformationContainerField({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: AppColors.darkGrey, width: 1.5)),
        ),
        child: CustomPaint(
          painter: DashedLinePainter(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 13),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: description != null
                        ? AppTextStyles.titleTextStyle()
                            .copyWith(fontWeight: FontWeight.w500)
                        : null,
                    textAlign: TextAlign.justify,
                  ),
                ),
                description != null
                    ? Expanded(
                        flex: 3,
                        child: Text(
                          description!,
                          style: AppTextStyles.normalTextStyle(),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Bottom Dashed Border for Fields.
class DashedLinePainter extends CustomPainter {
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
