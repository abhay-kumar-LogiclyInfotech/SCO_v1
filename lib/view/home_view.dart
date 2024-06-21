import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../viewModel/language_change_ViewModel.dart';

enum Language { english, spanish }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      body: Column(
        children: [
          Directionality(textDirection: TextDirection.rtl, child: TextField(
            decoration: InputDecoration(
              suffix: Icon(Icons.email,color: Colors.grey ,),
              prefix: Icon(Icons.local_airport)
            ),
          ))
        ],
      ),
    );
  }
}
