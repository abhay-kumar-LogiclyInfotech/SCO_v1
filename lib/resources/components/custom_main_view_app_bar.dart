import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final void Function() onTap;
  final TextDirection textDirection;

  const CustomTopAppBar(
      {Key? key,
      this.height = kToolbarHeight,
      required this.onTap,
      required this.textDirection})
      : super(key: key);

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}


// total notifications
int totalNotifications = 10;

class _CustomTopAppBarState extends State<CustomTopAppBar>
    with MediaQueryMixin<CustomTopAppBar> {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Material(
      color: Colors.white,
      elevation: 0.3,
      child: SafeArea(
        child: Directionality(
          textDirection: getTextDirection(langProvider) ,
          child: Container(
            color: Colors.white,
            height: widget.height,
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 80,
                      child: SvgPicture.asset('assets/sco_logo-cropped.svg'),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  height: widget.height,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: widget.onTap,
                        child: SvgPicture.asset(
                          "assets/hamburger.svg", fit: BoxFit.contain,
                          // height: 20,
                          // width: 20,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          //*------Notifications Bell Deprecated by Designer-----*/
                          GestureDetector(
                            onTap: () {},
                            child:

                            badges.Badge(badgeContent: Text(     totalNotifications > 9 ? '9+' : totalNotifications.toString()
                                ,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),),
                              position: badges.BadgePosition.bottomEnd(end: -8,bottom: -6),
                              badgeStyle: badges.BadgeStyle(badgeColor: AppColors.scoThemeColor,borderSide: BorderSide(color: AppColors.scoButtonColor)),
                              ignorePointer: true,
                              child: SvgPicture.asset(
                              "assets/notification_bell.svg",
                              height: 20,
                              width: 20,
                            ),

                            )
                            ,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/search.svg",
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
