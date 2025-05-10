import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/simple_tile_model.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../app_text_styles.dart';

class SimpleTile extends StatelessWidget {

  final SimpleTileModel? item;
  final double? leadingHeight ;
  final double? leadingWidth ;
  const SimpleTile({super.key,required this.item,
    this.leadingHeight = 40,
    this.leadingWidth = 40,
  });

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen:false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: ListTile(
        minTileHeight: 80,
        splashColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.only(left: 10,right: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(item?.title ?? '',style: AppTextStyles.titleBoldTextStyle(),),
        tileColor: Colors.white,
        leading: SvgPicture.asset(item?.assetAddress ?? '',height: leadingHeight,width: leadingWidth,),
        trailing:  Icon(
          getTextDirection(langProvider) == TextDirection.rtl ? Icons.keyboard_arrow_left_sharp : Icons.keyboard_arrow_right_sharp,
          color: Colors.grey,
          size: 28,
        ),
        onTap: item?.routeBuilder,
      ),
    );
  }
}
