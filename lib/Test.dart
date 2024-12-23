import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Hello, World!',
          style: TextStyle(fontSize: 32.0),
        ),
        Text(
          'a',
          style: TextStyle(fontSize: 32.0),
        ),
        Text(
          '0',
          style: TextStyle(fontSize: 10.0),
        ),  Text(
          '`',
          style: TextStyle(fontSize: 32.0),
        ),
      ],
    ));
  }
}
