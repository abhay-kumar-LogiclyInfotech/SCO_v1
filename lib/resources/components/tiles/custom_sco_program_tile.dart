import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_text_styles.dart';


class CustomScoProgramTile extends StatefulWidget {

  final String? imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;
  final double imageSize;
  final Widget? trailing;
  final int maxLines;


  const CustomScoProgramTile({super.key,
     this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.imageSize = 76,
    this.trailing,
    this.maxLines = 2
  });

  @override
  State<CustomScoProgramTile> createState() => _CustomScoProgramTileState();
}

class _CustomScoProgramTileState extends State<CustomScoProgramTile> with MediaQueryMixin<CustomScoProgramTile> {
  @override
  Widget build(BuildContext context) {

    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen:false);

    return   Directionality(
      textDirection: getTextDirection(langProvider),
      child: GestureDetector(
        onTap: widget.onTap,
        child:

        Material(
          elevation: 0.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),
          child: ListTile(
            tileColor: Colors.white,
            contentPadding: EdgeInsets.all(kTilePadding),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),
            leading: _imageSection(),
            title: _titleSection(),
            trailing: _endSection(),
          ),
        ),


        // Material(
        //   elevation: 7,
        //   borderRadius: BorderRadius.circular(10),
        //   color: Colors.transparent,
        //   shadowColor: Colors.black.withOpacity(0.2),
        //   child: Container(
        //     padding: const EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         // Expanded(flex:3,child: _imageSection()),
        //         // Expanded(flex:10,child: _titleSection()),
        //         // Expanded(flex:1,child: _endSection())
        //         _imageSection(),
        //         Expanded(child: _titleSection()),
        //         _endSection()
        //       ],
        //     ),
        //   ),
        // ),
      ),
    )
    ;
  }

  Widget _imageSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [

        if(widget.imagePath != null)
        Image.asset(
          widget.imagePath ?? '',
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
          height: widget.imageSize,
          width: widget.imageSize,
          // width: screenWidth / 4,
          // height: screenHeight / 11,
          errorBuilder: (BuildContext context, Object, StackTrace) {
            return Image.asset(
              "assets/sidemenu/scholarships_uae.jpg",
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              height: widget.imageSize,
              width: widget.imageSize,
              // width: screenWidth / 4,
              // height: screenHeight / 11,
            );
          },
        ),
        // green tick
        // Container(
        //     height: 17,
        //     width: 19,
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(5),
        //           bottomRight: Radius.circular(10)),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.only(
        //         top: 1.0,
        //         left: 1,
        //       ),
        //       child: Container(
        //           decoration: const BoxDecoration(
        //             color: Colors.green,
        //             borderRadius: BorderRadius.only(
        //                 bottomRight: Radius.circular(10),
        //                 topLeft: Radius.circular(5)),
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(2.0),
        //             child: SvgPicture.asset(
        //               "assets/sidemenu/correct.svg",
        //               width: 7,
        //               height: 5,
        //               fit: BoxFit.fill,
        //             ),
        //           )),
        //     ))
      ],
    );
  }

  Widget _titleSection() {
    return Padding(
      // padding: const EdgeInsets.only(left: 10,right: 20),
      padding: EdgeInsets.zero,
      child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            widget.title ?? '',
            style: AppTextStyles.titleBoldTextStyle(),
          ),
         if(widget.subTitle.isNotEmpty) Column(
            children: [
              kMinorSpace,
              Text(
                widget.subTitle,
                style: AppTextStyles.subTitleTextStyle().copyWith(color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: widget.maxLines,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _endSection() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

       widget.trailing ??   Icon(
         getTextDirection(context.read<LanguageChangeViewModel>()) == TextDirection.rtl
             ? Icons.keyboard_arrow_left_outlined
             : Icons.keyboard_arrow_right_outlined,
         color: Colors.grey,
       ),

      ],
    );
  }
}
