import 'package:flutter/material.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Information view"),),

    );
  }
}
