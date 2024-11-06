import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_colors.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
   Widget? trailing;
  final Widget expandedContent;

  CustomExpansionTile({
    required this.title,
    this.trailing,
    required this.expandedContent,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin, MediaQueryMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen:false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  });
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                    color: AppColors.scoButtonColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(widget.title,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      Transform.rotate(
                        angle: _isExpanded ? pi : 2*pi, // 270° or 90°
                        child:  widget.trailing ?? const SizedBox.shrink() ,
                      )
                    ],
                  ),
                ),
              ), // SizeTransition(

              SizeTransition(
                sizeFactor: _animation,
                child: CustomPaint(
                  painter: DashedBottomBorderPainter(),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                    child: widget.expandedContent,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DashedBottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.scoButtonColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Paint solidPaint = Paint()
      ..color = AppColors.darkGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    // const double dashWidth = 4;
    // const double dashGap = 4;
    // double startX = 3;

    // while (startX < size.width-2) {
    //   canvas.drawLine(
    //     Offset(startX, 0),
    //     Offset(startX + dashWidth, 0),
    //     paint,
    //   );
    //   startX += dashWidth + dashGap;
    // }

    const double radius = 15;

    final rightPath = Path()
      ..moveTo(size.width, 2)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: const Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: const Radius.circular(radius))
      ..lineTo(0, 2);
    canvas.drawPath(rightPath, solidPaint);

    // canvas.drawLine(Offset(size.width-15,size.height), Offset(0, size.height), paint);
    // canvas.drawLine(Offset(0,size.height), Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
