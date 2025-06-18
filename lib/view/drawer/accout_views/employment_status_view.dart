import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_text_field.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/get_employment_status_viewModel.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/attachment_add_file_button.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/create_update_employment_status_viewModel.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';

class EmploymentStatusView extends StatefulWidget {
  const EmploymentStatusView({super.key});

  @override
  State<EmploymentStatusView> createState() => _EmploymentStatusViewState();
}

class _EmploymentStatusViewState extends State<EmploymentStatusView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;

  List<DropdownMenuItem> _employmentStatusMenuItemsList = [];
  List<DropdownMenuItem> _employerMenuItemsList = [];

  Future _initializeData() async {
    /// fetch student profile Information t prefill the user information
    // final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context,listen: false);
    // await studentProfileProvider.getPersonalDetails();

    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);

    /// Check and populate dropdowns only if the values exist
    if (Constants.lovCodeMap['EMPLOYMENT_ST']?.values != null) {
      _employmentStatusMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['EMPLOYMENT_ST']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    if (Constants.lovCodeMap['EMPLOYER']?.values != null) {
      _employerMenuItemsList = populateCommonDataDropdown(
          menuItemsList: Constants.lovCodeMap['EMPLOYER']!.values!,
          provider: langProvider,
          textColor: AppColors.scoButtonColor);
    }

    /// *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

    final getEmploymentStatusProvider = Provider.of<GetEmploymentStatusViewModel>(context, listen: false);
    await getEmploymentStatusProvider.getEmploymentStatus();

    if (getEmploymentStatusProvider.apiResponse.status == Status.COMPLETED) {
      final status = getEmploymentStatusProvider.apiResponse.data?.data?.employmentStatus;

      /// prefilling the form
      _employmentStatusController.text = status?.employmentStatus ?? '';
      _employerController.text = status?.employerName ?? '';
      _commentsController.text = status?.comment ?? '';


      if (status?.listOfFiles != null && status?.listOfFiles != []) {
        _attachmentsList.clear();
        for (int i = 0; i < status!.listOfFiles!.length; i++) {
          _attachmentsList.add(ListOfFiles.fromJson(status!.listOfFiles![i].toJson()));
        }
      }

      /// To refresh the page
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      /// initialize navigation services
      GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _permissionServices = getIt.get<PermissionServices>();
      _mediaServices = getIt.get<MediaServices>();
      _authService = getIt.get<AuthService>();

      await _initializeData();
    });

    super.initState();
  }

  @override
  void dispose() {
    // Dispose FocusNodes
    _employmentStatusFocusNode.dispose();
    _employerFocusNode.dispose();
    _commentsFocusNode.dispose();

    // Dispose TextEditingControllers
    _employmentStatusController.dispose();
    _employerController.dispose();
    _commentsController.dispose();

    // Clear the dropdown menu item lists
    _employmentStatusMenuItemsList.clear();
    _employerMenuItemsList.clear();

    // Clear the attachments list
    _attachmentsList.clear();

    // Call super.dispose()
    super.dispose();
  }


  bool _isProcessing = false;

  setProcessing(bool value) {
    setState(() {
      _isProcessing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomSimpleAppBar(
        titleAsString: localization.employmentStatusTitle,
      ),
      body: Utils.modelProgressHud(
          processing: _isProcessing,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(localization), onRefresh: _initializeData)),
    );
  }

  Widget _buildUi(AppLocalizations localization) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetEmploymentStatusViewModel>(
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
                padding:  EdgeInsets.all(kPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Employment status card
                    _employmentStatusCard(
                        provider: provider, langProvider: langProvider,localization: localization,),

                    /// submit buttons
                    _submitAndBackButton(
                        langProvider: langProvider,
                        employmentStatusProvider: provider,
                    localization: localization),
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


  /// FocusNodes
  final FocusNode _employmentStatusFocusNode = FocusNode();
  final FocusNode _employerFocusNode = FocusNode();
  final FocusNode _commentsFocusNode = FocusNode();

  /// TextEditingControllers
  final TextEditingController _employmentStatusController = TextEditingController();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  /// Error texts
  String? _employmentStatusError;
  String? _employerError;
  String? _commentsError;

  Widget _employmentStatusCard(
      {required GetEmploymentStatusViewModel provider,
      required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomInformationContainer(
      leading: SvgPicture.asset("assets/myAccount/emloyment_Status_card_title_icon.svg"),
      title: localization.employmentDetails,
        expandedContent: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        fieldHeading(
            title: localization.employmentStatusFieldTitle,
            // title: '''الحالة الوظيفية''',
            important: true,
            langProvider: langProvider),
        scholarshipFormDropdown(
            currentFocusNode: _employmentStatusFocusNode,
            controller: _employmentStatusController,
            menuItemsList: _employmentStatusMenuItemsList,
            hintText: localization.select,
            errorText: _employmentStatusError,
            onChanged: (value) {
              setState(() {
                _employmentStatusError = null;
                _employmentStatusController.text = value;
                Utils.requestFocus(
                    focusNode: _employerFocusNode, context: context);
              });
            },
            context: context),

        /// ****************************************************************
        kFormHeight,
        fieldHeading(title: localization.emphistEmployerName, important: false, langProvider: langProvider),
        scholarshipFormDropdown(
            currentFocusNode: _employerFocusNode,
            controller: _employerController,
            menuItemsList: _employerMenuItemsList,
            hintText: localization.emphistEmployerNameWatermark,
            errorText: _employerError,
            onChanged: (value) {
              setState(() {
                _employerError = null;
                _employerController.text = value;
                Utils.requestFocus(
                    focusNode: _commentsFocusNode, context: context);
              });
            },
            context: context),

        /// ****************************************************************
        kFormHeight,
        fieldHeading(
            title: localization.comments, important: false, langProvider: langProvider),
        scholarshipFormTextField(
            currentFocusNode: _commentsFocusNode,
            controller: _commentsController,
            hintText: localization.commentsWatermark,
            textInputType: TextInputType.text,
            errorText: _commentsError,
            maxLines: 3,
            onChanged: (value) {
              if (_commentsFocusNode.hasFocus) {
                setState(() {});
              }
            }),

        /// ****************************************************************
        kFormHeight,

        /// ****************************************************************
        const MyDivider(
          color: AppColors.lightGrey,
        ),

        /// This section is to add file
        /// We have to show only one attachment to upload because api accepts only one attachment at a time.


        AttachmentAddFileButton(
            showButton: !(_attachmentsList.any((element){return element.newRecord == true || element.newlyAded == true;})),
            addFile: () async {
          await _addFile(
          );
        }),

        /// attachments
        _attachmentsUploadSection(),
      ],
    ));
  }

  final List<ListOfFiles> _attachmentsList = [];

  Widget _attachmentsUploadSection() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _attachmentsList.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          final attachment = _attachmentsList[index];
          return Column(
            children: [
              /// to show the card and also remove function is implemented
              PickedAttachmentCard(
                  index: index,
                  attachmentType: AttachmentType.employment,
                  attachment: attachment,
                  onRemoveAttachment: () {
                    setState(() {
                      _attachmentsList.removeAt(index);
                    });
                  }),
               SizedBox(height: kCardSpace,)
            ],
          );
        });
  }
  /// Function to add Attachment to the list
  _addFile() async {
    /// kindly check for permissions
    // final permitted = await _permissionServices.checkAndRequestPermission(Platform.isIOS ? Permission.storage : Permission.manageExternalStorage, context);
    if (true) {
      /// TODO: PLEASE ADD ALLOWED EXTENSIONS
      final file = await _mediaServices.getSingleFileFromPicker();

      if (file != null) {
        setState(() {
          _attachmentsList.add(ListOfFiles(
            attachmentSeqNumberController: TextEditingController(),
            descriptionController: TextEditingController(),
            dateController: TextEditingController(),
            attachSysfileNameController: TextEditingController(text: file.path.split('/').last),
            attachUserFileController: TextEditingController(text: file.path.split('/').last),
            base64StringController: TextEditingController(text: base64Encode(file.readAsBytesSync())),
            attachmentSeqNumberFocusNode: FocusNode(),
            descriptionFocusNode: FocusNode(),
            dateFocusNode: FocusNode(),
            attachSysfileNameFocusNode: FocusNode(),
            attachUserFileFocusNode: FocusNode(),
            base64StringFocusNode: FocusNode(),
            newRecord: true,
          ));
        });
      }
    }
  }
  Widget _submitAndBackButton(
      {required langProvider,
      UserInfo? userInfo,
      GetEmploymentStatusViewModel? employmentStatusProvider,
        required AppLocalizations localization
      }) {
    return Column(
      children: [
        kFormHeight,
        kFormHeight,
        ChangeNotifierProvider(
          create: (context) => CreateUpdateEmploymentStatusViewModel(),
          child: Consumer<CreateUpdateEmploymentStatusViewModel>(
              builder: (context, createUpdateProvider, _) {
            return CustomButton(
                buttonName: localization.update,
                isLoading:
                    createUpdateProvider.apiResponse.status == Status.LOADING,
                borderColor: Colors.transparent,
                // buttonColor: AppColors.scoThemeColor,
                textDirection: getTextDirection(langProvider),
                onTap: () async {
                  setProcessing(true);

                  bool result = validateForm(
                      langProvider: langProvider, userInfo: userInfo,localization: localization);
                  if (result) {
                    /// Create Form
                    createForm(provider: employmentStatusProvider);

                    // log(createEmploymentStatusForm.toString());
                    log(updateEmploymentStatusForm.toString());
                    bool result = employmentStatusProvider
                                ?.apiResponse?.data?.data?.employmentStatus !=
                            null
                        ? await createUpdateProvider
                            .createUpdateEmploymentStatus(
                                form: updateEmploymentStatusForm,
                                updating: true)
                        : await createUpdateProvider
                            .createUpdateEmploymentStatus(
                                form: createEmploymentStatusForm,
                                updating: false);
                    if (result) {
                      setProcessing(false);
                      /// update and refresh the information
                      await _initializeData();
                    }
                  }
                  setProcessing(false);
                });
          }),
        ),
      ],
    );
  }



  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm({required langProvider, UserInfo? userInfo,     required AppLocalizations localization}) {
    firstErrorFocusNode = null;

    if (_employmentStatusController.text.isEmpty) {
      setState(() {
        _employmentStatusError = localization.employmentStatusRequired;
        firstErrorFocusNode ??= _employmentStatusFocusNode;
      });
    }

    // if (_employerController.text.isEmpty) {
    //   setState(() {
    //     _employerError = "Please Select Employer";
    //     firstErrorFocusNode ??= _employerFocusNode;
    //   });
    // }
    //

    /// checking for fist error node
    if (firstErrorFocusNode != null) {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      return false;
    } else {
      /// No errors found, return true
      return true;
    }
  }

  /// My Final Submission form
  Map<String, dynamic> createEmploymentStatusForm = {};
  Map<String, dynamic> updateEmploymentStatusForm = {};

  void createForm(
      {GetEmploymentStatusViewModel? provider,
      GetPersonalDetailsViewModel? personalDetails}) {
    /// create Employment status form it uses post method
    createEmploymentStatusForm = {
      "sequanceNumber": "1",
      "employmentStatus": _employmentStatusController.text,
      "employerName": _employerController.text,
      "currentFlag": "Y",
      "comment": _commentsController.text,
      "listOfFiles": _attachmentsList.map((element) {
        return element.toJson();
      }).toList()
    };

    /// update Employment status form it uses put method
    updateEmploymentStatusForm = {
      "emplId": provider?.apiResponse?.data?.data?.employmentStatus?.emplId,
      "sequanceNumber": provider?.apiResponse?.data?.data?.employmentStatus?.sequanceNumber,
      "employmentStatus": _employmentStatusController.text,
      "employerName": _employerController.text,
      "currentFlag": "N",
      "comment": _commentsController.text,
      "listOfFiles": _attachmentsList.map((element) {
        return element.toJson();
      }).toList()
    };
  }
}
