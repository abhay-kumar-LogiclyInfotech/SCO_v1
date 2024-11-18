

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/simple_card.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/viewModel/account/personal_details/update_personal_details_viewmodel.dart';
import 'package:sco_v1/viewModel/services/auth_services.dart';
import 'package:sco_v1/viewModel/services/media_services.dart';
import 'package:sco_v1/viewModel/services/permission_checker_service.dart';

import '../../../data/response/status.dart';
import '../../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/cards/picked_attachment_card.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/myDivider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/account/personal_details/get_personal_details_viewmodel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../viewModel/services/navigation_services.dart';


class EmploymentStatusView extends StatefulWidget {
  const EmploymentStatusView({super.key});

  @override
  State<EmploymentStatusView> createState() => _EmploymentStatusViewState();
}

class _EmploymentStatusViewState extends State<EmploymentStatusView> with MediaQueryMixin {
  late NavigationServices _navigationServices;
  late AuthService _authService;
  late PermissionServices _permissionServices;
  late MediaServices _mediaServices;



  List<DropdownMenuItem> _employmentStatusMenuItemsList = [];
  List<DropdownMenuItem> _employerMenuItemsList = [];


  Future _initializeData()async{
    /// Get User id to call the get employment status api




    /// fetch student profile Information t prefill the user information
    final studentProfileProvider = Provider.of<GetPersonalDetailsViewModel>(context,listen: false);
    await studentProfileProvider.getPersonalDetails();

    /// *------------------------------------------ Initialize dropdowns start ------------------------------------------------------------------*
    final langProvider = Provider.of<LanguageChangeViewModel>(context,listen: false);
    /// Check and populate dropdowns only if the values exist
    if (Constants.lovCodeMap['EMPLOYMENT_ST']?.values != null) {_employmentStatusMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['EMPLOYMENT_ST']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}

    if (Constants.lovCodeMap['EMPLOYER']?.values != null) {_employerMenuItemsList = populateCommonDataDropdown(menuItemsList: Constants.lovCodeMap['EMPLOYER']!.values!, provider: langProvider, textColor: AppColors.scoButtonColor);}
 /// *------------------------------------------ Initialize dropdowns end ------------------------------------------------------------------*

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        titleAsString: "Employment Status",
      ),
      body: _buildUi(),
    );
  }



  Widget _buildUi() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Consumer<GetPersonalDetailsViewModel>(
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
              final user = provider.apiResponse.data?.data?.user;
              final userInfo = provider.apiResponse.data?.data?.userInfo;

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

                        /// Employment status card
                        _employmentStatusCard(provider: provider,langProvider: langProvider),



                        /// submit buttons
                        _submitAndBackButton(langProvider: langProvider,userInfo: userInfo,provider: provider),
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





  ///*------Student Information Section------*

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

  Widget _employmentStatusCard({required GetPersonalDetailsViewModel provider,required LanguageChangeViewModel langProvider}) {
    return SimpleCard(
        expandedContent: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// First name
            fieldHeading(title: "Employment Status", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _employmentStatusFocusNode,
                controller: _employmentStatusController,
                menuItemsList: _employmentStatusMenuItemsList,
                hintText: "Select Employment Status",
                errorText: _employmentStatusError,
                onChanged: (value) {
                  setState(() {
                    _employmentStatusError = null;
                    _employmentStatusController.text = value;
                    Utils.requestFocus(focusNode: _employerFocusNode, context: context);
                  });

                }, context: context),

            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Employer", important: true, langProvider: langProvider),
            scholarshipFormDropdown(
                currentFocusNode: _employerFocusNode,
                controller: _employerController,
                menuItemsList: _employerMenuItemsList,
                hintText: "Select Employer",
                errorText: _employerError,
                onChanged: (value) {
                  setState(() {
                    _employerError = null;
                    _employerController.text = value;
                    Utils.requestFocus(focusNode: _commentsFocusNode, context: context);
                  });

                }, context: context),
            /// ****************************************************************
            kFormHeight,
            fieldHeading(title: "Comments", important: false, langProvider: langProvider),
            scholarshipFormTextField(
                currentFocusNode: _commentsFocusNode,
                controller: _commentsController,
                hintText: "Enter Your Comments",
                textInputType: TextInputType.text,
                errorText: _commentsError,
                maxLines: 3,
                onChanged: (value) {
                  if (_commentsFocusNode.hasFocus) {
                    setState(() {
                    });
                  }
                }),
            /// ****************************************************************
            kFormHeight,
            /// ****************************************************************
            const MyDivider(color: AppColors.lightGrey,),

            // This section is to add file
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Attachments"),
                addRemoveMoreSection(title: "Add File", add: true, onChanged: ()async{
                  await _addFile();
                })
              ],
            ),

            /// attachments
            _attachmentsUploadSection(),

          ],
        ));
  }


  final List<File> _attachmentsList = [];

  Widget _attachmentsUploadSection(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
        itemCount: _attachmentsList.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
        final file = _attachmentsList[index];
      return Column(
        children:
        [

          /// to show the card and also remove function is implemented
          PickedAttachmentCard(file: file, onRemoveAttachment: (){
            setState(() {
              _attachmentsList.removeAt(index);
            });
          }),
          kFormHeight,
        ],
      );
    });
  }

  Widget _submitAndBackButton({required langProvider,UserInfo? userInfo,GetPersonalDetailsViewModel? provider}){
    return Column(
      children: [
        kFormHeight,
        kFormHeight,

        ChangeNotifierProvider(create: (context)=>UpdatePersonalDetailsViewModel(),
          child: Consumer<UpdatePersonalDetailsViewModel>(builder: (context,updateProvider,_){
            return CustomButton(buttonName: "Update", isLoading: updateProvider?.apiResponse.status == Status.LOADING,borderColor: Colors.transparent,buttonColor: AppColors.scoThemeColor, textDirection: getTextDirection(langProvider),
                onTap: ()async{
                  bool result =  validateForm(langProvider: langProvider, userInfo: userInfo);
                  if(result){
                    /// Create Form
                    createForm(provider: provider);

                    print(form);
                    bool result = await updateProvider.updatePersonalDetails(form: form);
                    if(result){
                      /// update and refresh the information
                      await _initializeData();

                    }

                  }
                });

          }),

        ),
      ],
    );
  }


  /// Function to add Attachment to the list
  _addFile()async
  {
    /// kindly check for permissions
    final permitted = await _permissionServices.checkAndRequestPermission(Platform.isIOS ? Permission.storage : Permission.photos, context);
    if(permitted){

      /// TODO: PLEASE ADD ALLOWED EXTENSIONS
     final file =  await  _mediaServices.getSingleFileFromPicker();

     if(file != null){
       setState(() {
         _attachmentsList.add(file);
         });
     }
    }
  }


  /// To request focus where field needs to adjust:
  FocusNode? firstErrorFocusNode;

  bool validateForm({required langProvider,  UserInfo? userInfo}) {

    firstErrorFocusNode = null;

    if (_employmentStatusController.text.isEmpty) {
      setState(() {
        _employmentStatusError = "Please Select Employment Status";
        firstErrorFocusNode ??= _employmentStatusFocusNode;
      });
    }

    if (_employerController.text.isEmpty) {
      setState(() {
        _employerError = "Please Select Employer";
        firstErrorFocusNode ??= _employerFocusNode;
      });
    }
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
  Map<String,dynamic> form = {};
  void createForm( {GetPersonalDetailsViewModel? provider}) {
    form = {
      "employmentStatus": {
        "emplId": "000921",
        "sequanceNumber": "1",
        "employmentStatus": "NWR",
        "university": "00016148",
        "currentFlag": "Y",
        "comment": "%COMMENTS%",
        "listOfFiles": [
          {
            "attachmentSeqNumber": "1",
            "description": "",
            "date": 1731607771453,
            "attachSysfileName": "20230110172609443_IRCTC Next Generation eTicketing System.pdf",
            "attachUserFile": "IRCTC Next Generation eTicketing System.pdf",
            "base64String": "base64String",
            "newRecord": false
          }
        ]
      }
    };
  }
}

