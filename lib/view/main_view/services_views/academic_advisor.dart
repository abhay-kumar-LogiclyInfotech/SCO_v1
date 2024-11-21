import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class AcademicAdvisorView extends StatefulWidget {
  const AcademicAdvisorView({super.key});

  @override
  State<AcademicAdvisorView> createState() => _AcademicAdvisorViewState();
}

class _AcademicAdvisorViewState extends State<AcademicAdvisorView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// get personal details to show addresses
      await Provider.of<GetMyAdvisorViewModel>(context, listen: false)
          .getMyAdvisor();
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(titleAsString: "Academic Advisor"),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetMyAdvisorViewModel>(builder: (context, provider, _) {
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (provider.apiResponse.data?.data?.listOfAdvisor != null)
                        ? Column(
                            children: [
                              /// Advisor's list section
                              _advisorsList(
                                  provider: provider,
                                  langProvider: langProvider),

                              /// meeting request button
                              _meetingRequestButton(
                                  provider: provider,
                                  langProvider: langProvider),
                            ],
                          )
                        : const Text("No Data Found")
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

  ///*------ advisor's list Section------*
  Widget _advisorsList(
      {required GetMyAdvisorViewModel provider,
      required LanguageChangeViewModel langProvider}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.apiResponse?.data?.data?.listOfAdvisor?.length ?? 0,
        itemBuilder: (context, index) {
          final element =
              provider.apiResponse?.data?.data?.listOfAdvisor?[index];
          return Padding(
            padding: EdgeInsets.only(bottom: kPadding),
            child: SimpleCard(
                contentPadding: EdgeInsets.zero,
                expandedContent:
                    Column(mainAxisSize: MainAxisSize.max, children: [
                  /// ------------ Advisor's Section ------------
                  CustomInformationContainerField(
                      title: "",
                      descriptionAsWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: Text(
                          element?.advisorName ?? '',
                          style: AppTextStyles.normalTextStyle().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: AppColors.scoButtonColor),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Column(
                      children: [
                        CustomInformationContainerField(
                          title: "Advisor Id",
                          description: element?.advisorId ?? ''),
                        CustomInformationContainerField(
                            title: "Role",
                            description: element?.advisorRoleDescription ?? ''),
                        CustomInformationContainerField(
                            title: "Contact Number",
                            description: element?.phoneNo ?? ''),
                        CustomInformationContainerField(
                            title: "Email",
                            description: element?.email ?? '',
                            isLastItem: true),
                        kFormHeight,
                      ],
                    ),
                  ),
                ])),
          );
        });
  }


  /// Meeting Request Button
  Widget _meetingRequestButton(
      {required GetMyAdvisorViewModel provider,
      required LanguageChangeViewModel langProvider}) {
    return CustomButton(
        buttonName: "MEETING REQUEST",
        isLoading: false,
        buttonColor: AppColors.scoButtonColor,
        textDirection: getTextDirection(langProvider),
        onTap: () {});
  }
}
