import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/Test.dart';
import 'package:sco_v1/controller/dependency_injection.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/models/home/ScoProgramsTileModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/carsousel_slider.dart';
import 'package:sco_v1/resources/components/custom_about_organization_containers.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_vertical_divider.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/resources/components/requests_count_container.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/authentication/login/login_view.dart';
import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/aBriefAboutSco_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/news_and_events_view.dart';
import 'package:sco_v1/view/main_view/notifications/notifications_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_abroad/scholarship_in_abroad_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/scholarship_in_uae_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/web_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/view/main_view/services_views/finance.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/salaryDetailsView.dart';
import 'package:sco_v1/view/main_view/services_views/request_view.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../hive/hive_manager.dart';
import '../../models/services/MyFinanceStatusModel.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_urls.dart';
import '../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../resources/custom_painters/faq_painters.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/account/personal_details/get_profile_picture_url_viewModel.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../../viewModel/services/alert_services.dart';
import '../drawer/custom_drawer_views/vision_and_mission_view.dart';

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
  UserRole? role ;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // final provider = Provider.of<HomeSliderViewModel>(context, listen: false);
      // final langProvider =
      //     Provider.of<LanguageChangeViewModel>(context, listen: false);
      // await provider.homeSlider(context: context, langProvider: langProvider);
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
      setState(() {

      });


      // Getting Fresh Roles
      final getRolesProvider = Provider.of<GetRoleViewModel>(context,listen:false);
      await getRolesProvider.getRoles();
      role = getRoleFromList(HiveManager.getRole());
      final profilePictureProvider  = Provider.of<GetProfilePictureUrlViewModel>(context,listen: false);
      /// Fetching profile picture url
      await profilePictureProvider.getProfilePictureUrl();
      setState(() {
        // Update state to reflect that notifications count is loaded
      });
      if(isLogged){
        setProcessing(true);

      /// Fetch data from providers
      final myFinanceProvider = Provider.of<MyFinanceStatusViewModel>(context, listen: false);
      final requestsProvider = Provider.of<GetAllRequestsViewModel>(context, listen: false);
      final talkToMyAdvisor = Provider.of<GetMyAdvisorViewModel>(context, listen: false);
      final getNotificationsCount = Provider.of<GetNotificationsCountViewModel>(context, listen: false);
      final getAllNotificationProvider = Provider.of<GetAllNotificationsViewModel>(context, listen: false);
      try
      {
        // Fetch notifications count
        await getNotificationsCount.getNotificationsCount();
        setState(() {
          // Update state to reflect that notifications count is loaded
        });



    // //// This will show the top salary only
    // _scholarshipApproved(langProvider: langProvider),
    // // kFormHeight,
    // _announcements(langProvider: langProvider),
    // kFormHeight,
    // _financeView(langProvider: langProvider),
    // kFormHeight,
    // _requestView(langProvider: langProvider),
    // kFormHeight,
    // _talkToMyAdvisor(langProvider: langProvider),


        if(role == UserRole.scholarStudent) {
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


      } catch (e) {
        // Handle exceptions for individual tasks or overall process
        print("Error fetching data: $e");
      } finally {
        setProcessing(false);
        setState(() {
          // Final UI refresh to ensure everything is up-to-date
        });
      }}

      setProcessing(false);
    } catch (error) {
      setProcessing(false);
      /// Handle any errors
      print('Error during refresh: $error');
    }
    setProcessing(false);
  }



  bool isProcessing = false;
  setProcessing(value){
    setState(() {
      isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Utils.modelProgressHud(processing: isProcessing,child:  Utils.pageRefreshIndicator(
            child: _buildUI(), onRefresh: _onRefresh)));
    //    body:  Shimmer.fromColors(
    //      baseColor: AppColors.lightGrey,
    //      highlightColor: Colors.grey.withOpacity(0.5),
    //      //   highlightColor: AppColors.scoLightThemeColor,
    //      enabled: true,
    //      child: ListView.builder(
    //        itemCount: 5,
    //        itemBuilder: (context, index) {
    //          return Container(
    //            height: 150.0, // Use a fixed height value for better performance
    //            margin: const EdgeInsets.only(bottom: 10),
    //            width: double.infinity,
    //            decoration: BoxDecoration(
    //              color: Colors.black.withOpacity(0.9),
    //              borderRadius: BorderRadius.circular(20.0), // Adjust as desired
    //              border: Border.all(
    //                color: Colors.white, // Consider a contrasting border color
    //                width: 1.0, // Adjust border thickness
    //              ),
    //            ),
    //          );
    //        },
    //      ),
    //    )
    // );
  }

  // check for the scholarship status
  ScholarshipStatus scholarshipStatus = ScholarshipStatus.applyScholarship;

  Widget _buildUI() {
    // *-----Initialize the languageProvider-----*
    final langProvider = Provider.of<LanguageChangeViewModel>(context);



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            kFormHeight,
            // CustomButton(buttonName: "Test", isLoading: false, textDirection: getTextDirection(langProvider), onTap: (){
            //   final provider = Provider.of<TestApi>(context,listen: false);
            //   provider.testApi();
            // }),

            //CarouselSlider:
            // *-----Client Said he don't need CarouselSlider on the home page----*/
            // _carouselSlider(),
            if(isLogged && role == UserRole.applicants) Column(
              children: [
                _scholarshipAppliedContainer(langProvider: langProvider),
                kFormHeight,
                _uploadDocumentsSection(langProvider: langProvider),
                kFormHeight,
                _faqSection(langProvider: langProvider),
                kFormHeight,
              ],
            ),

            // _faqContainer(langProvider: langProvider),
            // kFormHeight,
            // _aboutOrganization(langProvider: langProvider),
         if (!isLogged || role == UserRole.student || role == UserRole.user)
          Column(
              children: [
                _applyScholarshipButton(langProvider: langProvider),
                kFormHeight,
                _scoPrograms(langProvider: langProvider),
                kFormHeight,
                _faqSection(langProvider: langProvider),
                kFormHeight,
              ],
            ),
            if (isLogged && role == UserRole.scholarStudent)  Column(
              children: [
                //// This will show the top salary only
                _scholarshipApproved(langProvider: langProvider),
                // kFormHeight,
                _announcements(langProvider: langProvider),
                kFormHeight,
                _financeView(langProvider: langProvider),
                kFormHeight,
                _requestView(langProvider: langProvider),
                kFormHeight,
                _talkToMyAdvisor(langProvider: langProvider),
                kFormHeight,
              ],
            ),

          ],
        ),
      ),
    );
  }

  /***
      // *----CarouselSlider-------*
      Widget _carouselSlider() {
      return SizedBox(
      child: CarouselSlider(
      options: CarouselOptions(
      height: orientation == Orientation.portrait ? 190.0 : 210,
      aspectRatio: 16 / 9,
      viewportFraction: 0.85,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 2),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      scrollDirection: Axis.horizontal,
      ),
      items: [_carouselItem()]),
      );
      }


      Widget _carouselItem() {
      return Consumer<LanguageChangeViewModel>(
      builder: (context, provider, _) {
      return Stack(
      children: [
      ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
      "assets/sidemenu/aBriefAboutSco.jpg",
      fit: BoxFit.fill,
      height: double.infinity,
      width: double.infinity,
      )),

      //Gradient:
      Container(
      width: double.infinity,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [
      Colors.black,
      Colors.black87.withOpacity(0.2),
      ], begin: Alignment.bottomCenter, end: Alignment.center)),
      ),
      //Read more:
      Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding:
      const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
      child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      //Read more:
      Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Icon(
      Icons.arrow_back_ios,
      color: Color(0xffAD8138),
      size: 14,
      ),
      const SizedBox(
      width: 2,
      ),
      Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
      AppLocalizations.of(context)!.readMore,
      style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xffAD8138)),
      ),
      ),
      ],
      ),
      ],
      ),

      const SizedBox(
      width: 15,
      ), //right side content:
      Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
      AppLocalizations.of(context)!.scholarships,
      style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600),
      ),
      ),
      const SizedBox(
      width: 8,
      ),
      SvgPicture.asset("assets/scholarship.svg")
      ],
      ),
      Text(
      AppLocalizations.of(context)!.scholarshipsInTheUAE,
      textAlign: TextAlign.end,
      style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600),
      )
      ],
      ),
      )
      ],
      ))
      ],
      );
      },
      );
      }

   ***/

// *---Container for approved scholarships-----*
  Widget _scholarshipApproved({required LanguageChangeViewModel langProvider}) {
    return Consumer<MyFinanceStatusViewModel>(
        builder: (context, financeStatusProvider, _) {
      switch (financeStatusProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.COMPLETED:
          final listOfSalaries = financeStatusProvider.apiResponse.data?.data?.listSalaryDetials ?? [];

          final topSalaryDetails = listOfSalaries.isNotEmpty ? listOfSalaries[0] : null;

          return _homeViewCard(
              langProvider: langProvider,
              title: AppLocalizations.of(context)!.scholarshipOffice,
              icon: Image.asset("assets/scholarship_office.png"),
              content: Column(
                children: [
                  // Amount and Read More Button
                  _buildAmountAndButton(
                      langProvider: langProvider, topSalary: topSalaryDetails),

                  const SizedBox(height: 10),

                  const Divider(color: Color(0xffDFDFDF)),

                  const SizedBox(height: 10),
                  // Date Information
                  _buildDateInfo(
                      langProvider: langProvider,
                      date: topSalaryDetails?.salaryMonth),
                ],
              ));
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
          final firstNotification = allNotificationsProvider.apiResponse.data?.isNotEmpty ?? false ?  allNotificationsProvider.apiResponse.data?.first : null;
         return
           allNotificationsProvider.apiResponse.data?.isNotEmpty ?? false ?
         _homeViewCard(
            onTap: (){
              _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const NotificationsView() ));
            },
            title:AppLocalizations.of(context)!.announcement,
            icon: SvgPicture.asset("assets/announcements.svg"),
            langProvider: langProvider,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kFormHeight,
                Text(
                 firstNotification?.subject ?? '',
                  style: AppTextStyles.titleTextStyle().copyWith(fontSize: 15),
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
                      convertTimestampToDate(firstNotification?.createDate ?? 0),
                      style: AppTextStyles.subTitleTextStyle()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      convertTimestampToTime(firstNotification?.createDate ?? 0),
                      style: AppTextStyles.subTitleTextStyle()
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                )
              ],
            ),
          ) : showVoid;
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
              Row(
                children: [
                  Text(
                    topSalary?.amount.toString() ?? "0",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B9967),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    topSalary?.currency.toString() ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff0B9967),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                topSalary?.status.toString() ?? "",
                style: const TextStyle(
                  color: Color(0xff9AA6B2),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // Read More Button
        readMoreButton(
            langProvider: langProvider,
            onTap: () {
              _navigationServices.pushCupertino(CupertinoPageRoute(
                  builder: (context) => const SalaryDetailsView()));
            }),
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
    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Scholarship status:
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scholarship Status",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.hintDarkGrey),
                        textAlign: TextAlign.start,
                      ),
                      Text("Scholarship Applied",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                readMoreButton(
                  langProvider: langProvider,
                  onTap: () {
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const ApplicationStatusView()));
                  },
                )
              ],
            ),
            kFormHeight,

            // divider
            const Divider(color: AppColors.lightGrey),
            const SizedBox.square(
              dimension: 5,
            ),
            // date
            // _buildDateInfo(langProvider: langProvider, date: "DD/MM/YYYY"),
          ],
        ));
  }

  Widget _uploadDocumentsSection({required LanguageChangeViewModel langProvider}){
    return CustomInformationContainer(leading: SvgPicture.asset("assets/myDocuments.svg"),title: "Upload Documents", expandedContent: Column(
      children: [

        const SizedBox(height: 25),
        Text("My Documents",style: AppTextStyles.titleBoldTextStyle().copyWith(height: 1.9)),
        const Text("Click Below to Upload Documents",style: TextStyle(height: 1.5),),
        const SizedBox(height: 25),
        const MyDivider(color: AppColors.darkGrey),
        const SizedBox(height: 30),
        CustomButton(buttonName: "Click Here", isLoading: false,buttonColor: AppColors.scoButtonColor, textDirection: getTextDirection(langProvider), onTap: (){
          _alertServices.toastMessage(AppLocalizations.of(context)!.comingSoon,);
        }),
        const SizedBox(height: 30),
      ],
    ));
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
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            kFormHeight,
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
            kFormHeight,
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
          return _homeViewCard(
              onTap: () {
                _navigationServices.pushCupertino(CupertinoPageRoute(
                    builder: (context) => const FinanceView()));
              },
              title: AppLocalizations.of(context)!.myFinance,
              icon: SvgPicture.asset("assets/my_finance.svg"),
              langProvider: langProvider,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  kFormHeight,
                  Center(
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 30,
                      runAlignment: WrapAlignment.spaceEvenly,
                      alignment: WrapAlignment.spaceAround,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _financeAmount(
                          titleColor: const Color(0xffEC6330),
                          title: AppLocalizations.of(context)!.salary,
                          subTitle: salary?.amount.toString() ?? '',
                        ),
                        CustomVerticalDivider(),
                        _financeAmount(
                          titleColor: const Color(0xff3A82F7),
                          title: AppLocalizations.of(context)!.deduction,
                          subTitle: deduction?.totalDeducted.toString() ?? '',
                        ),
                        CustomVerticalDivider(),
                        _financeAmount(
                          titleColor: const Color(0xff67CE67),
                          title:AppLocalizations.of(context)!.bonus,
                          subTitle: bonus?.amount.toString() ?? '',
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // warning
                  Text(
                    AppLocalizations.of(context)!.warning,
                    style: AppTextStyles.subTitleTextStyle()
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    warning?.termDescription ?? '',
                    style: AppTextStyles.titleBoldTextStyle()
                        .copyWith(fontSize: 18),
                  ),
                ],
              ));
        case null:
          return showVoid;
      }
    });
  }

  Widget _financeAmount(
      {String title = "",
      String subTitle = "",
      Color titleColor = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: titleColor, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              color: AppColors.scoButtonColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        )
      ],
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
          final requests = requestsProvider.apiResponse.data?.data?.listOfRequest;
          final totalRequests = requestsProvider.apiResponse.data?.data?.listOfRequest?.length;
          final approvedRequests =
              requests?.where((r) => r.status == "APPROV")?.length ?? 0;
          final pendingRequests =
              requests?.where((r) => r.status == "RECVD")?.length ?? 0;
          final rejectedRequests =
              requests?.where((r) => r.status == "DENY")?.length ?? 0;
          return _homeViewCard(
              title: AppLocalizations.of(context)!.requests,
              icon: SvgPicture.asset("assets/request.svg"),
              langProvider: langProvider,
              headerExtraContent: RequestsCountContainer(
                  color: Colors.blue.shade600, count: totalRequests),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                _navigationServices.pushCupertino(CupertinoPageRoute(
                    builder: (context) => const RequestView()));
              },
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 50.0,right: 50),
                    child: Text(
                      AppLocalizations.of(context)!.totalNumberOfRequests,
                      style: const TextStyle(fontSize: 14, height: 2.5),
                    ),
                  ),
                  kFormHeight,
                  _homeViewCardBottomContainer(
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.start,
                        alignment: WrapAlignment.spaceEvenly,
                        runSpacing: 10,
                        children: [
                          IntrinsicWidth(
                              child: _requestTypeWithCount(
                                  requestType:  AppLocalizations.of(context)!.approved,
                                  count: approvedRequests,
                                  color: Colors.green.shade500)),
                          kFormHeight,
                          _requestTypeWithCount(
                              requestType:  AppLocalizations.of(context)!.pending,
                              count: pendingRequests,
                              color: const Color(0xffF4AA73)),
                          kFormHeight,
                          _requestTypeWithCount(
                              requestType:  AppLocalizations.of(context)!.rejected,
                              count: rejectedRequests,
                              color: AppColors.DANGER),
                        ],
                      )),
                ],
              ));
        case null:
          return showVoid;
      }
    });
  }

  /// Req
  Widget _requestTypeWithCount(
      {String requestType = "",
      dynamic color = Colors.black,
      dynamic count = 10}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(requestType,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
        const SizedBox.square(dimension: 5),
        RequestsCountContainer(color: color, count: count)
      ],
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

            return _homeViewCard(
                onTap: () {
                  _navigationServices.pushCupertino(CupertinoPageRoute(
                      builder: (context) => const AcademicAdvisorView()));
                },
                title: AppLocalizations.of(context)!.talkToMyAdvisor,
                icon: SvgPicture.asset("assets/talk_to_my_advisor.svg"),
                langProvider: langProvider,
                contentPadding: EdgeInsets.zero,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.only(left: 50.0,right: 50),
                      child: Text(
                        AppLocalizations.of(context)!.youCanSeeListOfAdvisors,
                        style: const TextStyle(fontSize: 14, height: 2.5),
                      ),
                    ),
                    kFormHeight,
                    _homeViewCardBottomContainer(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // image of the academic advisor
                            Row(
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/login_bg.png")))),
                                kFormHeight,

                                /// Title and subtitle
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 120),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        topAdvisor?.advisorName ?? '',
                                        style:
                                            AppTextStyles.titleBoldTextStyle()
                                                .copyWith(
                                                    fontSize: 14, height: 1.3),
                                      ),
                                      Text(
                                          topAdvisor?.advisorRoleDescription
                                                  ?.toString() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              height: 2,
                                              overflow: TextOverflow.ellipsis)),
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
                                        onPressed: ()async {
                                         await Utils.launchEmail(topAdvisor?.email ?? '');



                                        },
                                        isEnabled: false,
                                        shape: const CircleBorder(),
                                        child: SvgPicture.asset(
                                            "assets/message_advisor.svg")),
                                    // Call advisor
                                    CustomMaterialButton(
                                        onPressed: ()async {
                                         await Utils.makePhoneCall(
                                              phoneNumber:
                                                  topAdvisor?.phoneNo ?? '',
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
                ));
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
        'subTitle': " ",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
              createRoute(WebView(url: AppUrls.scholarshipInsideUae, scholarshipType: 'INT')),
            ),
      },
      {
        'title': localization.scholarshipExternal,
        'subTitle': "",
        'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(
          createRoute(WebView(url: AppUrls.scholarshipOutsideUae, scholarshipType: 'EXT')),
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
          Row(
            children: [
              // title for sco programs
              Text(
                AppLocalizations.of(context)!.aboutSCO,
                style: AppTextStyles.appBarTitleStyle(),
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
    final localization  = AppLocalizations.of(context)!;
    return _homeViewCard(
        title: localization.faqs,
        icon: const Icon(Icons.face),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(localization.frequentlyAskedQuestions,
              style: AppTextStyles.titleTextStyle(),
            )
          ],
        ),
        langProvider: langProvider,
        onTap: () {
          // Navigate to FAQ page
          _navigationServices.pushCupertino(
              CupertinoPageRoute(builder: (context) => const FaqView()));
        });
  }

  // main card for home
  Widget _homeViewCard({
    required String title,
    required Widget icon,
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
                      top: kPadding,
                      left: kPadding,
                      right: kPadding,
                      bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          icon,
                          const SizedBox(width: 10),
                          Text(
                            title,
                            style: AppTextStyles.titleBoldTextStyle()
                                .copyWith(fontSize: 16),
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
                        bottom: kPadding,
                        left: kPadding,
                        right: kPadding,
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

// Widget _aboutOrganization({required LanguageChangeViewModel langProvider}) {
//   return _homeViewCard(
//       icon: SvgPicture.asset(
//         "assets/aboutTheOrganization.svg",
//         height: 20,
//         width: 20,
//       ),
//       title: AppLocalizations.of(context)!.aboutTheOrganization,
//       langProvider: langProvider,
//       content: Column(
//         children: [
//           const Divider(color: Color(0xffDFDFDF)),
//           const SizedBox(height: 10),
//           _buildInfoRow1(),
//           const SizedBox(height: 10),
//           _buildInfoRow2(),
//         ],
//       ));
// }

// Widget _buildInfoRow1() {
//   return Consumer<LanguageChangeViewModel>(
//     builder: (context, provider, _) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/aboutSco.svg",
//               name: AppLocalizations.of(context)!.aboutSco,
//               onTap: () {
//                 _navigationServices.pushSimpleWithAnimationRoute(
//                     createRoute(const ABriefAboutScoView(
//                   appBar: true,
//                 )));
//               },
//               textDirection: getTextDirection(provider),
//             ),
//           ),
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/scholarships.svg",
//               name: AppLocalizations.of(context)!.scholarship,
//               onTap: () async {
//                 // check if user is logged in or not
//                 final bool alreadyLoggedIn = await _authService.isLoggedIn();
//                 if (!alreadyLoggedIn) {
//                   _navigationServices.goBackUntilFirstScreen();
//                   _navigationServices.pushCupertino(CupertinoPageRoute(
//                       builder: (context) => const LoginView()));
//                 } else {
//                   _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()));
//                 }
//               },
//               textDirection: getTextDirection(provider),
//             ),
//           ),
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/certificates.svg",
//               name: AppLocalizations.of(context)!.certificates,
//               onTap: () {},
//               textDirection: getTextDirection(provider),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
//
// Widget _buildInfoRow2() {
//   return Consumer<LanguageChangeViewModel>(
//     builder: (context, provider, _) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/faqs.svg",
//               name: AppLocalizations.of(context)!.faqs,
//               textDirection: getTextDirection(provider),
//               onTap: () {
//                 _navigationServices.pushSimpleWithAnimationRoute(
//                     createRoute(const FaqView()));
//               },
//             ),
//           ),
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/vision_and_mission.svg",
//               name: AppLocalizations.of(context)!.visionAndMission,
//               textDirection: getTextDirection(provider),
//               onTap: () {
//                 _navigationServices.pushSimpleWithAnimationRoute(
//                     createRoute(const VisionAndMissionView()));
//               },
//             ),
//           ),
//           Expanded(
//             child: CustomAboutOrganizationContainers(
//               assetName: "assets/news_and_events.svg",
//               name: AppLocalizations.of(context)!.newsAndEvents,
//               textDirection: getTextDirection(provider),
//               onTap: () {
//                 _navigationServices.pushSimpleWithAnimationRoute(
//                     createRoute(const NewsAndEventsView()));
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
}
