// Places where you have syntax error then just do this
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/account_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_view.dart';
import 'package:sco_v1/view/main_view/academic_services_view.dart';
import 'package:sco_v1/view/main_view/accout_views/addresses_view.dart';
import 'package:sco_v1/view/main_view/home_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../resources/app_colors.dart';
import '../resources/components/custom_main_view_app_bar.dart';
import 'main_view/about_us_view.dart';
import 'main_view/sco_program_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool services = false;
  bool home = true;
  bool support = false;

  List<dynamic> screens = [
    const AcademicServicesView(),
    const HomeView(),
    const SupportView(),
  ];

  int currentIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider_1 =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Scaffold(
      key: scaffoldState,
      appBar: CustomTopAppBar(
        textDirection: getTextDirection(provider_1),
        onTap: () {
          provider_1.appLocale == const Locale('en')
              ? scaffoldState.currentState!.openDrawer()
              : scaffoldState.currentState!.openEndDrawer();
        },
      ),
      drawer: CustomDrawerView(
        textDirection: getTextDirection(provider_1),
        scaffoldState: scaffoldState,
      ),
      drawerEnableOpenDragGesture:
          provider_1.appLocale == const Locale('en') ? true : false,
      endDrawer: CustomDrawerView(
        textDirection: getTextDirection(provider_1),
        scaffoldState: scaffoldState,

      ),
      endDrawerEnableOpenDragGesture:
          provider_1.appLocale == const Locale('ar') ? true : false,
      body: _buildUI(),
      bottomNavigationBar: SafeArea(
        child: Material(
          color: Colors.white,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          services = true;
                          home = false;
                          support = false;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.sizeOf(context).width * .25,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: SvgPicture.asset(
                                  services
                                      ? "assets/services_selected.svg"
                                      : "assets/services.svg",
                                )),
                            Text(
                              // AppLocalizations.of(context)!.services,
                              "Services",
                              style: TextStyle(
                                  color: services
                                      ? Colors.black
                                      : const Color(0xfff9AA6B2),
                                  fontSize: 12,
                                  fontWeight: services
                                      ? FontWeight.w900
                                      : FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          services = false;
                          home = true;
                          support = false;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.sizeOf(context).width * .25,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: SvgPicture.asset(
                                  home
                                      ? "assets/home_selected.svg"
                                      : "assets/home.svg",
                                )),
                            Text(
                              AppLocalizations.of(context)!.home,
                              style: TextStyle(
                                  color: home
                                      ? Colors.black
                                      : const Color(0xfff9AA6B2),
                                  fontSize: 12,
                                  fontWeight: home
                                      ? FontWeight.w900
                                      : FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          services = false;
                          home = false;
                          support = true;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.sizeOf(context).width * .25,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: SvgPicture.asset(
                                  support
                                      ? "assets/support_selected.svg"
                                      : "assets/support.svg",
                                )),
                            Text(
                              // AppLocalizations.of(context)!.support,
                              "Support",
                              style: TextStyle(
                                  color: support
                                      ? Colors.black
                                      : const Color(0xfff9AA6B2),
                                  fontSize: 12,
                                  fontWeight:
                                  support ? FontWeight.w900 : FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    if (services) {
      return screens[0];
    }

    if (home) {
      return screens[1];
    }

    return screens[2];
  }
}
