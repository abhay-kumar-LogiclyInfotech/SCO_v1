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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/navigation_services.dart';


class WarningDetailsView extends StatefulWidget {
  const WarningDetailsView({super.key});

  @override
  State<WarningDetailsView> createState() => _WarningDetailsViewState();


}

class _WarningDetailsViewState extends State<WarningDetailsView> with MediaQueryMixin
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

  ///*------ WARNING DETAILS Section------*
  Widget _warningDetails({required MyFinanceStatusViewModel provider, required LanguageChangeViewModel langProvider}) {
    final listOfWarnings = provider.apiResponse.data?.data?.listWarnings ?? [];
    return CustomInformationContainer(
        title: 'Warning Details',
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
                    financeCard(
                        color: index%2 != 0 ? const Color(0xffF9F9F9) : Colors.white,
                        content:  [
                          CustomInformationContainerField(title: "S.No", description: (index+1).toString() ?? '- -'),
                          CustomInformationContainerField(title: "Term", description: topWarning?.termDescription.toString() ?? '- -'),
                          CustomInformationContainerField(title: "Certificate Description", description: topWarning?.warningCertificate.toString() ?? '- -' ,isLastItem: true),
                          kFormHeight,
                        ],  langProvider: langProvider,isLastTerm: index == listOfWarnings.length -1),
                    if(index < listOfWarnings.length-1 ) const MyDivider(color: AppColors.darkGrey),
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
        padding:  EdgeInsets.only(left: kPadding,right: kPadding,top: kPadding),
        child: Column(
          children: content,
        ),
      ),
    );
  }
}
