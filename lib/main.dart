import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/view/authentication/forgot_password/answer_security_question_view.dart';
import 'package:sco_v1/view/authentication/forgot_password/confirmation_view.dart';
import 'package:sco_v1/view/authentication/forgot_password/forgot_password_view.dart';
import 'package:sco_v1/view/authentication/forgot_password/forgot_security_question_otp_verification_view.dart';
import 'package:sco_v1/view/authentication/signup/signup_otp_verification_view.dart';
import 'package:sco_v1/view/authentication/signup/terms_and_conditions_view.dart';
import 'package:sco_v1/view/authentication/signup/update_security_question_view.dart';
import 'package:sco_v1/view/main_view.dart';
import 'package:sco_v1/viewModel/authentication/security_question_ViewModel.dart';
import 'package:sco_v1/viewModel/authentication/signup_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/faq_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/vision_and_mission_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/getIt_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:sco_v1/viewModel/splash_viewModels/commonData_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Test.dart';
import 'hive/hive_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveManager.init();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String languageCode =
      sharedPreferences.getString('language_code') ?? '';
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  await setup();
  runApp(MyApp(locale: languageCode));
}

Future<void> setup() async {
  bool isRegistered = await registerServices();
  if (isRegistered) {
    debugPrint(
        "In main file:---------------->>>>>>>>>>>>>>>>>> All Services Registered Successfully");
  } else {
    debugPrint(
        "In main file:---------------->>>>>>>>>>>>>>>>>>Services not Registered");
  }
}

late NavigationServices _navigationServices;
final GetIt getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  final String locale;

  MyApp({super.key, required this.locale}) {
    _navigationServices = getIt.get<NavigationServices>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CommonDataViewModel()),
          ChangeNotifierProvider(create: (_) => LanguageChangeViewModel()),
          ChangeNotifierProvider(create: (_) => SignupViewModel()),
          ChangeNotifierProvider(create: (_) => SecurityQuestionViewModel()),
          ChangeNotifierProvider(create: (_) => FaqViewModel()),
          ChangeNotifierProvider(create: (_) => VisionAndMissionViewModel()),

        ],
        child: Consumer<LanguageChangeViewModel>(
          builder: (context, provider, _) {
            if (provider.appLocale == null) {
              if (locale.isEmpty) {
                provider.changeLanguage(const Locale('en'));
              } else {
                provider.changeLanguage(Locale(locale));
              }
            }
            return MaterialApp(
              title: 'SCO',
              // locale: locale == ''
              //     ? const Locale('en')
              //     : provider.appLocale == null
              //         ? Locale(locale)
              //         : Provider.of<LanguageChangeViewModel>(context).appLocale,
              locale: provider.appLocale,

              //when enters the app;
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                // GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('ar')],
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme(),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              navigatorKey: _navigationServices.navigationStateKey,
              routes: _navigationServices.routes,
              initialRoute: "/splashView",

              // home:  Test()
            );
          },
        ));
  }
}

