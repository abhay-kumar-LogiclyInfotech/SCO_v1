import 'package:flutter/material.dart';

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
        required this.textDirection,
      required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Material(
        elevation: widget.elevation ?? 0,
        borderRadius: BorderRadius.circular(180),
        child: Container(
          height: widget.height ?? MediaQuery.of(context).size.height * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
              color: widget.buttonColor ?? Colors.black,
              border: Border.all(color: widget.borderColor ?? Colors.black),
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(180)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: widget.leadingIcon,
              ),
             const SizedBox(width: 2,),
              Directionality(
                textDirection: widget.textDirection,
                child: Center(
                    child: widget.isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    )
                        : Text(
                      widget.buttonName,
                      style: TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontSize: widget.fontSize ?? 22,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          )


        ),
      ),
    );
  }
}
