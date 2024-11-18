import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sco_v1/utils/utils.dart';

class RequestsCountContainer extends StatefulWidget {
  Color color;
  dynamic count;
   RequestsCountContainer({super.key,this.color = Colors.black,this.count = 0});

  @override
  State<RequestsCountContainer> createState() => _RequestsCountContainerState();
}

class _RequestsCountContainerState extends State<RequestsCountContainer> with MediaQueryMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:  const BoxConstraints(minWidth: 22,minHeight: 22,maxHeight: 22),
        padding: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(3)),
        alignment: Alignment.center,
        child:  Text(
        widget.count.toString().length < 25 ?  widget.count.toString() : "${widget.count.toString().substring(0,25)}..",
          style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
        ));
  }
}
