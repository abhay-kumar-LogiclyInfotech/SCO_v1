import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../app_text_styles.dart';

class CustomNewsAndEventsTile extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  String? date;
  final void Function() onTap;

  CustomNewsAndEventsTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      this.date,
      required this.onTap});

  @override
  State<CustomNewsAndEventsTile> createState() =>
      _CustomNewsAndEventsTileState();
}

class _CustomNewsAndEventsTileState extends State<CustomNewsAndEventsTile>
    with MediaQueryMixin<CustomNewsAndEventsTile> {


  @override
  void initState() {
    super.initState();
    //fetch Image Url:

  }


  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 4, child: _imageSection()),
                Expanded(flex: 10, child: _titleSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        widget.imagePath,
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
        // width: screenWidth / 4,
        // height: screenHeight / 11,
        errorBuilder: (BuildContext context, Object, StackTrace) {
          return Image.asset(
            "assets/sidemenu/scholarships_uae.jpg",
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            // width: screenWidth / 4,
            // height: screenHeight / 11,
          );
        },
      ),
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            widget.title.length < 63
                ? widget.title
                : "${widget.title.substring(0, 63)}..",
            style: AppTextStyles.titleTextStyle(),
          ),
          const SizedBox(height: 7,),
          Text(
            widget.subTitle.length < 30
                ? widget.subTitle
                : "${widget.subTitle.substring(0, 30)}...",
            style: AppTextStyles.subTitleTextStyle(),
          ),
          const SizedBox(height: 7,),
//Date
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/sidemenu/date_icon.svg"),
              const SizedBox(
                width: 4.5,
              ),
              Text(
                widget.date ?? "Date",
                // textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Color(0xff9A6F32),
                  fontSize: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
