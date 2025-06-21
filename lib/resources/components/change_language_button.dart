import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/app_urls.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModel/language_change_ViewModel.dart';
import '../app_colors.dart';
import 'custom_advanced_switch.dart';import '../../l10n/app_localizations.dart';


class ChangeLanguageButton extends StatefulWidget
{
   bool showBackButton;
  ChangeLanguageButton({super.key,this.showBackButton = false});

  @override
  State<ChangeLanguageButton> createState() => _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends State<ChangeLanguageButton> with MediaQueryMixin {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    _navigationServices = GetIt.instance.get<NavigationServices>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppUrls.displayLanguageToggleButton ? Directionality(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      child: SizedBox(
        width: screenWidth,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /// back button
            if(widget.showBackButton) InkResponse(
              splashColor: Colors.green,
              onTap: () {
                _navigationServices.goBack();
              },
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const  Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    weight: 1,
                    fill: 1,
                  ),
                  Text( AppLocalizations.of(context)?.back ?? 'Back',style: const TextStyle(color: Colors.black),),
                ],
              ),
            ),

            /// language change button
           widget.showBackButton ?  Expanded(
              child: newChangeLanguageWidget(),
            ) : newChangeLanguageWidget(),
          ],
        ),
      ),
    ) : showVoid;
  }

}
Widget changeLanguageButtonWidget(){
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text("English",style: TextStyle(color: Colors.black),),
      const SizedBox(
        width: 10,
      ),
      Consumer<LanguageChangeViewModel>(
        builder: (context, provider, _) {
          return CustomAdvancedSwitch(
            controller: provider.languageController,
            activeColor: AppColors.scoThemeColor,
            inactiveColor: Colors.grey,
            initialValue: provider.languageController.value,
            onChanged: (value) async {
              if (value) {
                context
                    .read<LanguageChangeViewModel>()
                    .changeLanguage(const Locale('ar'));
              } else {
                context
                    .read<LanguageChangeViewModel>()
                    .changeLanguage(const Locale('en'));
              }
            },
          );
        },
      ),
      const SizedBox(width: 10),
      const  Text("عربي",style: TextStyle(color: Colors.black),),
    ],
  );
}

Widget newChangeLanguageWidget(){
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Consumer<LanguageChangeViewModel>(
        builder: (context, provider, _) {
          return MaterialButton(onPressed: (){
            if (context.read<LanguageChangeViewModel>().appLocale == const Locale('en')) {
              context.read<LanguageChangeViewModel>().changeLanguage(const Locale('ar'));
            } else {
              context.read<LanguageChangeViewModel>().changeLanguage(const Locale('en'));
            }
          },
              color: AppColors.scoThemeColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              visualDensity: VisualDensity.compact,
          child: Text(context.read<LanguageChangeViewModel>().appLocale == const Locale('en') ? "عربي" : "English",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)
          );
        },
      ),
    ],
  );
}
