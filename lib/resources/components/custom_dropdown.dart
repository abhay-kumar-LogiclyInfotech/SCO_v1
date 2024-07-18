// import 'package:flutter/material.dart';
// import 'package:sco_v1/utils/utils.dart';
//
// import '../app_colors.dart';
//
// class CustomDropdown extends StatefulWidget {
//   final dynamic leading;
//
//   // final List<String> genderList;
//   final List<DropdownMenuItem> menuItemsList;
//
//   // final List<dynamic> menuList;
//   final void Function(dynamic value) onChanged;
//   final FocusNode currentFocusNode;
//   final TextDirection textDirection;
//   Color? fillColor;
//   Border? border;
//   BorderRadiusGeometry? borderRadius;
//   String? hintText;
//
//   CustomDropdown({
//     super.key,
//     required this.leading,
//     required this.textDirection,
//     required this.menuItemsList, // required this.menuList,
//     required this.onChanged,
//     required this.currentFocusNode,
//     this.fillColor,
//     this.hintText,
//     this.border,
//     this.borderRadius,
//   });
//
//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown>
//     with MediaQueryMixin<CustomDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: widget.textDirection,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//         decoration: BoxDecoration(
//           color: widget.fillColor ?? Colors.transparent,
//           border: widget.border ??
//               const Border(bottom: BorderSide(color: AppColors.darkGrey)),
//           borderRadius: widget.borderRadius,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(child: widget.leading),
//             Expanded(
//                 child: DropdownButtonFormField(
//               dropdownColor: AppColors.scoButtonColor,
//               items: widget.menuItemsList,
//
//               onChanged: widget.onChanged,
//               focusNode: widget.currentFocusNode,
//               decoration:
//
//               // InputDecoration(
//               //   errorStyle: TextStyle(color: Colors.white.withOpacity(1)),
//               //   contentPadding: EdgeInsets.symmetric(
//               //       horizontal: screenWidth * 0.02,
//               //       vertical: screenWidth * 0.01),
//               //   alignLabelWithHint: true,
//               //   hintFadeDuration: const Duration(milliseconds: 500),
//               //   border: InputBorder.none,
//               //   focusedBorder: InputBorder.none,
//               //   errorBorder: InputBorder.none,
//               //   enabledBorder: InputBorder.none,
//               //   focusedErrorBorder: InputBorder.none,
//               // ),
//               InputDecoration(
//                 // errorText: widget.errorText,
//                 contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
//                 prefixIcon: widget.leading,
//                 prefixIconConstraints: const BoxConstraints(
//                   minWidth: 30,
//                   minHeight: 0,
//                 ),
//                 // suffix: widget.icon,
//                 // suffixIcon: widget.trailing,
//                 // isCollapsed: true,
//                 isDense: true,
//                 alignLabelWithHint: true,
//                 hintText: widget.hintText,
//                 hintFadeDuration: const Duration(milliseconds: 500),
//                 hintStyle: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
//                 border: const UnderlineInputBorder(
//                     borderRadius: BorderRadius.zero,
//                     borderSide: BorderSide(color: AppColors.darkGrey)),
//                 focusedBorder: const UnderlineInputBorder(
//                     borderRadius: BorderRadius.zero,
//                     borderSide: BorderSide(color: AppColors.darkGrey)),
//                 errorBorder: const UnderlineInputBorder(
//                     borderRadius: BorderRadius.zero,
//                     borderSide: BorderSide(color: Colors.red)),
//                 enabledBorder: const UnderlineInputBorder(
//                     borderRadius: BorderRadius.zero,
//                     borderSide: BorderSide(color: AppColors.darkGrey)),
//                 focusedErrorBorder: const UnderlineInputBorder(
//                     borderRadius: BorderRadius.zero,
//                     borderSide: BorderSide(color: AppColors.darkGrey)),
//               ),
//
//               // cursorColor: AppColors.darkGrey,
//               style: const TextStyle(color: AppColors.darkGrey),
//               padding: EdgeInsets.zero,
//               hint: Text(
//                 widget.hintText ?? widget.menuItemsList[0].value.toString(),
//                 style: const TextStyle(
//                     color: AppColors.darkGrey,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500),
//               ),
//               icon: const Icon(
//                 Icons.keyboard_arrow_down_sharp,
//                 color: AppColors.darkGrey,
//               ),
//
//               // keyboardType: widget.textInputType ?? TextInputType.text,
//             )),
//             // Container(child: widget.trailing)
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  final TextDirection textDirection;
  Color? fillColor;
  InputBorder? border;
  BorderRadiusGeometry? borderRadius;
  String? hintText;

  CustomDropdown({
    super.key,
    this.leading,
    required this.textDirection,
    required this.menuItemsList, // required this.menuList,
    required this.onChanged,
    required this.currentFocusNode,
    this.fillColor,
    this.hintText,
    this.border,
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
        dropdownColor: AppColors.scoButtonColor,
        items: widget.menuItemsList,

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
          hintStyle: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
          border: widget.border ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.darkGrey)),
          focusedBorder: widget.border ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.darkGrey)),
          errorBorder: widget.border ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.red)),
          enabledBorder: widget.border ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.darkGrey)),
          focusedErrorBorder: widget.border ??
              const UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.darkGrey)),
        ),

        // cursorColor: AppColors.darkGrey,
        style: const TextStyle(color: AppColors.darkGrey),
        padding: EdgeInsets.zero,
        hint: Text(
          widget.hintText ?? widget.menuItemsList[0].value.toString(),
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
      ),
    );
  }
}
