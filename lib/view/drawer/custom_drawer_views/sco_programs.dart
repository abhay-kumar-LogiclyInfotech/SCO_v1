import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/custom_sco_program_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../resources/app_colors.dart';
import '../../../viewModel/services/navigation_services.dart';

class ScoPrograms extends StatefulWidget {
  const ScoPrograms({super.key});

  @override
  State<ScoPrograms> createState() => _ScoProgramsState();
}

class _ScoProgramsState extends State<ScoPrograms>
    with MediaQueryMixin<ScoPrograms> {
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
          title: Text(
        AppLocalizations.of(context)!.scoPrograms,
        style: AppTextStyles.appBarTitleStyle(),
      )),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final provider = Provider.of<LanguageChangeViewModel>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomScoProgramTile(
              textDirection: getTextDirection(provider),
              imagePath: "assets/sidemenu/distinguished_doctors.jpg",
              title: "Scholarships in Abroad",
              subTitle:
                  "The office, which was establishe in 1999 under the direct..",
              onTap: () {});
        },
      ),
    );
  }
}
