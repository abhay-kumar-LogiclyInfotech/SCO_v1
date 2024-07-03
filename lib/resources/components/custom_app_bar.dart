import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sco_v1/utils/utils.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final void Function() onTap;
  final TextDirection textDirection;

  const CustomTopAppBar(
      {Key? key,
      this.height = 50.0,
      required this.onTap,
      required this.textDirection})
      : super(key: key);

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomTopAppBarState extends State<CustomTopAppBar>
    with MediaQueryMixin<CustomTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: widget.textDirection,
        child: Container(
          color: Colors.transparent,
          height: widget.height,
          width: double.infinity,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                    width: 80,
                    child: Image.asset('assets/company_logo.jpg'),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                height: widget.height,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: SvgPicture.asset(
                        "assets/hamburger.svg", fit: BoxFit.contain,
                        // height: 20,
                        // width: 20,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/notification_bell.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/search.svg",
                            height: 20,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
