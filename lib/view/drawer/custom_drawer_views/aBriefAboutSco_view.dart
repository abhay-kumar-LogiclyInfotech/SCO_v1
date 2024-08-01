import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';
import '../../../resources/app_colors.dart';
import '../../../viewModel/services/navigation_services.dart';

class ABriefAboutScoView extends StatefulWidget {
  const ABriefAboutScoView({super.key});

  @override
  State<ABriefAboutScoView> createState() => _ABriefAboutScoViewState();
}

class _ABriefAboutScoViewState extends State<ABriefAboutScoView>
    with MediaQueryMixin<ABriefAboutScoView> {
  late NavigationServices _navigationService;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        title: Text(AppLocalizations.of(context)!.aBriefAboutSCO,
            style: AppTextStyles.appBarTitleStyle()),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Image Section:
            _imageSection(),
            const SizedBox(height: 20),
            //About Us Detailed Text Section:
            _detailSection(),
          ],
        ),
      ),
    );
  }

  Widget _imageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/sidemenu/aBriefAboutSco.jpg",
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            width: screenWidth,
            height: screenHeight / 5,
            errorBuilder: (BuildContext context, Object, StackTrace) {
              return Image.asset(
                "assets/sidemenu/aBriefAboutSco.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                width: screenWidth,
                height: screenHeight / 5,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
              elevation: 2,
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 1.0,
                  left: 5,
                  right: 5,
                  bottom: 1,
                ),
                child: Text(
                  "Scholarships",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget _detailSection() {
    return const Text(
      Constants.longText,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
