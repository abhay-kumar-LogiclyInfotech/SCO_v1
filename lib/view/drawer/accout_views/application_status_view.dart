import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get_it/get_it.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/view/apply_scholarship/fill_scholarship_form_view.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/get_list_application_status_viewmodel.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';

import '../../../utils/utils.dart';
import '../../../viewModel/apply_scholarship/deleteDraftViewmodel.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class ApplicationStatusView extends StatefulWidget {
  const ApplicationStatusView({super.key});

  @override
  State<ApplicationStatusView> createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;


  /// selected value:
  String _selectedAcademicCareer = '';

  /// Academic career menuItemList
  List<GetAllActiveScholarshipsModel?>? academicCareerMenuItemList = [];

  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context, listen: false);
      await provider.getAllActiveScholarships(context: context, langProvider: Provider.of<LanguageChangeViewModel>(context, listen: false));


    });

    /// fetch list of application status
    await Provider.of<GetListApplicationStatusViewModel>(context, listen: false).getListApplicationStatus();
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
      appBar: CustomSimpleAppBar(
        titleAsString: "Application Status",
      ),
      body: Utils.modelProgressHud(
        processing: _isProcessing,
        child: _buildUi()
      )

      ,
    );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetListApplicationStatusViewModel>(
        builder: (context, provider, _) {
      switch (provider.apiResponse.status) {
        case Status.LOADING:
          return Utils.pageLoadingIndicator();

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
                    _applicationsSection(
                        provider: provider, langProvider: langProvider),
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

  Widget _applicationsSection(
      {required GetListApplicationStatusViewModel provider,
      required LanguageChangeViewModel langProvider}) {
    return Column(
      children:
          provider.apiResponse.data!.data!.applicationStatus.map((element) {
        final application = element.applicationStatus;
        final configurationKey = element.submissionConfigurationKey;
        bool isDraft = application.programAction == "DRAFT";

        return Column(
          children: [
            SimpleCard(
                expandedContent: Column(
              mainAxisSize: MainAxisSize.max,
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

                /// edit draft button
                /// delete draft button
                if (isDraft)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Delete Draft button
                      ///
                      ///
                      Consumer<DeleteDraftViewmodel>(
                        builder: (context, provider, _) {
                          return
                          IconsOutlineButton(
                            text: 'Delete',
                            padding: const EdgeInsets.all(10),
                            iconData: Icons.cancel_outlined,
                            textStyle: const TextStyle(color: Colors.red),
                            iconColor: Colors.red,
                            onPressed: () async {

                              setProcessing(true);
                              /// delete Draft Permanent
                              await provider.deleteDraft(draftId: application.applicationProgramNumber ?? '');
                              /// refreshing the data
                              await _initializeData();
                              setProcessing(false);

                            },

                          );
                        },
                      ),

                      IconsButton(
                        onPressed: () {
                          // _navigationServices.pushReplacementCupertino(CupertinoPageRoute(builder: (context)=>FillScholarshipFormView(draftId: application.applicationProgramNumber ?? '')));
                        },
                        text: 'Edit',
                        iconData: Icons.arrow_circle_right_outlined,
                        color: AppColors.scoThemeColor,
                        textStyle: const TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                      ),
                      // CustomButton(
                      //     buttonName: "Delete Draft",
                      //     borderColor: Colors.red.shade400,
                      //     buttonColor: Colors.red.shade100,
                      //     textColor: Colors.red,
                      //     borderRadius: BorderRadius.circular(10),
                      //     isLoading: false,
                      //     textDirection: getTextDirection(langProvider),
                      //     onTap: () {}),
                      /// Edit Draft button
                      // CustomButton(
                      //     buttonName: "Edit Draft",
                      //     borderColor: Colors.brown.shade400,
                      //     buttonColor: Colors.brown.shade100,
                      //     textColor: Colors.brown,
                      //     borderRadius: BorderRadius.circular(10),
                      //     isLoading: false,
                      //     textDirection: getTextDirection(langProvider),
                      //     onTap: () {})
                    ],
                  )
              ],
            )),
            kFormHeight,
          ],
        );
      }).toList(),
    );
  }
}
