import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/view/drawer/accout_views/employment_status_view.dart';

class WorkStatusView extends StatefulWidget {
  const WorkStatusView({super.key});

  @override
  State<WorkStatusView> createState() => _WorkStatusViewState();
}

class _WorkStatusViewState extends State<WorkStatusView> {
  @override
  Widget build(BuildContext context) {
    return const EmploymentStatusView();
  }
}
