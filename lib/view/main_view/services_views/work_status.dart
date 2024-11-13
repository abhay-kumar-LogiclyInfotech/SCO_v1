import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';

class WorkStatusView extends StatefulWidget {
  const WorkStatusView({super.key});

  @override
  State<WorkStatusView> createState() => _WorkStatusViewState();
}

class _WorkStatusViewState extends State<WorkStatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: Text("Work Status"),),
    );
  }
}
