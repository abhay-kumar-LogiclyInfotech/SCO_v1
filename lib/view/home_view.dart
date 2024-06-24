import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_button.dart';

import '../viewModel/language_change_ViewModel.dart';

enum Language { english, spanish }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)!.emailAddress),
      //   actions: [
      //     Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
      //       return PopupMenuButton(
      //           onSelected: (Language item) {
      //             if (Language.english.name == item.name) {
      //               provider.changeLanguage(const Locale('en'));
      //             } else {
      //               debugPrint('Arabic');
      //               provider.changeLanguage(const Locale('ar'));
      //             }
      //           },
      //           itemBuilder: (BuildContext context) =>
      //               <PopupMenuEntry<Language>>[
      //                 const PopupMenuItem(
      //                     value: Language.english, child: Text("English")),
      //                 const PopupMenuItem(
      //                     value: Language.spanish, child: Text("Arabic"))
      //               ]);
      //     })
      //   ],
      // ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //top bar:
              _topAppBar(),

              const SizedBox(
                height: 20,
              ), //CarouselSlider:
              _carouselSlider(),
              const SizedBox(
                height: 10
              ),
              _amountContainer(),
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
                  child: Image.asset('assets/company_logo.png')),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
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
            height: 190.0,
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
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/carousel_demo_image.png",
                      fit: BoxFit.cover,
                    ))),

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
                              textDirection:
                                  provider.appLocale == const Locale('en') ||
                                          provider.appLocale == null
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
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
                                textDirection:
                                    provider.appLocale == const Locale('en') ||
                                            provider.appLocale == null
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
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
    return Consumer(

      builder: (context,provider,_){
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding:  const EdgeInsets.all(25),
              child: Column(
                children: [
                  //Scholarship office:
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                        AppLocalizations.of(context)!.scholarshipOffice,
                        style: const TextStyle(
                            color: Color(0xff093B59),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/scholarship_office.png",
                        height: 30,
                        width: 30,
                      )
                    ],
                  ), //information:

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      const Expanded(
                        child:  Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("300",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700,color:  Color(0xff0B9967))),
                                SizedBox(width: 4),
                                Text("AED",style: TextStyle(fontSize: 14,color:  Color(0xff0B9967),fontWeight: FontWeight.w400),)
                              ],
                            ),
                            Text("02/09/2023",style: TextStyle(color: Color(0xff9AA6B2),fontSize: 12,fontWeight: FontWeight.w400),)
                          ],
                        ),
                      )
                      ,
                      GestureDetector(
                        //Implement read more here:
                        onTap:(){},
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: CustomButton(
                              buttonName: AppLocalizations.of(context)!.readMore,
                              isLoading: false,
                              textDirection: TextDirection.ltr,
                              onTap: () {},
                              textColor: const  Color(0xffAD8138),
                              borderColor: const Color(0xffAD8138),
                              buttonColor: Colors.white,
                              fontSize: 14,
                              height: 40,
                            )),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15,),

                  const Divider(color:  Color(0xffDFDFDF
                  ),),
                  const SizedBox(height: 10,),

                  const  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.calendar_month_outlined,color:Color(0xffA7B0C1)),
                      SizedBox(width: 5,),
                      Text("01/09/2023 - 01/09/2024",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff8591A7)),),
                      SizedBox(width: 5,),
                      Text("(12 mon)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff8591A7)),),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
