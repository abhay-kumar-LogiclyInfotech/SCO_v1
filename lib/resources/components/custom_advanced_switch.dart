import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CustomAdvancedSwitch extends StatelessWidget {

  final ValueNotifier<bool> controller;
  final Color activeColor;
  final Color inactiveColor;
  final bool initialValue;
  final void Function(dynamic) onChanged;
  CustomAdvancedSwitch({super.key,required this.controller,required this.activeColor,required this.inactiveColor,required this.initialValue,required this.onChanged});



  @override
  Widget build(BuildContext context) {
    return                 AdvancedSwitch(
        // controller: controller,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        borderRadius: BorderRadius.circular(200),
        disabledOpacity: 0.5,
        width: 35.0,
        height: 20.0,
        initialValue: initialValue,
        onChanged: onChanged);
    ;
  }
}
