import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAboutOrganizationContainers extends StatefulWidget {
  final String assetName;
  final String name;
  final VoidCallback onTap;
  final TextDirection textDirection;

  const CustomAboutOrganizationContainers({
    Key? key,
    required this.assetName,
    required this.name,
    required this.onTap,
    required this.textDirection,
  }) : super(key: key);

  @override
  State<CustomAboutOrganizationContainers> createState() =>
      _CustomAboutOrganizationContainersState();
}

class _CustomAboutOrganizationContainersState
    extends State<CustomAboutOrganizationContainers> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerSize = screenWidth * 0.147;
    final textSize = screenWidth * 0.032;
    final spacing = screenHeight * 0.009;
    const iconSize = 25.0;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: screenWidth*0.3,
        child: Column(
          children: [
            _buildIconContainer(containerSize, iconSize),
            SizedBox(height: spacing),
            _buildText(textSize),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(double containerSize, double iconSize) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffB6883A), Color(0xff9D7633)],
          begin: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(containerSize * 0.18),
      ),
      child: Center(
        child: SvgPicture.asset(
          widget.assetName,
          height: iconSize,
          width: iconSize,
          fit: BoxFit.none,
        ),
      ),
    );
  }

  Widget _buildText(double textSize) {
    return Directionality(
      textDirection: widget.textDirection,
      child: Text(
        widget.name,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
