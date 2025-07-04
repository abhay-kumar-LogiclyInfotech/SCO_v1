import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/Custom_Material_Button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/attachments_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/edit_employment_history_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/edit_graduation_details_View.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/edit_major_and_universities_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/edit_required_examinations_view.dart';
import 'package:sco_v1/view/drawer/accout_views/edit_applied_application_sections/view_application_details_view.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/splash/commonData_model.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_simple_app_bar.dart';

import '../../../utils/utils.dart';
import '../../../viewModel/apply_scholarship/deleteDraftViewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../viewModel/services/alert_services.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'edit_applied_application_sections/edit_high_school_details_view.dart';

class ApplicationStatusView extends StatefulWidget {
  const ApplicationStatusView({super.key});

  @override
  State<ApplicationStatusView> createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> with MediaQueryMixin, WidgetsBindingObserver, RouteAware, TickerProviderStateMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;
  late AlertServices _alertServices;

  late TabController _tabController;

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();
      _alertServices = getIt.get<AlertServices>();



      /// add listener to tab
      _tabController.addListener(() {
        if(_tabController.indexIsChanging){
          setState(() {
          });
        }
      });

      await _onRefresh();
    });

    /// INITIALIZE THE TAB- -CONTROLLER
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  final List<ApplicationStatus> _draftApplicationStatus = [];
  final List<ApplicationStatus> _otherApplicationStatus = [];
  final List<ApplicationStatus> _allApplications = [];

  Future<void> _onRefresh() async {
    try{

      // _draftApplicationStatus.clear();
      // _otherApplicationStatus.clear();
      _allApplications.clear();
      /// fetch list of application status
      final applicationStatusProvider = Provider.of<GetListApplicationStatusViewModel>(context, listen: false);
      await applicationStatusProvider.getListApplicationStatus();

      if(applicationStatusProvider.apiResponse.status == Status.COMPLETED){
        if(applicationStatusProvider.apiResponse.data?.data?.applicationStatus != null ){
          if(applicationStatusProvider.apiResponse.data?.data?.applicationStatus.isNotEmpty ?? false){
            // _draftApplicationStatus.clear();
            // _otherApplicationStatus.clear();
            _allApplications.clear();
            for(var element in applicationStatusProvider.apiResponse.data!.data!.applicationStatus){
              _allApplications.add(element);
              // if(element.applicationStatus.programAction == 'DRAFT'){
              //   _draftApplicationStatus.add(element);
              // }
              // else{
              //   _otherApplicationStatus.add(element);
              // }
            }
          }
        }
      }
    }
    catch (e,stackTrace){
      print(stackTrace);
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
    final localization = AppLocalizations.of(context)!;


    return Scaffold(
      appBar: CustomSimpleAppBar(
        titleAsString: localization.myApplications,
      ),
      body: Utils.modelProgressHud(
        processing: _isProcessing,
        child: _buildUi(localization)
      )

    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Column(
        children: [

          /// Tab Bar
          // Container(
          //   color: _tabController.index == 1 ? Colors.green.withAlpha(100) : AppColors.scoThemeColor.withAlpha(50),
          //   child: TabBar(
          //     automaticIndicatorColorAdjustment: false,
          //     controller: _tabController,
          //     // dividerColor: Colors.black,
          //     indicatorColor: AppColors.scoButtonColor,
          //     labelColor: AppColors.scoButtonColor,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          //     indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
          //     labelStyle: AppTextStyles.bold15ScoButtonColorTextStyle(),
          //     unselectedLabelStyle: AppTextStyles.bold15ScoButtonColorTextStyle().copyWith(fontSize: 13),
          //     unselectedLabelColor: AppColors.scoButtonColor,
          //     dragStartBehavior: DragStartBehavior.down,
          //     overlayColor: WidgetStateProperty.resolveWith((state){
          //       if(state.contains(WidgetState.selected)){
          //         return Colors.green;
          //       }
          //       else if(state.contains(WidgetState.pressed)){
          //         return AppColors.scoThemeColor.withOpacity(0.3);
          //       }
          //       else if( state.contains(WidgetState.focused)){
          //         return Colors.red;
          //       }
          //       else if( state.contains(WidgetState.scrolledUnder)){
          //         return Colors.red;
          //       }
          //       else if( state.contains(WidgetState.hovered)){
          //         return Colors.red;
          //       }
          //       else{
          //         return Colors.red;
          //       }
          //
          //     }),
          //     indicator: const BoxDecoration(
          //       color: Colors.white,
          //       border: Border(
          //         bottom: BorderSide(color: AppColors.scoButtonColor, width: 1.5), // Bottom border only
          //       ),
          //     ),
          //     tabs: [
          //       Tab(icon: SvgPicture.asset("assets/myAccount/com""pleted_applications.svg",height: 14,width: 14,),iconMargin: const EdgeInsets.all(8),child:  Text(localization.completed),),
          //       Tab(icon: SvgPicture.asset("assets/myAccount/draft_applications.svg",height: 14,width: 14,),iconMargin: const EdgeInsets.all(8),child:  Text(localization.draft),),
          //     ],
          //   ),
          // ),
          /// Tab Bar View which holds the applications
          Expanded(
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
                      child:  _allApplicationsSection(langProvider: langProvider,localization: localization),



                      // TabBarView(
                      //     controller: _tabController,
                      //     children: [
                      //       _otherApplicationsSection(langProvider: langProvider,draftTab:false,localization: localization),
                      //       _draftApplicationsSection(langProvider: langProvider,draftTab:true,localization: localization),
                      // ]),
                    ),
                  );

                case Status.NONE:
                  return showVoid;
                case null:
                  return showVoid;
              }
            }),
          ),
        ],
      ),
    );
  }


  /// show the content on the basis of application status
  bool showOnStatusBasis(ApplicationStatusDetail? application){
    if( application?.programAction?.toString().toUpperCase().trim() == 'APPL' ||
         application?.programAction?.toString().toUpperCase().trim() == 'ADMT' ||
         application?.programAction?.toString().toUpperCase().trim() == 'UNDP' ||
         application?.programAction?.toString().toUpperCase().trim() == 'DENY'
    )
    // if(application?.programAction?.toString().toUpperCase().trim() == 'DRAFT')
    {
      return false;
  }
  return true;
  }



  _allApplicationsSection({
    required LanguageChangeViewModel langProvider,
    required AppLocalizations localization}){
    return Utils.pageRefreshIndicator(
        onRefresh: _onRefresh,
        child:  _allApplications.isEmpty ?  Utils.showOnNoDataAvailable(context: context,text: localization.noApplication) : SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _allApplications.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (context,index){
                return  SizedBox(height: kCardSpace,);
              },
              itemBuilder: (context, index) {
                final element = _allApplications[index];
                final application = element.applicationStatus;
                final applicationScholarship = element.applicationStatus.scholarship;
                final configurationKey = element.submissionConfigurationKey;
                bool isNotDraft = (application.programAction != 'DRAFT');
                return SimpleCard(
                  cardColor: isNotDraft ? AppColors.greenColor.withAlpha(800) : AppColors.scoThemeColor.withAlpha(800),
                  expandedContent: Column(
                    children: isNotDraft ? [
                      Column(
                        children: [
                          // CustomInformationContainerField(
                          //   title: localization.sr,
                          //   description: (index+1).toString() ?? '- -',
                          // ),

                          CustomInformationContainerField(
                            title: localization.applicationType,
                            description: Constants.getNameOfScholarshipByConfigurationKey(localization: localization,configurationKey: configurationKey)  ?? '- -',
                          ),
                          CustomInformationContainerField(
                            title: localization.applicationNumber,
                            description: application?.admApplicationNumber ?? '- -',
                          ),
                          CustomInformationContainerField(
                            title: localization.applicationStatus,
                            description: getFullNameFromLov(
                              langProvider: langProvider,
                              lovCode: 'PROGRAM_ACTION',
                              code: application.programAction
                                  ?.toString()
                                  .toUpperCase()
                                  .trim() ??
                                  '',
                            ),
                          ),
                          CustomInformationContainerField(
                              title: localization.scholarshipType,
                              description: getFullNameFromLov(langProvider: langProvider,code: application.scholarshipType,lovCode: 'SCHOLARSHIP_TYPE')
                          ),

                          if(showOnStatusBasis(application))
                            Column(
                              children: [
                                CustomInformationContainerField(
                                  title: localization.country,
                                  description: application.scholarship?.country != null ? getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code: application?.scholarship?.country) : '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.university,
                                  // description: application?.scholarship?.university?.toString() ?? '- -',
                                  description: getFullNameForUniversity(context: context,value: applicationScholarship?.university?.toString(), country: applicationScholarship?.country ?? '', admitType: applicationScholarship?.admitType, scholarshipType: applicationScholarship?.scholarshipType),
                                ),

                                // CustomInformationContainerField(
                                //   title: localization.majors,
                                //   description: getFullNameForMajor(value: applicationScholarship?.academicPlan?.toString(),
                                //       isStudyCountry: applicationScholarship?.country == 'UAE',
                                //       isSpecialCase: false,
                                //       academicCareer: element.applicationStatus.acadCareer ??'',
                                //       scholarshipType: element.applicationStatus.scholarshipType ??'',
                                //       admitType: element.applicationStatus.admitType ?? '',
                                //       context: context,
                                //   )
                                //
                                // application?.scholarship?.academicPlan?.toString() ?? '- -',
                                // ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipApprovedDate,
                                  description: application.scholarship?.scholarshipApprovedDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipStartDate,
                                  description: application.scholarship?.studyStartDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipEndDate,
                                  description: application.scholarship?.scholarshipEndDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.academicCareer,
                                  description: getFullNameFromLov(langProvider: langProvider,code: element.applicationStatus.acadCareer?.toString() ?? '- -',lovCode: 'ACADEMIC_CAREER')

                                  ,isLastItem: true,
                                ),
                              ],
                            ),
                          actionButtonHolder(actionButtons: [
                            /// VIEW APPLICATION
                            actionButton(backgroundColor: AppColors.scoThemeColor, text: localization.viewDetails, onPressed: (){
                              _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> ViewApplicationDetailsView(
                                applicationStatusDetails: application,
                                configurationKey:configurationKey,
                              )));
                            }),
                            /// UPLOAD APPROVED ATTACHMENTS
                            if(application?.attachmentAllowed ?? false)
                              actionButton(backgroundColor: AppColors.INFO, text: localization.attachments, onPressed: (){
                                _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> AttachmentsView(
                                  applicationStatusDetails: application,
                                  configurationKey: configurationKey,
                                )));
                              }),
                            /// UNIVERSITY WISHLIST
                            // actionButton(backgroundColor: AppColors.scoMidThemeColor, text: localization.universityWishlist, onPressed: (){
                            //   _alertServices.toastMessage(localization.comingSoon);
                            // }),
                            /// EDIT BUTTON
                            /// SHOW EDIT BUTTON IF EDITING IS ALLOWED
                            if(application.editAllowed || application.editAllowed.toString() == 'true')
                              actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.edit, onPressed: (){

                                /// show options which are available to edit for specific application
                                showModalBottomSheet
                                  (context: context,
                                    builder: (context){return
                                      Container(
                                        // height: screenHeight/4,
                                        width: screenWidth,
                                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
                                        decoration: const BoxDecoration(
                                            color: Colors.white
                                        ),
                                        child: SafeArea(
                                          child: GridView(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing:10,childAspectRatio: 5),
                                            children: [
                                              /// EDIT HIGH-SCHOOL DETAILS
                                              if(application.schoolEditAllowed.toString().toUpperCase() == 'Y' && shouldShowHighSchoolDetails(application.acadCareer))
                                                actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.highSchoolDetails, onPressed: (){
                                                  /// Move to required examinations list
                                                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditHighSchoolDetailsView(
                                                    applicationStatusDetails: application,
                                                  )));
                                                }),

                                              /// EDIT GRADUATION DETAILS
                                              if(application.graduationEditAllowed.toString().toUpperCase() == 'Y' && shouldShowGraduationSection(application.acadCareer))
                                                actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.graduationDetails, onPressed: (){
                                                  /// Move to Edit Graduation Details
                                                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditGraduationDetailsView(
                                                    applicationStatusDetails: application,
                                                  )));
                                                }),

                                              /// EDIT UNIVERSITY AND MAJORS DETAILS
                                              if(application.wishListEditAllowed.toString().toUpperCase() == 'Y' && shouldShowUniversityAndMajors(application.acadCareer))
                                                actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.universityAndMajor, onPressed: (){
                                                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditMajorsAndUniversityView(
                                                    applicationStatusDetails: application,
                                                    configurationKey: configurationKey,
                                                  )));
                                                }),

                                              /// EDIT UNIVERSITY AND MAJORS DETAILS
                                              if(application.testEditAllowed.toString().toUpperCase() == 'Y' && shouldShowRequiredExaminations(application.acadCareer))
                                                actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.requiredExamination, onPressed: (){
                                                  /// Move to required examinations list
                                                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditRequiredExaminationsView(
                                                    applicationStatusDetails: application,
                                                  )));
                                                }),

                                              /// EDIT EMPLOYMENT HISTORY DETAILS
                                              if(application.workExpEditAllowed.toString().toUpperCase() == 'Y' && shouldShowEmploymentHistory(configurationKey))
                                                actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.employmentHistory, onPressed: (){
                                                  /// move to edit employment history
                                                  _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditEmploymentHistoryView(
                                                    applicationStatusDetails: application,
                                                  )));
                                                }),
                                            ],
                                          ),
                                        ),
                                      );});
                              }),
                          ]
                          )
                        ],
                      ),
                      if(index < _otherApplicationStatus.length - 1 ) const MyDivider(color: AppColors.darkGrey)
                    ] : [
                      Column(
                        children: [
                          // CustomInformationContainerField(
                          //   title: localization.sr,
                          //   description: (index+1).toString() ?? '- -',
                          // ),
                          CustomInformationContainerField(
                            title: localization.applicationType,
                            description: Constants.getNameOfScholarshipByConfigurationKey(localization: localization,configurationKey: configurationKey)  ?? '- -',
                          ),

                          CustomInformationContainerField(
                            title: localization.applicationStatus,
                            description: application.programAction?.toString(),
                          ),
                          CustomInformationContainerField(
                            title: localization.academicCareer, /// We will show application name here
                            // description: configurationKey,
                            description: getFullNameFromLov(langProvider: langProvider,code: application.acadCareer,lovCode: 'ACADEMIC_CAREER'),
                            isLastItem: false,
                          ),
                          if (true)
                            actionButtonHolder(actionButtons: [
                              /// Delete Action Button
                              Consumer<DeleteDraftViewmodel>(builder: (context, provider, _) {
                                return actionButton(backgroundColor: AppColors.scoThemeColor, text: localization.deleteDraftApplication, onPressed: () async {

                                  Dialogs.materialDialog(
                                      barrierDismissible: false,
                                      title: localization.deleteDraftApplication,
                                      msg:localization.deleteDraftConfirmation,
                                      color: Colors.white,
                                      context: context,
                                      actionsBuilder: (context)
                                      {
                                        return [
                                          /// delete draft
                                          CustomButton(buttonName: localization.deleteDraftApplication, isLoading: false, textDirection: getTextDirection(langProvider), onTap:  ()async{
                                            setProcessing(true);
                                            _navigationServices.goBack();
                                            await provider.deleteDraft(draftId: application.applicationProgramNumber ?? '',);
                                            setProcessing(false);
                                            await _onRefresh();
                                          }),


                                          // Cancel deletion
                                          CustomButton(buttonName: localization.no, isLoading: false,buttonColor: Colors.white,borderColor: Colors.grey,textColor: Colors.grey, textDirection: getTextDirection(langProvider), onTap: (){
                                            _navigationServices.goBack();
                                          },),
                                        ];
                                      }


                                  );


                                });}),
                              /// Edit Action Button
                              actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.edit, onPressed: () {_navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => FillScholarshipFormView(draftId: application.applicationProgramNumber ?? '',),),);}),

                            ])
                        ],
                      ),
                      if(index < _draftApplicationStatus.length - 1 ) const MyDivider(color: AppColors.darkGrey)
                    ]



                    ,
                  ),
                );
              }
          ),
        ),
    );
  }







  ///*- -- -- -- -- -- - other Applications Section- -- -- -- -- -- -*
  Widget _otherApplicationsSection({
    required LanguageChangeViewModel langProvider,
    required bool draftTab,
    required AppLocalizations localization
  }) {
    return Utils.pageRefreshIndicator(
      onRefresh: _onRefresh,
      child: _otherApplicationStatus.isEmpty ?? true
          ?  Utils.showOnNoDataAvailable(context: context,text: localization.noApplication)
          : SingleChildScrollView(
        child: CustomInformationContainer(
          title: localization.applicationDetails,
          expandedContentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset("assets/services/request_details.svg"),
          expandedContent: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _otherApplicationStatus.length,
            itemBuilder: (context, index) {
              final element = _otherApplicationStatus[index];
              final application = element.applicationStatus;
              final applicationScholarship = element.applicationStatus.scholarship;
              final configurationKey = element.submissionConfigurationKey;
               return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(kPadding),
                      child: Column(
                        children: [
                          // CustomInformationContainerField(
                          //   title: localization.sr,
                          //   description: (index+1).toString() ?? '- -',
                          // ),

                          CustomInformationContainerField(
                            title: localization.applicationType,
                            description: Constants.getNameOfScholarshipByConfigurationKey(localization: localization,configurationKey: configurationKey)  ?? '- -',
                          ),
                          CustomInformationContainerField(
                            title: localization.applicationNumber,
                            description: application?.admApplicationNumber ?? '- -',
                          ),
                          CustomInformationContainerField(
                            title: localization.applicationStatus,
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
                            title: localization.scholarshipType,
                            description: getFullNameFromLov(langProvider: langProvider,code: application?.scholarshipType,lovCode: 'SCHOLARSHIP_TYPE')
                          ),

                          if(showOnStatusBasis(application))
                            Column(
                              children: [
                                CustomInformationContainerField(
                                  title: localization.country,
                                  description: application?.scholarship?.country != null ? getFullNameFromLov(langProvider: langProvider,lovCode: 'COUNTRY',code: application?.scholarship?.country) : '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.university,
                                  // description: application?.scholarship?.university?.toString() ?? '- -',
                                  description: getFullNameForUniversity(context: context,value: applicationScholarship?.university?.toString(), country: applicationScholarship?.country ?? '', admitType: applicationScholarship?.admitType, scholarshipType: applicationScholarship?.scholarshipType),
                                ),

                                // CustomInformationContainerField(
                                //   title: localization.majors,
                                //   description: getFullNameForMajor(value: applicationScholarship?.academicPlan?.toString(),
                                //       isStudyCountry: applicationScholarship?.country == 'UAE',
                                //       isSpecialCase: false,
                                //       academicCareer: element.applicationStatus.acadCareer ??'',
                                //       scholarshipType: element.applicationStatus.scholarshipType ??'',
                                //       admitType: element.applicationStatus.admitType ?? '',
                                //       context: context,
                                //   )
                                //
                                  // application?.scholarship?.academicPlan?.toString() ?? '- -',
                                // ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipApprovedDate,
                                  description: application?.scholarship?.scholarshipApprovedDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipStartDate,
                                  description: application?.scholarship?.studyStartDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.scholarshipEndDate,
                                  description: application?.scholarship?.scholarshipEndDate?.toString() ?? '- -',
                                ),
                                CustomInformationContainerField(
                                  title: localization.academicCareer,
                                  description: getFullNameFromLov(langProvider: langProvider,code: element.applicationStatus.acadCareer?.toString() ?? '- -',lovCode: 'ACADEMIC_CAREER')

                                  ,isLastItem: true,
                                ),
                              ],
                            ),
                          actionButtonHolder(actionButtons: [
                            /// VIEW APPLICATION
                            actionButton(backgroundColor: AppColors.scoThemeColor, text: localization.viewDetails, onPressed: (){
                              _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> ViewApplicationDetailsView(
                                applicationStatusDetails: application,
                                  configurationKey:configurationKey,
                              )));
                            }),
                            /// UPLOAD APPROVED ATTACHMENTS
                            if(application?.attachmentAllowed ?? false)
                              actionButton(backgroundColor: AppColors.INFO, text: localization.attachments, onPressed: (){
                              _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> AttachmentsView(
                                applicationStatusDetails: application,
                                configurationKey: configurationKey,
                              )));
                            }),
                            /// UNIVERSITY WISHLIST
                            // actionButton(backgroundColor: AppColors.scoMidThemeColor, text: localization.universityWishlist, onPressed: (){
                            //   _alertServices.toastMessage(localization.comingSoon);
                            // }),
                            /// EDIT BUTTON
                            /// SHOW EDIT BUTTON IF EDITING IS ALLOWED
                            if(application.editAllowed || application.editAllowed.toString() == 'true')
                            actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.edit, onPressed: (){

                              /// show options which are available to edit for specific application
                              showModalBottomSheet
                                (context: context,
                                  builder: (context){return
                                Container(
                                  // height: screenHeight/4,
                                  width: screenWidth,
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: kPadding),
                                  decoration: const BoxDecoration(
                                    color: Colors.white
                                ),
                                child: SafeArea(
                                  child: GridView(
                                   shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing:10,childAspectRatio: 5),
                                    children: [
                                      /// EDIT HIGH-SCHOOL DETAILS
                                      if(application.schoolEditAllowed.toString().toUpperCase() == 'Y' && shouldShowHighSchoolDetails(application.acadCareer))
                                      actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.highSchoolDetails, onPressed: (){
                                        /// Move to required examinations list
                                        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditHighSchoolDetailsView(
                                          applicationStatusDetails: application,
                                        )));
                                      }),

                                      /// EDIT GRADUATION DETAILS
                                      if(application.graduationEditAllowed.toString().toUpperCase() == 'Y' && shouldShowGraduationSection(application.acadCareer))
                                        actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.graduationDetails, onPressed: (){
                                          /// Move to Edit Graduation Details
                                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditGraduationDetailsView(
                                            applicationStatusDetails: application,
                                          )));
                                      }),

                                      /// EDIT UNIVERSITY AND MAJORS DETAILS
                                      if(application.wishListEditAllowed.toString().toUpperCase() == 'Y' && shouldShowUniversityAndMajors(application.acadCareer))
                                        actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.universityAndMajor, onPressed: (){
                                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditMajorsAndUniversityView(
                                            applicationStatusDetails: application,
                                            configurationKey: configurationKey,
                                          )));
                                      }),

                                      /// EDIT UNIVERSITY AND MAJORS DETAILS
                                      if(application.testEditAllowed.toString().toUpperCase() == 'Y' && shouldShowRequiredExaminations(application.acadCareer))
                                        actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.requiredExamination, onPressed: (){
                                          /// Move to required examinations list
                                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditRequiredExaminationsView(
                                            applicationStatusDetails: application,
                                          )));
                                        }),

                                      /// EDIT EMPLOYMENT HISTORY DETAILS
                                      if(application.workExpEditAllowed.toString().toUpperCase() == 'Y' && shouldShowEmploymentHistory(configurationKey))
                                        actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.employmentHistory, onPressed: (){
                                          /// move to edit employment history
                                          _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> EditEmploymentHistoryView(
                                            applicationStatusDetails: application,
                                          )));
                                      }),
                                    ],
                                  ),
                                ),
                                );});
                            }),
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



  ///*- -- -- -- -- -- - Draft Applications Section- -- -- -- -- -- -*
  Widget _draftApplicationsSection({
    required LanguageChangeViewModel langProvider,
    required bool draftTab,
    required AppLocalizations localization
  }) {
    return Utils.pageRefreshIndicator(onRefresh: _onRefresh,
        child: _draftApplicationStatus.isEmpty ?? true ?  Utils.showOnNoDataAvailable(context: context,text: localization.youDontHaveDraft)
    :
    CustomInformationContainer(
      title: localization.applicationDetails,
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/request_details.svg"),
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
                      // CustomInformationContainerField(
                      //   title: localization.sr,
                      //   description: (index+1).toString() ?? '- -',
                      // ),
                      CustomInformationContainerField(
                        title: localization.applicationType,
                        description: Constants.getNameOfScholarshipByConfigurationKey(localization: localization,configurationKey: configurationKey)  ?? '- -',
                      ),

                      CustomInformationContainerField(
                        title: localization.applicationStatus,
                        description: application?.programAction?.toString(),
                      ),
                      CustomInformationContainerField(
                        title: localization.academicCareer, /// We will show application name here
                        // description: configurationKey,
                        description: getFullNameFromLov(langProvider: langProvider,code: application.acadCareer,lovCode: 'ACADEMIC_CAREER'),
                        isLastItem: false,
                      ),
                      if (isDraft)
                      actionButtonHolder(actionButtons: [
                        /// Delete Action Button
                        Consumer<DeleteDraftViewmodel>(builder: (context, provider, _) {
                          return actionButton(backgroundColor: AppColors.scoThemeColor, text: localization.deleteDraftApplication, onPressed: () async {

                            Dialogs.materialDialog(
                                barrierDismissible: false,
                                title: localization.deleteDraftApplication,
                                msg:localization.deleteDraftConfirmation,
                                color: Colors.white,
                                context: context,
                                actionsBuilder: (context)
                                {
                                  return [
                                    /// delete draft
                                    CustomButton(buttonName: localization.deleteDraftApplication, isLoading: false, textDirection: getTextDirection(langProvider), onTap:  ()async{
                                      setProcessing(true);
                                      _navigationServices.goBack();
                                      await provider.deleteDraft(draftId: application.applicationProgramNumber ?? '',);
                                      setProcessing(false);
                                      await _onRefresh();
                                    }),


                                    // Cancel deletion
                                    CustomButton(buttonName: localization.no, isLoading: false,buttonColor: Colors.white,borderColor: Colors.grey,textColor: Colors.grey, textDirection: getTextDirection(langProvider), onTap: (){
                                      _navigationServices.goBack();
                                    },),
                                  ];
                                }


                            );


                          });}),
                        /// Edit Action Button
                        actionButton(backgroundColor: AppColors.scoButtonColor, text: localization.edit, onPressed: () {_navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => FillScholarshipFormView(draftId: application.applicationProgramNumber ?? '',),),);}),

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







  Widget actionButtonHolder({required List<Widget> actionButtons}){
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(localization.actions,style: AppTextStyles.subTitleTextStyle()),
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

/// Action Button for application
Widget actionButton({required backgroundColor,required text,required onPressed}){
  return CustomMaterialButton(onPressed: onPressed,backgroundColor: backgroundColor ,visualDensity: VisualDensity.compact,child: Text(text,style: AppTextStyles.myApplicationsEditButton()));
}


/// Helper method for university
List<Values> populateUniversitiesWishList(
    {
      required BuildContext context,
      required String country,
      bool isSpecialCase = false,
      String? admitType,
      String? scholarshipType,
    }


    )
{
  /// Step 1: Fetch initial list of universities based on country
  List<Values> items = fetchListOfValue("UNIVERSITY#$country#UNV",context);

  /// List to store final items
  List<Values> itemsNew = [];

  // / Step 2: Handle special case
  if (isSpecialCase ?? false) {
    // itemsNew.add(const DropdownMenuItem(
    //     value: "OTH", child: Text("آخر"))); /// "OTH" means "Other"
    itemsNew.add(Values(code: 'OTH',value: 'Other',valueArabic: 'آخر',));
  }

  /// Step 3: Check for different admit types
  if (admitType?.toUpperCase() == "NLU") {
    /// For "NLU" admit type
    itemsNew = fetchListOfValue("EXTUNIVERSITYNL#$country#UNV",context);
  } else if (country.toUpperCase() == "GBR") {
    /// For country "GBR"
    // itemsNew.add(const DropdownMenuItem(value: "OTH", child: Text("آخر")));
    itemsNew.add(Values(code: 'OTH',value: 'Other',valueArabic: 'آخر',));
  } else if (country.toUpperCase() != "ARE" && scholarshipType?.toUpperCase() != "INT") {
    /// For countries not equal to "ARE" and scholarship type not "INT"
    itemsNew = fetchListOfValue("GRAD_UNIVERSITY#$country#UNV",context);
  } else if (scholarshipType?.toUpperCase() == "INT" && admitType?.toUpperCase() == "MET") {
    /// For "INT" scholarship type with "MET" admit type
    for (var item in items) {
      if (item.value.toString().toUpperCase() == "00000105") {
        itemsNew.add(item);
      }
    }
  } else {
    /// Default case, add all items
    itemsNew.addAll(items);
  }

  // universityInfo.universityDropdown = itemsNew;
  return itemsNew;
}


List<Values> fetchListOfValue(String key,BuildContext context) {
  /// Your logic to fetch values goes here
  final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
  if (Constants.lovCodeMap[key]?.values != null) {
    return Constants.lovCodeMap[key]!.values!;

    populateCommonDataDropdown(
      menuItemsList: Constants.lovCodeMap[key]!.values!,
      provider: langProvider,
      textColor: AppColors.scoButtonColor,
    );
  } else {
    /// Handle the case where the values are null (e.g., return an empty list or log an error)
    return []; /// or any appropriate fallback
  }
}


/// Function to get full name from university list
dynamic getFullNameForUniversity({required value,required country, required admitType,required scholarshipType,
required BuildContext context
}){
  final langProvider = Provider.of<LanguageChangeViewModel>(context);
  bool  isLTR =  getTextDirection(langProvider) == TextDirection.ltr;
  final listOfValues = populateUniversitiesWishList(country: country,admitType: admitType,scholarshipType: scholarshipType,context: context);
  for(var i in listOfValues){
    if(i.code.toString() == value.trim()){
      if(isLTR){
        return i.value.toString();
      }
      return i.valueArabic.toString();
    };
  }
  return null;
}


//// Get full name of major
/// Function to get full name for majors
String getFullNameForMajor({required value,required isStudyCountry,required isSpecialCase,required String academicCareer,String? admitType,String? scholarshipType,required BuildContext context}){
  List<dynamic> majorMenuItems =   getMajors(academicCareer: academicCareer, admitType: admitType, scholarshipType: scholarshipType, isStudyCountry: isStudyCountry, isSpecialCase: isSpecialCase);

  print(majorMenuItems.length);

  final langProvider = Provider.of<LanguageChangeViewModel>(context);
  bool  isLTR =  getTextDirection(langProvider) == TextDirection.ltr;
  for(var i in majorMenuItems){
    if(i.code.toString() == value.trim()){
      if(isLTR){
        return i.value.toString();
      }
      return i.valueArabic.toString();
    }
  }
  return '';
}

