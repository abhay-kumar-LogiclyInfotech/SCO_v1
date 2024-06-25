import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class UserInfoContainer extends StatefulWidget {
  final String title;
  final String displayTitle;
  dynamic textDirection;

    UserInfoContainer({
    Key? key,
    required this.title,
    required this.displayTitle,
    required this.textDirection,
  }) : super(key: key);

  @override
  State<UserInfoContainer> createState() => _UserInfoContainerState();
}

class _UserInfoContainerState extends State<UserInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Directionality(
                          textDirection: widget.textDirection,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff8591A9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/edit.svg",
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Directionality(
                          textDirection: widget.textDirection,
                          child: Text(
                            widget.displayTitle,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
