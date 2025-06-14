import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../viewModel/drawer/individual_image_viewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class NewsAndEventsDetailView extends StatefulWidget {
  final String imageId;
  final String title;
  final String subTitle;
  final String content;
  final String date;

  const NewsAndEventsDetailView(
      {super.key,
      required this.imageId,
      required this.title,
      required this.subTitle,
      required this.content,
      required this.date});

  @override
  State<NewsAndEventsDetailView> createState() =>
      _NewsAndEventsDetailViewState();
}

class _NewsAndEventsDetailViewState extends State<NewsAndEventsDetailView>
    with MediaQueryMixin<NewsAndEventsDetailView> {

  String? _imageUrl;

  void _initializeData() async {



    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    final provider = Provider.of<IndividualImageViewModel>(context, listen: false);

    // Schedule the data fetch to avoid direct async calls in build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool result = await provider.individualImage(
          context: context,
          langProvider: langProvider,
          imageId: widget.imageId);

      if (result && mounted) {
        // Ensure widget is still mounted
        setState(() {
          _imageUrl = provider.individualImageResponse.data!.data!.imageUrl!;
        });
      }
    });
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;

    super.initState();

    //Initialize the image url;
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(AppLocalizations.of(context)!.news,
            style: AppTextStyles.appBarTitleStyle()),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: getTextDirection(langProvider),
          child: Column(
            children: [
              Material(
                color: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 3,
                borderRadius: BorderRadius.circular(kCardRadius),
                child: Column(
                  mainAxisSize: MainAxisSize.max,

                  children: [
                    //Image Section:
                    _imageSection(langProvider), const SizedBox(height: 20),
                    // date


                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children:[

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/sidemenu/date_icon.svg",),
                              const SizedBox(
                                  width: 4.5
                              ),
                              Text(
                                widget.date ?? "Date", // textAlign: TextAlign.justify,
                                style:  const TextStyle(
                                  color: AppColors.scoThemeColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          _titleSection(),
                          // const SizedBox(height: 5),
                          //
                          // _descriptionSection(),
                          const SizedBox(height: 10),

                          //About Us Detailed Text Section:
                          _contentSection(), const SizedBox(height: 20),
                        ]
                      ),
                    )

                  ],
                ),
              ),
              kFormHeight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSection(langProvider) {
    return Consumer<IndividualImageViewModel>(
      builder: (context, provider, _) {
        switch (provider.individualImageResponse.status) {
          case Status.LOADING:
            return Container(
              width: screenWidth,
              height: screenHeight / 5,
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
            return Container(
              width: screenWidth,
              height: screenHeight / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 30),
                    SizedBox(height: 10),
                    Text(
                      'Error loading image',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          case Status.COMPLETED:
            return AspectRatio(
              aspectRatio: 4/2,
              child:
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeInOut,
                    // height: 95,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kCardRadius),
                        image: DecorationImage(
                          image: NetworkImage(_imageUrl ?? Constants.newsImageUrl,),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                ],
              ),
            );


            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _imageUrl ?? Constants.newsImageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                width: screenWidth,
                height: screenHeight / 5,
                // width: screenWidth / 4,
                // height: screenHeight / 5.6,
                errorBuilder: (BuildContext context, Object, StackTrace) {
                  return Image.asset(
                    "assets/news_image.jpg",
                    filterQuality: FilterQuality.high,
                    width: screenWidth,
                    height: screenHeight / 5,
                    fit: BoxFit.cover,
                    // width: screenWidth / 4,
                    // height: screenHeight / 8,
                  );
                },
              ),
            );

          default:
            return Container(
              width: screenWidth,
              height: screenHeight / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.3),
              ),
            );
        }
      },
    );
  }

  Widget _titleSection() {
    return Text(
      widget.title,
      style: AppTextStyles.titleTextStyle(),
      textAlign: TextAlign.justify,
    );
  }

  Widget _descriptionSection() {
    return Text(
      widget.subTitle,
      style: AppTextStyles.subTitleTextStyle(),
      textAlign: TextAlign.justify,
    );
  }

  Widget _contentSection() {
    return Text(
      widget.content,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
