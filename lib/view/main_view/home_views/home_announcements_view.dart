import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/notifications_view_models/get_all_notifications_viewModel.dart';
import '../notifications/notifications_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeAnnouncementsView extends StatefulWidget {
  const HomeAnnouncementsView({super.key});

  @override
  State<HomeAnnouncementsView> createState() => _HomeAnnouncementsViewState();
}

class _HomeAnnouncementsViewState extends State<HomeAnnouncementsView> with MediaQueryMixin {



  late NavigationServices _navigationServices;

  @override
  void initState() {
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetAllNotificationsViewModel>(
        builder: (context, allNotificationsProvider, _) {
          switch (allNotificationsProvider.apiResponse.status) {
            case Status.LOADING:
              return showVoid;
            case Status.ERROR:
              return showVoid;
            case Status.COMPLETED:
            // Check if there's any notification with `isNew == true`
              final hasNewNotification =
                  allNotificationsProvider.apiResponse.data?.any(
                        (notification) => notification.isNew == true,
                  ) ??
                      false;

// Get the first notification with `isNew == true` if available
              final firstNotification = hasNewNotification
                  ? allNotificationsProvider.apiResponse.data?.firstWhere(
                    (notification) => notification.isNew == true,
              )
                  : null;

              return hasNewNotification
                  ?
              Column(
                children: [
                  // kSmallSpace,
                  HomeViewCard(
                    onTap: () {
                      _navigationServices.pushCupertino(CupertinoPageRoute(
                          builder: (context) => const NotificationsView()));
                    },
                    title: AppLocalizations.of(context)!.announcement,
                    icon: SvgPicture.asset("assets/announcements.svg"),
                    langProvider: langProvider,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kFormHeight,
                        Text(
                          firstNotification?.subject ?? '',
                          style: AppTextStyles.titleTextStyle()
                              .copyWith(fontSize: 15),
                        ),
                        kFormHeight,
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.grey.shade400,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              convertTimestampToDate(
                                  firstNotification?.createDate ?? 0),
                              style: AppTextStyles.subTitleTextStyle()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              convertTimestampToTime(
                                  firstNotification?.createDate ?? 0),
                              style: AppTextStyles.subTitleTextStyle()
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  kSmallSpace,

                ],
              )
                  : showVoid;
            case Status.NONE:
              return showVoid;
            case null:
              return showVoid;
          }
        });
  }
}
