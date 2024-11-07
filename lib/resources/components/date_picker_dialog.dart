import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




myDatePickerDialog(context)async{
 return await showDatePickerDialog(
    context: context,
    initialDate: DateTime.now(),
    minDate: DateTime(1950, 10, 10),
    maxDate: DateTime.now(),
    width: 300,
    height: 300,
    currentDate: DateTime.now(),
    selectedDate:   DateTime.now(),
    currentDateDecoration:  BoxDecoration(color: Colors.green,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(10)),
    currentDateTextStyle:  const TextStyle(color: Colors.green),
    daysOfTheWeekTextStyle: const TextStyle(),
    // disbaledCellsDecoration: const BoxDecoration(),
    disabledCellsTextStyle:  TextStyle(color: Colors.grey.shade400),
    enabledCellsDecoration: const BoxDecoration(),
    enabledCellsTextStyle: const TextStyle(),
    initialPickerType: PickerType.days,
    selectedCellDecoration: const BoxDecoration(),
    selectedCellTextStyle: const TextStyle(),
    leadingDateTextStyle: const TextStyle(),
    slidersColor: Colors.lightBlue,
    highlightColor: Colors.redAccent,
    slidersSize: 20,
    splashColor: Colors.lightBlueAccent,
    splashRadius: 40,
    centerLeadingDate: true,
  );
}