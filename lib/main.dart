import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/view/test.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/get_submitted_application_details_by_applicaion_number_viewModel.dart';
import 'package:sco_v1/viewModel/account/get_base64String_viewModel.dart';
import 'package:sco_v1/viewModel/account/get_employment_status_viewModel.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_profile_picture_viewModel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/FetchDraftByConfigurationKeyViewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/attach_file_viewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/deleteDraftViewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/find_draft_by_draft_id_viewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/saveAsDraftViewmodel.dart';
import 'package:sco_v1/viewModel/apply_scholarship/submitApplicationViewmodel.dart';
import 'package:sco_v1/viewModel/authentication/forgot_password_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/get_roles_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/login_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/otp_verification_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/security_question_ViewModel.dart';
import 'package:sco_v1/viewModel/authentication/signup_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/terms_and_conditions_viewModel.dart';
import 'package:sco_v1/viewModel/authentication/update_security_question_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/a_brief_about_sco_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/faq_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/individual_image_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/news_and_events_viewModel.dart';
import 'package:sco_v1/viewModel/drawer/vision_and_mission_viewModel.dart';
import 'package:sco_v1/viewModel/get_page_content_by_urls_viewModels/Internal/get_page_content_by_url_viewModel.dart';
import 'package:sco_v1/viewModel/home/home_slider_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/decrease_notification_count_viewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import 'package:sco_v1/viewModel/services/getIt_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:sco_v1/viewModel/services_viewmodel/create_request_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/get_all_notes_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/get_specific_note_details_view_Model.dart';
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/upload_attachment_to_note_viewModel.dart';
import 'package:sco_v1/viewModel/splash_viewModels/commonData_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Test.dart';
import 'controller/dependency_injection.dart';
import 'hive/hive_manager.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

          // register Test ViewModel
          // ChangeNotifierProvider(create: (_) => TestApi()),
        ],
        child: Consumer<LanguageChangeViewModel>(
          builder: (context, provider, _) {
            if (provider.appLocale == null) {
              if (widget.locale.isEmpty) {
                provider.changeLanguage(const Locale('en'));
              } else {
                provider.changeLanguage(Locale(widget.locale));
              }
            }
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
            // return MaterialApp(
              title: 'SCO',
              // locale: locale == ''
              //     ? const Locale('en')
              //     : provider.appLocale == null
              //         ? Locale(locale)
              //         : Provider.of<LanguageChangeViewModel>(context).appLocale,
              locale: provider.appLocale,
              //when enters the app;
              localizationsDelegates: const [
                // AppLocalizations.delegate,
                // GlobalMaterialLocalizations.delegate,
                // // GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,

                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('ar')],
              theme: ThemeData(
                fontFamily: 'droidArabicKufi',
                // textTheme: GoogleFonts.robotoTextTheme(),
                // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                // useMaterial3: true,
              ),
              navigatorKey: widget._navigationServices.navigationStateKey,
              routes: widget._navigationServices.routes,
              initialRoute: "/splashView",
              // home: TestView()
            );
          },
        ));
  }
}