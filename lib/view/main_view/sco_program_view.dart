import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class ScoProgramsView extends StatefulWidget {
  const ScoProgramsView({super.key});

  @override
  State<ScoProgramsView> createState() => _ScoProgramsViewState();
}

class _ScoProgramsViewState extends State<ScoProgramsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,

      appBar: AppBar(title: Text("Message view"),),

    );
  }
}
