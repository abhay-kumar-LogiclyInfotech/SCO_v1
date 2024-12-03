import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/view/main_view/notifications/notification_detail_view.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../viewModel/services/navigation_services.dart';
import '../../../resources/app_text_styles.dart';
import '../../../viewModel/notifications_view_models/get_notifications_count_viewModel.dart';


class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;



  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// get all notifications
      await Provider.of<GetAllNotificationsViewModel>(context, listen: false).getAllNotifications();
      await Provider.of<GetNotificationsCountViewModel>(context,listen: false).getNotificationsCount();

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
        backgroundColor: AppColors.bgColor,
        appBar: CustomSimpleAppBar(titleAsString: localization.notificationCenter,inNotifications: true,),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(localization: localization), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi({required AppLocalizations localization}) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetAllNotificationsViewModel>(
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
                        // Edit Addresses Button
                          provider.apiResponse.data?.isNotEmpty ?? false ?
                          _notificationsSection(provider: provider,langProvider: langProvider,localization: localization) : Utils.showOnNoDataAvailable()
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

  Widget _notificationsSection(
      {required GetAllNotificationsViewModel provider, required LanguageChangeViewModel langProvider ,required AppLocalizations localization}) {


    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.apiResponse.data?.length ?? 0,
      itemBuilder: (context, index) {
        // Sort the notifications based on `isNew` before building the list
        final sortedData = (provider.apiResponse.data ?? [])
          ..sort((a, b) {
            // Convert isNew to integer for comparison: true (1), false (0)
            final isNewA = (a.isNew ?? false) ? 1 : 0;
            final isNewB = (b.isNew ?? false) ? 1 : 0;
            return isNewB.compareTo(isNewA);
          });

        final element = sortedData[index];

        return Padding(
          padding: EdgeInsets.only(bottom: kPadding),
          child: SimpleCard(
            onTap: () {
              // Navigate to notification details
              _navigationServices.pushCupertino(
                CupertinoPageRoute(
                  builder: (context) => NotificationDetailView(notification: element),
                ),
              );
            },
            contentPadding: EdgeInsets.zero,
            expandedContent: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // ------------ Advisor's Section ------------
                CustomInformationContainerField(
                  title: "",
                  descriptionAsWidget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Row(
                      children: [
                        element.isNew ?? false
                            ? SvgPicture.asset("assets/bell.svg")
                            : SvgPicture.asset("assets/message_seen_bell.svg"),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            element.subject ?? '',
                            style: AppTextStyles.normalTextStyle().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: AppColors.scoButtonColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      CustomInformationContainerField(
                        title: localization.from,
                        description: element.from ?? '',
                      ),
                      CustomInformationContainerField(
                        title: localization.status,
                        description: getFullNameFromLov(
                          langProvider: langProvider,
                          lovCode: 'NOTIFICATION_STS',
                          code: element.status ?? '',
                        ),
                      ),
                      CustomInformationContainerField(
                        title: localization.createdOn,
                        description: convertTimestampToDateTime(element.createDate ?? 0),
                        isLastItem: true,
                      ),
                      kFormHeight,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );


  }
}
