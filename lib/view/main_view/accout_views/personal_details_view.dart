import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';

class PersonalDetailsView extends StatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomSimpleAppBar(title: Text("Personal Details"),),
    );
  }
}
