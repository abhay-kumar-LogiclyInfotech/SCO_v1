import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode currentFocusNode;
  FocusNode? nextFocusNode;
  bool? autofocus;
  final TextEditingController controller;
  bool? obscureText;
  final String hintText;
  bool? textCapitalization;
  Widget? icon;
  bool? filled;
  Color? fillColor;
  bool? readOnly;
  TextInputType? textInputType;
  dynamic leading;
  dynamic trailing;
  final void Function(String? value) onChanged;
  void Function()? onTap;
  String? errorText;
  List<TextInputFormatter>? inputFormat;
  InputBorder? border;
  int? maxLines;
  int? maxLength;
  bool? enabled;
  dynamic validator;
  TextStyle? textStyle;

  CustomTextField({
    super.key,
    this.readOnly,
    required this.currentFocusNode,
    this.nextFocusNode,
    this.autofocus,
    required this.controller,
    this.obscureText,
    this.fillColor,
    required this.hintText,
    this.textCapitalization,
    this.icon,
    this.filled,
    this.textInputType,
    this.leading,
    this.trailing,
    required this.onChanged,
    this.onTap,
    this.errorText,
    this.inputFormat,
    this.border,
    this.maxLines,
    this.maxLength,
    this.textStyle,
    this.enabled,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with MediaQueryMixin<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: TextField(
        enabled: widget.enabled,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines ?? 1,
        readOnly: widget.readOnly ?? false,
        focusNode: widget.currentFocusNode,
        controller: widget.controller,
        autofocus: widget.autofocus ?? false,
        obscureText: widget.obscureText ?? false,
        textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
        textCapitalization: widget.textCapitalization == true
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        decoration: InputDecoration(
          errorText: widget.errorText,
          errorMaxLines: 5,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.03,
            horizontal: widget.leading == null ? screenWidth * 0.03 : 0,
          ),
          prefixIcon: widget.leading,
          // Adjust padding as needed)
          // (widget.maxLines != null && widget.maxLines! > 1)
          //     ? Padding(
          //         padding: const EdgeInsets.only(bottom: 47),
          //         child: widget.leading ?? Container())
          //     :

          // add a default widget if leading is null
          prefixIconConstraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 0,
          ),
          suffix: widget.icon,
          suffixIcon: widget.trailing,
          // isCollapsed: true,
          isDense: true,
          alignLabelWithHint: true,
          hintText: widget.hintText,
          hintFadeDuration: const Duration(milliseconds: 500),
          // hintStyle: widget.textStyle ?? const TextStyle(color: AppColors.hintDarkGrey, fontSize: 14),
          hintStyle: const TextStyle(color: AppColors.hintDarkGrey, fontSize: 14,fontWeight: FontWeight.normal),
          border: widget.border ?? Utils.underLinedInputBorder(),
          focusedBorder: widget.border?.copyWith(
                  borderSide: const BorderSide(color: Colors.green)) ??
              Utils.underLinedInputBorder(),
          errorBorder: widget.border
                  ?.copyWith(borderSide: const BorderSide(color: Colors.red)) ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.red)),
          enabledBorder: widget.border ?? Utils.underLinedInputBorder(),

          focusedErrorBorder: widget.border
                  ?.copyWith(borderSide: const BorderSide(color: Colors.red)) ??
              Utils.underLinedInputBorder(),
          filled: widget.filled,
          fillColor: widget.fillColor ?? Colors.grey.shade200,
        ),
        inputFormatters: widget.inputFormat,
        cursorColor: AppColors.hintDarkGrey,
        style: widget.textStyle ?? const TextStyle(color: AppColors.hintDarkGrey),
        keyboardType: widget.textInputType ?? TextInputType.text,
        onSubmitted: (_) {
          widget.nextFocusNode != null
              ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
              : FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          widget.onChanged(value.trim());
        },
      ),
    );
  }
}
