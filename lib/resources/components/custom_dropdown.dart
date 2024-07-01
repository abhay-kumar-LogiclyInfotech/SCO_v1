import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sco_v1/utils/utils.dart';

import '../app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> gender;
  final void Function(String? value) onChanged;
  final FocusNode currentFocusNode;
  final TextDirection textDirection;

  String? hintText;

  CustomDropdown({
    super.key,
    required this.textDirection,
    required this.gender,
    required this.onChanged,
    required this.currentFocusNode,
    this.hintText,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with MediaQueryMixin<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return

      Directionality(
      textDirection: widget.textDirection,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset("assets/gender.svg"),
            ),
            Expanded(
                child: DropdownButtonFormField(
              dropdownColor: AppColors.scoButtonColor,
              items: widget.gender.map((String item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(
                    item.toString(),
                    style: const TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
              focusNode: widget.currentFocusNode,
              decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.white.withOpacity(1)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenWidth * 0.01),
                alignLabelWithHint: true,
                hintFadeDuration: const Duration(milliseconds: 500),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              // cursorColor: AppColors.darkGrey,
              style: const TextStyle(color: AppColors.darkGrey),
              padding: EdgeInsets.zero,
              hint: Text(
                widget.hintText ?? "Gender",
                style: const TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors.darkGrey,
              ),
              // keyboardType: widget.textInputType ?? TextInputType.text,
            )),
            // Container(child: widget.trailing)
          ],
        ),
      ),
    );

  }
}
