import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
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

    /// INITIALIZE THE TAB--CONTROLLER
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  List<ApplicationStatus> _draftApplicationStatus = [];
  List<ApplicationStatus> _otherApplicationStatus = [];

  Future<void> _onRefresh() async {
    /// fetch list of application status
   final applicationStatusProvider = Provider.of<GetListApplicationStatusViewModel>(context, listen: false);
    await applicationStatusProvider.getListApplicationStatus();

    if(applicationStatusProvider.apiResponse.status == Status.COMPLETED){
      if(applicationStatusProvider.apiResponse.data?.data?.applicationStatus != null ){
        if(applicationStatusProvider.apiResponse.data?.data?.applicationStatus.isNotEmpty ?? false){
          _draftApplicationStatus.clear();
          _otherApplicationStatus.clear();
          for(var element in applicationStatusProvider.apiResponse.data!.data!.applicationStatus){
            if(element.applicationStatus.programAction == 'DRAFT'){
              _draftApplicationStatus.add(element);
            }
            else{
              _otherApplicationStatus.add(element);
            }
          }
        }
      }
    }


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
        titleAsString: "My Application",
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

        /// Tab Bar
        TabBar(
          automaticIndicatorColorAdjustment: false,
          controller: _tabController,
          // dividerColor: Colors.black,
          indicatorColor: AppColors.scoButtonColor,
          labelColor: AppColors.scoButtonColor,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
          labelStyle: AppTextStyles.bold15ScoButtonColorTextStyle(),
          unselectedLabelStyle: AppTextStyles.bold15ScoButtonColorTextStyle().copyWith(fontSize: 13),
          unselectedLabelColor: AppColors.scoButtonColor,
          dragStartBehavior: DragStartBehavior.down,
          overlayColor: WidgetStateProperty.resolveWith((state){
            if(state.contains(WidgetState.selected)){
              return Colors.green;
            }
            else if(state.contains(WidgetState.pressed)){
              return AppColors.scoThemeColor.withOpacity(0.3);
            }
            else if( state.contains(WidgetState.focused)){
              return Colors.red;
            }
            else if( state.contains(WidgetState.scrolledUnder)){
              return Colors.red;
            }
            else if( state.contains(WidgetState.hovered)){
              return Colors.red;
            }
            else{
              return Colors.red;
            }

          }),
          indicator: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColors.scoButtonColor, width: 1.5), // Bottom border only
            ),
          ),
          tabs: [
            Tab(icon: SvgPicture.asset("assets/myAccount/com""pleted_applications.svg",height: 14,width: 14,),iconMargin: const EdgeInsets.all(8),child: const Text("Completed"),),
            Tab(icon: SvgPicture.asset("assets/myAccount/draft_applications.svg",height: 14,width: 14,),iconMargin: const EdgeInsets.all(8),child: const Text("Draft"),),
          ],
        ),
        /// Tab Bar View which holds the applications
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
                            _otherApplicationsSection(langProvider: langProvider,draftTab:false),
                            _draftApplicationsSection(langProvider: langProvider,draftTab:true),
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


  /// show the content on the basis of application status
  bool showOnStatusBasis(ApplicationStatusDetail? application){
    if( application?.programAction?.toString().toUpperCase().trim() == 'APPL' ||
         application?.programAction?.toString().toUpperCase().trim() == 'ADMT' ||
         application?.programAction?.toString().toUpperCase().trim() == 'UNDP' ||
         application?.programAction?.toString().toUpperCase().trim() == 'DENY'
    ){
      return false;
  }
  return true;
  }


  ///*------------ other Applications Section------------*
  Widget _otherApplicationsSection({
    required LanguageChangeViewModel langProvider,
    required bool draftTab,
  }) {
    return Utils.pageRefreshIndicator(
      onRefresh: _onRefresh,
      child: _otherApplicationStatus.isEmpty ?? true
          ?  Utils.showOnNoDataAvailable()
          : SingleChildScrollView(
        child: CustomInformationContainer(
          title: "Application Details", // Hardcoded for title
          expandedContentPadding: EdgeInsets.zero,
          expandedContent: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _otherApplicationStatus.length,
            itemBuilder: (context, index) {
              final element = _otherApplicationStatus[index];
              final application = element.applicationStatus;
              final configurationKey = element.submissionConfigurationKey;
               return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(kPadding),
                      child: Column(
                        children: [
                          CustomInformationContainerField(
                            title: "S. No",
                            description: (index+1).toString() ?? '--',
                          ),
                          CustomInformationContainerField(
                            title: "Application Type",
                            description: configurationKey ?? '--',
                          ),
                          CustomInformationContainerField(
                            title: "Application Number",
                            description: application?.admApplicationNumber ?? '--',
                          ),
                          CustomInformationContainerField(
                            title: "Status",
                            description: getFullNameFromLov(
                              langProvider: langProvider,
                              lovCode: 'PROGRAM_ACTION',
                              code: application?.programAction
                                  ?.toString()
                                  .toUpperCase()
                                  .trim() ??
                                  '',
                            ),
                          ),
                          CustomInformationContainerField(
                            title: "Scholarship Type",
                            description: application?.scholarshipType ?? '--',
                          ),


                          if(showOnStatusBasis(application))
                            Column(
                              children: [
                                CustomInformationContainerField(
                                  title: "Country",
                                  description: application?.scholarship?.country != null ? getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code: application?.scholarship?.country) : '--',
                                ),
                                CustomInformationContainerField(
                                  title: "University",
                                  description: application?.scholarship?.university?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Major",
                                  description: application?.scholarship?.academicPlan?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Approved Date",
                                  description: application?.scholarship?.scholarshipApprovedDate?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Scholarship Start Date",
                                  description: application?.scholarship?.studyStartDate?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Scholarship End Date",
                                  description: application?.scholarship?.scholarshipEndDate?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Academic Career",
                                  description: application?.scholarship?.academicCareer?.toString() ?? '--',
                                ),
                                CustomInformationContainerField(
                                  title: "Academic Career", // Hardcoded
                                  description: element.submissionConfigurationKey ?? '--',
                                  isLastItem: false,
                                ),
                              ],
                            ),
                          actionButtonHolder(actionButtons: [
                            actionButton(backgroundColor: AppColors.SUCCESS, text: "View", onPressed: (){}),
                            actionButton(backgroundColor: AppColors.INFO, text: "Attachments", onPressed: (){}),
                            actionButton(backgroundColor: AppColors.scoMidThemeColor, text: "Wish List", onPressed: (){}),
                          ]
                          )
                        ],
                      ),
                    ),
                    if(index < _otherApplicationStatus.length - 1 ) const MyDivider(color: AppColors.darkGrey)
                  ],
                );
              }
          ),
        ),
      ),
    );
  }



  ///*------------ Draft Applications Section------------*
  Widget _draftApplicationsSection({
    required LanguageChangeViewModel langProvider,
    required bool draftTab
  }) {
    return Utils.pageRefreshIndicator(onRefresh: _onRefresh,child:
    _draftApplicationStatus.isEmpty ?? true
        ?  Utils.showOnNoDataAvailable()
    :

    CustomInformationContainer(
      title: "Application Status",
      expandedContentPadding: EdgeInsets.zero,
      expandedContent: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _draftApplicationStatus.length,
        itemBuilder: (context, index) {
          final element = _draftApplicationStatus[index];
          final application = element.applicationStatus;
          final configurationKey = element.submissionConfigurationKey;
          bool isDraft = application.programAction == "DRAFT";

          if(isDraft) {
            return Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(kPadding),
                  child: Column(
                    children: [
                      CustomInformationContainerField(
                        title: "S. No",
                        description: (index+1).toString() ?? '--',
                      ),
                      CustomInformationContainerField(
                        title: "Application Type",
                        description: application.description,
                      ),

                      /// TODO: Change this for new applications
                      CustomInformationContainerField(
                        title: "Status",
                        description: application?.programAction?.toString(),
                      ),
                      CustomInformationContainerField(
                        title: "Academic Career",
                        description: configurationKey,
                        isLastItem: false,
                      ),
                      if (isDraft)
                      actionButtonHolder(actionButtons: [
                        actionButton(backgroundColor: AppColors.INFO,
                            text: "Edit",
                            onPressed: () {
                             _navigationServices.pushCupertino(
                             CupertinoPageRoute(
                              builder: (context) =>
                                  FillScholarshipFormView(
                                    draftId: application.applicationProgramNumber ?? '',),),);}),
                        Consumer<DeleteDraftViewmodel>(
                          builder: (context, provider, _) {
                            return actionButton(backgroundColor: AppColors.DANGER, text: "Delete", onPressed: () async {
                              setProcessing(true);
                              print( application.applicationProgramNumber ?? '');
                              await provider.deleteDraft(
                                draftId: application.applicationProgramNumber ?? '',
                              );
                              await _onRefresh();
                              setProcessing(false);
                            });}),
                      ])

                    ],
                  ),
                ),
                if(index < _draftApplicationStatus.length - 1 ) const MyDivider(color: AppColors.darkGrey)
              ],
            );
          }
        },
      ),
    ));
  }


  /// Action Button for application
  Widget actionButton({required backgroundColor,required text,required onPressed}){
    return CustomMaterialButton(onPressed: onPressed,backgroundColor: backgroundColor ,visualDensity: VisualDensity.compact,child: Text(text,style: AppTextStyles.myApplicationsEditButton()));
  }

  Widget actionButtonHolder({required List<Widget> actionButtons}){
    return SizedBox(
      width: double.infinity,
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Actions",style: AppTextStyles.subTitleTextStyle()),
          Wrap(
            spacing: kPadding,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: actionButtons,
          ),
        ],
      ),

    );
  }

}
