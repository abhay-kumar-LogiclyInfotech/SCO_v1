
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../data/response/status.dart';
import '../../../models/drawer/news_and_events_model.dart';
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
  late NavigationServices _navigationServices;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return VisibilityDetector(
      key: const Key('carousel-visibility-key'),
      onVisibilityChanged: (info) {
        final isNowVisible = info.visibleFraction > 0;
        if (_isVisible != isNowVisible) {
          setState(() {
            _isVisible = isNowVisible;
          });
        }
      },
      child: Consumer<LanguageChangeViewModel>(
        builder: (context,langProvider,_){

          final languageId = getTextDirection(langProvider) == TextDirection.rtl
              ? 'ar_SA'
              : 'en_US';


          return Consumer<NewsAndEventsViewmodel>(
            builder: (context, provider, _) {
              switch (provider.newsAndEventsResponse.status) {
                case Status.LOADING:
                case Status.ERROR:
                  return showVoid;

                case Status.COMPLETED:

                  final newsList = provider.parsedNewsAndEventsModelList;

                  final List<Widget> items = (newsList.length > 5 ? newsList.sublist(0,5) : newsList).map<Widget>((item) {
                    return ChangeNotifierProvider(
                      create: (_) => IndividualImageViewModel(),
                      child: GestureDetector(
                        onTap: () {
                          _navigationServices.pushCupertino(CupertinoPageRoute(
                            builder: (context) => NewsAndEventsDetailView(
                              imageId: item.coverImageFileEntryId,
                              date: item.getFormattedDate(context.read<LanguageChangeViewModel>()).toString(),
                              title: item.getTitle(languageId),
                              subTitle: item.getDescription(languageId),
                              content: item.getContent(languageId),
                            ),
                          ));
                        },
                        child: CarouselItemBuilder(item: item, languageId: languageId),
                      ),
                    );
                  }).toList();

                  return Column(
                    children: [
                      kMinorSpace,
                      Directionality(
                        textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: orientation == Orientation.portrait ? 220.0 : 210,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.9,
                            enlargeFactor: 0.1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: _isVisible,
                            autoPlayInterval: const Duration(seconds: 7),
                            autoPlayAnimationDuration: const Duration(milliseconds: 500),
                            autoPlayCurve: Curves.linear,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: items,
                        ),
                      ),
                      kHomeCardSpace,
                    ],
                  );

                default:
                  return showVoid;
              }
            },
          );
        },
      )

      ,
    );
  }
}

class CarouselItemBuilder extends StatefulWidget {
  final ParseNewsAndEventsModel item;
  final String languageId;

  const CarouselItemBuilder({
    super.key,
    required this.languageId,
    required this.item,
  });

  @override
  State<CarouselItemBuilder> createState() => _CarouselItemBuilderState();
}

class _CarouselItemBuilderState extends State<CarouselItemBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<IndividualImageViewModel>(context, listen: false).individualImage(
        context: context,
        langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false),
        imageId: widget.item.coverImageFileEntryId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(context)),
      child: Stack(
        children: [
          SizedBox(
            height: 220,
            child: Consumer<IndividualImageViewModel>(
              builder: (context, imageProvider, _) {
                switch (imageProvider.individualImageResponse.status) {
                  case Status.LOADING:
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: const Center(
                        child: CupertinoActivityIndicator(color: AppColors.scoThemeColor),
                      ),
                    );

                  case Status.ERROR:
                  case Status.COMPLETED:
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: imageProvider.individualImageResponse.data?.data?.imageUrl ?? Constants.newsImageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, object, _) {
                          return Image.asset(Constants.newsImageUrl, fit: BoxFit.cover);
                        },
                      ),
                    );

                  default:
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    );
                }
              },
            ),
          ),

          // Gradient Overlay
          Container(
            width: double.infinity,
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
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.item.getTitle(widget.languageId),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
