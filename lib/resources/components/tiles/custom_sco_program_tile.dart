import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../view/responsive.dart';
import '../../app_text_styles.dart';


class CustomScoProgramTile extends StatefulWidget {

  final String imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;

  const CustomScoProgramTile({super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap
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
        child: Material(
          elevation: 7,
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          shadowColor: Colors.black.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Expanded(flex:3,child: _imageSection()),
                // Expanded(flex:10,child: _titleSection()),
                // Expanded(flex:1,child: _endSection())
                _imageSection(),
                Expanded(child: _titleSection()),
                _endSection()
              ],
            ),
          ),
        ),
      ),
    )
    ;
  }

  Widget _imageSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            widget.imagePath,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            height: 76,
            width: 76,
            // width: screenWidth / 4,
            // height: screenHeight / 11,
            errorBuilder: (BuildContext context, Object, StackTrace) {
              return Image.asset(
                "assets/sidemenu/scholarships_uae.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                height: 76,
                width: 76,
                // width: screenWidth / 4,
                // height: screenHeight / 11,
              );
            },
          ),
        ),
        // green tick
        Container(
            height: 17,
            width: 19,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 1.0,
                left: 1,
              ),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(
                      "assets/sidemenu/correct.svg",
                      width: 7,
                      height: 5,
                      fit: BoxFit.fill,
                    ),
                  )),
            ))
      ],
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 20),
      child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            // widget.title.length < 30 ? widget.title : "${widget.title.substring(0, 30)}...",
            widget.title ?? '',
            // textAlign: TextAlign.left,
            style: AppTextStyles.titleBoldTextStyle(),
          ),
         if(widget.subTitle.isNotEmpty) Column(
            children: [
              const SizedBox(height: 5),
              Text(
                widget.subTitle.length < (screenWidth < 420 ? 25 : 25) ?
                widget.subTitle
                    : "${widget.subTitle.substring(0, ((screenWidth < 420 ? 25 : 25)))}...",
                // textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,fontSize: 12,height: 1.5
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _endSection() {
   final langProvider  = Provider.of<LanguageChangeViewModel>(context,listen: false);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Transform.rotate(angle: getTextDirection(langProvider) == TextDirection.rtl ? pi : 0,child: SvgPicture.asset(
          "assets/sidemenu/goForward.svg",
          width: 20,
          height: 20,
          fit: BoxFit.fill,
        ),),

      ],
    );
  }
}
