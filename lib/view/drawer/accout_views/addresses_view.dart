import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/kButtons/edit_button.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';
import 'edit_addresses_view.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// get personal details to show addresses
      await Provider.of<GetPersonalDetailsViewModel>(context, listen: false)
          .getPersonalDetails();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();

      await _initializeData();
    });

    super.initState();
  }

  bool _isProcessing = false;

  void setProcessing(bool isProcessing) {
    setState(() {
      _isProcessing = isProcessing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomSimpleAppBar(titleAsString: localization.address),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi(localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetPersonalDetailsViewModel>(
        builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator(context: context);

        case Status.ERROR:
          return Center(
            child: Text(
              AppLocalizations.of(context)!.somethingWentWrong,
            ),
          );
        case Status.COMPLETED:
          return Directionality(
            textDirection: getTextDirection(langProvider),
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Edit Addresses Button
                    (provider.apiResponse.data?.data?.userInfo?.addresses !=
                            null)
                        ? Column(
                            children: [
                              EditButton(onTap: () {
                                _navigationServices
                                    .pushSimpleWithAnimationRoute(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const EditAddressesView()));
                              }),
                              kFormHeight,

                              /// Addresses list section
                              _addressesSection(
                                  provider: provider,
                                  langProvider: langProvider,
                                  localization: localization),
                            ],
                          )
                        : Utils.showOnNoDataAvailable(context: context)
                  ],
                ),
              ),
            ),
          );

        case Status.NONE:
          return showVoid;
        case null:
          return showVoid;
      }
    });
  }

  ///*------ Applications Section------*

  Widget _addressesSection(
      {required GetPersonalDetailsViewModel provider,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            provider.apiResponse?.data?.data?.userInfo?.addresses?.length ?? 0,
        itemBuilder: (context, index) {
          final element =
              provider.apiResponse?.data?.data?.userInfo?.addresses?[index];
          return Padding(
            padding: EdgeInsets.only(bottom: kPadding),
            child: SimpleCard(
                expandedContent:
                    Column(mainAxisSize: MainAxisSize.max, children: [
              /// ------------ Addresses Section ------------
              CustomInformationContainerField(
                  title: localization.sr,
                  description: (index + 1).toString() ?? '- -'),
              CustomInformationContainerField(
                  title: localization.addressLine1,
                  description: element?.addressLine1 ?? '- -'),
              CustomInformationContainerField(
                  title: localization.addressLine2,
                  description: element?.addressLine2 ?? '- -'),
              CustomInformationContainerField(
                  title: localization.addressType,
                  description: getFullNameFromLov(
                      langProvider: langProvider,
                      lovCode: 'ADDRESS_TYPE',
                      code: element?.addressType ?? '- -')),
              CustomInformationContainerField(
                  title: localization.city,
                  description: element?.city ?? '- -'),
              CustomInformationContainerField(
                  title: localization.country,
                  description: getFullNameFromLov(
                      langProvider: langProvider,
                      lovCode: "COUNTRY",
                      code: element?.country ?? '- -')),
              CustomInformationContainerField(
                  title: localization.poBox,
                  description: element?.postalCode ?? '- -'),
              CustomInformationContainerField(
                  title: localization.state,
                  description: getFullNameFromLov(
                      langProvider: langProvider,
                      lovCode: "STATE#${element?.country ?? '- -'}",
                      code: element?.state ?? '- -'),
                  isLastItem: true),
            ])),
          );
        });
  }
}
