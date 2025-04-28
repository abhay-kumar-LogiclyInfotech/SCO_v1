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
import 'package:sco_v1/viewModel/notifications_view_models/get_notifications_count_viewModel.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';
import 'package:html/parser.dart' as html;

import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../l10n/app_localizations.dart';

import '../../../../viewModel/services/navigation_services.dart';
import '../../../models/notifications/GetAllNotificationsModel.dart';
import '../../../resources/app_text_styles.dart';
import 'package:flutter_html/flutter_html.dart' as flutter_html;

class NotificationDetailView extends StatefulWidget {
  final GetAllNotificationsModel notification;

  const NotificationDetailView({super.key, required this.notification});

  @override
  State<NotificationDetailView> createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView>
    with MediaQueryMixin {
  Future _initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      try {
        /// Decrease the notification count:
        final decreaseCountProvider = Provider.of<DecreaseNotificationCountViewModel>(context, listen: false);
        final notification = widget.notification;
        final form = {
          "userId": notification.userId ?? '',
          "notificationId": notification.notificationId ?? '',
          "emplId": notification.emplId ?? ''
        };

        /// Calling decrease count api
        await decreaseCountProvider.decreaseNotificationCount(form: form);

        /// Refreshing the notifications now
        /// get all notifications
        await Provider.of<GetNotificationsCountViewModel>(context,
                listen: false)
            .getNotificationsCount();
        await Provider.of<GetAllNotificationsViewModel>(context, listen: false)
            .getAllNotifications();
      } catch (e) {
        // print(e.toString());
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
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
      appBar: CustomSimpleAppBar(
        titleAsString: localization.notificationDetails,
        inNotifications: true,
      ),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization: localization),
              onRefresh: _initializeData)),
    );
  }

  Widget _buildUi({required AppLocalizations localization}) {
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
                padding:  EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // See Full notification details
                    _notificationDetailsSection(
                        provider: widget.notification,
                        langProvider: langProvider,
                        localization: localization)
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
      {required GetAllNotificationsModel provider,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return SimpleCard(
      contentPadding: EdgeInsets.zero,
      expandedContent: Column(children: [
        CustomInformationContainerField(
            title: "",
            descriptionAsWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: kCardPadding),
              child: Row(
                children: [
                  provider.isNew ?? false
                      ? SvgPicture.asset("assets/bell.svg")
                      : SvgPicture.asset("assets/message_seen_bell.svg"),
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
          padding: EdgeInsets.symmetric(horizontal: kCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInformationContainerField(
                  title: localization.from, description: provider?.from ?? ''),
              CustomInformationContainerField(
                  title: localization.createdOn,
                  description:
                      convertTimestampToDateTime(provider?.createDate ?? 0)),
              // CustomInformationContainerField(
              //     title: localization.status,
              //     description: getFullNameFromLov(
              //         langProvider: langProvider,
              //         lovCode: 'NOTIFICATION_STS',
              //         code: provider?.status ?? '')),
              CustomInformationContainerField(
                  title: localization.notificationType,
                  description: getFullNameFromLov(
                      langProvider: langProvider,
                      lovCode: 'NOTIFICATION_TYPE',
                      code: provider?.notificationType ?? '')),
              // CustomInformationContainerField(
              //     title: localization.importance,
              //     description: getFullNameFromLov(
              //         langProvider: langProvider,
              //         lovCode: 'NOTIF_IMPORTANCE',
              //         code: provider?.importance ?? '')),
              CustomInformationContainerField(
                  title: localization.subject,
                  description: provider?.subject ?? ''),
              Text(
                localization.message,
                style: AppTextStyles.subTitleTextStyle(),
              ),
              Html(
                data: provider.messageText ?? '',
                onAnchorTap: (a, b, c) async {
                  await Utils.launchingUrl(a);
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
