import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../../utils/utils.dart';
import '../../app_colors.dart';
import '../custom_button.dart';
import '../../../l10n/app_localizations.dart';


class KReturnButton extends StatefulWidget {
  const KReturnButton({super.key});

  @override
  State<KReturnButton> createState() => _KReturnButtonState();
}

class _KReturnButtonState extends State<KReturnButton> {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return CustomButton(
        buttonName: localization.back,
        isLoading: false,
        borderColor: AppColors.scoThemeColor,
        buttonColor: Colors.white,
        textDirection: getTextDirection(langProvider),
        textColor: AppColors.scoThemeColor,
        onTap: () async {
          _navigationServices.goBack();
        });
  }
}
