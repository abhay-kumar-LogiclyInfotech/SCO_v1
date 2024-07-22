import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';

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
