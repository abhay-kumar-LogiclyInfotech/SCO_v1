import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../models/home/ScoProgramsTileModel.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/carsousel_slider.dart';
import '../../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../scholarship_in_abroad/scholarship_in_abroad_view.dart';
import '../scholarship_in_uae/scholarship_in_uae_view.dart';
import '../../../l10n/app_localizations.dart';

class HomeScoProgramsView extends StatefulWidget {
  const HomeScoProgramsView({super.key});

  @override
  State<HomeScoProgramsView> createState() => _HomeScoProgramsViewState();
}

class _HomeScoProgramsViewState extends State<HomeScoProgramsView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  int _scoProgramCurrentIndex = 0;

  final List<Widget> _scoProgramsList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];

  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeScoPrograms(); // Update list when localization changes
  }

  void _initializeScoPrograms() {
    final localization = AppLocalizations.of(context)!;

    final scoProgramsMapList = [
      {
        'title': localization.scholarshipInternal,
        'subTitle': localization.internalScholarshipDesc,
        'imagePath': Constants.scholarshipInUae,
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
          createRoute(ScholarshipsInUaeView()),
        ),
      },
      {
        'title': localization.scholarshipExternal,
        'subTitle': localization.externalScholarshipDesc,
        'imagePath': Constants.scholarshipInAbroad,
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
          createRoute(ScholarshipInAbroadView()),
        ),
      },
    ];

    _scoProgramsModelsList.clear();
    _scoProgramsList.clear();

    for (var map in scoProgramsMapList) {
      final model = ScoProgramTileModel.fromJson(map);
      _scoProgramsModelsList.add(model);
      _scoProgramsList.add(
        CustomScoProgramTile(
          key: ValueKey(model.title), // Ensure uniqueness
          imagePath: model.imagePath!,
          title: model.title!,
          // subTitle: model.subTitle!,
          subTitle: "",
          onTap: model.onTap!,
          imageSize: 55,
          trailing:  Icon(
            getTextDirection(context.read<LanguageChangeViewModel>()) == TextDirection.rtl
                ? Icons.keyboard_arrow_left_outlined
                : Icons.keyboard_arrow_right_outlined,
            color: Colors.grey,
          ),
        ),
      );
    }

    setState(() {}); // Trigger rebuild after updating lists
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSmallSpace,
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.scoPrograms,
                style: AppTextStyles.appBarTitleStyle().copyWith(fontSize: 20),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),kMinorSpace,
          Column(
            children: [
              // carousel slider
              if (_scoProgramsList.isNotEmpty)
                CustomCarouselSlider(
                  height: 75,
                  items: _scoProgramsList,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _scoProgramCurrentIndex = index;
                    });
                  },
                ),
              kSmallSpace, // animated moving dots
              Row(
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
      ),
    );
  }
}
