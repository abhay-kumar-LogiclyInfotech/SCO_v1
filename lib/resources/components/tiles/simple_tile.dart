import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/simple_tile_model.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_text_styles.dart';

class SimpleTile extends StatefulWidget {

  final SimpleTileModel? item;
  final double? leadingHeight ;
  final double? leadingWidth ;
  const SimpleTile({super.key,required this.item,
    this.leadingHeight = 40,
    this.leadingWidth = 40,
  });

  @override
  State<SimpleTile> createState() => _SimpleTileState();
}

class _SimpleTileState extends State<SimpleTile> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen:false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: ListTile(
        // minTileHeight: 10,
        splashColor: Colors.grey.shade200,
        contentPadding:  EdgeInsets.all(kTilePadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCardRadius)),
        title: Text(widget.item?.title ?? '',style: AppTextStyles.titleBoldTextStyle(),),
        tileColor: Colors.white,
        leading: SvgPicture.asset(widget.item?.assetAddress ?? '',height: widget.leadingHeight,width: widget.leadingWidth,),
        trailing:  Icon(
          getTextDirection(langProvider) == TextDirection.rtl ? Icons.keyboard_arrow_left_sharp : Icons.keyboard_arrow_right_sharp,
          color: Colors.grey,
          size: 28,
        ),
        onTap: widget.item?.routeBuilder,
      ),
    );
  }
}
