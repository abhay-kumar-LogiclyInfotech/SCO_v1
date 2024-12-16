import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/change_language_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/aBriefAboutSco_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/sco_programs.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/vision_and_mission_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/account_view.dart';
import 'package:sco_v1/view/main_view.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../resources/app_colors.dart';
import '../../resources/components/account/profile_with_camera_button.dart';
import '../../resources/components/custom_advanced_switch.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../../viewModel/services/auth_services.dart';
import '../../viewModel/services/navigation_services.dart';
import '../authentication/login/login_view.dart';
import 'custom_drawer_views/contact_us_view.dart';
import 'custom_drawer_views/faq_view.dart';
import 'custom_drawer_views/news_and_events_view.dart';
import '../main_view/services_view.dart';

class CustomDrawerView extends StatefulWidget {
  final TextDirection? textDirection;
  dynamic scaffoldState;

  CustomDrawerView({
    super.key,
    this.textDirection,
    this.scaffoldState,
  });

  @override
  State<CustomDrawerView> createState() => _CustomDrawerViewState();
}

class _CustomDrawerViewState extends State<CustomDrawerView> {
  String _name = "User Name";
  List<String> _roles = ["User Type"];

  late NavigationServices _navigationServices;
  late AuthService _authService;
  late AlertServices _alertServices;

  bool _isArabic = false;
  bool _isLoading = true; // State to track loading
  bool _toLogin = false;

  final _languageController = ValueNotifier<bool>(false);

  Future<void> getInitialLanguage() async {
    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // final String? language = preferences.getString('language_code');
    //
    // if (language != null && language == 'ar') {
    //   _isArabic = true;
    //   _languageController.value = true;
    // } else {
    //   _isArabic = false;
    //   _languageController.value = false;
    // }

    // check user is logged in or not
    _toLogin = await _authService.isLoggedIn();

    setState(() {
      _isLoading = false; // Set loading to false after initialization
    });
  }

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadAppVersion();

      // getting initial language
      await getInitialLanguage();

      /// Getting profile picture and  name and userTypes
      if (_toLogin) {
        // SETTING USERNAME AND ROLES
        _name = HiveManager.getName() ?? 'User Name';
        _roles = HiveManager.getRole() ?? [];

        // Getting Fresh Roles
        final getRolesProvider =
            Provider.of<GetRoleViewModel>(context, listen: false);
        await getRolesProvider.getRoles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;

    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: AppColors.scoButtonColor,
      // shadowColor: const Color(0xffffffff),
      elevation: 1,
      width: MediaQuery.sizeOf(context).width * 0.75,

      child: SafeArea(
        bottom: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Upper section
                    Expanded(
                      child: Directionality(
                        textDirection: getTextDirection(langProvider),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            //*------User Profile Section------*/
                            if (_toLogin)
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Consumer<GetProfilePictureUrlViewModel>(
                                        builder: (context, provider, _) {
                                          return ProfileWithCameraButton(
                                              profileSize: 55,
                                              cameraEnabled: false,
                                              profileImage: provider.apiResponse
                                                          .data?.url !=
                                                      null
                                                  ? NetworkImage(provider
                                                      .apiResponse.data!.url!
                                                      .toString())
                                                  : const AssetImage(
                                                      'assets/personal_details/dummy_profile_pic.png'),
                                              onTap: () {},
                                              onLongPress: () {});
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: SizedBox(
                                          // color: Colors.green,
                                          height: 55,
                                          // width: MediaQuery.sizeOf(context).width * 0.5,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 5),
                                                SelectableText(
                                                  // _roles.where((role){
                                                  //  return role.isNotEmpty;
                                                  // }).join(', ')
                                                  _roles.any((role) =>
                                                          role.toLowerCase() ==
                                                          'students')
                                                      ? "Student"
                                                      : "User Type",

                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.65)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),

                            //*------Menu Items Section------*/
                            //*------Login------*/
                            if (!_toLogin)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  localization.login,
                                  style: AppTextStyles.drawerButtonsStyle(),
                                ),
                                leading: SvgPicture.asset(
                                    "assets/sidemenu/login.svg"),
                                dense: true,
                                horizontalTitleGap: 5,
                                onTap: () {
                                  _navigationServices.pushCupertino(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const LoginView()));
                                },
                                shape: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.25))),
                              ),

                            //*------ Account ------*/
                            if (_toLogin)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(localization.myAccount,
                                    style: AppTextStyles.drawerButtonsStyle()),
                                leading: SvgPicture.asset(
                                    "assets/sidemenu/account.svg"),
                                dense: true,
                                horizontalTitleGap: 5,
                                onTap: () {
                                  _navigationServices.pushCupertino(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const AccountView()));
                                },
                                shape: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.25))),
                              ),

                            //*------Home------*/
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(localization.home,
                                  style: AppTextStyles.drawerButtonsStyle()),
                              leading:
                                  SvgPicture.asset("assets/sidemenu/home.svg"),
                              dense: true,
                              horizontalTitleGap: 5,
                              onTap: () {
                                _navigationServices.pushReplacementCupertino(
                                    CupertinoPageRoute(
                                        builder: (context) => MainView()));
                              },
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.25))),
                            ),

                            //*------About Us------*/
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                localization.aboutSco,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              leading: SvgPicture.asset(
                                  "assets/sidemenu/aboutUs.svg"),
                              dense: true,
                              horizontalTitleGap: 5,
                              onTap: () {
                                _navigationServices.pushCupertino(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ABriefAboutScoView(
                                              appBar: true,
                                            )));
                              },
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.25))),
                            ),

                            // *---- Vision and mission ----*
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(localization.vision_mission_values,
                                  style: AppTextStyles.drawerButtonsStyle()),
                              leading: SvgPicture.asset(
                                  "assets/sidemenu/visionMission.svg"),
                              dense: true,
                              horizontalTitleGap: 5,
                              onTap: () {
                                _navigationServices.pushCupertino(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const VisionAndMissionView()));
                              },
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.25))),
                            ),

                            //*------About Us------*/
                            // ExpansionTile(
                            //   dense: true,
                            //   shape: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //           color: Colors.white.withOpacity(0.25))),
                            //   collapsedShape: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //           color: Colors.white.withOpacity(0.25))),
                            //   tilePadding: EdgeInsets.zero,
                            //   leading: SvgPicture.asset(
                            //       "assets/sidemenu/aboutUs.svg"),
                            //   title:  Text(
                            //     localization.aboutUs,
                            //     style: const TextStyle(
                            //         color: Colors.white, fontSize: 14),
                            //   ),
                            //   iconColor: Colors.white,
                            //   collapsedIconColor: Colors.white,
                            //   children: <Widget>[
                            //     GestureDetector(
                            //       onTap: () {
                            //
                            //         _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const ABriefAboutScoView(appBar: true,)));
                            //       },
                            //       child: Container(
                            //           color: Colors.transparent,
                            //           padding: const EdgeInsets.all(8),
                            //           // width: MediaQuery.sizeOf(context).width * 0.3,
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize.max,
                            //             children: [
                            //               Expanded(
                            //                 flex: 1,
                            //                 child: SvgPicture.asset(
                            //                     "assets/sidemenu/briefAboutSco.svg"),
                            //               ),
                            //                Expanded(
                            //                 flex: 2,
                            //                 child: Text(
                            //                   localization.aBriefAboutSCO,
                            //                   style: const TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 14),
                            //                 ),
                            //               )
                            //             ],
                            //           )),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //
                            //         _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const VisionAndMissionView()));
                            //
                            //       },
                            //       child: Container(
                            //         color: Colors.transparent,
                            //         padding: const EdgeInsets.all(8),
                            //         // width: MediaQuery.sizeOf(context).width * 0.3,
                            //         child: Row(
                            //           mainAxisSize: MainAxisSize.max,
                            //           children: [
                            //             Expanded(
                            //               flex: 1,
                            //               child: SvgPicture.asset(
                            //                   "assets/sidemenu/visionMission.svg"),
                            //             ),
                            //              Expanded(
                            //               flex: 2,
                            //               child: Text(
                            //                 localization.visionMission,
                            //
                            //                 style:const  TextStyle(
                            //                     color: Colors.white,
                            //                     fontSize: 14),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const FaqView()));
                            //       },
                            //       child: Container(
                            //           color: Colors.transparent,
                            //           padding: const EdgeInsets.all(8),
                            //           // width: MediaQuery.sizeOf(context).width * 0.3,
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize.max,
                            //             children: [
                            //               Expanded(
                            //                 flex: 1,
                            //                 child: SvgPicture.asset(
                            //                     "assets/sidemenu/faq.svg"),
                            //               ),
                            //                Expanded(
                            //                 flex: 2,
                            //                 child: Text(
                            //                   localization.faq,
                            //
                            //                   style:const  TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 14),
                            //                 ),
                            //               )
                            //             ],
                            //           )),
                            //     ),
                            //   ],
                            // ),
                            //*------SCO Programs------*/
                            Visibility(
                              visible: true,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(localization.scoPrograms,
                                    style: AppTextStyles.drawerButtonsStyle()),
                                leading: SvgPicture.asset(
                                    "assets/sidemenu/scoProgram.svg"),
                                dense: true,
                                horizontalTitleGap: 5,
                                onTap: () {
                                  _navigationServices.pushCupertino(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const ScoPrograms()));
                                },
                                shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                                ),
                              ),
                            ),
                            //*------News------*/
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(localization.newsAndEvents,
                                  style: AppTextStyles.drawerButtonsStyle()),
                              leading:
                                  SvgPicture.asset("assets/sidemenu/news.svg"),
                              dense: true,
                              horizontalTitleGap: 5,
                              onTap: () {
                                _navigationServices.pushCupertino(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const NewsAndEventsView()));
                              },
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.25))),
                            ),
                            //*------Contact Us------*/
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(localization.contactUs,
                                  style: AppTextStyles.drawerButtonsStyle()),
                              leading: SvgPicture.asset(
                                  "assets/sidemenu/contactUs.svg"),
                              dense: true,
                              horizontalTitleGap: 5,
                              onTap: () async {
                                _navigationServices.pushCupertino(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ContactUsView()));
                              },
                              shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.25))),
                            ),
                            //*------Logout------*/
                            if (_toLogin)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(localization.logout,
                                    style: AppTextStyles.drawerButtonsStyle()),
                                leading: SvgPicture.asset(
                                    "assets/sidemenu/logout.svg"),
                                dense: true,
                                horizontalTitleGap: 5,
                                onTap: () async {
                                  await _authService.clearAllUserData();
                                  await _authService.clearCounter();

                                  /// Clearing all data from hive database
                                  // await HiveManager.clearData();
                                  await HiveManager.clearEmiratesId();
                                  await HiveManager.clearUserId();
                                  await HiveManager.clearName();
                                  await HiveManager.clearRole();

                                  _navigationServices.pushReplacementCupertino(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const MainView()));
                                  _navigationServices.pushCupertino(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const LoginView()));
                                  // _alertServices.toastMessage(localization.logout_success);
                                },
                                shape: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.25))),
                              ),
                            const SizedBox(
                              height: 50,
                            ),
                          ]),
                        ),
                      ),
                    ),

                    //*-----Language Selection Section-----*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //*-----Change Language Button-----*/
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/sidemenu/language.svg"),
                            Text(
                              localization.language,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            const Text(
                              "English",
                              style: TextStyle(
                                  color: AppColors.scoLightThemeColor),
                            ),
                            Consumer<LanguageChangeViewModel>(
                              builder: (context, provider, _) {
                                return CustomAdvancedSwitch(
                                  controller: provider.languageController,
                                  activeColor: AppColors.scoThemeColor,
                                  inactiveColor: Colors.grey,
                                  initialValue:
                                      provider.languageController.value,
                                  onChanged: (value) async {
                                    if (value) {
                                      await Provider.of<
                                                  LanguageChangeViewModel>(
                                              context,
                                              listen: false)
                                          .changeLanguage(const Locale('ar'));
                                      widget.scaffoldState.currentState!
                                          .openEndDrawer();
                                    } else {
                                      await Provider.of<
                                                  LanguageChangeViewModel>(
                                              context,
                                              listen: false)
                                          .changeLanguage(const Locale('en'));
                                      widget.scaffoldState.currentState!
                                          .openDrawer();
                                    }
                                  },
                                );
                              },
                            ),
                            const Text(
                              "عربي",
                              style: TextStyle(
                                  color: AppColors.scoLightThemeColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Directionality(
                            textDirection: getTextDirection(langProvider),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(_appVersion,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String _appVersion = '';

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'Version ${packageInfo.version} (${packageInfo.buildNumber})';
      // _appVersion = 'Version ${packageInfo.version}';
    });
  }
}
