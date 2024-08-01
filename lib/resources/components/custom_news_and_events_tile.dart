import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/individual_image_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../data/response/status.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class CustomNewsAndEventsTile extends StatefulWidget {
  final String imageId;
  final String title;
  final String subTitle;
  String? date;
  final void Function() onTap;


  CustomNewsAndEventsTile(
      {super.key,
      required this.imageId,
      required this.title,
      required this.subTitle,
      this.date,
      required this.onTap,
   });

  @override
  State<CustomNewsAndEventsTile> createState() =>
      _CustomNewsAndEventsTileState();
}

class _CustomNewsAndEventsTileState extends State<CustomNewsAndEventsTile> {

  late NavigationServices _navigationServices;


  String? _imageUrl;

  void _initializeData() async {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    final provider =
        Provider.of<IndividualImageViewModel>(context, listen: false);

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
    super.initState();
    //register services:
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();


    //Initialize the image url;
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: GestureDetector(
        // onTap: widget.onTap,
        onTap: widget.onTap,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 4, child: _imageSection(langProvider)),
                Expanded(flex: 10, child: _descSection()),
              ],
            ),
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
            return Container(
              height: 100,
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
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _imageUrl ?? Constants.newsImageUrl, filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                height: 100,
                // width: screenWidth / 4,
                // height: screenHeight / 5.6,
                errorBuilder: (BuildContext context, Object, StackTrace) {
                  return Image.network(
                    "assets/sidemenu/scholarships_uae.jpg",
                    filterQuality: FilterQuality.high,
                    height: 100,
                    fit: BoxFit.cover,
                    // width: screenWidth / 4,
                    // height: screenHeight / 8,
                  );
                },
              ),
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
    );
  }

  Widget _descSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 15,
        top: 1,
        bottom: 1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            widget.title.length < 55
                ? widget.title
                : "${widget.title.substring(0, 55)}..",
            style: AppTextStyles.titleTextStyle(),
          ),
          const SizedBox(height: 7),
          Text(
            widget.subTitle.length < 25
                ? widget.subTitle
                : "${widget.subTitle.substring(0, 25)}...",
            style: AppTextStyles.subTitleTextStyle(),
          ),
          const SizedBox(height: 7),
//Date
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/sidemenu/date_icon.svg"),
              const SizedBox(
                width: 4.5,
              ),
              Text(
                widget.date ?? "Date", // textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Color(0xff9A6F32),
                  fontSize: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
