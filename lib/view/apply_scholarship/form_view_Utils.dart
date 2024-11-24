import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';
import '../../resources/components/custom_dropdown.dart';
import '../../resources/components/custom_text_field.dart';
import '../../resources/components/myDivider.dart';
import '../../utils/utils.dart';
import '../../viewModel/language_change_ViewModel.dart';






  // text field style which is used to styling hint and actual text
  final TextStyle textFieldTextStyle = AppTextStyles.titleTextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.scoButtonColor);


// dashed section divider is used to indicate the difference between the sections
dynamic sectionDivider() {
  return const Column(
    children: [
      SizedBox(height: 20),
       MyDivider(color: AppColors.scoButtonColor),
      SizedBox(height: 20),
    ],
  );
}

// Add Remove more section Button
dynamic addRemoveMoreSection(
    {required String title,
      required bool add,
      required Function() onChanged}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      MaterialButton(
        onPressed: onChanged,
        color: add ? AppColors.scoThemeColor : AppColors.DANGER,
        height: double.minPositive,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              add ? Icons.add_circle_outline : Icons.remove_circle_outline,
              size: 12,
              weight: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 3),
            ConstrainedBox(
              // constraints: BoxConstraints(maxWidth: screenWidth / 2),
              constraints: BoxConstraints(maxWidth: 100),
              // Set maximum width
              child: Text(
                title,
                style: AppTextStyles.subTitleTextStyle().copyWith(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                // Adds ellipsis when text overflows
                softWrap: false,
              ),
            )
          ],
        ),
      ),
    ],
  );
}


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
     InputBorder? border,
    required Function(String? value) onChanged,
  }) {
    return CustomTextField(
      readOnly: readOnly,
      currentFocusNode: currentFocusNode,
      nextFocusNode: nextFocusNode,
      controller: controller,
      filled: filled,
      obscureText: false,
      border: border ?? Utils.outlinedInputBorder(),
      hintText: hintText,
      textStyle: textFieldTextStyle,
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
      textStyle: textFieldTextStyle,
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

dynamic scholarshipFormTimeField(
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
    textStyle: textFieldTextStyle,
    textInputType: TextInputType.datetime,
    textCapitalization: true,
    trailing: const Icon(
      Icons.watch_later_rounded,
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




