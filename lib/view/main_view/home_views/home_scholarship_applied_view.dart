import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../services_views/finance_details_views/salaryDetailsView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScholarshipAppliedView extends StatefulWidget {
  const HomeScholarshipAppliedView({super.key});

  @override
  State<HomeScholarshipAppliedView> createState() =>
      _HomeScholarshipAppliedViewState();
}

class _HomeScholarshipAppliedViewState extends State<HomeScholarshipAppliedView> with MediaQueryMixin {

  late NavigationServices _navigationServices;

  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return HomeViewCard(
        onTap: () {
          _navigationServices.pushCupertino(CupertinoPageRoute(
              builder: (context) => const SalaryDetailsView()));
        },
        langProvider: langProvider,
        title: localization.scholarshipOffice,
        // icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            kSmallSpace,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Scholarship status:
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.scholarshipStatusApplied,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.hintDarkGrey),
                        textAlign: TextAlign.start,
                      ),
                      Text(localization.scholarshipAppliedApplied,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                // readMoreButton(
                //   langProvider: langProvider,
                //   onTap: () {
                //     _navigationServices.pushCupertino(CupertinoPageRoute(
                //         builder: (context) => const ApplicationStatusView()));
                //   },
                // )
              ],
            ),
            kSmallSpace,
          ],
        ));
  }
}
