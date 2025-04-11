

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/kButtons/kReturnButton.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/edit_application/edit_application_sections_viewModel.dart';
import 'package:sco_v1/viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../../data/response/status.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
import '../../../../viewModel/language_change_ViewModel.dart';
import '../../../apply_scholarship/form_views/employment_history_view.dart';


class EditEmploymentHistoryView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;
  const EditEmploymentHistoryView({super.key,required this.applicationStatusDetails});

  @override
  State<EditEmploymentHistoryView> createState() => _EditEmploymentHistoryViewState();
}

class _EditEmploymentHistoryViewState extends State<EditEmploymentHistoryView> with MediaQueryMixin{
late AlertServices _alertServices;


PsApplication? peopleSoftApplication;
dynamic form ;


  @override
  void initState() {

    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback)async{
      await _refreshView();
    });
    super.initState();
  }

  _refreshView()async{
    WidgetsBinding.instance.addPostFrameCallback((callback)async{

      _employmentHistoryList.clear();
      _employmentStatusItemsList.clear();
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


        peopleSoftApplication = psApplicationProvider.apiResponse.data?.data.psApplication;



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

        form = peopleSoftApplication?.toJson();



        setState(() {

        });
      }});
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

  Widget _employmentHistoryDetailsSection({required int step, required LanguageChangeViewModel langProvider}) {
    final localization = AppLocalizations.of(context)!;
   return Consumer<GetApplicationSectionViewModel>(
      builder: (context,provider,_){
        switch (provider.apiResponse.status){
          case Status.LOADING:
            return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return  Utils.showOnError();
          case Status.COMPLETED:
          return SingleChildScrollView(
            child: Column(
              children: [
                EmploymentHistoryView(onEmploymentStatusChanged: (value) {
                  setState(() {
                    _employmentStatus = value;
                    if (_employmentStatus == 'N') {
                      _employmentHistoryList.clear();
                      _employmentHistoryList = [];
                      form['emplymentHistory']=[];
                    }
                    // if (_employmentHistoryList.isEmpty) {
                    //   _addEmploymentHistory();
                    // }
                    else {
                      _employmentHistoryList.clear();
                      _addEmploymentHistory();
                    }
                  });
                },
                    employmentHistoryList: _employmentHistoryList,
                    employmentStatus: _employmentStatus,
                    employmentStatusItemsList: _employmentStatusItemsList,
                    draftPrevNextButtons: const SizedBox()
                ),

                /// submit and back button
                _submitAndBackButton(localization:localization,langProvider: langProvider),
              ],
            ),
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

  Widget _submitAndBackButton({required AppLocalizations localization,required LanguageChangeViewModel langProvider}) {
      /// SubmitButton
    return  Padding(
      padding:  EdgeInsets.all(kPadding),
      child: Column(
          children: [

            ChangeNotifierProvider(create: (context)=>EditApplicationSectionsViewModel(),
            child: Consumer<EditApplicationSectionsViewModel>(
              builder: (context,provider,_){
                return CustomButton(buttonName: localization.update, isLoading: provider.apiResponse.status == Status.LOADING, textDirection: getTextDirection(langProvider),
                    onTap: ()async{
                      if(validateEmploymentHistory(langProvider)){
                    form['emplymentHistory'] = _employmentHistoryList.isNotEmpty ? _employmentHistoryList.map((element){return element.toJson();}).toList() : [];
                    await provider.editApplicationSections(applicationNumber: widget.applicationStatusDetails.admApplicationNumber,form: form,sectionType: EditApplicationSection.employmentHistory);
                    await _refreshView();
                  }
                });
              },
            ),
            ),
            kFormHeight,
            const KReturnButton(),
          ],
        ),
    );
}

  FocusNode? firstErrorFocusNode;
  bool validateEmploymentHistory(langProvider) {
    final localization = AppLocalizations.of(context)!;
    firstErrorFocusNode = null;

    /// validate employment history

    /// select employment status
    if (_employmentStatus == null || _employmentStatus == '') {
      _alertServices.showToast(message: "${localization.previouslyEmployed} ?",
        // context: context,
      );
    }

    if (_employmentStatus != null &&
        _employmentStatus != '' &&
        _employmentStatus != 'N') {
      for (int i = 0; i < _employmentHistoryList.length; i++) {
        var element = _employmentHistoryList[i];

        /// employer name
        if (element.employerNameController.text.isEmpty || element.employerNameError != null) {
          setState(() {
            element.employerNameError = localization.emphistEmployerNameValidate;
            firstErrorFocusNode ??= element.employerNameFocusNode;
          });
        }

        /// designation
        if (element.titleController.text.isEmpty || element.titleError != null) {
          setState(() {
            element.titleError = localization.emphistTitleNameValidate;
            firstErrorFocusNode ??= element.titleFocusNode;
          });
        }

        ///work place
        if (element.placeController.text.isEmpty || element.placeError != null) {
          setState(() {
            element.placeError = localization.emphistPlaceValidate;
            firstErrorFocusNode ??= element.placeFocusNode;
          });
        }

        ///occupation
        if (element.occupationController.text.isEmpty || element.occupationError != null) {
          setState(() {
            element.occupationError = localization.emphistOccupationNameValidate;
            firstErrorFocusNode ??= element.occupationFocusNode;
          });
        }

        /// start date
        if (element.startDateController.text.isEmpty || element.startDateError != null) {
          setState(() {
            element.startDateError = localization.employmentStartDateRequired;
            firstErrorFocusNode ??= element.startDateFocusNode;
          });
        }

        /// end date
        if (_employmentStatus == 'P' &&
            ( element.endDateController.text.isEmpty || element.endDateError != null)) {
          setState(() {
            element.endDateError = localization.employmentEndDateRequired;
            firstErrorFocusNode ??= element.endDateFocusNode;
          });
        }

        /// end date
        if (element.endDateController.text.isNotEmpty && (element.endDateController.text == element.startDateController.text)) {

          setState(() {
            element.endDateError = "${localization.employmentEndDateRequired}\nPlease correct start and End Date";
            firstErrorFocusNode ??= element.endDateFocusNode;
          });
        }

        /// reporting manager
        if (element.reportingManagerController.text.isEmpty || element.reportingManagerError != null) {
          setState(() {
            element.reportingManagerError = localization.emphistReportingManagerValidate;
            firstErrorFocusNode ??= element.reportingManagerFocusNode;
          });
        }
        /// contact number
        if (element.contactNumberController.text.isEmpty || element.contactNumberError != null) {
          setState(() {
            element.contactNumberError = localization.emphistMgrContactNoValidate;
            firstErrorFocusNode ??= element.contactNumberFocusNode;
          });
        }
        /// email
        if (element.contactEmailController.text.isEmpty || element.contactEmailError != null) {
          setState(() {
            element.contactEmailError = localization.registrationEmailAddressValidate;
            firstErrorFocusNode ??= element.contactEmailFocusNode;
          });
        }
      }
    }
    /// checking for fist error node
    if (firstErrorFocusNode != null ||
        _employmentStatus == null ||
        _employmentStatus == '') {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      return true;
    }
  }
}