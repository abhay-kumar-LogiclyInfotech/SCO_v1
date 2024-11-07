import 'package:dropdown_button2/dropdown_button2.dart';
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
  bool? filled;
  Color? textColor;
  String? errorText;
  bool? readOnly;
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
    this.filled,
    this.textColor,
    this.hintText,
    this.errorText,
    this.outlinedBorder = false,
    this.borderRadius,
    this.readOnly
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
      child: IgnorePointer(
        ignoring: widget.readOnly ?? false,
        child:

        // DropdownButtonFormField(
        DropdownButtonFormField2(

        isExpanded: true,
          // isDense: true,
          // dropdownColor: AppColors.scoButtonColor,

          // dropdownColor: Colors.white,

          items: widget.menuItemsList,
          value: widget.value,
          onChanged: widget.onChanged,
          focusNode: widget.currentFocusNode,
          decoration: InputDecoration(
            errorText:  widget.errorText,
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
                const TextStyle(color: AppColors.hintDarkGrey, fontSize: 14,fontWeight: FontWeight.w500),
            border: widget.outlinedBorder
                ? Utils.outlinedInputBorder()
                : Utils.underLinedInputBorder(),
            focusedBorder: widget.outlinedBorder
                ? Utils.outlinedInputBorder().copyWith(borderSide: const BorderSide(color: Colors.green))
                : Utils.underLinedInputBorder(),
            errorBorder: widget.outlinedBorder
                ? Utils.outlinedInputBorder().copyWith(borderSide: const BorderSide(color: Colors.red))
                : Utils.underLinedInputBorder(),
            enabledBorder: widget.outlinedBorder
                ? Utils.outlinedInputBorder()
                : Utils.underLinedInputBorder(),
            focusedErrorBorder: widget.outlinedBorder
                ? Utils.outlinedInputBorder()
                : Utils.underLinedInputBorder(),
            filled: widget.filled,
            fillColor: Colors.grey.shade200,
          ),

          // cursorColor: AppColors.darkGrey,
          style: TextStyle(
            color: widget.textColor ?? AppColors.hintDarkGrey,
          ),
          // padding: EdgeInsets.zero,
          hint: Text(
            widget.hintText ?? widget.menuItemsList[0].value.toString(),
            style: TextStyle(
              color: widget.textColor ?? AppColors.hintDarkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          iconStyleData: const IconStyleData(icon:  Icon(
            Icons.keyboard_arrow_down_sharp,
            color: AppColors.darkGrey,
          ),
          openMenuIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            color: AppColors.darkGrey,
          ),
          ),
          menuItemStyleData: const MenuItemStyleData(

            padding: EdgeInsets.symmetric(horizontal: 0)
          ),
          dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          // keyboardType: widget.textInputType ?? TextInputType.text,
        ),
      ),
    );
  }
}


