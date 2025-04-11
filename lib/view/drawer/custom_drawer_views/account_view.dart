import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/accout_views/addresses_view.dart';
import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
import 'package:sco_v1/view/drawer/accout_views/employment_status_view.dart';
import 'package:sco_v1/view/drawer/accout_views/security_questions_view.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../../data/response/status.dart';
import '../../../hive/hive_manager.dart';
import '../../../models/account/simple_tile_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/tiles/simple_tile.dart';
import '../../../resources/getRoles.dart';
import '../../../viewModel/authentication/get_roles_viewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../accout_views/change_password_view.dart';
import '../accout_views/personal_details_view.dart';
import '../../../l10n/app_localizations.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> with MediaQueryMixin {
  late NavigationServices _navigationServices;

  /// Get Roles
  UserRole? role;
  bool _isProcessing = false;

  setIsProcessing(value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      setIsProcessing(true);
      // Getting Fresh Roles
      final getRolesProvider =
          Provider.of<GetRoleViewModel>(context, listen: false);
      await getRolesProvider.getRoles();
      role = getRoleFromList(HiveManager.getRole());
      setIsProcessing(false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: localization.myAccount),
      body: _buildUi(localization),
    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    final accountItemsMapList = [
      {
        'title': localization.personalDetailsTitle,
        'assetAddress': "assets/myAccount/personal_details.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const PersonalDetailsView()))
      },
      // if (role == UserRole.scholarStudent)
      //   {
      //     'title': localization.employmentStatusTitle,
      //     'assetAddress': "assets/myAccount/employment_status.svg",
      //     "routeBuilder": () =>
      //         _navigationServices.pushSimpleWithAnimationRoute(
      //             createRoute(const EmploymentStatusView()))
      //   },
      // {
      //   'title': localization.myApplications,
      //   'assetAddress': "assets/myAccount/application_status.svg",
      //   "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
      //       createRoute(const ApplicationStatusView()))
      // },
      {
        'title': localization.change_password,
        'assetAddress': "assets/myAccount/change_password.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const ChangePasswordView()))
      },
      // if (role == UserRole.scholarStudent || role == UserRole.applicants)
      //   {
      //     'title': localization.address,
      //     'assetAddress': "assets/myAccount/addresses.svg",
      //     "routeBuilder": () => _navigationServices
      //         .pushSimpleWithAnimationRoute(createRoute(const AddressesView()))
      //   },
      {
        'title': localization.securityQuestion,
        'assetAddress': "assets/myAccount/security_questions.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(
            createRoute(const SecurityQuestionsView()))
      },
    ];

    List<SimpleTileModel> itemsList = [];

    for (var element in accountItemsMapList) {
      itemsList.add(SimpleTileModel.fromJson(element));
    }

    return Padding(
        padding: EdgeInsets.all(kPadding),
        child: Consumer<GetRoleViewModel>(builder: (context, provider, _) {
          switch (provider.apiResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator(context: context);
            case Status.ERROR:
              return showVoid;
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  final item = itemsList[index];
                  return Padding(
                    padding:  EdgeInsets.only(bottom: kTileSpace),
                    child: SimpleTile(item: item),
                  );
                },
              );
            case Status.NONE:
              return showVoid;
            case null:
              return showVoid;
          }
        }));
  }
}
