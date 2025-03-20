import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:rename_app/constants.dart';
import 'package:sco_v1/utils/utils.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Widget> items;
  Function(int,CarouselPageChangedReason)? onPageChanged;
  final double height;
   CustomCarouselSlider({super.key,required this.items, this.onPageChanged,this.height = 100});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: widget.height,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          scrollDirection: Axis.horizontal,
          onPageChanged: widget.onPageChanged
        ),
        items: widget.items,
    );
  }
}
