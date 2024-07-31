import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';

class EmploymentStatusView extends StatefulWidget {
  const EmploymentStatusView({super.key});

  @override
  State<EmploymentStatusView> createState() => _EmploymentStatusViewState();
}

class _EmploymentStatusViewState extends State<EmploymentStatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: Text("Employement Status View"),),
    );
  }
}
