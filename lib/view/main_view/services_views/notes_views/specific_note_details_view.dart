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
import 'package:sco_v1/viewModel/services_viewmodel/notes_viewModels/get_specific_note_details_view_Model.dart';

import '../../../../data/response/status.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/account/Custom_inforamtion_container.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../../viewModel/services/navigation_services.dart';


class SpecificNoteDetailsView extends StatefulWidget {
  final String noteId;
  const SpecificNoteDetailsView({super.key,required this.noteId});

  @override
  State<SpecificNoteDetailsView> createState() => _SpecificNoteDetailsViewState();


}

class _SpecificNoteDetailsViewState extends State<SpecificNoteDetailsView> with MediaQueryMixin
{


  Future _initializeData() async {

    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      /// fetch my application with approved
      await Provider.of<GetSpecificNoteDetailsViewModel>(context, listen: false).getSpecificNoteDetails(noteId: widget.noteId);
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
      appBar: CustomSimpleAppBar(titleAsString: localization.guidance_notes),
      body: Utils.modelProgressHud(processing: _isProcessing, child: Utils.pageRefreshIndicator(child: _buildUi(localization: localization), onRefresh: _initializeData) ),
    );
  }

  Widget _buildUi({required AppLocalizations localization}) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Consumer<GetSpecificNoteDetailsViewModel>(
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
              final listDetails = provider.apiResponse.data?.data?.adviseeNote?.noteDetailList ?? [];
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
                        listDetails.isNotEmpty ?
                        _listDetails(provider: provider, langProvider: langProvider,localization: localization) : Utils.showOnNoDataAvailable(context: context)
                        ,
                         SizedBox(height: kCardSpace,),
                        _listActions(provider: provider, langProvider: langProvider,localization: localization)


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

  ///*------  DETAILS Section------*
  Widget _listDetails({required GetSpecificNoteDetailsViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
   final noteInfo =  provider.apiResponse.data?.data?.adviseeNote;
    return CustomInformationContainer(
        title: localization.noteDetails,
        leading: SvgPicture.asset("assets/services/request_details.svg"),
        expandedContent: Column(
          children: [
            CustomInformationContainerField(title: localization.institution, description: noteInfo?.institution ?? '- -'),
              CustomInformationContainerField(title: localization.type, description: getFullNameFromLov(langProvider: langProvider,lovCode: "CATEGORY",code:  noteInfo?.noteType ?? '- -' )),
            CustomInformationContainerField(title: localization.subType,description: getFullNameFromLov(langProvider: langProvider,lovCode: 'SUB_CATEGORY#${noteInfo?.noteType}',code: noteInfo?.noteSubType ?? '- -') ),
            CustomInformationContainerField(title: localization.contactType, description: getFullNameFromLov(langProvider: langProvider,lovCode: "CONTACT_TYPE",code:  noteInfo?.contactType )),
            CustomInformationContainerField(title: localization.noteStatus, description: getFullNameFromLov(langProvider: langProvider,lovCode: "NOTE_STATUS",code:  noteInfo?.noteStatus )),
            CustomInformationContainerField(title: localization.canAdviseeView, description:  getFullNameFromLov(langProvider: langProvider,lovCode: "NOTE_ACCESS",code:  noteInfo?.access )),
            CustomInformationContainerField(title: localization.createdOn, description: noteInfo?.createdOn?.toString() ?? '- -'),
            CustomInformationContainerField(title: localization.subject, description: noteInfo?.subject ?? '- -',isLastItem: true),
          ],
        )
    );

  }


  Widget _listActions({required GetSpecificNoteDetailsViewModel provider, required LanguageChangeViewModel langProvider,required AppLocalizations localization}) {
    final actionsList = provider.apiResponse.data?.data?.adviseeNote?.actionList ?? [];
    return  CustomInformationContainer(
        title: localization.actions,
        leading: SvgPicture.asset("assets/services/request_details.svg"),
        expandedContent:  actionsList.isNotEmpty ?  ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actionsList.length,
            itemBuilder: (context,index){
              final action = actionsList[0];
              return
                Column(
                  children: [
                    financeCard(
                        color: index%2 != 0 ? const Color(0xffF9F9F9) : Colors.white,
                        content:  [
                          CustomInformationContainerField(title: localization.sr, description: (index+1).toString() ?? '- -'),
                          CustomInformationContainerField(title: localization.comments, description: action.desc ?? '- -'),
                          CustomInformationContainerField(title: localization.dueDate, description: action.dueDate?.toString() ?? '- -'),
                          CustomInformationContainerField(title: localization.status, description: getFullNameFromLov(langProvider: langProvider,lovCode: 'ITEM_ACTION_STATUS',code:  action.status),isLastItem: true ) ,
                        ],  langProvider: langProvider,isLastTerm: index == actionsList.length -1),
                    if(index < actionsList.length-1 ) const MyDivider(color: AppColors.darkGrey),
                  ],
                );}) : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 50),
                  child: Utils.showOnNoDataAvailable(context: context),
                )
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
