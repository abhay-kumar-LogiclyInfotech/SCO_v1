import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/cards/home_view_card.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../l10n/app_localizations.dart';

import '../../drawer/custom_drawer_views/faq_view.dart';


class HomeFaqView extends StatefulWidget {
  const HomeFaqView({super.key});

  @override
  State<HomeFaqView> createState() => _HomeFaqViewState();
}

class _HomeFaqViewState extends State<HomeFaqView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        kHomeCardSpace,
        HomeViewCard(
            title: localization.faqs,
            contentPadding:  EdgeInsets.zero,
            icon: SvgPicture.asset("assets/support/support_1_0_1/FAQ.svg",height: 20,width: 20,),

            content: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Text(
                //   localization.frequentlyAskedQuestions,
                //   style: AppTextStyles.titleTextStyle(),
                // )
              ],
            ),
            langProvider: langProvider,
            onTap: () {
              // Navigate to FAQ page
              _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => const FaqView()));
            }),
      ],
    );
  }
}
