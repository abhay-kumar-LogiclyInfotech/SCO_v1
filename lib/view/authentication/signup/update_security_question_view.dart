import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/login/login_view.dart';
import 'package:sco_v1/viewModel/authentication/security_question_ViewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../../resources/app_colors.dart';
import '../../../../viewModel/services/navigation_services.dart';
import '../../../data/response/status.dart';
import '../../../hive/hive_manager.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_dropdown.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../viewModel/authentication/update_security_question_viewModel.dart';

class UpdateSecurityQuestionView extends StatefulWidget {
  bool updatingSecurityQuestion;

  UpdateSecurityQuestionView(
      {super.key, this.updatingSecurityQuestion = false});

  @override
  State<UpdateSecurityQuestionView> createState() =>
      _UpdateSecurityQuestionViewState();
}

class _UpdateSecurityQuestionViewState extends State<UpdateSecurityQuestionView>
    with MediaQueryMixin<UpdateSecurityQuestionView> {
  late NavigationServices _navigationService;
  late AlertServices _alertServices;

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();

  List<DropdownMenuItem> _securityQuestionItemsList = [];

  String? _answerError;
  String? _userId;

  // creating and updating the security question setup view
  /// This is the call to api to get the all security questions and populate dropdown.
  Future<void> _initializeData(
      {required LanguageChangeViewModel langProvider}) async {
    final provider =
        Provider.of<SecurityQuestionViewModel>(context, listen: false);
    await provider.getSecurityQuestions(
        // context: context,
        langProvider: langProvider,
        userId: _userId ?? '');
    // langProvider: langProvider, userId: "976311" ?? '');

    if (provider.getSecurityQuestionResponse.status == Status.COMPLETED) {
      _securityQuestionItemsList = populateNormalDropdown(
          menuItemsList: provider.getSecurityQuestionResponse.data?.data?.securityQuestions ??
              [],
          provider: langProvider);
      setState(() {});
    }
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    //initialize the userId:
    _userId = HiveManager.getUserId();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _initializeData(
          langProvider:
              Provider.of<LanguageChangeViewModel>(context, listen: false));
      setState(() {});
    });

    super.initState();
    _answerError = null;
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _questionFocusNode.dispose();
    _answerFocusNode.dispose();
    super.dispose();
  }

  bool _processing = false;

  setProcessing(value) {
    setState(() {
      _processing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
          title: widget.updatingSecurityQuestion
              ? Text(
                  localization.securityQuestion,
                  style: AppTextStyles.appBarTitleStyle(),
                )
              : SvgPicture.asset(
                  "assets/sco_logo.svg",
                  fit: BoxFit.fill,
                  height: 35,
                  width: 110,
                )),
      body: Utils.modelProgressHud(
          child: _buildUI(context: context), processing: _processing),
    );
  }

  Widget _buildUI({required BuildContext context}) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xfff8f8fa),
        ),
        SafeArea(
            child: Align(
          alignment: Alignment.topCenter,
          child: bgLogo(),
        )),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: orientation == Orientation.portrait ? screenHeight / 3 : screenHeight / 3,),
          padding: EdgeInsets.symmetric(horizontal: kPadding+kPadding,vertical: kPadding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(60, 60)),
          ),
          child: Column(
            children: [
              kLargeSpace,

              _title(),
              Expanded(
                child: Consumer<SecurityQuestionViewModel>(
                  builder: (context, provider, _) {
                    switch (provider.getSecurityQuestionResponse.status) {
                      case Status.LOADING:
                        return Utils.pageLoadingIndicator(context: context);
                      case Status.ERROR:
                        return Text(
                          AppLocalizations.of(context)!.somethingWentWrong,
                          style: const TextStyle(fontSize: 18),
                        );
                      case Status.COMPLETED:
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              fieldHeading(
                                title: AppLocalizations.of(context)!.securityQuestion,
                                important: true,
                                langProvider: langProvider,
                              ),
                              _questionField(langProvider: langProvider),
                              const SizedBox(height: 20),
                              fieldHeading(
                                title: AppLocalizations.of(context)!.securityAnswer,
                                important: true,
                                langProvider: langProvider,
                              ),
                              _answerField(langProvider: langProvider),
                              const SizedBox(height: 30),
                              _submitButton(
                                langProvider: langProvider,
                              )
                            ],
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  //title:
  Widget _title() {
    return Text(
      AppLocalizations.of(context)!.securityQuestionSetup,
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  //security question field:
  Widget _questionField({required LanguageChangeViewModel langProvider}) {
    return CustomDropdown(
      textDirection: getTextDirection(langProvider),
      menuItemsList: _securityQuestionItemsList,
      onChanged: (value) {
        setState(() {
          _questionController.text = value!;
          FocusScope.of(context).requestFocus(_answerFocusNode);
        });
      },
      outlinedBorder: true,
      currentFocusNode: _questionFocusNode,
      hintText: AppLocalizations.of(context)!.selectSecurityQuestion,
    );
  }

  //security answer field:
  Widget _answerField({required LanguageChangeViewModel langProvider}) {
    return CustomTextField(
        currentFocusNode: _answerFocusNode,
        controller: _answerController,
        obscureText: false,
        hintText: AppLocalizations.of(context)!.answerSecurityQuestion,
        textInputType: TextInputType.emailAddress,
        textCapitalization: true,
        maxLines: 1,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.darkGrey)),
        errorText: _answerError,
        onChanged: (value) {
          // Validate only when user interacts with the field
          if (_answerFocusNode.hasFocus) {
            setState(() {
              _answerError = ErrorText.getSecurityAnswerError(answer: value!, context: context);
            });
          }
        });
  }

//Security Answer submit field
  Widget _submitButton({required LanguageChangeViewModel langProvider}) {
    //Creating single Provider instance i.e. not putting in the top of the widget tree.
    return Consumer<UpdateSecurityQuestionViewModel>(
      builder: (context, provider, _) {
        return CustomButton(
          textDirection: getTextDirection(langProvider),
          buttonName: AppLocalizations.of(context)!.submitSecurityQuestion,
          isLoading:
              provider.updateSecurityQuestionResponse.status == Status.LOADING
                  ? true
                  : false,
          onTap: () async {
            setProcessing(true);

            bool result = validateForm(langProvider: langProvider);
            if (result) {
              provider.setSecurityQuestion(_questionController.text);
              provider.setSecurityAnswer(_answerController.text);
              bool updateResult = await provider.updateSecurityQuestion(
                langProvider: langProvider,
                userId: _userId ?? '',
              );

              /// checking updating security question because we are using this screen twice
              if (updateResult && !widget.updatingSecurityQuestion) {
                _navigationService.goBackUntilFirstScreen();
                _navigationService.pushReplacementCupertino(CupertinoPageRoute(builder: (context) => const LoginView()));
              }
            }
            setProcessing(false);
          },
          fontSize: 16,
          borderColor: Colors.transparent,
          elevation: 1,
        );
      },
    );
  }

  //Extra validations for better user Experience:
  bool validateForm({required LanguageChangeViewModel langProvider}) {
    if (_questionController.text.isEmpty) {
      _alertServices.showErrorSnackBar(AppLocalizations.of(context)!.selectSecurityQuestion);
      return false;
    }
    if (_answerController.text.isEmpty) {
      _alertServices.showErrorSnackBar(AppLocalizations.of(context)!.writeSecurityAnswer);
      return false;
    }

    return true;
  }
}
//background static picture:
Widget bgLogo() {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: SvgPicture.asset(
      "assets/security_question_bg1.svg",
    ),
  );
}