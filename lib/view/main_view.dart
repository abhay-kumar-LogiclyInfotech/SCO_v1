// Places where you have syntax error then just do this
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/login/login_view.dart';
import 'package:sco_v1/view/main_view/services_view.dart';
import 'package:sco_v1/view/main_view/home_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../resources/app_colors.dart';
import '../resources/components/custom_main_view_app_bar.dart';
import '../viewModel/services/auth_services.dart';
import '../viewModel/services/navigation_services.dart';
import 'drawer/drawer_view.dart';
import 'main_view/support _view.dart';

class MainView extends StatefulWidget {

  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool services = false;
  bool home = true;
  bool support = false;

  List<Widget> screens = [
    const ServicesView(),
    const HomeView(),
    const SupportView(),
  ];

  int currentIndex = 1;

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();



  late AuthService _authService;
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;
  bool _isLoggedIn = false;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback)async{
      /// On the very first check that user is logged in or not. If not then move to the login view directly.
      final isLoggedIn = await _authService.isLoggedIn();
        setState(() {
          _isLoggedIn = isLoggedIn;
        });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      key: scaffoldState,
      appBar: CustomTopAppBar(
        textDirection: getTextDirection(langProvider),
        onTap: () {
          langProvider.appLocale == const Locale('en')
              ? scaffoldState.currentState!.openDrawer()
              : scaffoldState.currentState!.openEndDrawer();
        },
      ),
      drawer: DrawerView(
        textDirection: getTextDirection(langProvider),
        scaffoldState: scaffoldState,
      ),
      drawerEnableOpenDragGesture: langProvider.appLocale == const Locale('en') ? true : false,
      endDrawer: DrawerView(textDirection: getTextDirection(langProvider), scaffoldState: scaffoldState),
      endDrawerEnableOpenDragGesture: langProvider.appLocale == const Locale('ar') ? true : false,
      body:  IndexedStack(index: currentIndex,children: screens) ,
      bottomNavigationBar: Directionality(
          textDirection: getTextDirection(langProvider),
          child: BottomNavigationBar(
            selectedItemColor: AppColors.scoThemeColor,
            backgroundColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (index) {
          
              if(index == 0){
                if(_isLoggedIn){
                  setState(() {
                    currentIndex = index;
                  });
                }else{
                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const LoginView()));
                  // _alertServices.showCustomSnackBar("Please Login to use services",
                  //   // context,
                  // );
                }
              }
              else{
                setState(() {
                  currentIndex = index;
                });
              }
          
              },
              items: [
        BottomNavigationBarItem(icon:  SvgPicture.asset("assets/services.svg"),activeIcon:SvgPicture.asset("assets/services_selected.svg"),label: localization.service),
          
          BottomNavigationBarItem(icon:  SvgPicture.asset("assets/home.svg"),activeIcon:SvgPicture.asset("assets/home_selected.svg"),label: localization.home),
          
     BottomNavigationBarItem(icon:  SvgPicture.asset("assets/support.svg"),activeIcon:SvgPicture.asset("assets/support_selected.svg"),label: localization.support),
          ]),
        ),
    );
  }
}
