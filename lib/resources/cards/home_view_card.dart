import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../viewModel/language_change_ViewModel.dart';
import '../app_text_styles.dart';

class HomeViewCard extends StatefulWidget {

  final String title;
  final Widget? icon;
  final Widget content;
  final Widget? headerExtraContent;
  final LanguageChangeViewModel langProvider;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;

   const HomeViewCard({super.key
  ,
    required  this.title,
    this.icon,
    required this.content,
    this.headerExtraContent,
    required this.langProvider,
    this.onTap, this.contentPadding,

  });

  @override
  State<HomeViewCard> createState() => _HomeViewCardState();
}

class _HomeViewCardState extends State<HomeViewCard> with MediaQueryMixin{
  @override
  Widget build(BuildContext context) {

    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        elevation: 0.5,
        color: Colors.white,
        shadowColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(kCardRadius),
        child: Directionality(
          textDirection: getTextDirection(langProvider),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: kCardPadding,
                    left: kCardPadding,
                    right: kCardPadding,
                    bottom: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              widget.icon ?? showVoid,
                              if (widget.icon != null) const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: AppTextStyles.titleBoldTextStyle()
                                      .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 5),
                              widget.headerExtraContent ?? showVoid,
                            ],
                          )),
                      Icon(
                        getTextDirection(langProvider) == TextDirection.rtl
                            ? Icons.keyboard_arrow_left_outlined
                            : Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                // kFormHeight,
                Padding(
                  padding: widget.contentPadding ??
                      EdgeInsets.only(
                        bottom: kCardPadding,
                        left: kCardPadding,
                        right: kCardPadding,
                      ),
                  child: widget.content,
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
