import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(title: Text('Custom Expansion Tile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomExpansionTile(
            title: Text('Expansion Tile Title',style: TextStyle(color: Colors.white),),
            children: [
              ListTile(title: Text('Item 1')),
              ListTile(title: Text('Item 2')),
              ListTile(title: Text('Item 3')),
            ],
          ),
        ),
      ),

    );
  }
}


class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  CustomExpansionTile({required this.title, required this.children});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.scoButtonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.title,
                AnimatedBuilder(
                  animation: _controller.view,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value * 1.5708, // 90 degrees in radians
                      child: Icon(Icons.expand_more),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: CustomPaint(
            painter: DashedBorderPainter(color: AppColors.scoButtonColor),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),

                ),
              ),
                child: Column(children: widget.children)),
          ),
        ),
      ],
    );
  }
}



class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw top dashed line
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    // Draw left, right, and bottom solid lines
    final solidLinePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, 0), Offset(0, size.height), solidLinePaint); // Left
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), solidLinePaint); // Right
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), solidLinePaint); // Bottom
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
