import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_about_organization_containers.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';

import '../resources/app_colors.dart';
import '../viewModel/language_change_ViewModel.dart';

enum Language { english, spanish }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with MediaQueryMixin<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //CarouselSlider:
              _carouselSlider(),
              const SizedBox(height: 10),
              _amountContainer(),
              _aboutOrganization(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topAppBar() {
    return Container(
      color: Colors.transparent,
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 35,
                  width: 80,
                  child: Image.asset('assets/company_logo.jpg')),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/notification_bell.svg",
                    height: 20,
                    width: 20,
                  ),
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
          )
        ],
      ),
    );
  }

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

  Widget _amountContainer() {
    return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // Scholarship Office Header
                  _buildScholarshipOfficeHeader(context),

                  // Amount and Read More Button
                  _buildAmountAndButton(context, provider),

                  const SizedBox(height: 10),

                  const Divider(color: Color(0xffDFDFDF)),

                  const SizedBox(height: 10),

                  // Date Information
                  _buildDateInfo(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScholarshipOfficeHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.scholarshipOffice,
          style: const TextStyle(
            color: Color(0xff093B59),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          "assets/scholarship_office.jpg",
          height: 30,
          width: 30,
        ),
      ],
    );
  }

  Widget _buildAmountAndButton(
      BuildContext context, LanguageChangeViewModel provider) {
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
        GestureDetector(
          onTap: () {
            // Implement read more functionality here
          },
          child: SizedBox(
            width: screenWidth * 0.35,
            child: CustomButton(
              buttonName: AppLocalizations.of(context)!.readMore,
              isLoading: false,
              onTap: () {},
              textDirection: getTextDirection(provider),
              textColor: const Color(0xffAD8138),
              borderColor: const Color(0xffAD8138),
              buttonColor: Colors.white,
              fontSize: 14,
              height: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.calendar_month_outlined, color: Color(0xffA7B0C1)),
        SizedBox(width: 5),
        Text(
          "01/09/2023 - 01/09/2024",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xff8591A7),
          ),
        ),
        SizedBox(width: 5),
        Text(
          "(12 mon)",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff8591A7),
          ),
        ),
      ],
    );
  }

  Widget _aboutOrganization() {
    return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTitleRow(context),
                  const SizedBox(height: 15),
                  const Divider(color: Color(0xffDFDFDF)),
                  const SizedBox(height: 10),
                  _buildInfoRow1(),
                  const SizedBox(height: 10),
                  _buildInfoRow2(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.aboutTheOrganization,
          style: const TextStyle(
            color: Color(0xff093B59),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(
          "assets/aboutTheOrganization.svg",
          height: 20,
          width: 20,
        ),
      ],
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
                onTap: () {},
                textDirection: getTextDirection(provider),
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/scholarships.svg",
                name: AppLocalizations.of(context)!.scholarship,
                onTap: () {},
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
                onTap: () {},
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/vision_and_mission.svg",
                name: AppLocalizations.of(context)!.visionAndMission,
                textDirection: getTextDirection(provider),
                onTap: () {},
              ),
            ),
            Expanded(
              child: CustomAboutOrganizationContainers(
                assetName: "assets/news_and_events.svg",
                name: AppLocalizations.of(context)!.newsAndEvents,
                textDirection: getTextDirection(provider),
                onTap: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
