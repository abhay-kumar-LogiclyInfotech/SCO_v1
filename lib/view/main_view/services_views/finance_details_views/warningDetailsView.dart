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
import 'finance_card.dart';


class WarningDetailsView extends StatefulWidget {
  const WarningDetailsView({super.key});

  @override
  State<WarningDetailsView> createState() => _WarningDetailsViewState();


}

class _WarningDetailsViewState extends State<WarningDetailsView> with MediaQueryMixin
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
      appBar: CustomSimpleAppBar(titleAsString: localization.warningDetails),
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
              final listOfWarnings = provider.apiResponse.data?.data?.listWarnings ?? [];
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
                        listOfWarnings.isNotEmpty ?
                        _warningDetails(provider: provider, langProvider: langProvider,localization:localization)
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

  ///*------ WARNING DETAILS Section------*
  Widget _warningDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    final listOfWarnings = provider.apiResponse.data?.data?.listWarnings ?? [];
    return CustomInformationContainer(
        title: localization.warningDetails,
        expandedContentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset("assets/services/warning_details.svg"),
        expandedContent: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listOfWarnings.length,
            itemBuilder: (context,index){
              final topWarning = listOfWarnings[index];
              return
                Column(
                  children: [
                    FinanceCard(
                        color: index%2 != 0 ? const Color(0xffF9F9F9) : Colors.white,
                        content:  [
                          CustomInformationContainerField(title: localization.sr, description: (index+1).toString() ?? '- -'),
                          CustomInformationContainerField(title: localization.term, description: topWarning?.termDescription.toString() ?? '- -'),
                          CustomInformationContainerField(title: localization.certificateDescription, description: topWarning?.warningCertificate.toString() ?? '- -' ,isLastItem: true),
                          kFormHeight,
                        ],  langProvider: langProvider,isLastTerm: index == listOfWarnings.length -1),
                    if(index < listOfWarnings.length-1 ) const NoMarginDivider(),
                  ],
                );})
    );

  }

}
