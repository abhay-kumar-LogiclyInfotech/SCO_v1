import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/view/drawer/accout_views/application_status_view.dart';
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

class MyScholarshipView extends StatefulWidget {
  const MyScholarshipView({super.key});

  @override
  State<MyScholarshipView> createState() => _MyScholarshipViewState();
}

class _MyScholarshipViewState extends State<MyScholarshipView> with MediaQueryMixin {

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
        appBar: CustomSimpleAppBar(titleAsString: localization.my_scholarship),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(localization), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi(localization) {
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
                    padding:  EdgeInsets.all(kPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Employment status card
                        _applicationsSection(provider: provider, langProvider: langProvider,localization: localization),
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

  Widget _applicationsSection({required MyScholarshipViewModel provider, required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
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
                title: localization.scholarship,
                description: getFullNameFromLov(langProvider: langProvider,code: element.scholarshipType,lovCode: 'MY_SCHOLARSHIP')

                // Constants.getNameOfScholarshipByConfigurationKey(localization: localization, configurationKey: "SCO${element.academicCareer}${element.scholarshipType}") ,
              ),
              CustomInformationContainerField(
                title: localization.countryAndUniversity,
                description: getFullNameForUniversity(value: element.university, country: element.country, admitType: element.admitType, scholarshipType: element.scholarshipType, context: context),
                // description: getFullNameFromLov(
                //   lovCode: 'EXT_ORG_ID',
                //   code: '${element.university}',
                //   langProvider: langProvider,
                // ) ,
              ),
              CustomInformationContainerField(
                title:  localization.country,
                description: getFullNameFromLov(
                  lovCode: 'COUNTRY',
                  code: '${element.country}',
                  langProvider: langProvider,
                ),
              ),
              // CustomInformationContainerField(
              //   title:  localization.major,
              //   description: element.academicCareer ?? '- -',
              // ),
              CustomInformationContainerField(
                title: localization.programDuration,
                description: element.numberOfYears ?? '- -',
              ),
              CustomInformationContainerField(
                title: localization.scholarshipApprovedDate,
                description: element.scholarshipApprovedDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: localization.scholarshipStartDate,
                description: element.studyStartDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: localization.scholarshipEndDate,
                description: element.scholarshipEndDate ?? '- -',
              ),
              CustomInformationContainerField(
                title: localization.applicationNumber,
                description: element.applicationNo ?? '- -',
              ),
              CustomInformationContainerField(
                title: localization.studentId,
                description: studentId,
                isLastItem: true,
              ),
            ],
          ),
        );
      },
    ) : Utils.showOnNoDataAvailable(context: context);
  }
}
