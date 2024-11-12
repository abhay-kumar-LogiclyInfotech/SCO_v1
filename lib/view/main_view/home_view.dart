import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/controller/dependency_injection.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/carsousel_slider.dart';
import 'package:sco_v1/resources/components/custom_about_organization_containers.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/authentication/login/login_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/aBriefAboutSco_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/news_and_events_view.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../resources/app_colors.dart';
import '../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../resources/custom_painters/faq_painters.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../drawer/custom_drawer_views/vision_and_mission_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with MediaQueryMixin<HomeView> {
  late NavigationServices _navigationServices;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      final applicationStatusProvider = Provider.of<GetListApplicationStatusViewModel>(context,listen: false);
      await applicationStatusProvider.getListApplicationStatus();

      // final provider = Provider.of<HomeSliderViewModel>(context, listen: false);
      // final langProvider =
      //     Provider.of<LanguageChangeViewModel>(context, listen: false);
      // await provider.homeSlider(context: context, langProvider: langProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: _buildUI(),
    );
  }


  // check for the scholarship status
  ScholarshipStatus scholarshipStatus = ScholarshipStatus.applyScholarship;

  Widget _buildUI() {
    // *-----Initialize the languageProvider-----*
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(kPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //CarouselSlider:

              // *-----Client Said he don't need CarouselSlider on the home page----*/
              // _carouselSlider(),
            if(scholarshipStatus == ScholarshipStatus.appliedScholarship)
              Column(
                children: [
                  _scholarshipAppliedContainer(langProvider: langProvider),
                  kFormHeight,
                ],
              ),

              if(scholarshipStatus == ScholarshipStatus.approvedScholarship)
                Column(
                  children: [
                    _scholarshipApproved(langProvider: langProvider),
                    kFormHeight,
                  ],
                ),

              // _faqContainer(langProvider: langProvider),
              // kFormHeight,
              // _aboutOrganization(langProvider: langProvider),
              kFormHeight,
              if(scholarshipStatus == ScholarshipStatus.applyScholarship) Column(children: [
                _applyScholarshipButton(langProvider: langProvider),
                kFormHeight,
                _scoPrograms(langProvider: langProvider),
                kFormHeight,
              ],),

              if(scholarshipStatus == ScholarshipStatus.appliedScholarship || scholarshipStatus == ScholarshipStatus.applyScholarship)   _faqSection(langProvider:langProvider)
            ],
          ),
        ),
      ),
    );
  }

  /***
      // *----CarouselSlider-------*
      Widget _carouselSlider() {
      return SizedBox(
      child: CarouselSlider(
      options: CarouselOptions(
      height: orientation == Orientation.portrait ? 190.0 : 210,
      aspectRatio: 16 / 9,
      viewportFraction: 0.85,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 2),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      scrollDirection: Axis.horizontal,
      ),
      items: [_carouselItem()]),
      );
      }


      Widget _carouselItem() {
      return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
      return Stack(
      children: [
      ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
      "assets/sidemenu/aBriefAboutSco.jpg",
      fit: BoxFit.fill,
      height: double.infinity,
      width: double.infinity,
      )),

      //Gradient:
      Container(
      width: double.infinity,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [
      Colors.black,
      Colors.black87.withOpacity(0.2),
      ], begin: Alignment.bottomCenter, end: Alignment.center)),
      ),
      //Read more:
      Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding:
      const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
      child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      //Read more:
      Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Icon(
      Icons.arrow_back_ios,
      color: Color(0xffAD8138),
      size: 14,
      ),
      const SizedBox(
      width: 2,
      ),
      Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
      AppLocalizations.of(context)!.readMore,
      style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xffAD8138)),
      ),
      ),
      ],
      ),
      ],
      ),

      const SizedBox(
      width: 15,
      ), //right side content:
      Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
      AppLocalizations.of(context)!.scholarships,
      style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600),
      ),
      ),
      const SizedBox(
      width: 8,
      ),
      SvgPicture.asset("assets/scholarship.svg")
      ],
      ),
      Text(
      AppLocalizations.of(context)!.scholarshipsInTheUAE,
      textAlign: TextAlign.end,
      style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600),
      )
      ],
      ),
      )
      ],
      ))
      ],
      );
      },
      );
      }

   ***/

// *---Container for approved scholarships-----*
  Widget _scholarshipApproved({required LanguageChangeViewModel langProvider}) {
    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            // Amount and Read More Button
            _buildAmountAndButton(langProvider: langProvider),

            const SizedBox(height: 10),

            const Divider(color: Color(0xffDFDFDF)),

            const SizedBox(height: 10),

            // Date Information
            _buildDateInfo(langProvider: langProvider, date: null),
          ],
        ));
  }

  // *----Scholarship applied container----*
  Widget _scholarshipAppliedContainer(
      {required LanguageChangeViewModel langProvider}) {
    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Scholarship status:
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scholarship Status",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.hintDarkGrey),
                        textAlign: TextAlign.start,
                      ),
                      Text("Scholarship Applied",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start)
                    ],
                  ),
                ),

                // read more button
                SizedBox(
                  width: screenWidth * 0.35,
                  child: CustomButton(
                    buttonName: AppLocalizations.of(context)!.readMore,
                    isLoading: false,
                    onTap: () {},
                    textDirection: getTextDirection(langProvider),
                    textColor: const Color(0xffAD8138),
                    borderColor: const Color(0xffAD8138),
                    buttonColor: Colors.white,
                    fontSize: 14,
                    height: 40,
                  ),
                ),
              ],
            ),
            kFormHeight,

            // divider
            const Divider(color: AppColors.lightGrey),
            const SizedBox.square(
              dimension: 5,
            ),

            // date
            _buildDateInfo(langProvider: langProvider, date: "DD/MM/YYYY"),
          ],
        ));
  }

  // *------Faq Container------*
  // Widget _faqContainer({required LanguageChangeViewModel langProvider}) {
  //   return Container(
  //     width: double.infinity,
  //     height: 170,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(kCardRadius),
  //         border: Border.all(color: AppColors.hintDarkGrey)),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(kCardRadius - 1),
  //       child: Stack(
  //         children: [
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: CustomPaint(
  //               painter: FaqSmallPainter(),
  //               size: const Size(double.maxFinite, 90),
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: CustomPaint(
  //               foregroundPainter: FaqBigPainter(),
  //               size: const Size(double.maxFinite, 120),
  //             ),
  //           ),
  //           Container(
  //             color: AppColors.lightBlue0.withOpacity(0.3),
  //           ),
  //           Positioned(
  //             top: kPadding,
  //             bottom: kPadding,
  //             right: kPadding,
  //             child: SvgPicture.asset(
  //               "assets/icon_faq_home.svg",
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAmountAndButton(
      {required LanguageChangeViewModel langProvider}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Amount Information
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "300",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B9967),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "AED",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0B9967),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Text(
                "02/09/2023",
                style: TextStyle(
                  color: Color(0xff9AA6B2),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // Read More Button
        SizedBox(
          width: screenWidth * 0.35,
          child: CustomButton(
            buttonName: AppLocalizations.of(context)!.readMore,
            isLoading: false,
            onTap: () {},
            textDirection: getTextDirection(langProvider),
            textColor: const Color(0xffAD8138),
            borderColor: const Color(0xffAD8138),
            buttonColor: Colors.white,
            fontSize: 14,
            height: 40,
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo(
      {required LanguageChangeViewModel langProvider, required dynamic date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_month_outlined, color: Color(0xffA7B0C1)),
        const SizedBox(width: 5),
        Text(
          date ?? "01/09/2023 - 01/09/2024",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.hintDarkGrey,
          ),
        ),
        // SizedBox(width: 5),
        // Text(
        //   "(12 mon)",
        //   style: TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.w400,
        //     color: Color(0xff8591A7),
        //   ),
        // ),
      ],
    );
  }

  Widget _aboutOrganization({required LanguageChangeViewModel langProvider}) {
    return _homeViewCard(
        icon: SvgPicture.asset(
          "assets/aboutTheOrganization.svg",
          height: 20,
          width: 20,
        ),
        title: AppLocalizations.of(context)!.aboutTheOrganization,
        langProvider: langProvider,
        content: Column(
          children: [
            const Divider(color: Color(0xffDFDFDF)),
            const SizedBox(height: 10),
            _buildInfoRow1(),
            const SizedBox(height: 10),
            _buildInfoRow2(),
          ],
        ));
  }

  // Apply Scholarship Button
  Widget _applyScholarshipButton(
      {required LanguageChangeViewModel langProvider}) {
    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            kFormHeight,
            Consumer(
              builder: (context,provider,_){
                return CustomButton(
                  buttonName: "Apply Scholarship",
                  isLoading: false,
                  onTap: () async {
                    // check if user is logged in or not
                    final bool alreadyLoggedIn = await _authService.isLoggedIn();
                    if (!alreadyLoggedIn) {
                      _navigationServices.goBackUntilFirstScreen();
                      _navigationServices.pushCupertino(CupertinoPageRoute(
                          builder: (context) => const LoginView()));
                    } else {



                      _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()));
                    }
                  },
                  textDirection: getTextDirection(langProvider),
                  textColor: AppColors.scoThemeColor,
                  borderColor: AppColors.scoThemeColor,
                  buttonColor: Colors.white,
                  fontSize: 16,
                  height: 45,
                );
              },
            ),
            kFormHeight,
          ],
        ));
  }

  // *---- Sco programs slider ----*
  final _scoProgramsList = [
    CustomScoProgramTile(
        imagePath: "assets/sidemenu/distinguished_doctors.jpg",
        title: "Scholarships in UAE",
        subTitle: "The office, which was establishe in 1999 under the direct..",
        onTap: () {}),
    CustomScoProgramTile(
        imagePath: "assets/sidemenu/distinguished_doctors.jpg",
        title: "Scholarships in Abroad",
        subTitle: "The office, which was establishe in 1999 under the direct..",
        onTap: () {}),
    CustomScoProgramTile(
        imagePath: "assets/sidemenu/distinguished_doctors.jpg",
        title: "Scholarships in Abroad",
        subTitle: "The office, which was establishe in 1999 under the direct..",
        onTap: () {}),
  ];
  int _scoProgramCurrentIndex = 0;
  Widget _scoPrograms({required LanguageChangeViewModel langProvider}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // title for sco programs
            Text(
              "SCO Program",
              style: AppTextStyles.appBarTitleStyle(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),

            // slider for sco programs
          ],
        ),
        Column(
          children: [
            // carousel slider
            CustomCarouselSlider(
              items: _scoProgramsList,
              onPageChanged: (index, reason) {
                setState(() {
                  _scoProgramCurrentIndex = index;
                });
              },
            ),
            kFormHeight,            // animated moving dots
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _scoProgramsList.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _scoProgramCurrentIndex == entry.key ? 7.0 : 5.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _scoProgramCurrentIndex == entry.key
                        ? Colors.black
                        : Colors.grey,
                  ),

                );
              }).toList(),
            )
          ],
        )
      ],
    );
  }

  // &---- FaQ section -----*
  Widget _faqSection({langProvider})
  {
    return _homeViewCard(title: "FAQ", icon: const Icon(Icons.face), content: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("Frequently Asked Questions",style: AppTextStyles.titleTextStyle(),)
      ],
    ), langProvider: langProvider,
      onTap: (){
      // Navigate to FAQ page
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const FaqView()));

    }


    );
  }












  // main card for home
  Widget _homeViewCard(
      {required String title,
      required Widget icon,
      required Widget content,
      required LanguageChangeViewModel langProvider,
      VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,
        color: Colors.white,
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(kCardRadius),
        child: Directionality(
          textDirection: getTextDirection(langProvider),
          child: Padding(
            padding: EdgeInsets.all(kPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        icon,
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: AppTextStyles.titleBoldTextStyle(),
                        ),
                      ],
                    )),
                    Icon(getTextDirection(langProvider) == TextDirection.rtl
                        ? Icons.keyboard_arrow_left_outlined
                        : Icons.keyboard_arrow_right_outlined,color: Colors.grey,)
                  ],
                ),
                kFormHeight,
                content
              ],
            ),
          ),
        ),
      ),
    );
  }









  Widget _buildInfoRow1() {
    return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/aboutSco.svg",
                name: AppLocalizations.of(context)!.aboutSco,
                onTap: () {
                  _navigationServices.pushSimpleWithAnimationRoute(
                      createRoute(const ABriefAboutScoView(
                    appBar: true,
                  )));
                },
                textDirection: getTextDirection(provider),
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/scholarships.svg",
                name: AppLocalizations.of(context)!.scholarship,
                onTap: () async {
                  // check if user is logged in or not
                  final bool alreadyLoggedIn = await _authService.isLoggedIn();
                  if (!alreadyLoggedIn) {
                    _navigationServices.goBackUntilFirstScreen();
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const LoginView()));
                  } else {
                    _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()));
                  }
                },
                textDirection: getTextDirection(provider),
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/certificates.svg",
                name: AppLocalizations.of(context)!.certificates,
                onTap: () {},
                textDirection: getTextDirection(provider),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow2() {
    return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/faqs.svg",
                name: AppLocalizations.of(context)!.faqs,
                textDirection: getTextDirection(provider),
                onTap: () {
                  _navigationServices.pushSimpleWithAnimationRoute(
                      createRoute(const FaqView()));
                },
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/vision_and_mission.svg",
                name: AppLocalizations.of(context)!.visionAndMission,
                textDirection: getTextDirection(provider),
                onTap: () {
                  _navigationServices.pushSimpleWithAnimationRoute(
                      createRoute(const VisionAndMissionView()));
                },
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/news_and_events.svg",
                name: AppLocalizations.of(context)!.newsAndEvents,
                textDirection: getTextDirection(provider),
                onTap: () {
                  _navigationServices.pushSimpleWithAnimationRoute(
                      createRoute(const NewsAndEventsView()));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
