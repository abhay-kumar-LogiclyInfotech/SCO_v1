// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:sco_v1/resources/components/tiles/simple_tile.dart';
// import 'package:sco_v1/utils/utils.dart';
// import 'package:sco_v1/view/drawer/custom_drawer_views/contact_us_view.dart';
// import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
// import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
// import 'package:sco_v1/viewModel/services/navigation_services.dart';
//
// import '../../hive/hive_manager.dart';
// import '../../models/account/simple_tile_model.dart';
// import '../../resources/app_colors.dart';
// import '../../resources/getRoles.dart';
// import '../../viewModel/authentication/get_roles_viewModel.dart';
// import '../../viewModel/language_change_ViewModel.dart';
// import '../../l10n/app_localizations.dart';
//
// class SupportView extends StatefulWidget {
//   const SupportView({super.key});
//
//   @override
//   State<SupportView> createState() => _SupportViewState();
// }
//
// class _SupportViewState extends State<SupportView> with MediaQueryMixin {
//   late NavigationServices _navigationServices;
//
//   @override
//   void initState() {
//     final GetIt getIt = GetIt.instance;
//     WidgetsBinding.instance.addPostFrameCallback((callback) async {
//       _navigationServices = getIt.get<NavigationServices>();
//       setIsProcessing(true);
//       // Getting Fresh Roles
//       final getRolesProvider =
//           Provider.of<GetRoleViewModel>(context, listen: false);
//       await getRolesProvider.getRoles();
//       role = getRoleFromList(HiveManager.getRole());
//       setIsProcessing(false);
//       setState(() {});
//     });
//     super.initState();
//   }
//
//   List<SimpleTileModel> itemsList = [];
//   bool _isInitialized = false;
//
//   /// Get Roles
//   UserRole? role;
//   bool _isProcessing = false;
//
//   setIsProcessing(value) {
//     setState(() {
//       _isProcessing = value;
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     if (!_isInitialized) {
//       // Initialize once
//
//       _onRefresh();
//       _isInitialized = true;
//     }
//   }
//
//   Future<void> _onRefresh() async {
//     setIsProcessing(true);
//     final localization = AppLocalizations.of(context);
//     final getRolesProvider = Provider.of<GetRoleViewModel>(context, listen: false);
//     await getRolesProvider.getRoles();
//     role = getRoleFromList(HiveManager.getRole());
//     itemsList.clear();
//     final supportItemsMapList = [
//       {
//         'title': localization?.contactUs,
//         'assetAddress': "assets/support/contact_us.svg",
//         "routeBuilder": () => _navigationServices
//             .pushSimpleWithAnimationRoute(createRoute(const ContactUsView()))
//       },
//       {
//         'title': localization?.faqs,
//         'assetAddress': "assets/support/faq.svg",
//         "routeBuilder": () => _navigationServices
//             .pushSimpleWithAnimationRoute(createRoute(const FaqView()))
//       },
//       if (role == UserRole.scholarStudent)
//         {
//           'title': localization?.academic_advisor,
//           'assetAddress': "assets/support/advisor_contact_details.svg",
//           "routeBuilder": () =>
//               _navigationServices.pushSimpleWithAnimationRoute(
//                   createRoute(const AcademicAdvisorView()))
//         },
//     ];
//
//     for (var element in supportItemsMapList) {
//       itemsList.add(SimpleTileModel.fromJson(element));
//     }
//     setState(() {});
//     setIsProcessing(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         body: Utils.modelProgressHud(
//             child: Utils.pageRefreshIndicator(
//                 child: _buildUI(), onRefresh: _onRefresh),
//             processing: _isProcessing));
//   }
//
//   Widget _buildUI() {
//     return Padding(
//       padding: EdgeInsets.all(kPadding), // Ensure kPadding is defined
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: itemsList
//               .map((item) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SimpleTile(item: item),
//                   ))
//               .toList(), // Convert the mapped items to a list of widgets
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/tiles/simple_tile.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/contact_us_view.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/faq_view.dart';
import 'package:sco_v1/view/main_view/services_views/academic_advisor.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../hive/hive_manager.dart';
import '../../models/account/simple_tile_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/getRoles.dart';
import '../../viewModel/authentication/get_roles_viewModel.dart';
import '../../viewModel/language_change_ViewModel.dart';
import '../../l10n/app_localizations.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late LanguageChangeViewModel _languageChangeViewModel;

  /// Get Roles
  UserRole? role;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _initializeRoles();
  }

  void _initializeServices() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _languageChangeViewModel = Provider.of<LanguageChangeViewModel>(context, listen: false);
  }

  Future<void> _initializeRoles() async {
    final getRolesProvider = Provider.of<GetRoleViewModel>(context, listen: false);
    await getRolesProvider.getRoles();
    role = getRoleFromList(HiveManager.getRole());
    setState(() {}); // Trigger rebuild after roles are fetched
  }

  List<SimpleTileModel> _buildItemsList(AppLocalizations localization) {
    return [
      SimpleTileModel.fromJson({
        'title': localization.contactUs,
        'assetAddress': "assets/support/support_1_0_1/Contact Us.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const ContactUsView())),
      }),
      SimpleTileModel.fromJson({
        'title': localization.faqs,
        'assetAddress': "assets/support/support_1_0_1/FAQ.svg",
        "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const FaqView())),
      }),
      if (role == UserRole.scholarStudent)
        SimpleTileModel.fromJson({
          'title': localization.academic_advisor,
          'assetAddress': "assets/support/support_1_0_1/Academic Advisor.svg",
          "routeBuilder": () => _navigationServices.pushSimpleWithAnimationRoute(createRoute(const AcademicAdvisorView())),
        }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    // Watch for language changes to rebuild UI dynamically
     Provider.of<LanguageChangeViewModel>(context);

    final itemsList = _buildItemsList(localization);

    return Scaffold(
      body: Utils.modelProgressHud(
        child: Utils.pageRefreshIndicator(
          child: _buildUI(itemsList),
          onRefresh: _initializeRoles,
        ),
        processing: role == null,
      ),
    );
  }

  Widget _buildUI(List<SimpleTileModel> itemsList) {
    return Padding(
      padding:  EdgeInsets.all(kPadding), // Ensure kPadding is defined
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: itemsList.map((item) => Padding(
              padding:  EdgeInsets.only(bottom: kTileSpace),
              child: SimpleTile(
                item: item,
              ),
            ),
          )
           .toList(),
        ),
      ),
    );
  }
}
