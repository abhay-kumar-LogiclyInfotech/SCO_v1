import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/drawer/individual_image_viewModel.dart';
import '../../../viewModel/drawer/news_and_events_viewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../drawer/custom_drawer_views/news_and_events_details_view.dart';

class HomeNewsCarouselSliderView extends StatefulWidget {
  const HomeNewsCarouselSliderView({super.key});

  @override
  State<HomeNewsCarouselSliderView> createState() => _HomeNewsCarouselSliderViewState();
}

class _HomeNewsCarouselSliderViewState extends State<HomeNewsCarouselSliderView> with MediaQueryMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsAndEventsViewmodel>(
      builder: (context, provider, _) {
        switch (provider.newsAndEventsResponse.status) {
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.COMPLETED:
            return Column(
              children: [
                Directionality(
                    textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: orientation == Orientation.portrait ? 220.0 : 210,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(milliseconds: 300),
                        autoPlayCurve: Curves.linear,
                        enlargeCenterPage: true,
                        enlargeFactor: 1,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: provider.parsedNewsAndEventsModelList
                          .map<Widget>((item) {
                        final languageId = getTextDirection(
                            context.read<LanguageChangeViewModel>()) ==
                            TextDirection.rtl
                            ? 'ar_SA'
                            : 'en_US';

                        return CarouselItemBuilder(
                          item: item,
                          languageId: languageId,
                        );
                      }).toList(),
                    )),
                kSmallSpace,
              ],
            );
          default:
            return showVoid;
        }
      },
    );
  }
}

class CarouselItemBuilder extends StatefulWidget {
  final dynamic item;
  final dynamic languageId;

  const CarouselItemBuilder({
    super.key,
    required this.languageId,
    required this.item,
  });

  @override
  State<CarouselItemBuilder> createState() => _CarouselItemBuilderState();
}

class _CarouselItemBuilderState extends State<CarouselItemBuilder> {

  late NavigationServices _navigationServices;

  void _initializeData() async {
    final langProvider =
    Provider.of<LanguageChangeViewModel>(context, listen: false);
    final provider =
    Provider.of<IndividualImageViewModel>(context, listen: false);

    // Schedule the data fetch to avoid direct async calls in build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider.individualImage(
          context: context,
          langProvider: langProvider,
          imageId: widget.item.coverImageFileEntryId);
    });
  }

  @override
  void initState() {
    super.initState();
    //register services:
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    //Initialize the image url;
    _initializeData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(context)),
      child: InkWell(
        onTap:  () {
          _navigationServices.pushCupertino(CupertinoPageRoute(
            builder: (context) => NewsAndEventsDetailView(
                imageId: widget.item.coverImageFileEntryId,
                date: widget.item
                    .getFormattedDate(
                    context.read<LanguageChangeViewModel>())
                    .toString(),
                title: widget.item.getTitle(widget.languageId),
                subTitle: widget.item
                    .getDescription(widget.languageId),
                content:
                widget.item.getContent(widget.languageId)),
          ));
        },
        child: Stack(
          children: [
            // Background Image
            SizedBox(
                height: 220,
                child: Consumer<IndividualImageViewModel>(
                  builder: (context, imageProvider, _) {
                    switch (imageProvider.individualImageResponse.status) {
                      case Status.LOADING:
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: const Center(
                            child: CupertinoActivityIndicator(
                              color: AppColors.scoThemeColor,
                            ),
                          ),
                        );
                      case Status.ERROR:
                      case Status.COMPLETED:
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:  CachedNetworkImage(
                            cacheKey: imageProvider.individualImageResponse.data?.data?.imageUrl ?? Constants.newsImageUrl,
                            imageUrl: "${imageProvider.individualImageResponse.data?.data?.imageUrl ?? Constants.newsImageUrl}?v=${DateTime.now().millisecondsSinceEpoch}",
                            // fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            errorWidget: (context,object,_){
                              return Image.asset(Constants.newsImageUrl);
                            },
                            errorListener: (object){
                              Image.asset(Constants.newsImageUrl);
                            },
                          ), // Show loader while fetching
                        );

                      default:
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        );
                    }
                  },
                )),

            // Gradient Overlay
            Container(
              width: double.infinity,
              // height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87.withOpacity(0.2)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),

            // Content Layer
            Container(
              // height: 220,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "Read More" Section
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         const Icon(Icons.arrow_back_ios,
                  //             color: Color(0xffAD8138), size: 14),
                  //         const SizedBox(width: 2),
                  //         InkWell(
                  //           onTap: () {
                  //             _navigationServices.pushCupertino(CupertinoPageRoute(
                  //               builder: (context) => NewsAndEventsDetailView(
                  //                   imageId: widget.item.coverImageFileEntryId,
                  //                   date: widget.item
                  //                       .getFormattedDate(
                  //                           context.read<LanguageChangeViewModel>())
                  //                       .toString(),
                  //                   title: widget.item.getTitle(widget.languageId),
                  //                   subTitle: widget.item
                  //                       .getDescription(widget.languageId),
                  //                   content:
                  //                       widget.item.getContent(widget.languageId)),
                  //             ));
                  //           },
                  //           child: Text(
                  //             AppLocalizations.of(context)!.readMore,
                  //             style: const TextStyle(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w600,
                  //               color: Color(0xffAD8138),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  // const SizedBox(width: 15),

                  // Right Side Content
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.item.getDescription(widget.languageId),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2, // Limits to 2 lines to prevent overflow
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
