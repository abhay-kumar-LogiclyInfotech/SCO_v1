
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getBulletText(text,{bool? squareBullet = false}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const  EdgeInsets.only(top: 6), // to align with text nicely
        child: Icon( squareBullet! ? Icons.square : Icons.circle, size: 8, color: Colors.black),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(text),
      ),
    ],
  );
}

