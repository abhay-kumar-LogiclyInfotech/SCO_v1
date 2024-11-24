import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class MyScholarshipView extends StatefulWidget {
  const MyScholarshipView({super.key});

  @override
  State<MyScholarshipView> createState() => _MyScholarshipViewState();
}

class _MyScholarshipViewState extends State<MyScholarshipView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;



  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      /// fetch my application with approved
      await Provider.of<MyScholarshipViewModel>(context, listen: false).getMyScholarship();

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
    return

      Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomSimpleAppBar(titleAsString: "My Scholarship"),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<MyScholarshipViewModel>(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Employment status card
                        _applicationsSection(provider: provider, langProvider: langProvider),
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

  Widget _applicationsSection({required MyScholarshipViewModel provider, required LanguageChangeViewModel langProvider}) {
    // return Column(
    //   children: provider.apiResponse.data!.data!.scholarships!.map((Scholarships element)
    //   {
    //
    //     return SimpleCard(expandedContent: Column(
    //       children: [
    //         Text(element?.country ?? ''),
    //       ],
    //     ));
    //
    //   }).toList(),
    // );
    final studentId = provider.apiResponse.data?.data?.dataDetails?.emplId ?? '';

   final listOfScholarships =  provider.apiResponse.data?.data?.dataDetails?.scholarships ?? [];
    return
    (listOfScholarships.isNotEmpty)?
     ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOfScholarships.length,
      itemBuilder: (context, index) {
        final element = listOfScholarships[index];
        return SimpleCard(
          expandedContent: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              /// ------------ MY SCHOLARSHIP (APPROVED SCHOLARSHIP) DETAILS ------------
              CustomInformationContainerField(
                title: "Scholarship Name",
                description: "SCO${element.academicCareer}${element.scholarshipType}",
              ),
              CustomInformationContainerField(
                title: "Country-University",
                description: getFullNameFromLov(
                  lovCode: 'EXT_ORG_ID',
                  code: '${element.university}',
                  langProvider: langProvider,
                ) ,
              ),
              CustomInformationContainerField(
                title: "Country",
                description: getFullNameFromLov(
                  lovCode: 'COUNTRY',
                  code: '${element.country}',
                  langProvider: langProvider,
                ),
              ),
              CustomInformationContainerField(
                title: "Major",
                description: element.academicCareer ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Program Duration",
                description: element.numberOfYears ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Approved Date",
                description: element.scholarshipApprovedDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Scholarship Start Date",
                description: element.studyStartDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Scholarship End Date",
                description: element.scholarshipEndDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Application Number",
                description: element.applicationNo ?? '- -',
              ),
              CustomInformationContainerField(
                title: "Student Id",
                description: studentId,
                isLastItem: true,
              ),
            ],
          ),
        );
      },
    ) : Utils.showOnNoDataAvailable();

    // return Column(
    //   children: provider.apiResponse.data?.data?.dataDetails?.scholarships?.map((element) {
    //     return SimpleCard(expandedContent: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         /// ------------ MY SCHOLARSHIP (APPROVED SCHOLARSHIP) DETAILS ------------
    //       CustomInformationContainerField(title: "Scholarship Name", description: "SCO${element.academicCareer}${element.scholarshipType}"),
    //       CustomInformationContainerField(title: "Country-University", description:  getFullNameFromLov(lovCode: 'EXT_ORG_ID',code: '${element.university}',langProvider: langProvider)     ),
    //       CustomInformationContainerField(title: "Country", description: getFullNameFromLov(lovCode: 'COUNTRY',code: '${element.country}',langProvider: langProvider)  ),
    //       CustomInformationContainerField(title: "Major", description: element.academicCareer),
    //       CustomInformationContainerField(title: "Program Duration", description: element.numberOfYears),
    //       CustomInformationContainerField(title: "Approved Date", description: element.scholarshipApprovedDate),
    //       CustomInformationContainerField(title: "Scholarship Start Date", description: element.studyStartDate),
    //       CustomInformationContainerField(title: "Scholarship End Date", description: element.scholarshipEndDate),
    //       CustomInformationContainerField(title: "Application Number", description: element.applicationNo),
    //       CustomInformationContainerField(title: "Student Id", description: studentId,isLastItem: true),
    //       ]
    //     ));
    //   }).toList() ?? [],
    // );
  }
}
