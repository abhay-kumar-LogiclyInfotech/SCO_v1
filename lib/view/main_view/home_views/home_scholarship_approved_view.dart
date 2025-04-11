import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../../models/services/MyFinanceStatusModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/home_view_card.dart';
import '../../../resources/components/custom_button.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../../viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import '../services_views/finance_details_views/salaryDetailsView.dart';
import '../../../l10n/app_localizations.dart';

class HomeScholarshipApprovedView extends StatefulWidget {
  const HomeScholarshipApprovedView({super.key});

  @override
  State<HomeScholarshipApprovedView> createState() =>
      _HomeScholarshipApprovedViewState();
}

class _HomeScholarshipApprovedViewState extends State<HomeScholarshipApprovedView> with MediaQueryMixin {

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
    final ltrDirection = getTextDirection(langProvider) == TextDirection.ltr;
    return Consumer<MyFinanceStatusViewModel>(
        builder: (context, financeStatusProvider, _) {
      switch (financeStatusProvider.apiResponse.status) {
        case Status.LOADING:
          return showVoid;
        case Status.ERROR:
          return showVoid;
        case Status.COMPLETED:
          final listOfSalaries =
              financeStatusProvider.apiResponse.data?.data?.listSalaryDetials ??
                  [];
          final topSalaryDetails =
              listOfSalaries.isNotEmpty ? listOfSalaries[0] : null;

          return Column(
            children: [
              // kFormHeight,
              HomeViewCard(
                  onTap: () {
                    _navigationServices.pushCupertino(CupertinoPageRoute(
                        builder: (context) => const SalaryDetailsView()));
                  },
                  langProvider: langProvider,
                  title: AppLocalizations.of(context)!.scholarshipOffice,
                  // icon: SvgPicture.asset('assets/sco_office.svg'),
                  content: Column(
                    children: [
                      // Amount and Read More Button
                      Padding(
                        padding: EdgeInsets.only(
                          left: ltrDirection ? 25 : 0,
                          right: ltrDirection ? 0 : 25,
                          top: 10,
                        ),
                        child: _buildAmountAndButton(
                            langProvider: langProvider,
                            topSalary: topSalaryDetails),
                      ),

                      if ((topSalaryDetails?.salaryMonth ?? '').isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 5),
                            const Divider(),
                            const SizedBox(height: 5),
                            // Date Information
                            _buildDateInfo(
                                langProvider: langProvider,
                                date: topSalaryDetails?.salaryMonth),
                          ],
                        ),
                    ],
                  )),
            ],
          );
        case Status.NONE:
          return showVoid;
        case null:
          showVoid;
      }
      return showVoid;
    });
  }
  /// Tile to show this month salary and will be shown only when student is scholar
  Widget _buildAmountAndButton(
      {required LanguageChangeViewModel langProvider,
        required ListSalaryDetials? topSalary}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Amount Information
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: topSalary?.amount.toString() ?? "0",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0B9967),
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(
                          width: 4), // Adds spacing between amount and currency
                    ),
                    TextSpan(
                      text: topSalary?.currency.toString() ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff0B9967),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
        // Read More Button
        // readMoreButton(
        //     langProvider: langProvider,
        //     onTap: () {
        //       _navigationServices.pushCupertino(CupertinoPageRoute(
        //           builder: (context) => const SalaryDetailsView()));
        //     }),
      ],
    );
  }


  Widget _buildDateInfo(
      {required LanguageChangeViewModel langProvider, required dynamic date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_month_outlined, color: Color(0xffA7B0C1)),
        const SizedBox(width: 5),
        Text(
          date ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.hintDarkGrey,
          ),
        ),
        // SizedBox(width: 5),
        // Text(
        //   "(12 mon)",
        //   style: TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.w400,
        //     color: Color(0xff8591A7),
        //   ),
        // ),
      ],
    );
  }


  Widget readMoreButton({required langProvider, required onTap}) => SizedBox(
    width: screenWidth * 0.35,
    child: CustomButton(
      buttonName: AppLocalizations.of(context)!.readMore,
      isLoading: false,
      onTap: onTap,
      textDirection: getTextDirection(langProvider),
      textColor: const Color(0xffAD8138),
      borderColor: const Color(0xffAD8138),
      buttonColor: Colors.white,
      fontSize: 14,
      height: 40,
    ),
  );
}




