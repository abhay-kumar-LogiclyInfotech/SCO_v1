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
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomSimpleAppBar(titleAsString: "My Finance"),
        body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(), onRefresh: _initializeData) ),
      );
  }

  Widget _buildUi() {
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
                        _salaryDetails(provider: provider, langProvider: langProvider),
                        kFormHeight,
                        _deductionDetails(provider: provider, langProvider: langProvider),
                        kFormHeight,
                        _bonusDetails(provider: provider, langProvider: langProvider),
                        kFormHeight,
                        _warningDetails(provider: provider, langProvider: langProvider),
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
  Widget _salaryDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider}) {

    final listOfSalaries = provider.apiResponse.data?.data?.listSalaryDetials ?? [];

    final topSalaryDetails = listOfSalaries.isNotEmpty ? listOfSalaries[0] : null;

    return CustomInformationContainer(
      title: 'Salary Details',
      leading: SvgPicture.asset("assets/services/salary_details.svg"),
      expandedContentPadding: EdgeInsets.zero,
      expandedContent: financeCard(content:  [
        CustomInformationContainerField(title: "Bank Name", description: topSalaryDetails?.bankName.toString() ?? '- -'),
        CustomInformationContainerField(title: "Amount", description: topSalaryDetails?.amount.toString() ?? '- -'),
        CustomInformationContainerField(title: "Currency", description: topSalaryDetails?.currency.toString() ?? '- -'),
        CustomInformationContainerField(title: "The Month", description: topSalaryDetails?.salaryMonth.toString() ?? '- -'),
        CustomInformationContainerField(title: "Status", description: topSalaryDetails?.status.toString() ?? '- -' ,isLastItem: true),
      ],  langProvider: langProvider,onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const SalaryDetailsView()));
      })
    );
  }




  ///*------  Top Deduction Section------*
  Widget _deductionDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider}) {

    final listOfDeduction = provider.apiResponse.data?.data?.listDeduction ?? [];
    final topDeduction = listOfDeduction.isNotEmpty  ? listOfDeduction[0] : null;
    return CustomInformationContainer(
      title: 'Deduction Details',
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/deduction_details.svg"),
      expandedContent: financeCard(content: [
        CustomInformationContainerField(title: "Total Deduction", description: topDeduction?.totalDeduction.toString() ?? '- -'),
        CustomInformationContainerField(title: "Total Deducted", description: topDeduction?.totalDeducted.toString() ?? '- -'),
        CustomInformationContainerField(title: "Deduction Pending", description: topDeduction?.deductionPending.toString() ?? '- -'),
        CustomInformationContainerField(title: "Currency", description: topDeduction?.currencyCode.toString() ?? '- -' ,isLastItem: true),
      ], onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const DeductionDetailsView()));

      }, langProvider: langProvider));
  }

  ///*------ Top Bonus Section------*
  Widget _bonusDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider}) {
    final listOfBonus = provider.apiResponse.data?.data?.listBonus ?? [];
    final topBonus = listOfBonus.isNotEmpty ? listOfBonus[0] : null;
    return CustomInformationContainer(
      title: 'Bonus Details',
        expandedContentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset("assets/services/bonus_details.svg"),
      expandedContent: financeCard(content: [
        CustomInformationContainerField(title: "Period", description: topBonus?.periodIdDescription.toString() ?? '- -' ?? '- -'),
        CustomInformationContainerField(title: "Term", description: topBonus?.termDescription.toString() ?? '- -'),
        CustomInformationContainerField(title: "Amount", description: topBonus?.amount.toString() ?? '- -'),
        CustomInformationContainerField(title: "Currency", description: topBonus?.currencyCode.toString() ?? '- -' ,isLastItem: true),
      ], onTapViewAll: (){
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const BonusDetailsView()));

      }, langProvider: langProvider));
  }

  ///*------ Top Warning Section------*
  Widget  _warningDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider}) {
    final listOfWarnings = provider.apiResponse.data?.data?.listWarnings ?? [];
    final topWarning = listOfWarnings.isNotEmpty ? listOfWarnings[0] : null;
    return CustomInformationContainer(
      title: 'Warning Details',
      expandedContentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/services/warning_details.svg"),
      expandedContent: financeCard(
          content: [
        CustomInformationContainerField(title: "Term", description: topWarning?.termDescription.toString() ?? '- -'),
        CustomInformationContainerField(title: "Certificate Description", description: topWarning?.warningCertificate.toString() ?? '- -' ,isLastItem: true),
          ],
          onTapViewAll: (){
            _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const WarningDetailsView()));
          },
          langProvider: langProvider));

  }


  Widget financeCard({required List<Widget> content,required onTapViewAll,required langProvider})
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
            child: CustomButton(buttonName: "View All", isLoading: false,buttonColor:AppColors.scoThemeColor,borderColor:Colors.transparent,textDirection: getTextDirection(langProvider), onTap: onTapViewAll),
          )
        ]
    );
  }
}
