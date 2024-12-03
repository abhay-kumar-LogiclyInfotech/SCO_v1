import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/account/change_password_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/components/custom_text_field.dart';
import '../../../viewModel/services/navigation_services.dart';


class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView>
    with MediaQueryMixin<ChangePasswordView> {
  late NavigationServices _navigationServices;

  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  late FocusNode _newPasswordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  final ValueNotifier<bool> _newPasswordValueNotifier =
  ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordValueNotifier =
  ValueNotifier<bool>(true);

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }


  /// managing the processing
  bool _processing = false;
  setProcessing(bool value)
  {
    setState(() {
      _processing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Utils.modelProgressHud(processing: _processing,child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/login_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: orientation == Orientation.portrait
                  ? screenHeight / 3
                  : screenHeight / 3,
            ),
            padding: EdgeInsets.only(
              left: orientation == Orientation.portrait
                  ? screenWidth * 0.08
                  : screenWidth / 100,
              right: orientation == Orientation.portrait
                  ? screenWidth * 0.08
                  : screenWidth / 100,
              top: orientation == Orientation.portrait
                  ? screenWidth * 0.05
                  : screenWidth / 100 * 5,
              bottom: orientation == Orientation.portrait
                  ? screenWidth / 100 * 1
                  : screenWidth / 100 * 1,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.elliptical(60, 60)),
            ),
            child: Column(
              children: [
                SizedBox(
                    child: SvgPicture.asset(
                      "assets/sco_logo.svg",
                      fit: BoxFit.fill,
                      height: 55,
                      width: 110,
                    )),
                Expanded(
                  child: Consumer<LanguageChangeViewModel>(
                    builder: (context, langProvider, _) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 33),

                            //heading:
                            _heading(langProvider), const SizedBox(height: 40),

                            //_passwordField
                            _newPasswordField(langProvider),
                            const SizedBox(height: 15),

                            _confirmPasswordField(langProvider),
                            const SizedBox(height: 60),

                            //Login Button:
                            _submitButton(langProvider),
                            kFormHeight,
                            _cancelButton(langProvider)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _heading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
        AppLocalizations.of(context)!.generate_new_password,
        style: const TextStyle(
          color: AppColors.scoButtonColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String? newPasswordErrorText;
  String? confirmPasswordErrorText;


  Widget _newPasswordField(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _newPasswordValueNotifier,
        builder: (context, newPasswordValueNotifier, child) {
          return CustomTextField(
            currentFocusNode: _newPasswordFocusNode,
            nextFocusNode: _confirmPasswordFocusNode,
            controller: _newPasswordController,
            hintText: AppLocalizations.of(context)!.newPassword,
            textInputType: TextInputType.visiblePassword,
            errorText: newPasswordErrorText,
            leading: SvgPicture.asset(
              "assets/lock.svg",
              // height: 18,
              // width: 18,
            ),
            obscureText: newPasswordValueNotifier,
            trailing: GestureDetector(
                onTap: () {
                  _newPasswordValueNotifier.value =
                  !_newPasswordValueNotifier.value;
                },
                child: _visibilityIcon(newPasswordValueNotifier)),
            onChanged: (value) {
              if(_newPasswordFocusNode.hasFocus){
                setState(() {
                  newPasswordErrorText = ErrorText.getPasswordError(password: _newPasswordController.text, context: context);
                });
              }
            },
          );
        });
  }

  Widget _confirmPasswordField(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _confirmPasswordValueNotifier,
        builder: (context, confirmPasswordValueNotifier, child) {
          return CustomTextField(
            currentFocusNode: _confirmPasswordFocusNode,
            controller: _confirmPasswordController,
            hintText: AppLocalizations.of(context)!.confirmPassword,
            textInputType: TextInputType.visiblePassword,
            leading: SvgPicture.asset(
              "assets/lock.svg",
            ),
            obscureText: confirmPasswordValueNotifier,
            trailing: GestureDetector(
                onTap: () {
                  _confirmPasswordValueNotifier.value =
                  !_confirmPasswordValueNotifier.value;
                },
                child:  _visibilityIcon(confirmPasswordValueNotifier),),
            errorText: confirmPasswordErrorText,
            onChanged: (value) {

              if(_confirmPasswordFocusNode.hasFocus){
                setState(() {
                  confirmPasswordErrorText = ErrorText.getPasswordError(password: _confirmPasswordController.text, context: context);
                });
              }
            },
          );
        });
  }

  Widget _visibilityIcon(bool show){
    return  show ?
    const Icon(Icons.visibility_off_rounded, color: AppColors.darkGrey,)
        : const Icon(
      Icons.visibility_rounded,
      color: AppColors.darkGrey,
    );
  }

  Widget _submitButton(LanguageChangeViewModel langProvider) {




    return ChangeNotifierProvider(create: (context)=>ChangePasswordViewModel(),
    child: Consumer<ChangePasswordViewModel>(builder: (context,provider,_){
      return CustomButton(
        textDirection: getTextDirection(langProvider),
        buttonName: AppLocalizations.of(context)!.submit,
        isLoading: false,
        onTap: ()async {
          setProcessing(true);
          bool result =  _validateFields();
          if(result)
          {
            /// call the reset password api
            await provider.changePassword(passwordOne: _newPasswordController.text.trim(), passwordTwo: _confirmPasswordController.text.trim());



          }
          setProcessing(false);
        },
        fontSize: 16,
        buttonColor: AppColors.scoThemeColor,
        borderColor: Colors.transparent,
        elevation: 1,
      );
    },),

    );




  }

  Widget _cancelButton(LanguageChangeViewModel provider) {
    final localization = AppLocalizations.of(context)!;

    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: localization.back,
      isLoading: false,
      onTap: () {
        _navigationServices.goBack();
      },
      fontSize: 16,
      buttonColor: Colors.white,
      borderColor: AppColors.scoThemeColor,
      textColor: AppColors.scoThemeColor,
      elevation: 0,
    );
  }


  bool _validateFields(){
    final localization = AppLocalizations.of(context)!;

    confirmPasswordErrorText = null;
    newPasswordErrorText = null;

    FocusNode? firstErrorFocusNode;
    firstErrorFocusNode = null;

    if(_newPasswordController.text.isEmpty || newPasswordErrorText != null){
        newPasswordErrorText = "${localization.registrationPasswordValidate}.*";
        firstErrorFocusNode = _newPasswordFocusNode;
    }
    if(_confirmPasswordController.text.isEmpty || confirmPasswordErrorText != null || _newPasswordController.text != _confirmPasswordController.text){
        confirmPasswordErrorText = "${localization.passwordsDoNotMatch}.*";
        firstErrorFocusNode = _confirmPasswordFocusNode;
    }

    if(firstErrorFocusNode != null){
      Utils.requestFocus(focusNode: _newPasswordFocusNode, context: context);
      return false;
    }

    return true;
  }

}
