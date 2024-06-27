import 'package:flutter/material.dart';
import 'package:sco_v1/utils/utils.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with MediaQueryMixin<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: screenHeight*0.5,
        width: screenWidth*0.8,
        padding: padding,
        color: Colors.amber,
      ),

    );
  }
}
