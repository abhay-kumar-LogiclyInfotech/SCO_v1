import 'package:flutter/material.dart';
import 'package:sco_v1/utils/utils.dart';

import '../app_colors.dart';

class CustomDropdown extends StatefulWidget {
  dynamic leading;

  // final List<String> genderList;
  final List<DropdownMenuItem> menuItemsList;

  // final List<dynamic> menuList;
  final void Function(dynamic value) onChanged;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;

  final TextDirection textDirection;
  Color? fillColor;
  Color? textColor;
  dynamic value;

  // InputBorder? border;
  BorderRadiusGeometry? borderRadius;
  String? hintText;
  bool outlinedBorder;

  CustomDropdown({
    super.key,
    this.leading,
    required this.textDirection,
    required this.menuItemsList, // required this.menuList,
    required this.onChanged,
    required this.currentFocusNode,
    this.value,
    this.nextFocusNode,
    this.fillColor,
    this.textColor,
    this.hintText,
    this.outlinedBorder = false,
    this.borderRadius,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with MediaQueryMixin<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: DropdownButtonFormField(
        isExpanded: true,
        // dropdownColor: AppColors.scoButtonColor,
        dropdownColor: Colors.white,
        items: widget.menuItemsList,
        value: widget.value,
        onChanged: widget.onChanged,
        focusNode: widget.currentFocusNode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.03,
              horizontal: widget.leading == null ? screenWidth * 0.03 : 0),
          prefixIcon: widget.leading,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 0,
          ),
          isDense: true,
          alignLabelWithHint: true,
          hintText: widget.hintText,
          hintFadeDuration: const Duration(milliseconds: 500),
          hintStyle:
              const TextStyle(color: AppColors.hintDarkGrey, fontSize: 14),
          border: widget.outlinedBorder
              ? outlinedInputBorder()
              : underLinedInputBorder(),
          focusedBorder: widget.outlinedBorder
              ? outlinedInputBorder()
              : underLinedInputBorder(),
          errorBorder: widget.outlinedBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.red))
              : const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.red)),
          enabledBorder: widget.outlinedBorder
              ? outlinedInputBorder()
              : underLinedInputBorder(),
          focusedErrorBorder: widget.outlinedBorder
              ? outlinedInputBorder()
                  .copyWith(borderSide: const BorderSide(color: Colors.green))
              : underLinedInputBorder(),
        ),

        // cursorColor: AppColors.darkGrey,
        style: TextStyle(
          color: widget.textColor ?? AppColors.hintDarkGrey,
        ),
        padding: EdgeInsets.zero,
        hint: Text(
          widget.hintText ?? widget.menuItemsList[0].value.toString(),
          style: TextStyle(
            color: widget.textColor ?? AppColors.hintDarkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppColors.darkGrey,
        ),

        // keyboardType: widget.textInputType ?? TextInputType.text,
      ),
    );
  }
}

InputBorder outlinedInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.darkGrey));
}

InputBorder underLinedInputBorder() {
  return const UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.darkGrey));
}
