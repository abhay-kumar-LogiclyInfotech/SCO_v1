import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../resources/components/custom_vertical_divider.dart';
import '../../../resources/components/requests_count_container.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services_viewmodel/get_all_requests_viewModel.dart';
import '../services_views/request_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeRequestsView extends StatefulWidget {
  const HomeRequestsView({super.key});

  @override
  State<HomeRequestsView> createState() => _HomeRequestsViewState();
}

class _HomeRequestsViewState extends State<HomeRequestsView> with MediaQueryMixin {


  late NavigationServices _navigationServices;
  @override
  void initState() {
    super.initState();
    final getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetAllRequestsViewModel>(
        builder: (context, requestsProvider, _) {
          switch (requestsProvider.apiResponse.status) {
            case Status.LOADING:
              return showVoid;
            case Status.ERROR:
              return showVoid;
            case Status.NONE:
              return showVoid;
            case Status.COMPLETED:
              final requests =
                  requestsProvider.apiResponse.data?.data?.listOfRequest;
              final totalRequests =
                  requestsProvider.apiResponse.data?.data?.listOfRequest?.length;
              final approvedRequests =
                  requests?.where((r) => r.status == "APPROV")?.length ?? 0;
              final pendingRequests =
                  requests?.where((r) => r.status == "RECVD")?.length ?? 0;
              final rejectedRequests =
                  requests?.where((r) => r.status == "DENY")?.length ?? 0;
              return Column(
                children: [
                  kSmallSpace,
                  HomeViewCard(
                      title: AppLocalizations.of(context)!.requests,
                      icon: SvgPicture.asset("assets/request.svg"),
                      langProvider: langProvider,
                      // headerExtraContent: RequestsCountContainer(color: Colors.blue.shade600, count: totalRequests),
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        _navigationServices.pushCupertino(CupertinoPageRoute(
                            builder: (context) => const RequestView()));
                      },
                      content: Column(
                        children: [
                          //  Padding(
                          //   padding: const EdgeInsets.only(left: 50.0,right: 50),
                          //   child: Text(
                          //     AppLocalizations.of(context)!.totalNumberOfRequests,
                          //     style: const TextStyle(fontSize: 14, height: 2.5),
                          //   ),
                          // ),
                          // kFormHeight,
                          const SizedBox(height: 8),
                          const Divider(),
                          Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: screenWidth < 370
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _requestElementList(
                                  approvedRequests: approvedRequests,
                                  pendingRequests: pendingRequests,
                                  rejectedRequests: rejectedRequests),
                            )
                                : Row(
                              // crossAxisAlignment: WrapCrossAlignment.center,
                              // runAlignment: WrapAlignment.start,
                              // alignment: WrapAlignment.spaceAround,
                              // runSpacing: 10,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: _requestElementList(
                                  approvedRequests: approvedRequests,
                                  pendingRequests: pendingRequests,
                                  rejectedRequests: rejectedRequests),
                            ),
                          )
                          // kFormHeight,
                          // kFormHeight,
                        ],
                      )),
                ],
              );
            case null:
              return showVoid;
          }
        });


  }

  List<Widget> _requestElementList(
      {approvedRequests, pendingRequests, rejectedRequests}) {
    return [
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.approved,
          count: approvedRequests,
          color: Colors.green.shade500),
      screenWidth < 370
          ? const Divider()
          : CustomVerticalDivider(
        height: 35,
        color: Colors.transparent,
      ),
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.pending,
          count: pendingRequests,
          color: const Color(0xffF4AA73)),
      screenWidth < 370
          ? const Divider()
          : CustomVerticalDivider(
        height: 35,
        color: Colors.transparent,
      ),
      _requestTypeWithCount(
          requestType: AppLocalizations.of(context)!.rejected,
          count: rejectedRequests,
          color: AppColors.DANGER),
    ];
  }

  /// Req
  Widget _requestTypeWithCount(
      {String requestType = "",
        dynamic color = Colors.black,
        dynamic count = 0}) {
    final langProvider = context.read<LanguageChangeViewModel>();
    return Container(
      width: screenWidth < 370 ? double.infinity : 100,
      alignment: screenWidth < 370
          ? getTextDirection(langProvider) == TextDirection.rtl
          ? Alignment.centerRight
          : Alignment.centerLeft
          : Alignment.center,
      color: Colors.transparent,
      child: screenWidth < 370
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(requestType,
                style: const TextStyle(
                    color: AppColors.scoButtonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox.square(dimension: 5),
          RequestsCountContainer(color: color, count: count),
        ],
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RequestsCountContainer(color: color, count: count),
          const SizedBox.square(dimension: 5),
          Text(requestType,
              style: const TextStyle(
                  color: AppColors.scoButtonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
