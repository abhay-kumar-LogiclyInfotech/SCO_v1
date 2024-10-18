import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/utils/utils.dart';
import '../../resources/app_colors.dart';

class StepsProgressView extends StatefulWidget {

  final int totalSections;
  final int currentSectionIndex;
  const StepsProgressView({super.key,required this.totalSections,required this.currentSectionIndex});

  @override
  State<StepsProgressView> createState() => _StepsProgressViewState();
}

class _StepsProgressViewState extends State<StepsProgressView> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        // shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.totalSections,
        itemBuilder: (context,index){
          return Row(
            children: [
              Container(
                  width: 72,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: index < widget.currentSectionIndex ? Colors.black : Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: index > widget.currentSectionIndex ? AppColors.lightGrey.withOpacity(0.01) :Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Step ${index+1}",style: const TextStyle(fontSize: 8),),
                      Container(
                        width: 20,
                        height: 20,
                        padding:  EdgeInsets.all( widget.currentSectionIndex == index ? 5 :0),
                        decoration: BoxDecoration(
                            border: Border.all(color: (widget.currentSectionIndex == index || index > widget.currentSectionIndex) ? Colors.grey : Colors.transparent ),
                            shape: BoxShape.circle
                        ),
                        child: widget.currentSectionIndex == index ? Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green
                          ),) : Container(
                          width: 10,
                          height: 10,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: index > widget.currentSectionIndex ? Colors.transparent : Colors.green
                          ), child: index > widget.currentSectionIndex ?    showVoid : const Center(child: Icon(Icons.done,color: Colors.white,size: 15,)),                          ) ,
                      ),
                    ],
                  )),
              // connection line
              if(index < widget.totalSections-1) Container(height: 1,color: Colors.grey,width: 37,)
            ],
          );
        },
      ),
    );
  }
}
