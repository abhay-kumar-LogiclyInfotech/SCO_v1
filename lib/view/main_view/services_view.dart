import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/account/custom_account_grid_container.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/view/main_view/services_views/finance.dart';
import 'package:sco_v1/view/main_view/services_views/guidance_notes.dart';
import 'package:sco_v1/view/main_view/services_views/my_scholarship_view.dart';
import 'package:sco_v1/view/main_view/services_views/request.dart';
import 'package:sco_v1/view/main_view/services_views/work_status.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../data/response/status.dart';
import '../../models/account/account_grid_container_view_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/components/tiles/simple_tile.dart';
import '../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late AlertServices _alertServices;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback)async{

        await _getAllApplicationStatus();


    });
  }

  /// method to ping the get all application status and update the screen as per condition given below.
  /// checking for the application is applied if applied then only show the services to the user.
  _getAllApplicationStatus()async{
    final applicationStatusProvider = Provider.of<GetListApplicationStatusViewModel>(context,listen:false);
    await applicationStatusProvider.getListApplicationStatus();
  }


 Future<void> _onRefresh()async{
   await _getAllApplicationStatus();
   setState(() {
      // update the state of the application status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // appBar: CustomSimpleAppBar(titleAsString: "Services"),
      body: RefreshIndicator(
        color: Colors.white,
          backgroundColor: AppColors.scoThemeColor,
          onRefresh: _onRefresh,
          child: ListView(children: [_buildUi()])),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
   final appLocalizations =  AppLocalizations.of(context);

    final accountItemsMapList = [
      {
        'title': appLocalizations?.apply_for_scholarship,
        'assetAddress': "assets/services/apply_scholarship.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()))
      },
      {
        'title': appLocalizations?.my_scholarship,
        'assetAddress': "assets/services/my_scholarship.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const MyScholarshipView()))
      },
      {
        'title': appLocalizations?.request,
        'assetAddress': "assets/services/request.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const RequestView()))
      },
      {
        'title': appLocalizations?.academic_advisor,
        'assetAddress': "assets/services/academic_advisor.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const AcademicAdvisorView()))
      },
      {
        'title': appLocalizations?.work_status,
        'assetAddress': "assets/services/work_status.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const WorkStatusView()))
      },
      {
        'title': appLocalizations?.finance,
        'assetAddress': "assets/services/finance.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const FinanceView()))
      },
      {
        'title': appLocalizations?.guidance_notes,
        'assetAddress': "assets/services/guidance_notes.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const GuidanceNotesView()))
      },
    ];

    List<SimpleTileModel> itemsList = [];

    for (var element in accountItemsMapList) {
      itemsList.add(SimpleTileModel.fromJson(element));
    }

    return Consumer<GetListApplicationStatusViewModel>(builder: (context,applicationStatusProvider,_){

      switch(applicationStatusProvider.apiResponse.status){
        case Status.LOADING:
          return Utils.pageLoadingIndicator(context: context);
        case Status.ERROR:
          return Utils.showOnError();
        case Status.COMPLETED:
          bool? alreadyAppliedResult =  applicationStatusProvider.apiResponse.data?.data?.applicationStatus.any((element){return element.applicationStatus.programAction != 'DRAFT';});
          if(alreadyAppliedResult != null && alreadyAppliedResult){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  final item = itemsList[index];
                  return Padding(
                    padding: (index < itemsList.length - 1)
                        ? const EdgeInsets.only(top: 20.0)
                        : (index == itemsList.length - 1)
                        ? EdgeInsets.only(top: kPadding,bottom: kPadding)
                        : EdgeInsets.zero,
                    child: SimpleTile(item: item),
                  );
                },
              ),
            );
          }
          else{
            return Padding(
              padding:  EdgeInsets.all(kPadding),
              child: SimpleCard(expandedContent: const Column(children: [Text("You have not applied for any scholarship yet. Please apply for scholarship to see services.")],)),
            ) ;}

        case Status.NONE:
          return Utils.showOnNone();
        case null:
          return Utils.showOnNull();
      }



    });
  }
}
