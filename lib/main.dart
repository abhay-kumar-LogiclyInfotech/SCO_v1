import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sco_v1/utils/utils.dart'; import '../../../../resources/app_urls.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'l10n/app_localizations.dart';
import 'viewModel/view_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/dependency_injection.dart';
import 'hive/hive_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();


  await HiveManager.init();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String languageCode = sharedPreferences.getString('language_code') ?? '';
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  DependencyInjection.init();
  await registerServices();
  runApp(MyApp(locale: languageCode));
}

class MyApp extends StatefulWidget {
  late NavigationServices _navigationServices;

  final String locale;

   MyApp({super.key, required this.locale}) {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          /// Always register language viewmodel first
          ChangeNotifierProvider(create: (_) => LanguageChangeViewModel()),
          ChangeNotifierProvider(create: (_) => CommonDataViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
          ChangeNotifierProvider(create: (_) => SignupViewModel()),
          ChangeNotifierProvider(create: (_) => OtpVerificationViewModel()),
          ChangeNotifierProvider(create: (_) => UpdateSecurityQuestionViewModel()),
          ChangeNotifierProvider(create: (_) => TermsAndConditionsViewModel()),
          ChangeNotifierProvider(create: (_) => SecurityQuestionViewModel()),
          ChangeNotifierProvider(create: (_) => FaqViewModel()),
          ChangeNotifierProvider(create: (_) => VisionAndMissionViewModel()),
          ChangeNotifierProvider(create: (_) => NewsAndEventsViewmodel()),
          ChangeNotifierProvider(create: (_) => IndividualImageViewModel()),
          ChangeNotifierProvider(create: (_) => ABriefAboutScoViewModel()),
          ChangeNotifierProvider(create: (_) => HomeSliderViewModel()),

          // Account
          ChangeNotifierProvider(create: (_) => GetPersonalDetailsViewModel()),

          // find Draft by Configuration Key
          ChangeNotifierProvider(create: (_) => FindDraftByConfigurationKeyViewmodel()),

          // find Draft by Draft ID Key
          ChangeNotifierProvider(create: (_) => FindDraftByDraftIdViewmodel()),

          // delete Draft
          ChangeNotifierProvider(create: (_) => DeleteDraftViewmodel()),
          // attachFile
          ChangeNotifierProvider(create: (_) => AttachFileViewmodel()),
          // get list of applications with statuses
          ChangeNotifierProvider(create: (_) => GetListApplicationStatusViewModel()),

          // get My Scholarship
          ChangeNotifierProvider(create: (_) => MyScholarshipViewModel()),

          // save as draft
          ChangeNotifierProvider(create: (_) => SaveAsDraftViewmodel()),

          // find all active scholarships
          ChangeNotifierProvider(create: (_) => GetAllActiveScholarshipsViewModel()),

          // submit application view model registration
          ChangeNotifierProvider(create: (_) => SubmitApplicationViewmodel()),


          // My Finance Status
          ChangeNotifierProvider(create: (_) => MyFinanceStatusViewModel()),

          // Get All Requests
          ChangeNotifierProvider(create: (_) => GetAllRequestsViewModel()),

          // create service Requests
          ChangeNotifierProvider(create: (_) => CreateRequestViewModel()),

          // Get All Academic Advisor's
          ChangeNotifierProvider(create: (_) => GetMyAdvisorViewModel()),

          // Get Employment Status
          ChangeNotifierProvider(create: (_) => GetEmploymentStatusViewModel()),

          // GetEmployment Status base64String
          ChangeNotifierProvider(create: (_) => GetBase64StringViewModel()),


          // Get profile picture Url
          ChangeNotifierProvider(create: (_) => GetProfilePictureUrlViewModel()),

          // Update Profile Picture Url
          ChangeNotifierProvider(create: (_) => UpdateProfilePictureViewModel()),


          // get Notifications count
          ChangeNotifierProvider(create: (_) => GetNotificationsCountViewModel()),

          // get Page content by url
          ChangeNotifierProvider(create: (_) => GetPageContentByUrlViewModel()),

          // get All Notes
          ChangeNotifierProvider(create: (_) => GetAllNotesViewModel()),

          // get Specific Note Details
          ChangeNotifierProvider(create: (_) => GetSpecificNoteDetailsViewModel()),

          // upload attachment to Note
          ChangeNotifierProvider(create: (_) => UploadAttachmentToNoteViewModel()),

          // get all notifications
          ChangeNotifierProvider(create: (_) => GetAllNotificationsViewModel()),

          // decrease notification count
          ChangeNotifierProvider(create: (_) => DecreaseNotificationCountViewModel()),

          // get Roles
          ChangeNotifierProvider(create: (_) => GetRoleViewModel()),

          // Get submitted application details
          ChangeNotifierProvider(create: (_) => GetSubmittedApplicationDetailsByApplicationNumberViewModel()),

          // get application sections of applied scholarship application
          ChangeNotifierProvider(create: (_) => GetApplicationSectionViewModel()),

          // get Uploaded list of attachments
          ChangeNotifierProvider(create: (_) => GetListOfAttachmentsViewModel()),


          /// Uploading and updating approved attachment
          ChangeNotifierProvider(create: (_) => UploadUpdateAttachmentViewModel()),

          /// Edit Peoplesoft application sections
          ChangeNotifierProvider(create: (_) => EditApplicationSectionsViewModel()),
        ],
        child: Consumer<LanguageChangeViewModel>(
          builder: (context, provider, _) {
            if (provider.appLocale == null) {
              if (widget.locale.isEmpty) {
                provider.changeLanguage(const Locale('ar'));
              } else {
                provider.changeLanguage(Locale(widget.locale));
              }
            }
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SCO',
              locale: provider.appLocale,
              themeMode: ThemeMode.light,

              //when enters the app;
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppUrls.displayLanguageToggleButton ? const [Locale('en'), Locale('ar')] : const [Locale('ar')] ,
              theme: ThemeData(fontFamily: 'droidArabicKufi',
                scaffoldBackgroundColor: AppColors.bgColor
              ),

              navigatorKey: widget._navigationServices.navigationStateKey,
              routes: widget._navigationServices.routes,
              initialRoute: "/splashView",
              // Add the diagonal banner via builder
              builder: (context, child) {
                Widget app = child ?? const SizedBox();
                if (AppUrls.displayStagingBanner) {
                  app = Banner(
                    message: 'STAGING',
                    location: getTextDirection(provider) == TextDirection.ltr ? BannerLocation.topEnd : BannerLocation.topStart,
                    color: AppColors.scoThemeColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
                    child: app,
                  );
                }
                return app;
              },
            );
          },
        ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}