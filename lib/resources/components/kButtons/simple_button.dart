

import 'package:flutter/material.dart';

import '../../app_colors.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const SimpleButton({super.key,required this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Text( title,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),),

    );
  }
}
