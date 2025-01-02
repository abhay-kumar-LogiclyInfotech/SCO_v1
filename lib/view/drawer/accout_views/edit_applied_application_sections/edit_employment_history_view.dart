import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';

import '../../../../data/response/status.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../apply_scholarship/form_views/employment_history_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EditEmploymentHistoryView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  const EditEmploymentHistoryView({super.key,required this.applicationStatusDetails});

  @override
  State<EditEmploymentHistoryView> createState() => _EditEmploymentHistoryViewState();
}

class _EditEmploymentHistoryViewState extends State<EditEmploymentHistoryView> {



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback)async{
      final LanguageChangeViewModel langProvider = Provider.of(context,listen: false);
      if (Constants.lovCodeMap['EMPLOYMENT_STATUS']?.values != null) {
        _employmentStatusItemsList = populateUniqueSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['EMPLOYMENT_STATUS']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }


      /// Making api call to ps-application
      final psApplicationProvider = Provider.of<GetApplicationSectionViewModel>(context,listen:false);
      await psApplicationProvider.getApplicationSections(applicationNumber: widget.applicationStatusDetails.admApplicationNumber);

      if(psApplicationProvider.apiResponse.status == Status.COMPLETED && psApplicationProvider.apiResponse.data?.data.psApplication.emplymentHistory != null)
      {

        /// TODO: ADD EMPLOYMENT STATUS HERE
        final empHistory = psApplicationProvider.apiResponse.data?.data.psApplication.emplymentHistory;

        if(empHistory?.isNotEmpty ?? false) {
          for (var element in empHistory!) {
            _employmentHistoryList.add(element);
          }
        }

          ///  Given by Backend Dev i.e. Amit Sharma: Tell him if employment count is more than 0 than ask him to select previous employment. And if 0 than not employed and if any employment record is not having the end date ask hi. To select currently employed
        if(_employmentHistoryList.isEmpty){
          _employmentStatus = 'N';
        }
        else if(_employmentHistoryList.any((element){
          return element.endDateController.text.isNotEmpty;
        }))
        {
          _employmentStatus = 'P';
        }
        else{
          _employmentStatus = 'E';
        }


      setState(() {

      });
    }});
    super.initState();
  }

   bool _isProcessing = false;
  resetProcessing(bool value){
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LanguageChangeViewModel langProvider = context.read<LanguageChangeViewModel>();
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomSimpleAppBar(titleAsString: localization.employmentHistory,),
      body: Utils.modelProgressHud(processing: _isProcessing,child: Padding(
        padding:  const EdgeInsets.symmetric(vertical: 20),
        child: _employmentHistoryDetailsSection(step: 0,langProvider: langProvider),
      ),
    ));
  }



  /// available employment status from lov
  List _employmentStatusItemsList = [];


  /// current Employment status
  String? _employmentStatus;


  /// employment history list
  List<EmploymentHistory> _employmentHistoryList = [];


  /// add employment history
  void _addEmploymentHistory() {
    setState(() {
      _employmentHistoryList.add(EmploymentHistory(
        employerNameController: TextEditingController(),
        designationController: TextEditingController(),
        startDateController: TextEditingController(),
        endDateController: TextEditingController(),
        occupationController: TextEditingController(),
        titleController: TextEditingController(),
        placeController: TextEditingController(),
        reportingManagerController: TextEditingController(),
        contactNumberController: TextEditingController(),
        contactEmailController: TextEditingController(),
        isNewController: TextEditingController(text: 'true'),
        errorMessageController: TextEditingController(),
        employerNameFocusNode: FocusNode(),
        designationFocusNode: FocusNode(),
        startDateFocusNode: FocusNode(),
        endDateFocusNode: FocusNode(),
        occupationFocusNode: FocusNode(),
        titleFocusNode: FocusNode(),
        placeFocusNode: FocusNode(),
        reportingManagerFocusNode: FocusNode(),
        contactNumberFocusNode: FocusNode(),
        contactEmailFocusNode: FocusNode(),
      ));
    });
  }


  void _removeEmploymentHistory(int index) {
    if (index >= 0 && index < _employmentHistoryList.length) {
      setState(() {
        /// Get the item to be deleted
        final item = _employmentHistoryList[index];

        /// Dispose of all the TextEditingController instances
        item.employerNameController.dispose();
        item.designationController.dispose();
        item.startDateController.dispose();
        item.endDateController.dispose();
        item.occupationController.dispose();
        item.titleController.dispose();
        item.placeController.dispose();
        item.reportingManagerController.dispose();
        item.contactNumberController.dispose();
        item.contactEmailController.dispose();
        item.isNewController.dispose();
        item.errorMessageController.dispose();

        /// Dispose of all the FocusNode instances
        item.employerNameFocusNode.dispose();
        item.designationFocusNode.dispose();
        item.startDateFocusNode.dispose();
        item.endDateFocusNode.dispose();
        item.occupationFocusNode.dispose();
        item.titleFocusNode.dispose();
        item.placeFocusNode.dispose();
        item.reportingManagerFocusNode.dispose();
        item.contactNumberFocusNode.dispose();
        item.contactEmailFocusNode.dispose();

        /// Remove the item from the list
        _employmentHistoryList.removeAt(index);
      });
    }
  }


    Widget _employmentHistoryDetailsSection(
        {required int step, required LanguageChangeViewModel langProvider}) {


   return Consumer<GetApplicationSectionViewModel>(
      builder: (context,provider,_){
        switch (provider.apiResponse.status){
          case Status.LOADING:
            return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return  Utils.showOnError();
          case Status.COMPLETED:
          return EmploymentHistoryView(onEmploymentStatusChanged: (value) {
            setState(() {
              _employmentStatus = value;
              print(_employmentStatus);

              if (_employmentStatus == 'N') {
                _employmentHistoryList.clear();
              }
              if (_employmentHistoryList.isEmpty) {
                _addEmploymentHistory();
              } else {
                _employmentHistoryList.clear();
                _addEmploymentHistory();
              }
            });
          },
              employmentHistoryList: _employmentHistoryList,
              employmentStatus: _employmentStatus,
              employmentStatusItemsList: _employmentStatusItemsList,
              draftPrevNextButtons: const SizedBox()
          );
          case Status.NONE:
            return  Utils.showOnNone();
          case null:
            return  Utils.showOnNone();
        }
        return Container();


      },
    );


    }
}