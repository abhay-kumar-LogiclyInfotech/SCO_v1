import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/account_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_view.dart';
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
  bool home = true;
  bool aboutUs = false;
  bool scoProgram = false;
  bool account = false;

  List<dynamic> screens = [
    const HomeView(),
    const AboutUsView(),
    const ScoProgramsView(),
    const AccountView()
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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          home = false;
                          aboutUs = false;
                          scoProgram = false;
                          account = true;
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
                                  account
                                      ? "assets/account_selected.svg"
                                      : "assets/account.svg",
                                )),
                            Text(
                              AppLocalizations.of(context)!.account,
                              style: TextStyle(
                                  color: account
                                      ? Colors.black
                                      : const Color(0xfff9AA6B2),
                                  fontSize: 12,
                                  fontWeight: account
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
                          home = false;
                          aboutUs = false;
                          scoProgram = true;
                          account = false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .25,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: SvgPicture.asset(
                                  scoProgram
                                      ? "assets/SCO_Program_selected.svg"
                                      : "assets/SCO_Program.svg",
                                )),
                            Text(
                              AppLocalizations.of(context)!.scoPrograms,
                              style: TextStyle(
                                  color: scoProgram
                                      ? Colors.black
                                      : const Color(0xfff9aa6b2),
                                  fontSize: 12,
                                  fontWeight: scoProgram
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
                          home = false;
                          aboutUs = true;
                          scoProgram = false;
                          account = false;
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
                                  aboutUs
                                      ? "assets/information_selected.svg"
                                      : "assets/information.svg",
                                )),
                            Text(
                              AppLocalizations.of(context)!.aboutUs,
                              style: TextStyle(
                                  color: aboutUs
                                      ? Colors.black
                                      : const Color(0xfff9AA6B2),
                                  fontSize: 12,
                                  fontWeight: aboutUs
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
                          home = true;
                          aboutUs = false;
                          scoProgram = false;
                          account = false;
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
                                  fontWeight:
                                      home ? FontWeight.w900 : FontWeight.w900),
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
    if (account) {
      return screens[3];
    }
    if (scoProgram) {
      return screens[2];
    }
    if (aboutUs) {
      return screens[1];
    }

    return screens[0];
  }
}
