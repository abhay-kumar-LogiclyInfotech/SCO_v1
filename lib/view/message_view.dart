import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,

      appBar: AppBar(title: Text("Message view"),),

    );
  }
}
