import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/myDivider.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_finanace_status_viewModel.dart';
import 'package:sco_v1/viewModel/services_viewmodel/my_scholarship_viewmodel.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/navigation_services.dart';


class SalaryDetailsView extends StatefulWidget {
  const SalaryDetailsView({super.key});

  @override
  State<SalaryDetailsView> createState() => _SalaryDetailsViewState();


}

class _SalaryDetailsViewState extends State<SalaryDetailsView> with MediaQueryMixin
{
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
      appBar: CustomSimpleAppBar(titleAsString: localization.salaryDetails),
      body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(localization: localization), onRefresh: _initializeData) ),
    );
  }

  Widget _buildUi({ required AppLocalizations localization}) {
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
              final listOfSalaries = provider.apiResponse.data?.data?.listSalaryDetials ?? [];
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

                        listOfSalaries.isNotEmpty ?
                        _salaryDetails(provider: provider, langProvider: langProvider,localization: localization)
                        : Utils.showOnNoDataAvailable(context: context)
                        ,
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
  Widget _salaryDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {

    final listOfSalaries = provider.apiResponse.data?.data?.listSalaryDetials ?? [];
      return CustomInformationContainer(
          title: localization.salaryDetails,
          leading: SvgPicture.asset("assets/services/salary_details.svg"),
          expandedContentPadding: EdgeInsets.zero,
          expandedContent: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfSalaries.length,
          itemBuilder: (context,index){
            final topSalaryDetails = listOfSalaries[index];
            return Column(
              children: [
                financeCard(
                    color: index%2 != 0 ? const Color(0xffF9F9F9) : Colors.white,
                    content:  [
                CustomInformationContainerField(title: localization.sr, description: (index+1).toString() ?? '- -'),
                CustomInformationContainerField(title: localization.bankName, description: topSalaryDetails?.bankName.toString() ?? '- -'),
                CustomInformationContainerField(title: localization.amount, description: topSalaryDetails?.amount.toString() ?? '- -'),
                CustomInformationContainerField(title: localization.currency, description: topSalaryDetails?.currency.toString() ?? '- -'),
                CustomInformationContainerField(title: localization.theMonth, description: topSalaryDetails?.salaryMonth.toString() ?? '- -'),
                CustomInformationContainerField(title: localization.status, description: topSalaryDetails?.status.toString() ?? '- -' ,isLastItem: true),
                kFormHeight,

                    ],  langProvider: langProvider,isLastTerm: index == listOfSalaries.length -1),
                if(index < listOfSalaries.length-1 ) const MyDivider(color: AppColors.darkGrey),
              ],
            );})
      );

  }

  Widget financeCard({required color,required List<Widget> content,required langProvider,bool isLastTerm = false})
  {
    return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: isLastTerm ? const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)) : null,
      border: Border.all(color: Colors.transparent)
    ),
      child: Padding(
        padding:  EdgeInsets.only(left: kCardPadding,right: kCardPadding,top: kCardPadding),
        child: Column(
          children: content,
        ),
      ),
    );
  }
}
