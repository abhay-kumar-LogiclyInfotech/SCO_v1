import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final bool isLoading;
  Gradient? gradient;
  double? height;
  double? fontSize;
  double? elevation;
  Color? buttonColor;
  Color? borderColor;
  Color? textColor;
  BorderRadius? borderRadius;
  Color? loaderColor;
  dynamic leadingIcon;
  final TextDirection textDirection;
  final void Function() onTap;

  CustomButton(
      {super.key,
      required this.buttonName,
      required this.isLoading,
      this.gradient,
      this.height,
      this.fontSize,
      this.elevation,
      this.buttonColor,
      this.textColor,
      this.leadingIcon,
      this.borderColor,
        this.borderRadius,
        this.loaderColor,
      required this.textDirection,
      required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with MediaQueryMixin<CustomButton> {
  bool _isPressed = false;


  @override
  Widget build(BuildContext context) {
final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return GestureDetector(
      onTapDown: (_) {
        // When the user starts pressing the container
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        // When the user lifts the finger
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        // When the touch is cancelled (e.g. by dragging outside)
        setState(() {
          _isPressed = false;
        });
      },

      onTap: () {
       widget.isLoading ? (){} : widget.onTap();
      },
      child: Material(
        elevation: widget.elevation ?? 0,
        borderRadius: widget.borderRadius ??  BorderRadius.circular(180),
        child: Container(
            // height: widget.height ?? (orientation == Orientation.portrait ? screenHeight * 0.06 : screenHeight * 0.1),
            // width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
                color: _isPressed ? AppColors.lightGrey : widget.buttonColor ?? AppColors.scoThemeColor,
                // border: Border.all(color: widget.borderColor ?? Colors.black),
                border: Border.all(color: widget.borderColor ?? AppColors.scoThemeColor),
                gradient: widget.gradient,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(180)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: widget.leadingIcon,
                ),
                const SizedBox(width: 2),
                Directionality(
                  textDirection: widget.textDirection,
                  child: Center(
                      child: widget.isLoading
                          ?  SizedBox(
                              height: 23,
                              width: 23,
                              child: Utils.pageLoadingIndicator(context: context,color: widget.loaderColor ?? Colors.white)
                            )
                          : Text(
                              widget.buttonName,
                              style: TextStyle(
                                  color: widget.textColor ?? Colors.white,
                                  fontSize: widget.fontSize ?? 16,
                                  fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,

                            )),
                ),
              ],
            )),
      ),
    );
  }
}
