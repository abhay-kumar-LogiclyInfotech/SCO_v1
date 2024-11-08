import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/account/custom_account_grid_container.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/apply_scholarship/select_scholarship_type_view.dart';
import 'package:sco_v1/view/drawer/accout_views/addresses_view.dart';
import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
import 'package:sco_v1/view/drawer/accout_views/employment_status_view.dart';
import 'package:sco_v1/view/drawer/accout_views/security_questions_view.dart';
import 'package:sco_v1/view/drawer/services_views/academic_advisor.dart';
import 'package:sco_v1/view/drawer/services_views/finance.dart';
import 'package:sco_v1/view/drawer/services_views/guidance_notes.dart';
import 'package:sco_v1/view/drawer/services_views/my_scholarship_view.dart';
import 'package:sco_v1/view/drawer/services_views/request.dart';
import 'package:sco_v1/view/drawer/services_views/work_status.dart';
import 'package:sco_v1/view/main_view/academic_services_view.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../../models/account/account_grid_container_view_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/tiles/simple_tile.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../accout_views/change_password_view.dart';
import '../accout_views/personal_details_view.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> with MediaQueryMixin {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: "Services"),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    final accountItemsMapList = [
      {
        'title': "Apply for a Scholarship",
        'assetAddress': "assets/services/apply_scholarship.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const SelectScholarshipTypeView()))
      },
      {
        'title': "My Scholarship",
        'assetAddress': "assets/services/my_scholarship.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const MyScholarshipView()))
      },
      {
        'title': "Request",
        'assetAddress': "assets/services/request.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const RequestView()))
      },
      {
        'title': "Academic Advisor",
        'assetAddress': "assets/services/academic_advisor.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const AcademicAdvisorView()))
      },
      {
        'title': "Work Status",
        'assetAddress': "assets/services/work_status.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const WorkStatusView()))
      },
      {
        'title': "Finance",
        'assetAddress': "assets/services/finance.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const FinanceView()))
      },
      {
        'title': "Guidance Notes",
        'assetAddress': "assets/services/guidance_notes.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const GuidanceNotesView()))
      },
    ];

    List<SimpleTileModel> itemsList = [];

    for (var element in accountItemsMapList) {
      itemsList.add(SimpleTileModel.fromJson(element));
    }

    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {

          final item = itemsList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SimpleTile(item: item),
          );
        },
      ),
    );


    // Previous one with gridview
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Directionality(
        textDirection: getTextDirection(langProvider),
        child: SingleChildScrollView(
          child: Column(
            children: [
//providing space from above
              const SizedBox(height: 20),

              //grid View:
              // GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: itemsList.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2, // Number of columns
              //       crossAxisSpacing: 30, // Spacing between columns
              //       mainAxisSpacing: 30, // Spacing between rows
              //       childAspectRatio: 1,
              //     ),
              //     itemBuilder: (context, index) {
              //       final lastIndex = itemsList.length - 1;
              //       SimpleTileModel item = itemsList[index];
              //       return CustomAccountGridContainer(
              //         assetAddress: item.assetAddress!,
              //         title: item.title!,
              //         onTap: item.routeBuilder!,
              //       );
              //     }),




              //Providing space from below
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
