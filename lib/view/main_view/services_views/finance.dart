import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/bonusDetailsView.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/deductionDetailsView.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/salaryDetailsView.dart';
import 'package:sco_v1/view/main_view/services_views/finance_details_views/warningDetailsView.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();


}

class _FinanceViewState extends State<FinanceView> with MediaQueryMixin
{
  late NavigationServices _navigationServices;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;



  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      /// fetch my application with approved
      await Provider.of<MyFinanceStatusViewModel>(context, listen: false).myFinanceStatus();

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
        appBar: CustomSimpleAppBar(titleAsString: localization.myFinance),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(localization), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi(localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<MyFinanceStatusViewModel>(
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
                        _salaryDetails(provider: provider, langProvider: langProvider,localization: localization),
                        kFormHeight,
                        _deductionDetails(provider: provider,langProvider: langProvider,localization: localization),
                        kFormHeight,
                        _bonusDetails(provider: provider, langProvider: langProvider,localization: localization),
                        kFormHeight,
                        _warningDetails(provider: provider, langProvider: langProvider,localization: localization),
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

  ///*------ Top Salary Section------*
  Widget _salaryDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {

    final listOfSalaries = provider.apiResponse.data?.data?.listSalaryDetials ?? [];

    final topSalaryDetails = listOfSalaries.isNotEmpty ? listOfSalaries[0] : null;

    return CustomInformationContainer(
      title: localization.salaryDetails,
      leading: SvgPicture.asset("assets/services/salary_details.svg"),
      expandedContentPadding: EdgeInsets.zero,
      expandedContent: financeCard(content:  [
        CustomInformationContainerField(title: localization.bankName, description: topSalaryDetails?.bankName.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.amount, description: topSalaryDetails?.amount.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.currency, description: topSalaryDetails?.currency.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.theMonth, description: topSalaryDetails?.salaryMonth.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.status,description: topSalaryDetails?.status.toString() ?? '- -' ,isLastItem: true),
      ],localization: localization , langProvider: langProvider,onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const SalaryDetailsView()));
      })
    );
  }




  ///*------  Top Deduction Section------*
  Widget _deductionDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {

    final listOfDeduction = provider.apiResponse.data?.data?.listDeduction ?? [];
    final topDeduction = listOfDeduction.isNotEmpty  ? listOfDeduction[0] : null;
    return CustomInformationContainer(
      title: localization.deductionDetails,
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/deduction_details.svg"),
      expandedContent: financeCard(content: [
        CustomInformationContainerField(title: localization.totalDeduction,description: topDeduction?.totalDeduction.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.totalDeducted, description: topDeduction?.totalDeducted.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.deductionPending, description: topDeduction?.deductionPending.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.currency, description: topDeduction?.currencyCode.toString() ?? '- -' ,isLastItem: true),
      ], onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const DeductionDetailsView()));

      }, langProvider: langProvider,localization: localization));
  }

  ///*------ Top Bonus Section------*
  Widget _bonusDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    final listOfBonus = provider.apiResponse.data?.data?.listBonus ?? [];
    final topBonus = listOfBonus.isNotEmpty ? listOfBonus[0] : null;
    return CustomInformationContainer(
      title: localization.bonusDetails,
        expandedContentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset("assets/services/bonus_details.svg"),
      expandedContent: financeCard(content: [
        CustomInformationContainerField(title: localization.period, description: topBonus?.periodIdDescription.toString() ?? '- -' ?? '- -'),
        CustomInformationContainerField(title: localization.term, description: topBonus?.termDescription.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.amount,description: topBonus?.amount.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.currency, description: topBonus?.currencyCode.toString() ?? '- -' ,isLastItem: true),
      ], onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const BonusDetailsView()));

      }, langProvider: langProvider,localization: localization));
  }

  ///*------ Top Warning Section------*
  Widget  _warningDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    final listOfWarnings = provider.apiResponse.data?.data?.listWarnings ?? [];
    final topWarning = listOfWarnings.isNotEmpty ? listOfWarnings[0] : null;
    return CustomInformationContainer(
      title: localization.warningDetails,
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/warning_details.svg"),
      expandedContent: financeCard(
          content: [
        CustomInformationContainerField(title: localization.term, description: topWarning?.termDescription.toString() ?? '- -'),
        CustomInformationContainerField(title: localization.certificateDescription, description: topWarning?.warningCertificate.toString() ?? '- -' ,isLastItem: true),
          ],
          onTapViewAll: (){
            _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const WarningDetailsView()));
          },
          langProvider: langProvider,localization: localization));
  }


  Widget financeCard({required List<Widget> content,required onTapViewAll,required langProvider, required AppLocalizations localization})
  {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: kPadding,right: kPadding,top: kPadding),
            child: Column(
              children: content,
            ),
          ),
          const MyDivider(color: AppColors.darkGrey),
          kFormHeight,
          Padding(
            padding:  EdgeInsets.only(left: kPadding,right: kPadding,bottom: kPadding),
            child: CustomButton(buttonName: localization.viewAll, isLoading: false,buttonColor:AppColors.scoThemeColor,borderColor:Colors.transparent,textDirection: getTextDirection(langProvider), onTap: onTapViewAll),
          )
        ]
    );
  }
}
