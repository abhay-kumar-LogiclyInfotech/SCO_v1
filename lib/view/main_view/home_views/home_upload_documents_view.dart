import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/myDivider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class HomeUploadDocumentsView extends StatefulWidget {
  const HomeUploadDocumentsView({super.key});

  @override
  State<HomeUploadDocumentsView> createState() =>
      _HomeUploadDocumentsViewState();
}

class _HomeUploadDocumentsViewState extends State<HomeUploadDocumentsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return const Column(
      children: [
        // kSmallSpace,
        // CustomInformationContainer(
        //     leading: SvgPicture.asset("assets/myDocuments.svg"),
        //     title: localization.uploadDocuments,
        //     expandedContent: Column(
        //       children: [
        //         const SizedBox(height: 25),
        //         Text(localization.myDocuments,
        //             style: AppTextStyles.titleBoldTextStyle()
        //                 .copyWith(height: 1.9)),
        //         Text(
        //           localization.clickToUploadDocuments,
        //           style: const TextStyle(height: 1.5),
        //         ),
        //         const SizedBox(height: 25),
        //         const MyDivider(color: AppColors.darkGrey),
        //         const SizedBox(height: 30),
        //         CustomButton(
        //             buttonName: localization.clickHere,
        //             isLoading: false,
        //             buttonColor: AppColors.scoButtonColor,
        //             textDirection: getTextDirection(langProvider),
        //             onTap: () {
        //               _alertServices.toastMessage(
        //                 AppLocalizations.of(context)!.comingSoon,
        //               );
        //             }),
        //         const SizedBox(height: 30),
        //       ],
        //     )),
      ],
    );
  }
}
