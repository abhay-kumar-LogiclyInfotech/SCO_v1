
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';




class PinInputTheme{


  static PinTheme defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ])
  );



}