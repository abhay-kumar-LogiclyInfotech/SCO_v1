
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import '../../l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/models/home/ScoProgramsTileModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
import 'package:sco_v1/resources/components/carsousel_slider.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_vertical_divider.dart';
import 'package:sco_v1/resources/components/requests_count_container.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_faq_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_finance_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_requests_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_scholarship_applied_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_sco_programs_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_talk_to_my_advisor_view.dart';
import 'package:sco_v1/view/main_view/home_views/home_upload_documents_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_abroad/scholarship_in_abroad_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/scholarship_in_uae_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/view/main_view/services_views/finance.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/salaryDetailsView.dart';
import 'package:sco_v1/view/main_view/services_views/request_view.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';

import '../../hive/hive_manager.dart';
import '../../models/services/MyFinanceStatusModel.dart';
import '../../resources/app_colors.dart';
import '../../resources/cards/home_view_card.dart';
import '../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../viewModel/drawer/news_and_events_viewModel.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../../viewModel/services/alert_services.dart';
import 'home_views/home_announcements_view.dart';
import 'home_views/home_apply_for_scholarship_view.dart';
import 'home_views/home_news_carousel_slider_view.dart';
import 'home_views/home_scholarship_approved_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with MediaQueryMixin<HomeView> {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late AlertServices _alertServices;

  bool isLogged = false;

  /// Get Roles
  UserRole? role;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    try {
      setProcessing(true);


      /// Check if the user is logged in
      isLogged = await _authService.isLoggedIn();
      setState(() {});

      // Getting Fresh Roles
      final getRolesProvider = Provider.of<GetRoleViewModel>(context, listen: false);
      await getRolesProvider.getRoles();
      role = getRoleFromList(HiveManager.getRole());



      final profilePictureProvider = Provider.of<GetProfilePictureUrlViewModel>(context, listen: false);

      /// Fetching profile picture url
      await profilePictureProvider.getProfilePictureUrl();
      setState(() {
        // Update state to reflect that notifications count is loaded
      });
      if (isLogged) {
        setProcessing(true);

        /// Fetch data from providers
        final myFinanceProvider = Provider.of<MyFinanceStatusViewModel>(context, listen: false);
        final requestsProvider = Provider.of<GetAllRequestsViewModel>(context, listen: false);
        final talkToMyAdvisor = Provider.of<GetMyAdvisorViewModel>(context, listen: false);
        final getNotificationsCount = Provider.of<GetNotificationsCountViewModel>(context, listen: false);
        final getAllNotificationProvider = Provider.of<GetAllNotificationsViewModel>(context, listen: false);
        try {
          // Fetch notifications count
          await getNotificationsCount.getNotificationsCount();
          setState(() {
            // Update state to reflect that notifications count is loaded
          });

          if (role == UserRole.scholarStudent) {
            // Fetch finance status
            await myFinanceProvider.myFinanceStatus();
            setState(() {
              // Update state to reflect that finance status is loaded
            });
            // Fetch requests
            await requestsProvider.getAllRequests();
            setState(() {
              // Update state to reflect that requests are loaded
            });

            // Fetch advisor data
            await talkToMyAdvisor.getMyAdvisor();
            setState(() {
              // Update state to reflect that advisor data is loaded
            });
          }

          // Fetch all notifications
          await getAllNotificationProvider.getAllNotifications();
          setState(() {
            // Update state to reflect that all notifications are loaded
          });

          context.read<NewsAndEventsViewmodel>().newsAndEvents(context: context);
        } catch (e) {
          // Handle exceptions for individual tasks or overall process
        } finally {
          setProcessing(false);
          setState(() {
            // Final UI refresh to ensure everything is up-to-date
          });
        }
      }

      setProcessing(false);
    } catch (error) {
      setProcessing(false);

      /// Handle any errors
      // print('Error during refresh: $error');
    }
    setProcessing(false);
  }

  bool isProcessing = false;

  setProcessing(value) {
    setState(() {
      isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Utils.modelProgressHud(processing: isProcessing, child: Utils.pageRefreshIndicator(child: _buildUI(), onRefresh: _onRefresh)));
  }

  // check for the scholarship status
  ScholarshipStatus scholarshipStatus = ScholarshipStatus.applyScholarship;

  Widget _buildUI() {
    // *-----Initialize the languageProvider-----*
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLogged && role == UserRole.applicants)
              Column(
                children: [
                  const HomeNewsCarouselSliderView(),
                  const HomeScholarshipAppliedView(), /// Scholarship applied container If a user is Applicant then show this and move the user to application statuses view
                  const HomeUploadDocumentsView(), /// AFTER SCHOLARSHIP APPLIED THIS WILL APPEAR IF THERE IS ANY APPROVED DOCUMENTS LIST AVAILABLE.
                  const HomeScoProgramsView(),
                  const HomeFaqView(),
                  kSmallSpace,
                ],
              ),
            if (!isLogged || role == UserRole.student || role == UserRole.user)
              Column(
                children: [
                  const HomeNewsCarouselSliderView(),
                  const HomeApplyForScholarshipView(),
                  const HomeScoProgramsView(),
                  const HomeFaqView(),
                  kSmallSpace,
                ],
              ),
            if (isLogged && role == UserRole.scholarStudent)
              Column(
                children: [
                  //// This will show the top salary only
                  // const HomeScholarshipApprovedView(),
                  const HomeAnnouncementsView(),
                  const HomeFinanceView(),
                  const HomeRequestsView(),
                  const HomeTalkToMyAdvisorView(),
                  kSmallSpace,
                ],
              ),
          ],
        ),
      ),
    );
  }

}



