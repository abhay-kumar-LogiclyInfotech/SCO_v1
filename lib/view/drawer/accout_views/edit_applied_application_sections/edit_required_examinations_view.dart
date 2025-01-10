import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/view/apply_scholarship/form_views/required_examinations_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../../data/response/status.dart';
import '../../../../models/account/GetListApplicationStatusModel.dart';
import '../../../../models/apply_scholarship/FillScholarshipFormModels.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/components/custom_simple_app_bar.dart';
import '../../../../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/utils.dart';
import '../../../../viewModel/account/edit_application_sections_view_Model/get_application_sections_view_model.dart';

class EditRequiredExaminationsView extends StatefulWidget {
  final ApplicationStatusDetail applicationStatusDetails;

  const EditRequiredExaminationsView({super.key, required this.applicationStatusDetails});

  @override
  State<EditRequiredExaminationsView> createState() => _EditRequiredExaminationsViewState();}

class _EditRequiredExaminationsViewState
    extends State<EditRequiredExaminationsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final langProvider =
          Provider.of<LanguageChangeViewModel>(context, listen: false);
      if (Constants
              .lovCodeMap[
                  'EXAMINATION#${widget.applicationStatusDetails.acadCareer}']
              ?.values !=
          null) {
        _requiredExaminationDropdownMenuItems = populateCommonDataDropdown(
            menuItemsList: Constants
                .lovCodeMap[
                    'EXAMINATION#${widget.applicationStatusDetails.acadCareer}']!
                .values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      if (Constants.lovCodeMap['TEST_SCORE_VAL']?.values != null) {
        _testScoreVal = populateUniqueSimpleValuesFromLOV(
            menuItemsList: Constants.lovCodeMap['TEST_SCORE_VAL']!.values!,
            provider: langProvider,
            textColor: AppColors.scoButtonColor);
      }

      /// Making api call to ps-application
      final psApplicationProvider =
          Provider.of<GetApplicationSectionViewModel>(context, listen: false);
      await psApplicationProvider.getApplicationSections(
          applicationNumber:
              widget.applicationStatusDetails.admApplicationNumber);

      if (psApplicationProvider.apiResponse.status == Status.COMPLETED &&
          psApplicationProvider
                  .apiResponse.data?.data.psApplication.emplymentHistory !=
              null) {
        final requiredExamination = psApplicationProvider
            .apiResponse.data?.data.psApplication.requiredExaminationList;

        if (requiredExamination?.isNotEmpty ?? false) {
          // If it's a list, iterate through it
          for (int index = 0; index < requiredExamination!.length!; index++) {
            var element = requiredExamination[index];
            _requiredExaminationList.add(element); // Add to the list
            // populate examination type dropdown
            _populateExaminationTypeDropdown(
                langProvider: langProvider, index: index);
          }
        }

        setState(() {});
      }
    });

    super.initState();
  }

  /// get examination type
  _populateExaminationTypeDropdown(
      {required LanguageChangeViewModel langProvider, required int index}) {
    setState(() {
      if (Constants
              .lovCodeMap[
                  'EXAMINATION_TYPE#${_requiredExaminationList[index].examinationController.text}']
              ?.values !=
          null) {
        _requiredExaminationList[index].examinationTypeDropdown =
            populateCommonDataDropdown(
                menuItemsList: Constants
                    .lovCodeMap[
                        'EXAMINATION_TYPE#${_requiredExaminationList[index].examinationController.text}']!
                    .values!,
                provider: langProvider,
                textColor: AppColors.scoButtonColor);
      }
    });
  }

  List<RequiredExaminations> _requiredExaminationList = [];

  List<DropdownMenuItem>? _requiredExaminationDropdownMenuItems = [];

  /// get min score and max score just fetching the elements from the lov and based on exam and exam type selection we will find min and max score and set that to the fields
  List _testScoreVal = [];

  bool _isProcessing = false;

  resetProcessing(bool value) {
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
        appBar: CustomSimpleAppBar(
          titleAsString: localization.requiredExamination,
        ),
        body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildUi()),
        ));
  }

  Widget _buildUi() {
    return Consumer<GetApplicationSectionViewModel>(
      builder: (context, provider, _) {
        switch (provider.apiResponse.status) {
          case Status.LOADING:
            return Utils.pageLoadingIndicator(context: context);
          case Status.ERROR:
            return Utils.showOnError();
          case Status.COMPLETED:
            return RequiredExaminationsView(
                draftPrevNextButtons: Container(),
                acadmicCareer: widget.applicationStatusDetails.acadCareer,
                requiredExaminationList: _requiredExaminationList,
                requiredExaminationDropdownMenuItems:
                    _requiredExaminationDropdownMenuItems,
                testScoreVal: _testScoreVal);
          case Status.NONE:
            return Utils.showOnNone();
          case null:
            return Utils.showOnNone();
        }
      },
    );
  }
}
