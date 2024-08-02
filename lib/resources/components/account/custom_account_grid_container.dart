import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_colors.dart';

class CustomAccountGridContainer extends StatefulWidget {
  final String assetAddress;
  final String title;
  final Function() onTap;
  const CustomAccountGridContainer(
      {super.key, required this.assetAddress, required this.title,required this.onTap});

  @override
  State<CustomAccountGridContainer> createState() =>
      _CustomAccountGridContainerState();
}

class _CustomAccountGridContainerState extends State<CustomAccountGridContainer>
    with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Material(
          elevation: .3,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            height: screenHeight * 0.16,
            width: screenWidth * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Assets Image:
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth * 0.2,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.scoThemeColor),
                  child: SvgPicture.asset(widget.assetAddress),
                ),
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
