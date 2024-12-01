import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/tiles/simple_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/contact_us_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../models/account/simple_tile_model.dart';
import '../../resources/app_colors.dart';
import '../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> with MediaQueryMixin {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;

    final supportItemsMapList = [
      {
        'title': localization.contactUs,
        'assetAddress': "assets/support/contact_us.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ContactUsView()))
      },

      {
        'title': localization.faqs,
        'assetAddress': "assets/support/faq.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const FaqView()))
      },
      {
        'title': localization.academic_advisor,
        'assetAddress': "assets/support/advisor_contact_details.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const AcademicAdvisorView()))
      },
    ];

    List<SimpleTileModel> itemsList = [];

    for (var element in supportItemsMapList) {
      itemsList.add(SimpleTileModel.fromJson(element));
    }

    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {

         final item = itemsList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleTile(item: item),
          );
        },
      ),
    );
  }
}
