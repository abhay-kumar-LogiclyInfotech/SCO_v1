import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sco_v1/view/main_view/notifications/notifications_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../data/response/status.dart';

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

class _CustomTopAppBarState extends State<CustomTopAppBar>
    with MediaQueryMixin<CustomTopAppBar> {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  bool isLoggedIn = false;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      isLoggedIn = await _authService.isLoggedIn();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Material(
      color: Colors.white,
      elevation: 0.3,
      child: SafeArea(
        child: Directionality(
          textDirection: getTextDirection(langProvider),
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
                      if (isLoggedIn)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //*------Notifications Bell Deprecated by Designer-----*/

                            Consumer<GetNotificationsCountViewModel>(
                              builder: (context, provider, _) {
                                switch (provider.apiResponse.status) {
                                  case Status.LOADING:
                                    return ringBell(totalNotifications,
                                        _navigationServices);
                                  case Status.ERROR:
                                    return ringBell(totalNotifications,
                                        _navigationServices);
                                  case Status.COMPLETED:
                                    return ringBell(
                                        provider.apiResponse.data.toString(),
                                        _navigationServices);
                                  case Status.NONE:
                                    return ringBell(totalNotifications,
                                        _navigationServices);
                                  case null:
                                    return ringBell(totalNotifications,
                                        _navigationServices);
                                }
                              },
                            ),

                            // const SizedBox(
                            //   width: 30,
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: SvgPicture.asset(
                            //     "assets/search.svg",
                            //     height: 20,
                            //     width: 20,
                            //   ),
                            // )
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

// total notifications
int totalNotifications = 0;

Widget ringBell(count, NavigationServices navigationServices) {
  totalNotifications = int.tryParse(count.toString()) ?? 0;
  return GestureDetector(
    onTap: () {
      navigationServices.pushCupertino(
          CupertinoPageRoute(builder: (context) => const NotificationsView()));
    },
    child: badges.Badge(
      badgeContent: Text(
        totalNotifications > 9 ? '9+' : totalNotifications.toString(),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
      ),
      position: badges.BadgePosition.bottomEnd(end: -8, bottom: -6),
      badgeStyle: const badges.BadgeStyle(
          badgeColor: AppColors.scoThemeColor,
          // border of badge
          // borderSide: BorderSide(color: AppColors.scoButtonColor)
      ),
      ignorePointer: true,
      child: SvgPicture.asset(
        "assets/notification_bell.svg",
        height: 20,
        width: 20,
      ),
    ),
  );
}
