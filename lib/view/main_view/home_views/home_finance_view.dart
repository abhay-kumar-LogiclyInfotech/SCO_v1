import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/kButtons/simple_button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../resources/components/custom_vertical_divider.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import '../services_views/finance.dart';
import '../../../l10n/app_localizations.dart';

class HomeFinanceView extends StatefulWidget {
  const HomeFinanceView({super.key});

  @override
  State<HomeFinanceView> createState() => _HomeFinanceViewState();
}

class _HomeFinanceViewState extends State<HomeFinanceView>
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
    final localization = AppLocalizations.of(context)!;
    return Consumer<MyFinanceStatusViewModel>(
        builder: (context, financeStatusProvider, _) {
      switch (financeStatusProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.NONE:
          return showVoid;
        case Status.COMPLETED:
          final financeData = financeStatusProvider.apiResponse.data?.data;
          final salary = financeData?.listSalaryDetials?.isNotEmpty == true ? financeData?.listSalaryDetials?.first : null;
          final deduction = financeData?.listDeduction?.isNotEmpty == true ? financeData?.listDeduction?.first : null;
          final bonus = financeData?.listBonus?.isNotEmpty == true ? financeData?.listBonus?.first : null;
          final warning = financeData?.listWarnings?.isNotEmpty == true ? financeData?.listWarnings?.first : null;
          return HomeViewCard(
              title: AppLocalizations.of(context)!.myFinance,
              icon: Image.asset("assets/home/finance_icon.png",height: 20,width: 20,),

              // icon: SvgPicture.asset("assets/my_finance.svg"),
              showArrow: false,
              onTap: () {
                // _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => const FinanceView()));
              },
              content: Column(
            children: [


              const NoMarginDivider(color: AppColors.lightGrey),
              SizedBox(height: kCardPadding,),
              Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(text: TextSpan(text: localization.homeSalary,style: AppTextStyles.titleBoldTextStyle().copyWith(color: Colors.grey)),),
                          RichText(text:  TextSpan(text: localization.paid,style: AppTextStyles.titleBoldTextStyle().copyWith(color: Colors.grey,height: 0.9)),),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text : salary?.amount?.toString() ?? '0',
                                  style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 28),
                                ),
                                TextSpan(
                                  text: ' ${salary?.currency?.toString() ?? ''}' ,
                                  style: const TextStyle(color: Colors.green,fontWeight: FontWeight.normal,fontSize: 17),
                                )
                              ]
                          ),),
                        RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.grey,fontSize: 13,height: 0.9),
                              children: [
                                TextSpan(
                                    text: salary?.salaryMonth?.toString() ?? ''
                                )
                              ]
                          ),),
                      ],
                    ),

                  ]),
                  kMediumSpace,
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: Wrap(
                      runSpacing: kTileSpace,
                      alignment: WrapAlignment.spaceBetween,
                      // spacing: screenWidth < 600 ? : 15,
                      // alignment: WrapAlignment.spaceBetween,
                      // runAlignment: WrapAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bonusOrDeductionContainer(
                            localization.deduction,
                            deduction?.totalDeducted?.toString() ?? '0',
                            Colors.red
                        ),
                        bonusOrDeductionContainer(
                          localization.bonus,
                          bonus?.amount?.toString() ?? '0',
                        ),

                      ],
                    ),
                  ),
                  kSmallSpace,

                  SimpleButton(onPressed: (){
                    _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => const FinanceView()));

                  }, title: localization.more),
                ],
              ),
            ],
          ), langProvider: langProvider);
        case null:
          return showVoid;
      }
    });
  }




  Widget bonusOrDeductionContainer(title,amount,[Color? color]){
    return Container(
      decoration: BoxDecoration(
          color:  AppColors.bgColor,
          borderRadius: BorderRadius.circular(14)
      ),
      width: screenWidth/2.33,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
          children:[
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                text: amount,
                style:  TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: color ?? Colors.green),
            )),
            RichText(text: TextSpan(
                text: title,
                style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey)
            )),

          ]
      ),
    );
  }










  List<Widget> _financeElements({salary, deduction, bonus}) {
    return [
      _financeAmount(
        // titleColor: const Color(0xffEC6330),
        iconAddress: "assets/salary_icon.svg",
        title: AppLocalizations.of(context)!.salary,
        subTitle: salary?.amount.toString() ?? '0',
      ),
      CustomVerticalDivider(height: 35),
      _financeAmount(
        // titleColor: const Color(0xff3A82F7),
        iconAddress: "assets/deduction_icon.svg",
        title: AppLocalizations.of(context)!.deduction,
        subTitle: deduction?.totalDeducted.toString() ?? '0',
      ),
      CustomVerticalDivider(height: 35),
      _financeAmount(
        // titleColor: const Color(0xff67CE67),
        iconAddress: "assets/bonus_icon.svg",
        title: AppLocalizations.of(context)!.bonus,
        subTitle: bonus?.amount.toString() ?? '0',
      ),
    ];
  }

  Widget _financeAmount(
      {String title = "",
      String iconAddress = '',
      String subTitle = "",
      Color titleColor = AppColors.scoButtonColor})
  {
    // Condition to check if the subtitle is at least 5 characters long
    String displayedSubtitle = (subTitle.length >= 5)
        ? "${subTitle.substring(0, 5)}+" // Extract first 5 characters
        : subTitle ??
            ""; // Fallback if subtitle is null or shorter than 5 characters

    return Container(
      width: screenWidth < 370 ? 80 : 100,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SvgPicture.asset(iconAddress),
          //     const SizedBox(width: 5),
          //     Text(
          //       title,
          //       style: TextStyle(
          //           color: titleColor, fontSize: 15, fontWeight: FontWeight.w600),
          //     ),
          //   ],
          // ),
          Text(
            textAlign: TextAlign.start,
            title,
            style: TextStyle(
                color: titleColor, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            displayedSubtitle,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

// HomeViewCard(
// onTap: () {_navigationServices.pushCupertino(CupertinoPageRoute(builder: (context) => const FinanceView()));},
// title: AppLocalizations.of(context)!.myFinance,
// icon: SvgPicture.asset("assets/my_finance.svg"),
// langProvider: langProvider,
// content: Column(
// // crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisSize: MainAxisSize.max,
// children: [
// Container(
// color: Colors.transparent,
// // padding:  EdgeInsets.only(top: kCardPadding,left: kCardPadding, right: kCardPadding, bottom: 10),
// width: double.infinity,
// child: Row(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: _financeElements(
// salary: salary,
// deduction: deduction,
// bonus: bonus,
// ),
// ),
// ),
// // warning
// // Text(
// //  AppLocalizations.of(context)!.warning,
// //   style: AppTextStyles.subTitleTextStyle()
// //       .copyWith(fontWeight: FontWeight.bold),
// // ),
// if ((warning?.termDescription ?? '').isNotEmpty)
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // const Divider(),
// const Row(),
// Padding(
// // padding: EdgeInsets.only(top: 8, bottom: 15, left: kCardPadding, right: kCardPadding),
// padding: const EdgeInsets.only(top: 8,
// // bottom: kCardPadding, left: kCardPadding, right: kCardPadding,
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(AppLocalizations.of(context)!.warning, style: AppTextStyles.subTitleTextStyle().copyWith(fontWeight: FontWeight.bold)),
// Text(
// warning!.termDescription!, // Using `!` because the null check ensures it's safe
// style: AppTextStyles.titleBoldTextStyle().copyWith(fontSize: 18),
// textAlign: TextAlign.start,
// ),
// ],
// ),
// ),
// ],
// ),
// ],
// )),


