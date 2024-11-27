import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/decrease_notification_count_viewModel.dart';
import 'package:sco_v1/viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';
import 'package:html/parser.dart' as html ;


import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../viewModel/services/navigation_services.dart';
import '../../../models/notifications/GetAllNotificationsModel.dart';
import '../../../resources/app_text_styles.dart';
import 'package:flutter_html/flutter_html.dart' as flutter_html;


class NotificationDetailView extends StatefulWidget {
  final GetAllNotificationsModel notification;
  const NotificationDetailView({super.key,required this.notification});

  @override
  State<NotificationDetailView> createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;



  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {


      try
      {

        /// Decrease the notification count:
        final decreaseCountProvider = Provider.of<DecreaseNotificationCountViewModel>(context,listen: false);
        final _notification = widget.notification;
        final form = {
          "userId": _notification.userId ?? '',
          "notificationId": _notification.notificationId ?? '',
          "emplId":_notification.emplId ?? ''
        };

        /// Calling decrease count api
        await decreaseCountProvider.decreaseNotificationCount(form:form);
      }

      catch(e){
        print(e.toString());
      }
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
        appBar: CustomSimpleAppBar(titleAsString: "Notification Details",inNotifications: true,),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<DecreaseNotificationCountViewModel>(
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
                        // See Full notification details
                        _notificationDetailsSection(provider: widget.notification,langProvider: langProvider)
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

  Widget _notificationDetailsSection(
      {required GetAllNotificationsModel provider, required LanguageChangeViewModel langProvider}) {


    return SimpleCard(
      contentPadding: EdgeInsets.zero,
      expandedContent:Column(children: [
        CustomInformationContainerField(
            title: "",
            descriptionAsWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                children: [
                  SvgPicture.asset("assets/bell.svg"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      provider.subject ?? '',
                      style: AppTextStyles.normalTextStyle().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.scoButtonColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInformationContainerField(
                  title: "From",
                  description: provider?.from ?? ''),
              CustomInformationContainerField(
                  title: "Created On",
                  description: convertTimestampToDateTime(provider?.createDate ?? 0)),
              CustomInformationContainerField(
                  title: "Status",
                  description:  getFullNameFromLov(langProvider: langProvider,lovCode: 'NOTIFICATION_STS',code: provider?.status ?? '') ),
              CustomInformationContainerField(
                  title: "Notification Type",
                  description: getFullNameFromLov(langProvider: langProvider,lovCode: 'NOTIFICATION_TYPE',code: provider?.notificationType ?? '') ),
              CustomInformationContainerField(
                  title: "Importance",
                  description: getFullNameFromLov(langProvider: langProvider,lovCode: 'NOTIF_IMPORTANCE',code: provider?.importance ?? '') ),
              CustomInformationContainerField(
                  title: "Subject",
                  description: provider?.subject ?? ''),
               Text("Message",style: AppTextStyles.subTitleTextStyle(),),
              Html(
                data: provider.messageText ?? '',
                onAnchorTap: (a,b,c)async{
                await  Utils.launchUrl(a);
                },
                style: {
                  "a": Style(
                    color: AppColors.scoThemeColor,
                    textDecoration: TextDecoration.underline,
                  ),
                  // "p": Style(
                  //   color: AppColors.scoButtonColor,
                  //   textDecoration: TextDecoration.none, // If no underline is needed for <p> tags
                  // ),
                  "div": Style(
                    color: AppColors.scoButtonColor,
                    fontSize: FontSize(14),
                    fontWeight: FontWeight.w600),
                },
              ),





              kFormHeight,
            ],
          ),
        ),
      ]),
    );

  }
}