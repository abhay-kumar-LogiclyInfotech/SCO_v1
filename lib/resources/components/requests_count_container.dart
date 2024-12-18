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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
            constraints:  const BoxConstraints(minWidth: 25,minHeight: 25,maxHeight: 25),
            padding:  const EdgeInsets.only(left: 2,right: 2,top: 1,bottom: 1),
            decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(3)),
            alignment: Alignment.center,
            child:  Text(
            widget.count.toString().length < 25 ?  widget.count.toString() : "${widget.count.toString().substring(0,25)}..",
              style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
