import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../view/apply_scholarship/form_view_Utils.dart';
import '../app_colors.dart';import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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


  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: IgnorePointer(
        ignoring: widget.readOnly ?? false,
        child:

        // DropdownButtonFormField(
        DropdownButtonFormField2(
           isExpanded: true,
          enableFeedback: true,
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
            weight: 10000,

          ),
          openMenuIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            color: AppColors.darkGrey,
            weight: 10000,
          ),
            iconSize: 25

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
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: scholarshipFormTextField(
                controller: textEditingController, currentFocusNode: FocusNode(), hintText: localization.searchHere, onChanged: (String? value) {  },
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.child.toString().toLowerCase().contains(searchValue.toLowerCase());
            },
          ),

        ),
      ),
    );
  }
}


