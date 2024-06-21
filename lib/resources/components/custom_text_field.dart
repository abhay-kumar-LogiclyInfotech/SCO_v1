import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode currentFocusNode;
  FocusNode? nextFocusNode;
  bool? autofocus;
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final bool isNumber;
  bool? textCapitalization;
  Widget? icon;
  int? maxLines;
  bool? filled;
  bool? readOnly;
  TextInputType? textInputType;
  final void Function(String? value) onChanged;

  CustomTextField(
      {super.key,
        this.readOnly,
        required this.currentFocusNode,
        this.nextFocusNode,
        this.autofocus,
        required this.controller,
        required this.obscureText,
        required this.hintText,
        this.textCapitalization,
        required this.isNumber,
        this.icon,
        this.maxLines,
        this.filled,
        this.textInputType,
        required this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly ?? false,
      focusNode: widget.currentFocusNode,
      controller: widget.controller,
      autofocus: widget.autofocus ?? false,
      maxLines: widget.maxLines,
      textCapitalization: widget.textCapitalization == true
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white.withOpacity(1)),
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.width * 0.01),
        suffix: widget.icon,
        alignLabelWithHint: true,
        hintText: widget.hintText,
        hintFadeDuration: const Duration(milliseconds: 500),
        hintStyle:
        const TextStyle(color: AppColors.darkGrey, fontSize: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      cursorColor: AppColors.darkGrey,
      style: const TextStyle(color: AppColors.darkGrey),
      keyboardType: widget.textInputType ?? TextInputType.text,
      onSubmitted: (_) {
        widget.nextFocusNode != null
            ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
            : FocusScope.of(context).unfocus();
      },
    );
  }
}