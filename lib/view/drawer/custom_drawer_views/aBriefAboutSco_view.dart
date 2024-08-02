
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/viewModel/drawer/a_brief_about_sco_viewModel.dart';
import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class ABriefAboutScoView extends StatefulWidget {
  final bool appBar;
  const ABriefAboutScoView({super.key,required this.appBar});

  @override
  State<ABriefAboutScoView> createState() => _ABriefAboutScoViewState();
}

class _ABriefAboutScoViewState extends State<ABriefAboutScoView>
    with MediaQueryMixin<ABriefAboutScoView> {
  late NavigationServices _navigationService;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:widget.appBar ?  CustomSimpleAppBar(
        title: Text(AppLocalizations.of(context)!.aBriefAboutSCO,
            style: AppTextStyles.appBarTitleStyle()),
      ) : null,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _imageSection(),
            const SizedBox(height: 20),
            _detailSection(langProvider),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 2,
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Scholarships",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailSection(LanguageChangeViewModel langProvider) {
    return Consumer<ABriefAboutScoViewModel>(
      builder: (context, provider, _) {
        switch (provider.aBriefAboutScoResponse.status) {
          case Status.LOADING:
            return const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.scoThemeColor,
              ),
            );

          case Status.ERROR:
            return Center(
              child: Text(
                AppLocalizations.of(context)!.somethingWentWrong,
              ),
            );

          case Status.COMPLETED:
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.contentSectionsList.length,
              itemBuilder: (context, index) {
                final section = provider.contentSectionsList[index];
                return Directionality(
                  textDirection: getTextDirection(langProvider),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.heading,
                          style: const TextStyle(
                            color: AppColors.scoThemeColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          section.paragraph,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          default:
            return Text(
              AppLocalizations.of(context)!.somethingWentWrong,
            );
        }
      },
    );
  }
}
