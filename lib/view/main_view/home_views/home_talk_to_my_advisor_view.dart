import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/utils/utils.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../resources/components/Custom_Material_Button.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services_viewmodel/get_my_advisor_viewModel.dart';
import '../services_views/academic_advisor.dart';
import '../../../l10n/app_localizations.dart';

class HomeTalkToMyAdvisorView extends StatefulWidget {
  const HomeTalkToMyAdvisorView({super.key});

  @override
  State<HomeTalkToMyAdvisorView> createState() =>
      _HomeTalkToMyAdvisorViewState();
}

class _HomeTalkToMyAdvisorViewState extends State<HomeTalkToMyAdvisorView>
    with MediaQueryMixin {
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
    return Consumer<GetMyAdvisorViewModel>(
      builder: (context, provider, _) {
        switch (provider.apiResponse.status) {
          case Status.LOADING:
            return showVoid;
          case Status.ERROR:
            return showVoid;
          case Status.NONE:
            return showVoid;
          case Status.COMPLETED:
            final listOfAdvisors =
                provider.apiResponse.data?.data?.listOfAdvisor ?? [];
            final topAdvisor =
                listOfAdvisors.isNotEmpty ? listOfAdvisors[0] : null;

            return listOfAdvisors.isEmpty
                ? showVoid
                : Column(
                    children: [
                      kHomeCardSpace,
                      HomeViewCard(
                          onTap: () {
                            _navigationServices.pushCupertino(
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const AcademicAdvisorView()));
                          },
                          title: AppLocalizations.of(context)!.talkToMyAdvisor,
                          icon: SvgPicture.asset(
                            "assets/support/support_1_0_1/Academic Advisor.svg",
                            height: 20,
                            width: 20,
                          ),
                          langProvider: langProvider,
                          // contentPadding: EdgeInsets.zero,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 50.0, right: 50),
                              //   child: Text(AppLocalizations.of(context)!.youCanSeeListOfAdvisors, style: const TextStyle(fontSize: 14, height: 2.5),),
                              // ),
                              // kFormHeight,
                              const NoMarginDivider(color: AppColors.lightGrey),
                              SizedBox(height: kCardPadding,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (topAdvisor?.advisorName ?? ''),
                                          style:
                                              AppTextStyles.titleBoldTextStyle()
                                                  .copyWith(
                                                      fontSize: 14,
                                                      height: 1.2),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          topAdvisor?.advisorRoleDescription
                                                  ?.toString() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 12, height: 2),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// call and message buttons

                                  Wrap(
                                    runSpacing: 0,
                                    spacing: -30,
                                    runAlignment: WrapAlignment.end,
                                    alignment: WrapAlignment.end,
                                    children: [
                                      // message Advisor
                                      CustomMaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () async {
                                            await Utils.launchEmail(
                                                topAdvisor?.email ?? '');
                                          },
                                          isEnabled: false,
                                          shape: const CircleBorder(),
                                          child: SvgPicture.asset(
                                            "assets/services/Email.svg",
                                            height: 13,
                                            width: 13,
                                          )),
                                      // Call advisor
                                      CustomMaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () async {
                                            await Utils.makePhoneCall(
                                                phoneNumber:
                                                    topAdvisor?.phoneNo ?? '',
                                                context: context);
                                          },
                                          isEnabled: false,
                                          shape: const CircleBorder(),
                                          child: SvgPicture.asset(
                                            "assets/call_advisor.svg",
                                            height: 15,
                                            width: 15,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  );
          case null:
            return showVoid;
        }
      },
    );
  }

  Widget homeViewCardBottomContainer({
    required dynamic child,
    dynamic backGroundColor = AppColors.lightBlue0,
    padding = EdgeInsets.zero,
  }) {
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(kCardRadius),
              bottomRight: Radius.circular(kCardRadius))),
      child: child,
    );
  }
}
