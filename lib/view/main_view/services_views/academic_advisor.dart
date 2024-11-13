import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';

class AcademicAdvisorView extends StatefulWidget {
  const AcademicAdvisorView({super.key});

  @override
  State<AcademicAdvisorView> createState() => _AcademicAdvisorViewState();
}

class _AcademicAdvisorViewState extends State<AcademicAdvisorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: Text("Academic Advisor"),),
    );
  }
}
