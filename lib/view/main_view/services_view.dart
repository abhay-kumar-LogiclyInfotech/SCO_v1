import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/view/main_view/services_views/finance.dart';
import 'package:sco_v1/view/main_view/services_views/guidance_notes.dart';
import 'package:sco_v1/view/main_view/services_views/my_scholarship_view.dart';
import 'package:sco_v1/view/main_view/services_views/request_view.dart';
import 'package:sco_v1/view/main_view/services_views/work_status.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../hive/hive_manager.dart';
import '../../models/account/simple_tile_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/components/tiles/simple_tile.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../l10n/app_localizations.dart';

import '../drawer/accout_views/addresses_view.dart';
import '../drawer/accout_views/application_status_view.dart';


class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;

  bool isLogged = false;
  /// Get Roles
  UserRole? role ;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _authService = getIt.get<AuthService>();

    WidgetsBinding.instance.addPostFrameCallback((callback)async{
     await _onRefresh();
    });
  }




 Future<void> _onRefresh()async{

   // Getting Fresh Roles
   final getRolesProvider = Provider.of<GetRoleViewModel>(context,listen:false);

   isLogged = await _authService.isLoggedIn();
     if(isLogged){
       await getRolesProvider.getRoles();
       role = getRoleFromList(HiveManager.getRole());
       // print(role.toString());
     }
   setState(() {
      // update the state of the application status
     /// to update the roles we are calling setState
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: RefreshIndicator(
        color: Colors.white,
          backgroundColor: AppColors.scoThemeColor,
          onRefresh: _onRefresh,
          child: ListView(children: [_buildUi()])),
    );
  }

  Widget _buildUi() {
    final appLocalizations =  AppLocalizations.of(context);

    final accountItemsMapList = [
      {
        'title': appLocalizations?.apply_for_scholarship,
        'assetAddress': "assets/services/Apply for a Scholarship.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()))
      },
      {
        'title': appLocalizations?.myApplications,
        'assetAddress': "assets/services/Application Status.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ApplicationStatusView()))
      },
      if(role == UserRole.scholarStudent)...{
        {
          'title': appLocalizations?.my_scholarship,
          'assetAddress': "assets/services/My Scholarship.svg",
          "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const MyScholarshipView()))
        },
        {
          'title': appLocalizations?.finance,
          'assetAddress': "assets/services/Finance 2.svg",
          "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
                  createRoute(const FinanceView()))
        },
        {
          'title': appLocalizations?.request,
          'assetAddress': "assets/services/Request 2.svg",
          "routeBuilder": () =>
              _navigationServices.pushSimpleWithAnimationRoute(
                  createRoute(const RequestView()))
        },
        {
          'title': appLocalizations?.academic_advisor,
          'assetAddress': "assets/services/Academic Advisor.svg",
          "routeBuilder": () =>
              _navigationServices.pushSimpleWithAnimationRoute(
                  createRoute(const AcademicAdvisorView()))
        },
        {
          'title': appLocalizations?.guidance_notes,
          'assetAddress': "assets/services/Guidance Notes.svg",
          "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const GuidanceNotesView()))
        },

        {
          'title': appLocalizations?.employmentStatusTitle,
          'assetAddress': "assets/services/Work Status.svg",
          "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const WorkStatusView()))
        },
          {
            'title': appLocalizations?.address,
            'assetAddress': "assets/services/Address.svg",
            "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const AddressesView()))
          },
      }
    ];

    List<SimpleTileModel> itemsList = [];

    for (var element in accountItemsMapList) {
      itemsList.add(SimpleTileModel.fromJson(element));
    }

    if(isLogged){
      return Padding(
        padding: EdgeInsets.all(kPadding),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            final item = itemsList[index];
            return Padding(
              padding:  EdgeInsets.only(bottom: kTileSpace),
              // padding: (index < itemsList.length - 1)
              //     ? const EdgeInsets.only(top: 10.0)
              //     : (index == itemsList.length - 1)
              //     ? const EdgeInsets.only(top: 10,bottom: 10)
              //     : EdgeInsets.zero,
              child: SimpleTile(item: item,
                leadingHeight: 40,
                leadingWidth: 40,
              ),
            );
          },
        ),
      );
    }
    else{
      return Padding(
        padding:  EdgeInsets.all(kPadding),
        child: SimpleCard(expandedContent:  Column(children: [Text(appLocalizations!.servicesUnavailable)],)),
      );
    }
  }
}
