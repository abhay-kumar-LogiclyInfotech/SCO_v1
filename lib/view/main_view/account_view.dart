import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_account_grid_container.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/accout_views/academic_services_view.dart';
import 'package:sco_v1/view/main_view/accout_views/addresses_view.dart';
import 'package:sco_v1/view/main_view/accout_views/application_status_view.dart';
import 'package:sco_v1/view/main_view/accout_views/change_password_view.dart';
import 'package:sco_v1/view/main_view/accout_views/employment_status_view.dart';
import 'package:sco_v1/view/main_view/accout_views/security_questions_view.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../models/account/account_grid_container_view_model.dart';
import '../../resources/app_colors.dart';
import '../../viewModel/language_change_ViewModel.dart';
import 'accout_views/personal_details_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
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
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    final accountItemsMapList = [
      {
        'title': "Personal Details",
        'assetAddress': "assets/myAccount/personal_details.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const PersonalDetailsView()))
      },
      {
        'title': "Academic Services",
        'assetAddress': "assets/myAccount/academic_services.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const AcademicServicesView()))
      },
      {
        'title': "Employment Status",
        'assetAddress': "assets/myAccount/employment_status.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const EmploymentStatusView()))
      },
      {
        'title': "Application Status",
        'assetAddress': "assets/myAccount/application_status.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const ApplicationStatusView()))
      },
      {
        'title': "Change Password",
        'assetAddress': "assets/myAccount/change_password.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const ChangePasswordView()))
      },
      {
        'title': "Addresses",
        'assetAddress': "assets/myAccount/address.svg",
        "routeBuilder": () => _navigationServices
            .pushSimpleWithAnimationRoute(createRoute(const AddressesView()))
      },
      {
        'title': "Security Questions",
        'assetAddress': "assets/myAccount/security_questions.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const SecurityQuestionsView()))
      }
    ];

    List<AccountGridContainerModel> itemsList = [];

    for (var element in accountItemsMapList) {
      itemsList.add(AccountGridContainerModel.fromJson(element));
    }

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
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 30, // Spacing between columns
                    mainAxisSpacing: 30, // Spacing between rows
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final lastIndex = itemsList.length - 1;
                    AccountGridContainerModel item = itemsList[index];
                    return CustomAccountGridContainer(
                      assetAddress: item.assetAddress!,
                      title: item.title!,
                      onTap: item.routeBuilder!,
                    );
                  }),

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
