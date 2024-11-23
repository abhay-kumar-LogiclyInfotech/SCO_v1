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
import 'package:sco_v1/view/drawer/custom_drawer_views/aBriefAboutSco_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/news_and_events_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_abroad/scholarship_in_abroad_view.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/scholarship_in_uae_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/view/main_view/services_views/finance.dart';
import 'package:sco_v1/view/main_view/services_views/request_view.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';

import '../../resources/app_colors.dart';
import '../../resources/components/tiles/custom_sco_program_tile.dart';
import '../../resources/custom_painters/faq_painters.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../drawer/custom_drawer_views/vision_and_mission_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with MediaQueryMixin<HomeView> {
  late NavigationServices _navigationServices;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // final provider = Provider.of<HomeSliderViewModel>(context, listen: false);
      // final langProvider =
      //     Provider.of<LanguageChangeViewModel>(context, listen: false);
      // await provider.homeSlider(context: context, langProvider: langProvider);
      await _onRefresh();
    });
  }


 Future _onRefresh()async{


    /// initialize the sco programs carousel slider
   _scoProgramsModelsList.clear();
_scoProgramsList.clear();
   _initializeScoPrograms();
   final myFinanceProvider =  Provider.of<MyFinanceStatusViewModel>(context, listen: false);
    final requestsProvider = Provider.of<GetAllRequestsViewModel>(context,listen: false);
    final talkToMyAdvisor = Provider.of<GetMyAdvisorViewModel>(context,listen: false);

    await Future.wait<dynamic>(
    [
     myFinanceProvider.myFinanceStatus(),
     requestsProvider.getAllRequests(),
      talkToMyAdvisor.getMyAdvisor(),
   ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Utils.pageRefreshIndicator(child: _buildUI(), onRefresh: _onRefresh)
    );
  }

  // check for the scholarship status
  ScholarshipStatus scholarshipStatus = ScholarshipStatus.applyScholarship;

  Widget _buildUI()  {
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
              Column(
                children: [
                  _scholarshipAppliedContainer(langProvider: langProvider),
                  kFormHeight,
                ],
              ),

              Column(
                children: [
                  _scholarshipApproved(langProvider: langProvider),
                  kFormHeight,
                  _announcements(langProvider: langProvider),
                  kFormHeight,
                ],
              ),

            // _faqContainer(langProvider: langProvider),
            // kFormHeight,
            // _aboutOrganization(langProvider: langProvider),
            kFormHeight,
            Column(
                children: [
                  _applyScholarshipButton(langProvider: langProvider),
                  kFormHeight,
                  _scoPrograms(langProvider: langProvider),
                  kFormHeight,
                ],
              ),
            _financeView(langProvider: langProvider),
            kFormHeight,
            _requestView(langProvider: langProvider),
            kFormHeight,
            _talkToMyAdvisor(langProvider: langProvider),
            kFormHeight,
            _faqSection(langProvider: langProvider),
            kFormHeight,
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
    return _homeViewCard(
        langProvider: langProvider,
        title: AppLocalizations.of(context)!.scholarshipOffice,
        icon: Image.asset("assets/scholarship_office.png"),
        content: Column(
          children: [
            // Amount and Read More Button
            _buildAmountAndButton(langProvider: langProvider),

            const SizedBox(height: 10),

            const Divider(color: Color(0xffDFDFDF)),

            const SizedBox(height: 10),

            // Date Information
            _buildDateInfo(langProvider: langProvider, date: null),
          ],
        ));
  }



  Widget _announcements({required LanguageChangeViewModel langProvider}) {
    return _homeViewCard(
      title: "Announcement",
      icon: SvgPicture.asset("assets/announcements.svg"),
      langProvider: langProvider,
      content: Column(
        children: [
          kFormHeight,
          Text("Announcing Announcement. Making an announcement is more understated...",style: AppTextStyles.titleTextStyle().copyWith(fontSize: 15),),
          kFormHeight,
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.calendar_month_outlined,color: Colors.grey.shade400,size: 15,),
              const SizedBox(width: 5),
              Text("DD-YYYY-MM",style: AppTextStyles.subTitleTextStyle().copyWith(fontWeight: FontWeight.bold),),
              const SizedBox(width: 5),
              Text("(01:55 PM)",style: AppTextStyles.subTitleTextStyle().copyWith(fontWeight: FontWeight.normal),),

            ],
          )
        ],
      ),
    );
  }

  Widget _buildAmountAndButton(
      {required LanguageChangeViewModel langProvider}) {
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
                  const Text(
                    "300",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B9967),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "AED",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0B9967),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Text(
                "02/09/2023",
                style: TextStyle(
                  color: Color(0xff9AA6B2),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // Read More Button
        SizedBox(
          width: screenWidth * 0.35,
          child: CustomButton(
            buttonName: AppLocalizations.of(context)!.readMore,
            isLoading: false,
            onTap: () {},
            textDirection: getTextDirection(langProvider),
            textColor: const Color(0xffAD8138),
            borderColor: const Color(0xffAD8138),
            buttonColor: Colors.white,
            fontSize: 14,
            height: 40,
          ),
        ),
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
          date ?? "01/09/2023 - 01/09/2024",
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


  // *----Scholarship applied container----*
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
                          textAlign: TextAlign.start)
                    ],
                  ),
                ),

                // read more button
                SizedBox(
                  width: screenWidth * 0.35,
                  child: CustomButton(
                    buttonName: AppLocalizations.of(context)!.readMore,
                    isLoading: false,
                    onTap: () {},
                    textDirection: getTextDirection(langProvider),
                    textColor: const Color(0xffAD8138),
                    borderColor: const Color(0xffAD8138),
                    buttonColor: Colors.white,
                    fontSize: 14,
                    height: 40,
                  ),
                ),
              ],
            ),
            kFormHeight,

            // divider
            const Divider(color: AppColors.lightGrey),
            const SizedBox.square(
              dimension: 5,
            ),

            // date
            _buildDateInfo(langProvider: langProvider, date: "DD/MM/YYYY"),
          ],
        ));
  }



  // Apply Scholarship Button
  Widget _applyScholarshipButton(
      {required LanguageChangeViewModel langProvider}) {
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
                  buttonName: "Apply Scholarship",
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
    return  Consumer<MyFinanceStatusViewModel>(
        builder: (context,financeStatusProvider,_){


          switch(financeStatusProvider.apiResponse.status){
            case Status.LOADING:
              return showVoid;
            case Status.ERROR:
              return showVoid;
            case Status.NONE:
              return showVoid;
            case Status.COMPLETED:
              final financeData = financeStatusProvider.apiResponse.data?.data;
              final salary = financeData?.listSalaryDetials?.isNotEmpty == true ? financeData?.listSalaryDetials?.first : null;
              final deduction = financeData?.listDeduction?.isNotEmpty == true ? financeData?.listDeduction?.first : null;
              final bonus = financeData?.listBonus?.isNotEmpty == true ? financeData?.listBonus?.first : null;
              final warning = financeData?.listWarnings?.isNotEmpty == true ? financeData?.listWarnings?.first : null;
              return _homeViewCard(
                onTap: ()
                {
                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const FinanceView()));
                },
                    title: "My Finance",
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
                                title: "Salary",
                                subTitle: salary?.amount.toString() ?? '',
                              ),
                              CustomVerticalDivider(),
                              _financeAmount(
                                titleColor: const Color(0xff3A82F7),
                                title: "Deduction",
                                subTitle: deduction?.totalDeducted.toString() ?? '',
                              ),
                              CustomVerticalDivider(),
                              _financeAmount(
                                titleColor: const Color(0xff67CE67),
                                title: "Bonus",
                                subTitle: bonus?.amount.toString() ?? '',
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        // warning
                        Text(
                          "Warning",
                          style: AppTextStyles.subTitleTextStyle()
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          warning?.termDescription ?? '',
                          style: AppTextStyles.titleBoldTextStyle().copyWith(fontSize: 18),
                        ),
                      ],
                    ));
            case null:
              return showVoid;
          }
});
  }

  Widget _financeAmount(
      {String title = "Title",
      String subTitle = "250.00",
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
        switch(requestsProvider.apiResponse.status){
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.NONE:
            return showVoid;
          case Status.COMPLETED:
            final requests = requestsProvider.apiResponse.data?.data?.listOfRequest;
            final totalRequests = requestsProvider.apiResponse.data?.data?.listOfRequest?.length;
            final approvedRequests = requests?.where((r) => r.status == "APPROV")?.length?? 0;
            final pendingRequests = requests?.where((r) => r.status == "RECVD")?.length?? 0;
            final rejectedRequests = requests?.where((r) => r.status == "DENY")?.length?? 0;
            return _homeViewCard(
            title: "Requests",
            icon: SvgPicture.asset("assets/request.svg"),
            langProvider: langProvider,
            headerExtraContent: RequestsCountContainer(color: Colors.blue.shade600, count: totalRequests),
            contentPadding: EdgeInsets.zero,
            onTap: (){_navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const RequestView()));},
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    "Total Number of Requests",
                    style: TextStyle(fontSize: 14, height: 2.5),
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
                                requestType: "Approved",
                                count: approvedRequests,
                                color: Colors.green.shade500)),
                        kFormHeight,
                        _requestTypeWithCount(
                            requestType: "Pending",
                            count: pendingRequests,
                            color: const Color(0xffF4AA73)),
                        kFormHeight,
                        _requestTypeWithCount(
                            requestType: "Rejected",
                            count: rejectedRequests,
                            color: AppColors.DANGER),
                      ],
                    )),
              ],
            ));
          case null:
            return showVoid;
        }
      }
    );
  }

  /// Req
  Widget _requestTypeWithCount(
      {String requestType = "Request Type",
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
      builder: (context,provider,_)
      {
        switch(provider.apiResponse.status){
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.NONE:
            return showVoid;
          case Status.COMPLETED:
            final listOfAdvisors = provider.apiResponse.data?.data?.listOfAdvisor ?? [];
           final topAdvisor =  listOfAdvisors.isNotEmpty ?  listOfAdvisors[0] : null;

            return _homeViewCard(
              onTap: (){
                _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const AcademicAdvisorView()));
              },
                title: "Talk to My Advisor",
                icon: SvgPicture.asset("assets/talk_to_my_advisor.svg"),
                langProvider: langProvider,
                contentPadding: EdgeInsets.zero,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        "You can see list of the advisors",
                        style: TextStyle(fontSize: 14, height: 2.5),
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
                                            image: AssetImage("assets/login_bg.png")))),
                                kFormHeight,
                                /// Title and subtitle
                                Container(
                                  constraints: const BoxConstraints(maxWidth: 120),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        topAdvisor?.advisorName ?? '',
                                        style: AppTextStyles.titleBoldTextStyle()
                                            .copyWith(fontSize: 14, height: 1.3),
                                      ),
                                       Text(
                                        topAdvisor?.advisorRoleDescription?.toString() ?? '' ,
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
                                constraints:
                                const BoxConstraints(minWidth: 200, maxWidth: 200),
                                child: Wrap(
                                  runSpacing: 0,
                                  spacing: -30,
                                  runAlignment: WrapAlignment.end,
                                  alignment: WrapAlignment.end,
                                  children: [
                                    // message Advisor
                                    CustomMaterialButton(
                                        onPressed: () {
                                          Utils.launchEmail(topAdvisor?.email ?? '');
                                        },
                                        isEnabled: false,
                                        shape: const CircleBorder(),
                                        child: SvgPicture.asset(
                                            "assets/message_advisor.svg")),
                                    // Call advisor
                                    CustomMaterialButton(
                                        onPressed: () {
                                          Utils.makePhoneCall(phoneNumber: topAdvisor?.phoneNo ?? '', context: context);},
                                        isEnabled: false,
                                        shape: const CircleBorder(),
                                        child: SvgPicture.asset("assets/call_advisor.svg")),
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
    final scoProgramsMapList = [
      {
        'title': "Scholarships In Uae",
        'subTitle': "This is Subtitle 1",
        'imagePath': "assets/sidemenu/scholarships_uae.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ScholarshipsInUaeView()),
        ),
      },
      {
        'title': "Scholarships In Abroad",
        'subTitle': "This is Subtitle 2",
        'imagePath': "assets/sidemenu/scholarships_abroad.jpg",
        "onTap": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ScholarshipInAboardView()),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // title for sco programs
            Text(
              "SCO Program",
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
    );
  }

  // &---- FaQ section -----*
  Widget _faqSection({langProvider}) {
    return _homeViewCard(
        title: "FAQ",
        icon: const Icon(Icons.face),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Frequently Asked Questions",
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
