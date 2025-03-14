import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_options.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/authentication/login/login_view.dart';
import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/main_view/notifications/notifications_view.dart';
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
import '../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../viewModel/drawer/individual_image_viewModel.dart';
import '../../viewModel/drawer/news_and_events_viewModel.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../../viewModel/services/alert_services.dart';
import '../drawer/custom_drawer_views/news_and_events_details_view.dart';

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

      /// Initialize the SCO programs carousel slider
      _scoProgramsModelsList.clear();
      _scoProgramsList.clear();
      _initializeScoPrograms();

      /// Check if the user is logged in
      isLogged = await _authService.isLoggedIn();
      setState(() {});

      // Getting Fresh Roles
      final getRolesProvider =
          Provider.of<GetRoleViewModel>(context, listen: false);
      await getRolesProvider.getRoles();
      role = getRoleFromList(HiveManager.getRole());
      final profilePictureProvider =
          Provider.of<GetProfilePictureUrlViewModel>(context, listen: false);

      /// Fetching profile picture url
      await profilePictureProvider.getProfilePictureUrl();
      setState(() {
        // Update state to reflect that notifications count is loaded
      });
      if (isLogged) {
        setProcessing(true);

        /// Fetch data from providers
        final myFinanceProvider =
            Provider.of<MyFinanceStatusViewModel>(context, listen: false);
        final requestsProvider =
            Provider.of<GetAllRequestsViewModel>(context, listen: false);
        final talkToMyAdvisor =
            Provider.of<GetMyAdvisorViewModel>(context, listen: false);
        final getNotificationsCount =
            Provider.of<GetNotificationsCountViewModel>(context, listen: false);
        final getAllNotificationProvider =
            Provider.of<GetAllNotificationsViewModel>(context, listen: false);
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

          context
              .read<NewsAndEventsViewmodel>()
              .newsAndEvents(context: context);
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
    /// Initialize the SCO programs carousel slider
    /// Currently we are clearing initializing again and again to show realtime language conversion
    _scoProgramsModelsList.clear();
    _scoProgramsList.clear();
    _initializeScoPrograms();

    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Utils.modelProgressHud(
            processing: isProcessing,
            child: Utils.pageRefreshIndicator(
                child: _buildUI(), onRefresh: _onRefresh)));
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
                  _scholarshipAppliedContainer(langProvider: langProvider),
                  _uploadDocumentsSection(langProvider: langProvider),
                  _faqSection(langProvider: langProvider),
                  kSmallSpace,
                ],
              ),
            if (!isLogged || role == UserRole.student || role == UserRole.user)
              Column(
                children: [
                  _carouselSlider(),
                  _applyScholarshipButton(langProvider: langProvider),
                  _scoPrograms(langProvider: langProvider),
                  _faqSection(langProvider: langProvider),
                  kSmallSpace,
                ],
              ),
            if (isLogged && role == UserRole.scholarStudent)
              Column(
                children: [
                  //// This will show the top salary only
                  _scholarshipApproved(langProvider: langProvider),
                  _announcements(langProvider: langProvider),
                  _financeView(langProvider: langProvider),
                  _requestView(langProvider: langProvider),
                  _talkToMyAdvisor(langProvider: langProvider),
                  kSmallSpace,
                ],
              ),
          ],
        ),
      ),
    );
  }

// *---Container for approved scholarships-----*
  Widget _scholarshipApproved({required LanguageChangeViewModel langProvider}) {
    final ltrDirection = getTextDirection(langProvider) == TextDirection.ltr;
    return Consumer<MyFinanceStatusViewModel>(
        builder: (context, financeStatusProvider, _) {
      switch (financeStatusProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.COMPLETED:
          final listOfSalaries =
              financeStatusProvider.apiResponse.data?.data?.listSalaryDetials ??
                  [];
          final topSalaryDetails =
              listOfSalaries.isNotEmpty ? listOfSalaries[0] : null;

          return Column(
            children: [
              // kFormHeight,
              _homeViewCard(
                  onTap: () {
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const SalaryDetailsView()));
                  },
                  langProvider: langProvider,
                  title: AppLocalizations.of(context)!.scholarshipOffice,
                  // icon: SvgPicture.asset('assets/sco_office.svg'),
                  content: Column(
                    children: [
                      // Amount and Read More Button
                      Padding(
                        padding: EdgeInsets.only(
                          left: ltrDirection ? 25 : 0,
                          right: ltrDirection ? 0 : 25,
                          top: 10,
                        ),
                        child: _buildAmountAndButton(
                            langProvider: langProvider,
                            topSalary: topSalaryDetails),
                      ),

                      if ((topSalaryDetails?.salaryMonth ?? '').isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 5),
                            const Divider(),
                            const SizedBox(height: 5),
                            // Date Information
                            _buildDateInfo(
                                langProvider: langProvider,
                                date: topSalaryDetails?.salaryMonth),
                          ],
                        ),
                    ],
                  )),
            ],
          );
        case Status.NONE:
          return showVoid;
        case null:
          showVoid;
      }
      return showVoid;
    });
  }

  Widget _announcements({required LanguageChangeViewModel langProvider}) {
    return Consumer<GetAllNotificationsViewModel>(
        builder: (context, allNotificationsProvider, _) {
      switch (allNotificationsProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.COMPLETED:
          // Check if there's any notification with `isNew == true`
          final hasNewNotification =
              allNotificationsProvider.apiResponse.data?.any(
                    (notification) => notification.isNew == true,
                  ) ??
                  false;

// Get the first notification with `isNew == true` if available
          final firstNotification = hasNewNotification
              ? allNotificationsProvider.apiResponse.data?.firstWhere(
                  (notification) => notification.isNew == true,
                )
              : null;

          return hasNewNotification
              ? Column(
                  children: [
                    kSmallSpace,
                    _homeViewCard(
                      onTap: () {
                        _navigationServices.pushCupertino(CupertinoPageRoute(
                            builder: (context) => const NotificationsView()));
                      },
                      title: AppLocalizations.of(context)!.announcement,
                      icon: SvgPicture.asset("assets/announcements.svg"),
                      langProvider: langProvider,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kFormHeight,
                          Text(
                            firstNotification?.subject ?? '',
                            style: AppTextStyles.titleTextStyle()
                                .copyWith(fontSize: 15),
                          ),
                          kFormHeight,
                          const Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey.shade400,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                convertTimestampToDate(
                                    firstNotification?.createDate ?? 0),
                                style: AppTextStyles.subTitleTextStyle()
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                convertTimestampToTime(
                                    firstNotification?.createDate ?? 0),
                                style: AppTextStyles.subTitleTextStyle()
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : showVoid;
        case Status.NONE:
          return showVoid;
        case null:
          return showVoid;
      }
    });
  }

  /// Tile to show this month salary and will be shown only when student is scholar
  Widget _buildAmountAndButton(
      {required LanguageChangeViewModel langProvider,
      required ListSalaryDetials? topSalary}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Amount Information
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: topSalary?.amount.toString() ?? "0",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0B9967),
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(
                          width: 4), // Adds spacing between amount and currency
                    ),
                    TextSpan(
                      text: topSalary?.currency.toString() ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff0B9967),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
        // Read More Button
        // readMoreButton(
        //     langProvider: langProvider,
        //     onTap: () {
        //       _navigationServices.pushCupertino(CupertinoPageRoute(
        //           builder: (context) => const SalaryDetailsView()));
        //     }),
      ],
    );
  }

  Widget _buildDateInfo(
      {required LanguageChangeViewModel langProvider, required dynamic date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_month_outlined, color: Color(0xffA7B0C1)),
        const SizedBox(width: 5),
        Text(
          date ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.hintDarkGrey,
          ),
        ),
        // SizedBox(width: 5),
        // Text(
        //   "(12 mon)",
        //   style: TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.w400,
        //     color: Color(0xff8591A7),
        //   ),
        // ),
      ],
    );
  }

  // *---- Scholarship applied container If a user is Applicant then show this and move the user to application statuses view ----*
  Widget _scholarshipAppliedContainer(
      {required LanguageChangeViewModel langProvider}) {
    final localization = AppLocalizations.of(context)!;
    return _homeViewCard(
        onTap: () {
          _navigationServices.pushCupertino(CupertinoPageRoute(
              builder: (context) => const SalaryDetailsView()));
        },
        langProvider: langProvider,
        title: localization.scholarshipOffice,
        // icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            kSmallSpace,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Scholarship status:
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.scholarshipStatusApplied,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.hintDarkGrey),
                        textAlign: TextAlign.start,
                      ),
                      Text(localization.scholarshipAppliedApplied,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                // readMoreButton(
                //   langProvider: langProvider,
                //   onTap: () {
                //     _navigationServices.pushCupertino(CupertinoPageRoute(
                //         builder: (context) => const ApplicationStatusView()));
                //   },
                // )
              ],
            ),
            kSmallSpace,
          ],
        ));
  }

  /// AFTER SCHOLARSHIP APPLIED THIS WILL APPEAR IF THERE IS ANY APPROVED DOCUMENTS LIST AVAILABLE.
  Widget _uploadDocumentsSection(
      {required LanguageChangeViewModel langProvider}) {
    return Column(
      children: [
        kSmallSpace,
        // CustomInformationContainer(
        //     leading: SvgPicture.asset("assets/myDocuments.svg"),
        //     title: localization.uploadDocuments,
        //     expandedContent: Column(
        //       children: [
        //         const SizedBox(height: 25),
        //         Text(localization.myDocuments,
        //             style: AppTextStyles.titleBoldTextStyle()
        //                 .copyWith(height: 1.9)),
        //         Text(
        //           localization.clickToUploadDocuments,
        //           style: const TextStyle(height: 1.5),
        //         ),
        //         const SizedBox(height: 25),
        //         const MyDivider(color: AppColors.darkGrey),
        //         const SizedBox(height: 30),
        //         CustomButton(
        //             buttonName: localization.clickHere,
        //             isLoading: false,
        //             buttonColor: AppColors.scoButtonColor,
        //             textDirection: getTextDirection(langProvider),
        //             onTap: () {
        //               _alertServices.toastMessage(
        //                 AppLocalizations.of(context)!.comingSoon,
        //               );
        //             }),
        //         const SizedBox(height: 30),
        //       ],
        //     )),
      ],
    );
  }

  Widget readMoreButton({required langProvider, required onTap}) => SizedBox(
        width: screenWidth * 0.35,
        child: CustomButton(
          buttonName: AppLocalizations.of(context)!.readMore,
          isLoading: false,
          onTap: onTap,
          textDirection: getTextDirection(langProvider),
          textColor: const Color(0xffAD8138),
          borderColor: const Color(0xffAD8138),
          buttonColor: Colors.white,
          fontSize: 14,
          height: 40,
        ),
      );

  // Apply Scholarship Button
  Widget _applyScholarshipButton(
      {required LanguageChangeViewModel langProvider}) {
    final localization = AppLocalizations.of(context)!;

    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        // icon: SvgPicture.asset("assets/sco_office.svg"),
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

  /// Finance View:
  Widget _financeView({required LanguageChangeViewModel langProvider}) {
    return Consumer<MyFinanceStatusViewModel>(
        builder: (context, financeStatusProvider, _) {
      switch (financeStatusProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.NONE:
          return showVoid;
        case Status.COMPLETED:
          final financeData = financeStatusProvider.apiResponse.data?.data;
          final salary = financeData?.listSalaryDetials?.isNotEmpty == true
              ? financeData?.listSalaryDetials?.first
              : null;
          final deduction = financeData?.listDeduction?.isNotEmpty == true
              ? financeData?.listDeduction?.first
              : null;
          final bonus = financeData?.listBonus?.isNotEmpty == true
              ? financeData?.listBonus?.first
              : null;
          final warning = financeData?.listWarnings?.isNotEmpty == true
              ? financeData?.listWarnings?.first
              : null;
          return Column(
            children: [
              kSmallSpace,
              _homeViewCard(
                  onTap: () {
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const FinanceView()));
                  },
                  contentPadding: EdgeInsets.zero,
                  title: AppLocalizations.of(context)!.myFinance,
                  icon: SvgPicture.asset("assets/my_finance.svg"),
                  langProvider: langProvider,
                  content: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      kSmallSpace,
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _financeElements(
                              salary: salary,
                              deduction: deduction,
                              bonus: bonus),
                        ),
                      ),
                      // warning
                      // Text(
                      //  AppLocalizations.of(context)!.warning,
                      //   style: AppTextStyles.subTitleTextStyle()
                      //       .copyWith(fontWeight: FontWeight.bold),
                      // ),
                      if ((warning?.termDescription ?? '').isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 15,
                                  left: kCardPadding,
                                  right: kCardPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.warning,
                                      style: AppTextStyles.subTitleTextStyle()
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Text(
                                    warning!.termDescription!,
                                    // Using `!` because the null check ensures it's safe
                                    style: AppTextStyles.titleBoldTextStyle()
                                        .copyWith(fontSize: 18),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  )),
            ],
          );
        case null:
          return showVoid;
      }
    });
  }

  List<Widget> _financeElements({salary, deduction, bonus}) {
    return [
      _financeAmount(
        // titleColor: const Color(0xffEC6330),
        iconAddress: "assets/salary_icon.svg",
        title: AppLocalizations.of(context)!.salary,
        subTitle: salary?.amount.toString() ?? '0',
      ),
      CustomVerticalDivider(height: 35),
      _financeAmount(
        // titleColor: const Color(0xff3A82F7),
        iconAddress: "assets/deduction_icon.svg",
        title: AppLocalizations.of(context)!.deduction,
        subTitle: deduction?.totalDeducted.toString() ?? '0',
      ),
      CustomVerticalDivider(height: 35),
      _financeAmount(
        // titleColor: const Color(0xff67CE67),
        iconAddress: "assets/bonus_icon.svg",
        title: AppLocalizations.of(context)!.bonus,
        subTitle: bonus?.amount.toString() ?? '0',
      ),
    ];
  }

  Widget _financeAmount(
      {String title = "",
      String iconAddress = '',
      String subTitle = "",
      Color titleColor = AppColors.scoButtonColor}) {
    // Condition to check if the subtitle is at least 5 characters long
    String displayedSubtitle = (subTitle.length >= 5)
        ? "${subTitle.substring(0, 5)}+" // Extract first 5 characters
        : subTitle ??
            ""; // Fallback if subtitle is null or shorter than 5 characters

    return Container(
      width: screenWidth < 370 ? 80 : 100,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SvgPicture.asset(iconAddress),
          //     const SizedBox(width: 5),
          //     Text(
          //       title,
          //       style: TextStyle(
          //           color: titleColor, fontSize: 15, fontWeight: FontWeight.w600),
          //     ),
          //   ],
          // ),
          Text(
            textAlign: TextAlign.start,
            title,
            style: TextStyle(
                color: titleColor, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            displayedSubtitle,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  /// Request View:
  Widget _requestView({required LanguageChangeViewModel langProvider}) {
    return Consumer<GetAllRequestsViewModel>(
        builder: (context, requestsProvider, _) {
      switch (requestsProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.NONE:
          return showVoid;
        case Status.COMPLETED:
          final requests =
              requestsProvider.apiResponse.data?.data?.listOfRequest;
          final totalRequests =
              requestsProvider.apiResponse.data?.data?.listOfRequest?.length;
          final approvedRequests =
              requests?.where((r) => r.status == "APPROV")?.length ?? 0;
          final pendingRequests =
              requests?.where((r) => r.status == "RECVD")?.length ?? 0;
          final rejectedRequests =
              requests?.where((r) => r.status == "DENY")?.length ?? 0;
          return Column(
            children: [
              kSmallSpace,
              _homeViewCard(
                  title: AppLocalizations.of(context)!.requests,
                  icon: SvgPicture.asset("assets/request.svg"),
                  langProvider: langProvider,
                  // headerExtraContent: RequestsCountContainer(color: Colors.blue.shade600, count: totalRequests),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const RequestView()));
                  },
                  content: Column(
                    children: [
                      //  Padding(
                      //   padding: const EdgeInsets.only(left: 50.0,right: 50),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.totalNumberOfRequests,
                      //     style: const TextStyle(fontSize: 14, height: 2.5),
                      //   ),
                      // ),
                      // kFormHeight,
                      const SizedBox(height: 8),
                      const Divider(),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: screenWidth < 370
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _requestElementList(
                                    approvedRequests: approvedRequests,
                                    pendingRequests: pendingRequests,
                                    rejectedRequests: rejectedRequests),
                              )
                            : Row(
                                // crossAxisAlignment: WrapCrossAlignment.center,
                                // runAlignment: WrapAlignment.start,
                                // alignment: WrapAlignment.spaceAround,
                                // runSpacing: 10,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: _requestElementList(
                                    approvedRequests: approvedRequests,
                                    pendingRequests: pendingRequests,
                                    rejectedRequests: rejectedRequests),
                              ),
                      )
                      // kFormHeight,
                      // kFormHeight,
                    ],
                  )),
            ],
          );
        case null:
          return showVoid;
      }
    });
  }

  List<Widget> _requestElementList(
      {approvedRequests, pendingRequests, rejectedRequests}) {
    return [
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.approved,
          count: approvedRequests,
          color: Colors.green.shade500),
      screenWidth < 370
          ? const Divider()
          : CustomVerticalDivider(
              height: 35,
              color: Colors.transparent,
            ),
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.pending,
          count: pendingRequests,
          color: const Color(0xffF4AA73)),
      screenWidth < 370
          ? const Divider()
          : CustomVerticalDivider(
              height: 35,
              color: Colors.transparent,
            ),
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.rejected,
          count: rejectedRequests,
          color: AppColors.DANGER),
    ];
  }

  /// Req
  Widget _requestTypeWithCount(
      {String requestType = "",
      dynamic color = Colors.black,
      dynamic count = 0}) {
    final langProvider = context.read<LanguageChangeViewModel>();
    return Container(
      width: screenWidth < 370 ? double.infinity : 100,
      alignment: screenWidth < 370
          ? getTextDirection(langProvider) == TextDirection.rtl
              ? Alignment.centerRight
              : Alignment.centerLeft
          : Alignment.center,
      color: Colors.transparent,
      child: screenWidth < 370
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(requestType,
                      style: const TextStyle(
                          color: AppColors.scoButtonColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox.square(dimension: 5),
                RequestsCountContainer(color: color, count: count),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RequestsCountContainer(color: color, count: count),
                const SizedBox.square(dimension: 5),
                Text(requestType,
                    style: const TextStyle(
                        color: AppColors.scoButtonColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ],
            ),
    );
  }

  /// Talk to my Advisor View:
  Widget _talkToMyAdvisor({required LanguageChangeViewModel langProvider}) {
    return Consumer<GetMyAdvisorViewModel>(
      builder: (context, provider, _) {
        switch (provider.apiResponse.status) {
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.NONE:
            return showVoid;
          case Status.COMPLETED:
            final listOfAdvisors =
                provider.apiResponse.data?.data?.listOfAdvisor ?? [];
            final topAdvisor =
                listOfAdvisors.isNotEmpty ? listOfAdvisors[0] : null;

            return listOfAdvisors.isEmpty
                ? showVoid
                : Column(
                    children: [
                      kSmallSpace,
                      _homeViewCard(
                          onTap: () {
                            _navigationServices.pushCupertino(
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const AcademicAdvisorView()));
                          },
                          title: AppLocalizations.of(context)!.talkToMyAdvisor,
                          icon:
                              SvgPicture.asset("assets/talk_to_my_advisor.svg"),
                          langProvider: langProvider,
                          contentPadding: EdgeInsets.zero,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .youCanSeeListOfAdvisors,
                                  style: const TextStyle(
                                      fontSize: 14, height: 2.5),
                                ),
                              ),
                              // kFormHeight,
                              const Divider(),
                              _homeViewCardBottomContainer(
                                  padding: const EdgeInsets.all(10),
                                  backGroundColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // image of the academic advisor
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/login_bg.png")))),
                                          kFormHeight,

                                          /// Title and subtitle
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 120),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  topAdvisor?.advisorName ?? '',
                                                  style: AppTextStyles
                                                          .titleBoldTextStyle()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          height: 1.2),
                                                ),
                                                Text(
                                                    topAdvisor
                                                            ?.advisorRoleDescription
                                                            ?.toString() ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// call and message buttons
                                      Expanded(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: 200, maxWidth: 200),
                                          child: Wrap(
                                            runSpacing: 0,
                                            spacing: -30,
                                            runAlignment: WrapAlignment.end,
                                            alignment: WrapAlignment.end,
                                            children: [
                                              // message Advisor
                                              CustomMaterialButton(
                                                  onPressed: () async {
                                                    await Utils.launchEmail(
                                                        topAdvisor?.email ??
                                                            '');
                                                  },
                                                  isEnabled: false,
                                                  shape: const CircleBorder(),
                                                  child: SvgPicture.asset(
                                                      "assets/message_advisor.svg")),
                                              // Call advisor
                                              CustomMaterialButton(
                                                  onPressed: () async {
                                                    await Utils.makePhoneCall(
                                                        phoneNumber: topAdvisor
                                                                ?.phoneNo ??
                                                            '',
                                                        context: context);
                                                  },
                                                  isEnabled: false,
                                                  shape: const CircleBorder(),
                                                  child: SvgPicture.asset(
                                                      "assets/call_advisor.svg")),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          )),
                    ],
                  );
          case null:
            return showVoid;
        }
      },
    );
  }

  // *---- Sco programs slider ----*
  int _scoProgramCurrentIndex = 0;

  final List<Widget> _scoProgramsList = [];
  final List<ScoProgramTileModel> _scoProgramsModelsList = [];

  void _initializeScoPrograms() {
    final localization = AppLocalizations.of(context)!;

    final scoProgramsMapList = [
      {
        'title': localization.scholarshipInternal,
        'subTitle': localization.internalScholarshipDesc,
        'imagePath': Constants.scholarshipInUae,
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
              createRoute(ScholarshipsInUaeView()),
            ),
      },
      {
        'title': localization.scholarshipExternal,
        'subTitle': localization.externalScholarshipDesc,
        'imagePath': Constants.scholarshipInAbroad,
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
              createRoute(ScholarshipInAbroadView()),
            ),
      },
    ];

    // Map JSON data to models
    for (var map in scoProgramsMapList) {
      _scoProgramsModelsList.add(ScoProgramTileModel.fromJson(map));
    }

    // Create widgets based on models
    for (var model in _scoProgramsModelsList) {
      _scoProgramsList.add(
        CustomScoProgramTile(
          imagePath: model.imagePath!,
          title: model.title!,
          subTitle: model.subTitle!,
          onTap: model.onTap!,
        ),
      );
    }
  }

  Widget _scoPrograms({required LanguageChangeViewModel langProvider}) {
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSmallSpace,
          Row(
            children: [
              // title for sco programs
              Text(
                AppLocalizations.of(context)!.scoPrograms,
                style: AppTextStyles.appBarTitleStyle().copyWith(fontSize: 20),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),

              // slider for sco programs
            ],
          ),
          Column(
            children: [
              // carousel slider
              CustomCarouselSlider(
                items: _scoProgramsList,
                onPageChanged: (index, reason) {
                  setState(() {
                    _scoProgramCurrentIndex = index;
                  });
                },
              ),
              kFormHeight, // animated moving dots
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _scoProgramsList.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _scoProgramCurrentIndex == entry.key ? 7.0 : 5.0,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _scoProgramCurrentIndex == entry.key
                          ? Colors.black
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              )
            ],
          )
        ],
      ),
    );
  }

  // &---- FaQ section -----*
  Widget _faqSection({langProvider}) {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        kSmallSpace,
        _homeViewCard(
            title: localization.faqs,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            // contentPadding:  EdgeInsets.zero,
            icon: SvgPicture.asset("assets/faq_1.svg"),
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
              _navigationServices.pushCupertino(
                  CupertinoPageRoute(builder: (context) => const FaqView()));
            }),
      ],
    );
  }

  // *----CarouselSlider-------*
  Widget _carouselSlider() {
    return Consumer<NewsAndEventsViewmodel>(
      builder: (context, provider, _) {
        switch (provider.newsAndEventsResponse.status) {
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.COMPLETED:
            return Column(
              children: [
                Directionality(
                    textDirection:
                        getTextDirection(context.read<LanguageChangeViewModel>()),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: orientation == Orientation.portrait ? 190.0 : 210,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 100),
                        autoPlayCurve: Curves.linear,
                        enlargeCenterPage: true,
                        enlargeFactor: 0,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: provider.parsedNewsAndEventsModelList
                          .map<Widget>((item) {
                        final languageId = getTextDirection(
                                    context.read<LanguageChangeViewModel>()) ==
                                TextDirection.rtl
                            ? 'ar_SA'
                            : 'en_US';

                        return CarouselItemBuilder(
                          item: item,
                          languageId: languageId,
                        );
                      }).toList(),
                    )),
                kFormHeight,
              ],
            );
          default:
            return showVoid;
        }
      },
    );

    ;
  }

  // main card for home
  Widget _homeViewCard({
    required String title,
    Widget? icon,
    required Widget content,
    headerExtraContent,
    required LanguageChangeViewModel langProvider,
    dynamic contentPadding,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 0.5,
        color: Colors.white,
        shadowColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(kCardRadius),
        child: Directionality(
          textDirection: getTextDirection(langProvider),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: kCardPadding,
                    left: kCardPadding,
                    right: kCardPadding,
                    bottom: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          icon ?? showVoid,
                          if (icon != null) const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              title,
                              style: AppTextStyles.titleBoldTextStyle()
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 5),
                          headerExtraContent ?? showVoid,
                        ],
                      )),
                      Icon(
                        getTextDirection(langProvider) == TextDirection.rtl
                            ? Icons.keyboard_arrow_left_outlined
                            : Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                // kFormHeight,
                Padding(
                  padding: contentPadding ??
                      EdgeInsets.only(
                        bottom: kCardPadding,
                        left: kCardPadding,
                        right: kCardPadding,
                      ),
                  child: content,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeViewCardBottomContainer({
    required dynamic child,
    dynamic backGroundColor = AppColors.lightBlue0,
    padding = EdgeInsets.zero,
  }) {
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(kCardRadius),
              bottomRight: Radius.circular(kCardRadius))),
      child: child,
    );
  }
}

class CarouselItemBuilder extends StatefulWidget {
  final dynamic item;
  final dynamic languageId;

  const CarouselItemBuilder({
    super.key,
    required this.languageId,
    required this.item,
  });

  @override
  State<CarouselItemBuilder> createState() => _CarouselItemBuilderState();
}

class _CarouselItemBuilderState extends State<CarouselItemBuilder> {
  String? _imageUrl;

  late NavigationServices _navigationServices;

  void _initializeData() async {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    final provider =
        Provider.of<IndividualImageViewModel>(context, listen: false);

    // Schedule the data fetch to avoid direct async calls in build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool result = await provider.individualImage(
          context: context,
          langProvider: langProvider,
          imageId: widget.item.coverImageFileEntryId);

      if (result && mounted) {
        // Ensure widget is still mounted
        setState(() {
          _imageUrl = provider.individualImageResponse.data!.data!.imageUrl!;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //register services:
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    //Initialize the image url;
    _initializeData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item.getTitle(widget.languageId));
    return Stack(
      children: [
        // Background Image
        SizedBox(
            height: 190,
            child: Consumer<IndividualImageViewModel>(
              builder: (context, imageProvider, _) {
                switch (imageProvider.individualImageResponse.status) {
                  case Status.LOADING:
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: const Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.scoThemeColor,
                        ),
                      ),
                    );
                  case Status.ERROR:
                  case Status.COMPLETED:
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:  CachedNetworkImage(
                        cacheKey: imageProvider.individualImageResponse.data?.data?.imageUrl ?? Constants.newsImageUrl,
                        imageUrl: "${imageProvider.individualImageResponse.data?.data?.imageUrl ?? Constants.newsImageUrl}?v=${DateTime.now().millisecondsSinceEpoch}",
                              fit: BoxFit.fill,
                              height: double.infinity,
                              width: double.infinity,
                        errorWidget: (context,object,_){
                                return Image.asset(Constants.newsImageUrl);
                        },
                        errorListener: (object){
                          Image.asset(Constants.newsImageUrl);
                        },
                            ), // Show loader while fetching
                    );

                  default:
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    );
                }
              },
            )),

        // Gradient Overlay
        Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black87.withOpacity(0.2)],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
        ),

        // Content Layer
        Container(
          height: 190,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "Read More" Section
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: Color(0xffAD8138), size: 14),
                      const SizedBox(width: 2),
                      InkWell(
                        onTap: () {
                          _navigationServices.pushCupertino(CupertinoPageRoute(
                            builder: (context) => NewsAndEventsDetailView(
                                imageId: widget.item.coverImageFileEntryId,
                                date: widget.item
                                    .getFormattedDate(
                                        context.read<LanguageChangeViewModel>())
                                    .toString(),
                                title: widget.item.getTitle(widget.languageId),
                                subTitle: widget.item
                                    .getDescription(widget.languageId),
                                content:
                                    widget.item.getContent(widget.languageId)),
                          ));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.readMore,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffAD8138),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(width: 15),

              // Right Side Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.item.getDescription(widget.languageId),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Limits to 2 lines to prevent overflow
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
