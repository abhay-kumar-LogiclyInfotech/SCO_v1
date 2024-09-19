import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';import 'package:getwidget/getwidget.dart';


class CustomCheckBoxTile extends StatelessWidget {
  bool isChecked;
  String title;
  ListTileControlAffinity? controlAffinity;
  void Function(bool? value) onChanged;

  CustomCheckBoxTile({
    super.key,
    required this.isChecked,
    required this.title,
    required this.onChanged,
    this.controlAffinity,
  });

  WidgetStateProperty<Color?> _getFillColor() {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.green; // Color when the checkbox is selected
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.blue; // Color when the checkbox is hovered
      }
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey; // Color when the checkbox is disabled
      }
      return null; // Default color
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: controlAffinity ?? ListTileControlAffinity.leading,
        // contentPadding: EdgeInsets.zero,
        dense: false,
        fillColor: _getFillColor(),
        splashRadius: 10,
        tileColor: Colors.grey.shade300,
        title: Text(
          title.toString(),
          style: const TextStyle(color: AppColors.scoThemeColor),
        ),
        value: isChecked,
        onChanged: onChanged);
  }
}



class CustomGFCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  TextStyle? textStyle;
  GFCheckboxType? type;

  CustomGFCheckbox({
    required this.value,
    required this.onChanged,
    required this.text,
    this.textStyle,
    this.type,
  });

  @override
  _CustomGFCheckboxState createState() => _CustomGFCheckboxState();
}

class _CustomGFCheckboxState extends State<CustomGFCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle checkbox when text is tapped
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GFCheckbox(
            size: 20,
            type: widget.type ?? GFCheckboxType.custom,
            // activeBgColor: AppColors.WHITE,
            // inactiveBorderColor: AppColors.checkBoxBorderColor,
            // activeBorderColor: AppColors.checkBoxBorderColor,
            // activeIcon: Padding(
            //   padding: const EdgeInsets.all(2.0),
            //   child: Container(decoration: BoxDecoration(color: AppColors.SUCCESS,borderRadius: BorderRadius.circular(180)),),
            // ),
            onChanged: widget.onChanged,
            value: widget.value,
            inactiveIcon: null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(widget.text,style: widget.textStyle,),
          ),

        ],
      ),
    );
  }
}




class CustomRadioListTile extends StatefulWidget {
  final bool value; // Value for the individual radio button
  final bool? groupValue; // The current selected value for the group
  final ValueChanged<bool?> onChanged; // Callback for when the value changes
  final String title; // Title text for the list tile
  final TextStyle? textStyle; // Optional custom style for the text
  final EdgeInsets? padding; // Optional padding for the list tile

  CustomRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.textStyle,
    this.padding,
  });

  @override
  State<CustomRadioListTile> createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the onChanged callback with the new value when the list tile is tapped
        widget.onChanged(widget.value);
      },
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            GFRadio(
              size: 20,
              activeBorderColor: AppColors.checkBoxBorderColor,
              inactiveBorderColor: AppColors.checkBoxBorderColor,
              value: widget.value, // Individual radio button value
              groupValue: widget.groupValue, // The currently selected value
              onChanged: widget.onChanged, // Callback for when value changes
              type: GFRadioType.basic,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.title,
                style: widget.textStyle ?? const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


