import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';

import '../../../utils/utils.dart';
import '../../../viewModel/apply_scholarship/deleteDraftViewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class ApplicationStatusView extends StatefulWidget {
  const ApplicationStatusView({super.key});

  @override
  State<ApplicationStatusView> createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> with MediaQueryMixin, WidgetsBindingObserver, RouteAware, TickerProviderStateMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  late TabController _tabController;








  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();

      await _onRefresh();
    });

    /// INITIALIZE THE TAB-CONTROLLER
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  Future<void> _onRefresh() async {
    /// fetch list of application status
    await Provider.of<GetListApplicationStatusViewModel>(context, listen: false).getListApplicationStatus();
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
      appBar: CustomSimpleAppBar(
        titleAsString: "Application Status",
      ),
      body: Utils.modelProgressHud(
        processing: _isProcessing,
        child: _buildUi()
      )

    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Column(
      children: [
        TabBar(
          automaticIndicatorColorAdjustment: false,
          controller: _tabController,
          // dividerColor: Colors.black,
          indicatorColor: AppColors.scoButtonColor,
          labelColor: AppColors.scoButtonColor,
          // indicatorWeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
          labelStyle: const  TextStyle(
              color: AppColors.scoButtonColor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
          unselectedLabelColor: AppColors.scoButtonColor,
          overlayColor: WidgetStateProperty.resolveWith((state){
            if(state.contains(WidgetState.selected)){
              return Colors.green;
            }
            else if(state.contains(WidgetState.pressed)){
              return Colors.grey.shade300;
            }
            else if( state.contains(WidgetState.focused)){
              return Colors.red;
            }
            else if( state.contains(WidgetState.focused)){
              return Colors.red;
            }
            else if( state.contains(WidgetState.scrolledUnder)){
              return Colors.red;
            }
            else{
              return Colors.red;
            }

          }),
          tabs: [
            Tab(icon: SvgPicture.asset("assets/myAccount/completed_applications.svg"),iconMargin: EdgeInsets.all(8),child: Text("Completed"),),
            Tab(icon: SvgPicture.asset("assets/myAccount/draft_applications.svg"),iconMargin: EdgeInsets.all(8),child: Text("Draft"),),
          ],
        ),
        Expanded(
          child: Material(
            color: Colors.white,
            child: Consumer<GetListApplicationStatusViewModel>(
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
                    child: Padding(
                      padding:  EdgeInsets.all(kPadding),
                      child: TabBarView(
                          controller: _tabController,
                          children: [
                        _applicationsSection(provider: provider, langProvider: langProvider,draftTab:false),
                        _applicationsSection(provider: provider, langProvider: langProvider,draftTab:true),
                      ]),
                    ),
                  );

                case Status.NONE:
                  return showVoid;
                case null:
                  return showVoid;
              }
            }),
          ),
        ),
      ],
    );
  }

  ///*------ Applications Section------*
  Widget _applicationsSection({
    required GetListApplicationStatusViewModel provider,
    required LanguageChangeViewModel langProvider,
    required bool draftTab
  }) {
    return RefreshIndicator(
      color: Colors.white,backgroundColor: AppColors.scoThemeColor,onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: CustomInformationContainer(
          title: "Application Status",
          expandedContentPadding: EdgeInsets.zero,
          expandedContent: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.apiResponse.data?.data?.applicationStatus?.length ?? 0,
            itemBuilder: (context, index) {
              final element = provider.apiResponse.data!.data!.applicationStatus[index];
              final application = element.applicationStatus;
              final configurationKey = element.submissionConfigurationKey;
              bool isDraft = application.programAction == "DRAFT";
              {
               return Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(kPadding),
                    child: Column(
                      children: [
                        CustomInformationContainerField(
                          title: "Application Type",
                          description: application.description,
                        ),
                        CustomInformationContainerField(
                          title: "Status",
                          description: application.programAction,
                        ),
                        CustomInformationContainerField(
                          title: "Academic Career",
                          description: configurationKey,
                          isLastItem: false,
                        ),
                        if (isDraft)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<DeleteDraftViewmodel>(
                                builder: (context, provider, _) {
                                  return IconsOutlineButton(
                                    text: 'Delete',
                                    padding: const EdgeInsets.all(10),
                                    iconData: Icons.cancel_outlined,
                                    textStyle: const TextStyle(color: Colors.red),
                                    iconColor: Colors.red,
                                    onPressed: () async {
                                      setProcessing(true);
                                      await provider.deleteDraft(
                                        draftId: application.applicationProgramNumber ?? '',
                                      );
                                      await _onRefresh();
                                      setProcessing(false);
                                    },
                                  );
                                },
                              ),
                              IconsButton(
                                onPressed: () {
                                  _navigationServices.pushCupertino(
                                    CupertinoPageRoute(
                                      builder: (context) => FillScholarshipFormView(
                                        draftId: application.applicationProgramNumber ?? '',
                                      ),
                                    ),
                                  );
                                },
                                text: 'Edit',
                                iconData: Icons.arrow_circle_right_outlined,
                                color: AppColors.scoThemeColor,
                                textStyle: const TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const MyDivider(color: AppColors.darkGrey)
                ],
              );
             }
            },
          ),
        ),
      ),
    );
  }



  // Widget _applicationsSection(
  //     {required GetListApplicationStatusViewModel provider,
  //     required LanguageChangeViewModel langProvider}) {
  //   return Column(
  //     children: provider.apiResponse.data!.data!.applicationStatus.map((element) {
  //       final application = element.applicationStatus;
  //       final configurationKey = element.submissionConfigurationKey;
  //       bool isDraft = application.programAction == "DRAFT";
  //       return Column(
  //         children: [
  //           SimpleCard(
  //               expandedContent: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               CustomInformationContainerField(
  //                 title: "Application Type",
  //                 description: application.description,
  //               ),
  //               CustomInformationContainerField(
  //                 title: "Status",
  //                 description: application.programAction,
  //               ),
  //
  //               CustomInformationContainerField(
  //                 title: "Academic Career",
  //                 description: configurationKey,
  //                 isLastItem: false,
  //               ),
  //
  //               /// edit draft button
  //               /// delete draft button
  //               if (isDraft)
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     /// Delete Draft button
  //                     ///
  //                     ///
  //                     Consumer<DeleteDraftViewmodel>(
  //                       builder: (context, provider, _) {
  //                         return
  //                         IconsOutlineButton(
  //                           text: 'Delete',
  //                           padding: const EdgeInsets.all(10),
  //                           iconData: Icons.cancel_outlined,
  //                           textStyle: const TextStyle(color: Colors.red),
  //                           iconColor: Colors.red,
  //                           onPressed: () async {
  //
  //                             setProcessing(true);
  //                             /// delete Draft Permanent
  //                             await provider.deleteDraft(draftId: application.applicationProgramNumber ?? '');
  //                             /// refreshing the data
  //                             await _onRefresh();
  //                             setProcessing(false);
  //
  //                           },
  //
  //                         );
  //                       },
  //                     ),
  //
  //                     IconsButton(
  //                       onPressed: () {
  //                         _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>FillScholarshipFormView(draftId: application.applicationProgramNumber ?? '',)));
  //                       },
  //                       text: 'Edit',
  //                       iconData: Icons.arrow_circle_right_outlined,
  //                       color: AppColors.scoThemeColor,
  //                       textStyle: const TextStyle(color: Colors.white),
  //                       iconColor: Colors.white,
  //                     ),
  //                     // CustomButton(
  //                     //     buttonName: "Delete Draft",
  //                     //     borderColor: Colors.red.shade400,
  //                     //     buttonColor: Colors.red.shade100,
  //                     //     textColor: Colors.red,
  //                     //     borderRadius: BorderRadius.circular(10),
  //                     //     isLoading: false,
  //                     //     textDirection: getTextDirection(langProvider),
  //                     //     onTap: () {}),
  //                     /// Edit Draft button
  //                     // CustomButton(
  //                     //     buttonName: "Edit Draft",
  //                     //     borderColor: Colors.brown.shade400,
  //                     //     buttonColor: Colors.brown.shade100,
  //                     //     textColor: Colors.brown,
  //                     //     borderRadius: BorderRadius.circular(10),
  //                     //     isLoading: false,
  //                     //     textDirection: getTextDirection(langProvider),
  //                     //     onTap: () {})
  //                   ],
  //                 )
  //             ],
  //           )),
  //           kFormHeight,
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }
}
