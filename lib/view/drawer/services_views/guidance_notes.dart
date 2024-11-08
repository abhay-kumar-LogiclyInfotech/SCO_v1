import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';

class GuidanceNotesView extends StatefulWidget {
  const GuidanceNotesView({super.key});

  @override
  State<GuidanceNotesView> createState() => _GuidanceNotesViewState();
}

class _GuidanceNotesViewState extends State<GuidanceNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: Text("Guidance Notes"),),
    );
  }
}
