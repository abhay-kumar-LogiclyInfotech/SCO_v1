import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/user_info_container.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_view.dart';


class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> with MediaQueryMixin<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.emailAddress),
        actions: [
          Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
            return PopupMenuButton(
                onSelected: (Language item) {
                  if (Language.english.name == item.name) {
                    provider.changeLanguage(const Locale('en'));

                  } else {
                    debugPrint('Arabic');
                    provider.changeLanguage(const Locale('ar'));
                  }
                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Language>>[
                  const PopupMenuItem(
                      value: Language.english, child: Text("English")),
                  const PopupMenuItem(
                      value: Language.spanish, child: Text("Arabic"))
                ]);
          })
        ],
      ),

      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //personal Information:
              _personalInformation(),

              //general information:
              _generalInformation()
            ],
          ),
        ),
      ),
    );
  }


  //personal Information:
  Widget _personalInformation() {
    return Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Static Text:
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: provider.appLocale == const Locale('en') ||
                            provider.appLocale == null
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Text(
                      AppLocalizations.of(context)!.personalInformation,
                      style: const TextStyle(
                          color: Color(0xff8591A9),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      UserInfoContainer(
                       title:  AppLocalizations.of(context)!.userName,
                        displayTitle: "Abhay Kumar",
                        textDirection:
                            provider.appLocale == const Locale('en') ||
                                    provider.appLocale == null
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                      ),
                      const Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                        title:                       AppLocalizations.of(context)!.location,

                        displayTitle: "Abhay Kumar",
                        textDirection:
                            provider.appLocale == const Locale('en') ||
                                    provider.appLocale == null
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                      ),
                     const Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.contactNumber,

                          displayTitle: "Abhay Kumar"),
                      const Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.emailId,

                          displayTitle: "Abhay Kumar"),
                     const  Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.password,

                          displayTitle: "Abhay Kumar"),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }

  Widget _generalInformation() {
    return Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Static Text:
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: provider.appLocale == const Locale('en') ||
                            provider.appLocale == null
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Text(
                      AppLocalizations.of(context)!.generalInformation,

                      style: const TextStyle(
                          color: Color(0xff8591A9),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const  EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.scholarship,

                          displayTitle: "Abhay Kumar"),
                     const  Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.country,

                          displayTitle: "Abhay Kumar"),
                     const  Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.state,

                          displayTitle: "Abhay Kumar"),
                     const  Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.address,
                          displayTitle: "Abhay Kumar"),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
