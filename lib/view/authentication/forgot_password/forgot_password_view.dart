import 'dart:math' show Random, pi;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/forgot_password/answer_security_question_view.dart';
import 'package:sco_v1/viewModel/authentication/forgot_password_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../resources/components/change_language_button.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../viewModel/services/alert_services.dart';
import '../../../viewModel/services/navigation_services.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with MediaQueryMixin<ForgotPasswordView> {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  late TextEditingController _emailController;
  late TextEditingController _captchaController;

  late FocusNode _emailFocusNode;
  late FocusNode _captchaFocusNode;

  String? _emailError;

  double _angle = 0;
  String? _captchaText;

  void _generateRandomCaptcha() {
    setState(() {
      int randomNumber = 100000 + Random().nextInt(900000);
      _captchaText = '$randomNumber';
    });
  }

  void _rotate() {
    setState(() {
      _generateRandomCaptcha();
      // Increment the angle by 360 degrees
      _angle += 180.0;
      // Ensure the angle stays within 0 to 360 degrees
      // Optional: Normalize the angle within 0 to 360 degrees
      // _angle %= 360.0;
    });
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    _emailController = TextEditingController();
    _captchaController = TextEditingController();

    _emailFocusNode = FocusNode();
    _captchaFocusNode = FocusNode();

    super.initState();
    _emailError = null;

    _rotate();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _captchaController.dispose();
    _emailController.dispose();
    _captchaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(color: AppColors.darkGrey,),
          SafeArea(
            // width: double.infinity,
            child: Image.asset(
              'assets/login_bg.png',
              fit: BoxFit.contain,
              // height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: orientation == Orientation.portrait
                  ? screenHeight / 2.5
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
                    builder: (context, provider, _) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 33),

                            //heading:
                            _heading(provider),
                            const SizedBox(height: 25),

                            _subHeading(provider),
                            const SizedBox(height: 25),
                            //email Address Field;
                            _emailAddressField(provider),
                            const SizedBox(height: 10),

                            //create Captcha by rotating:
                            _createCaptcha(),

                            //Enter Captcha:
                            _captchaField(provider),

                            const SizedBox(height: 35),

                            //Submit Button:
                            _submitButton(provider),
                            const SizedBox(height: 20),
                            //giving or option:
                            _or(),
                            const SizedBox(height: 20),

                            //sign up link:
                            _signUpLink(provider),
                            const SizedBox(height: 23),
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
      ),
    );
  }

  Widget _heading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
        AppLocalizations.of(context)!.forgotPasswordTitle,
        style: const TextStyle(
          color: AppColors.scoButtonColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _subHeading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(AppLocalizations.of(context)!.pleaseEnterYourEmailAddress,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center),
    );
  }

  Widget _emailAddressField(LanguageChangeViewModel provider) {
    return CustomTextField(
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _captchaFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emailAddress,
      textInputType: TextInputType.emailAddress,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emailError,
      onChanged: (value) {
        if (_emailFocusNode.hasFocus) {
          setState(() {
            _emailError =
                ErrorText.getEmailError(email: value!, context: context);
          });
        }
      },
    );
  }

  Widget _createCaptcha() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.darkGrey),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            _captchaText ?? '',
            style: AppTextStyles.titleTextStyle(),
          ),
        ),
        Transform.rotate(
            angle: _angle * 3.1415927 / 180, // Convert degrees to radians
            child: IconButton(
                onPressed: _rotate,
                icon: const Icon(
                  Icons.rotate_right,
                  size: 30,
                )))
      ],
    );
  }

  Widget _captchaField(LanguageChangeViewModel provider) {
    return CustomTextField(
      currentFocusNode: _captchaFocusNode,
      controller: _captchaController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.enterCaptcha,
      textInputType: TextInputType.number,
      leading: SvgPicture.asset(
        "assets/captcha.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {},
    );
  }

  Widget _submitButton(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(),
      child: Consumer<ForgotPasswordViewModel>(
        builder: (context, provider, _) {
          return CustomButton(
            textDirection: getTextDirection(langProvider),
            buttonName: AppLocalizations.of(context)!.submit,
            isLoading:
                provider.getSecurityQuestionResponse.status == Status.LOADING
                    ? true
                    : false,
            onTap: () async {
              bool validated = _validateForm(langProvider: langProvider);

              if (validated) {
                bool result = await provider.getSecurityQuestion(email: _emailController.text, context: context, langProvider: langProvider);

                if (result) {
                  final String securityQuestion = provider.getSecurityQuestionResponse.data?.data?.securityQuestion?.securityQuestion.toString() ?? "";
                  final String securityAnswer = provider.getSecurityQuestionResponse.data?.data?.securityQuestion?.securityAnswer.toString() ?? "";
                  final String userId = provider.getSecurityQuestionResponse.data?.data?.securityQuestion?.userId.toString() ?? "";

                  if (securityQuestion.isNotEmpty && securityAnswer.isNotEmpty && userId.isNotEmpty) {
                    _navigationServices.pushReplacementCupertino(
                        CupertinoPageRoute(builder: (context) => AnswerSecurityQuestionView(
                                securityQuestion: securityQuestion,
                                securityAnswer: securityAnswer,
                                userId: userId)));
                  }
                }
              }
            },
            fontSize: 16,
            buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );
        },
      ),
    );
  }

  Widget _or() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          AppLocalizations.of(context)!.or,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }

  Widget _signUpLink(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.dontHaveAccount,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            //Implement signup link here:
            onTap: () {
              _navigationServices.goBack();

              _navigationServices.pushNamed('/signUpView');
            },
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: const TextStyle(
                  color: AppColors.scoThemeColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateForm({required LanguageChangeViewModel langProvider}) {
    if (_emailController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.pleaseEnterYourEmailAddress,
          // context: context,
          provider: langProvider);
      return false;
    }
    if (_captchaController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message:AppLocalizations.of(context)!.pleaseEnterCaptcha,
          // context: context,
          provider: langProvider);
      return false;
    }
    if (_captchaText != _captchaController.text) {
      _rotate();
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.incorrectCaptcha,
          // context: context,
          provider: langProvider);
      return false;
    }

    return true;
  }
}
