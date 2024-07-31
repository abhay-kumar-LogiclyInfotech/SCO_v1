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
  final bool obscureText;
  final String hintText;
  bool? textCapitalization;
  Widget? icon;
  bool? filled;
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
      this.maxLines});

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
        onTap: widget.onTap,
        maxLines: widget.maxLines ?? 1,
        readOnly: widget.readOnly ?? false,
        focusNode: widget.currentFocusNode,
        controller: widget.controller,
        autofocus: widget.autofocus ?? false,
        obscureText: widget.obscureText,
        textCapitalization: widget.textCapitalization == true
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        decoration: InputDecoration(
          errorText: widget.errorText,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.03,
            horizontal: widget.leading == null ? screenWidth * 0.03 : 0,
          ),
          prefixIcon: (widget.maxLines != null && widget.maxLines! > 1)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 47),
                  child: widget.leading ?? Container())
              : widget.leading,

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
          hintStyle:
              const TextStyle(color: AppColors.hintDarkGrey, fontSize: 14),
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
        inputFormatters: widget.inputFormat,
        cursorColor: AppColors.hintDarkGrey,
        style: const TextStyle(color: AppColors.hintDarkGrey),
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sco_v1/resources/app_colors.dart';
// import 'package:sco_v1/utils/utils.dart';
//
// class CustomTextField extends StatefulWidget {
//   final FocusNode currentFocusNode;
//   FocusNode? nextFocusNode;
//   bool? autofocus;
//   final TextEditingController controller;
//   final bool obscureText;
//   final String hintText;
//   final bool isNumber;
//   bool? textCapitalization;
//   Widget? icon;
//   bool? filled;
//   bool? readOnly;
//   TextInputType? textInputType;
//   final TextDirection textDirection;
//   dynamic leading;
//   dynamic trailing;
//   final void Function(String? value) onChanged;
//   void Function()? onTap;
//   String? errorText;
//   List<TextInputFormatter>? inputFormat;
//
//   CustomTextField(
//       {super.key,
//       this.readOnly,
//       required this.currentFocusNode,
//       this.nextFocusNode,
//       this.autofocus,
//       required this.controller,
//       required this.obscureText,
//       required this.hintText,
//       this.textCapitalization,
//       required this.isNumber,
//       required this.textDirection,
//       this.icon,
//       this.filled,
//       this.textInputType,
//       this.leading,
//       this.trailing,
//       required this.onChanged,
//       this.onTap,
//       this.errorText,
//       this.inputFormat});
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField>
//     with MediaQueryMixin<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: widget.textDirection,
//       child: TextField(
//         onTap: widget.onTap,
//         readOnly: widget.readOnly ?? false,
//         focusNode: widget.currentFocusNode,
//         controller: widget.controller,
//         autofocus: widget.autofocus ?? false,
//         obscureText: widget.obscureText,
//         textCapitalization: widget.textCapitalization == true
//             ? TextCapitalization.sentences
//             : TextCapitalization.none,
//         decoration: InputDecoration(
//           errorText: widget.errorText,
//           contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
//           prefixIcon: widget.leading,
//           prefixIconConstraints: const BoxConstraints(
//             minWidth: 30,
//             minHeight: 0,
//           ),
//           suffix: widget.icon,
//           suffixIcon: widget.trailing,
//           isCollapsed: true,
//           alignLabelWithHint: true,
//           hintText: widget.hintText,
//           hintFadeDuration: const Duration(milliseconds: 500),
//           hintStyle: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
//           border: const UnderlineInputBorder(
//               borderRadius: BorderRadius.zero,
//               borderSide: BorderSide(color: AppColors.darkGrey)),
//           focusedBorder: const UnderlineInputBorder(
//               borderRadius: BorderRadius.zero,
//               borderSide: BorderSide(color: AppColors.darkGrey)),
//           errorBorder: const UnderlineInputBorder(
//               borderRadius: BorderRadius.zero,
//               borderSide: BorderSide(color: Colors.red)),
//           enabledBorder: const UnderlineInputBorder(
//               borderRadius: BorderRadius.zero,
//               borderSide: BorderSide(color: AppColors.darkGrey)),
//           focusedErrorBorder: const UnderlineInputBorder(
//               borderRadius: BorderRadius.zero,
//               borderSide: BorderSide(color: AppColors.darkGrey)),
//         ),
//         inputFormatters: widget.inputFormat,
//         cursorColor: AppColors.darkGrey,
//         style: const TextStyle(color: AppColors.darkGrey),
//         keyboardType: widget.textInputType ?? TextInputType.text,
//         onSubmitted: (value) {
//           widget.controller.text = value;
//           widget.nextFocusNode != null
//               ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
//               : FocusScope.of(context).unfocus();
//         },
//       ),
//     );
//
//   }
// }

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sco_v1/resources/app_colors.dart';
// import 'package:sco_v1/utils/utils.dart';
//
// class CustomTextField extends StatefulWidget {
//   final FocusNode currentFocusNode;
//   FocusNode? nextFocusNode;
//   bool? autofocus;
//   final TextEditingController controller;
//   final bool obscureText;
//   final String hintText;
//   final bool isNumber;
//   bool? textCapitalization;
//   Widget? icon;
//   bool? filled;
//   bool? readOnly;
//   TextInputType? textInputType;
//   final TextDirection textDirection;
//   dynamic leading;
//   dynamic trailing;
//   final void Function(String? value) onChanged;
//   void Function()? onTap;
//   String? errorText;
//   List<TextInputFormatter>? inputFormat;
//
//
//   CustomTextField(
//       {super.key,
//         this.readOnly,
//         required this.currentFocusNode,
//         this.nextFocusNode,
//         this.autofocus,
//         required this.controller,
//         required this.obscureText,
//         required this.hintText,
//         this.textCapitalization,
//         required this.isNumber,
//         required this.textDirection,
//         this.icon,
//         this.filled,
//         this.textInputType,
//         this.leading,
//         this.trailing,
//         required this.onChanged,
//         this.onTap,
//         this.errorText,
//         this.inputFormat});
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField>
//     with MediaQueryMixin<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: widget.textDirection,
//       child: Container(
//         // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
//         // decoration: const BoxDecoration(
//         //   border: Border(bottom: BorderSide(color: Colors.grey)),
//         // ),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Container(
//             //   child: widget.leading,
//             // ),
//             Expanded(
//                 child: TextField(
//                   onTap: widget.onTap,
//                   readOnly: widget.readOnly ?? false,
//                   focusNode: widget.currentFocusNode,
//                   controller: widget.controller,
//                   autofocus: widget.autofocus ?? false,
//                   obscureText: widget.obscureText,
//                   textCapitalization: widget.textCapitalization == true
//                       ? TextCapitalization.sentences
//                       : TextCapitalization.none,
//                   decoration: InputDecoration(
//                     // contentPadding: EdgeInsets.symmetric(
//                     //     horizontal: screenWidth * 0.02,
//                     //     vertical: screenWidth * 0.01),
//                     prefixIcon: Icon(Icons.account_circle_outlined),
//                     contentPadding: EdgeInsets.symmetric(vertical: 15.0),
//                     suffix: widget.icon,
//                     suffixIcon: widget.trailing,
//                     isCollapsed: true,
//                     alignLabelWithHint: true,
//                     hintText: widget.hintText,
//                     hintFadeDuration: const Duration(milliseconds: 500),
//                     hintStyle:
//                     const TextStyle(color: AppColors.darkGrey, fontSize: 14),
//                     // border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                         borderRadius: BorderRadius.zero,
//                         borderSide: BorderSide(color: Colors.green)
//                     ),
//                     // errorBorder: InputBorder.none,
//                     // enabledBorder: InputBorder.none,
//                     // focusedErrorBorder: InputBorder.none,
//                   ),
//                   inputFormatters: widget.inputFormat,
//                   cursorColor: AppColors.darkGrey,
//                   style: const TextStyle(color: AppColors.darkGrey),
//                   keyboardType: widget.textInputType ?? TextInputType.text,
//                   onSubmitted: (_) {
//                     widget.nextFocusNode != null
//                         ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
//                         : FocusScope.of(context).unfocus();
//                   },
//                 )),
//             // Container(child: widget.trailing)
//           ],
//         ),
//       ),
//     );
//
//     ;
//   }
// }
