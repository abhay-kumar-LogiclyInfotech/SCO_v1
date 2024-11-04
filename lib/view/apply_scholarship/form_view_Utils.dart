import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/custom_dropdown.dart';
import '../../resources/components/custom_text_field.dart';
import '../../utils/utils.dart';
import '../../viewModel/language_change_ViewModel.dart';


  // text field style which is used to styling hint and actual text
  final TextStyle _textFieldTextStyle = AppTextStyles.titleTextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.scoButtonColor);


  // to reduce the copy of code we created this where obscure text and border is not copied again and again, and if we need to use more features then we will use CustomTextField
   dynamic scholarshipFormTextField({
    required FocusNode currentFocusNode,
    FocusNode? nextFocusNode,
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    int? maxLines,
    int? maxLength,
    bool? filled,
    bool? readOnly,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormat,
    required Function(String? value) onChanged,
  }) {
    return CustomTextField(
      readOnly: readOnly,
      currentFocusNode: currentFocusNode,
      nextFocusNode: nextFocusNode,
      controller: controller,
      filled: filled,
      obscureText: false,
      border: Utils.outlinedInputBorder(),
      hintText: hintText,
      textStyle: _textFieldTextStyle,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormat: inputFormat,
      errorText: errorText,
      onChanged: onChanged,
      textInputType: textInputType ?? TextInputType.text,
    );
  }

  dynamic scholarshipFormDateField(
      {required FocusNode currentFocusNode,
        required TextEditingController controller,
        required String hintText,
        String? errorText,
        required Function(String? value) onChanged,
        required Function()? onTap,
        bool? filled}) {
    return CustomTextField(
      readOnly: true,
      filled: filled,
      // Prevent manual typing
      currentFocusNode: currentFocusNode,
      controller: controller,
      border: Utils.outlinedInputBorder(),
      hintText: hintText,
      textStyle: _textFieldTextStyle,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      trailing: const Icon(
        Icons.calendar_month,
        color: AppColors.scoLightThemeColor,
        size: 16,
      ),
      errorText: errorText,
      onChanged: onChanged,
      onTap: onTap,
    );
  }

  // dropdown for scholarship form
  dynamic scholarshipFormDropdown({
    bool? readOnly,
    required TextEditingController controller,
    required FocusNode currentFocusNode,
    required dynamic menuItemsList,
    required String hintText,
    String? errorText,
    bool? filled,
    required void Function(dynamic value) onChanged,
    required dynamic context,
  }) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    return CustomDropdown(
      readOnly: readOnly,
      value: controller.text.isEmpty ? null : controller.text,
      currentFocusNode: currentFocusNode,
      textDirection: getTextDirection(langProvider),
      menuItemsList: menuItemsList ?? [],
      hintText: hintText,
      textColor: AppColors.scoButtonColor,
      filled: filled,
      outlinedBorder: true,
      errorText: errorText,
      onChanged: onChanged,
    );
  }

  // title style which is used to styling Actual Section Heading
   dynamic sectionTitle({required String title}) {
    return Text(
      title,
      style: AppTextStyles.titleBoldTextStyle(),
    );
  }




