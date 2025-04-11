import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../resources/components/custom_button.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../apply_scholarship/select_scholarship_type_view.dart';
import '../../authentication/login/login_view.dart';
import '../../../l10n/app_localizations.dart';


class HomeApplyForScholarshipView extends StatefulWidget {
  const HomeApplyForScholarshipView({super.key});

  @override
  State<HomeApplyForScholarshipView> createState() => _HomeApplyForScholarshipViewState();
}

class _HomeApplyForScholarshipViewState extends State<HomeApplyForScholarshipView> with MediaQueryMixin{


  late NavigationServices _navigationServices;
  late AuthService _authService;

  @override
  void initState() {
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return HomeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        // icon: SvgPicture.asset("assets/sco_office.svg"),
        showTitle: false,
        content: Column(
          children: [
            kSmallSpace,
            Consumer(
              builder: (context, provider, _) {
                return CustomButton(
                  buttonName: localization.apply_for_scholarship,
                  isLoading: false,
                  onTap: () async {
                    // check if user is logged in or not
                    final bool alreadyLoggedIn =
                    await _authService.isLoggedIn();
                    if (!alreadyLoggedIn) {
                      _navigationServices.goBackUntilFirstScreen();
                      _navigationServices.pushCupertino(CupertinoPageRoute(
                          builder: (context) => const LoginView()));
                    } else {
                      _navigationServices.pushSimpleWithAnimationRoute(
                          createRoute(const SelectScholarshipTypeView()));
                    }
                  },
                  textDirection: getTextDirection(langProvider),
                  textColor: AppColors.scoThemeColor,
                  borderColor: AppColors.scoThemeColor,
                  buttonColor: Colors.white,
                  fontSize: 16,
                  height: 45,
                );
              },
            ),
            kSmallSpace,
          ],
        ));
  }
}
