import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../resources/components/custom_text_field.dart';
import '../../resources/validations_and_errorText.dart';
import '../../viewModel/services/navigation_services.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with MediaQueryMixin<ForgotPasswordView> {
  late NavigationServices _navigationServices;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  String? _emailError;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
    _emailError = null;
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
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
      textDirection: getTextDirection(provider),
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _passwordFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emailAddress,
      textInputType: TextInputType.emailAddress,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emailError,
      onChanged: (value) {
        if(_emailFocusNode.hasFocus){
          setState(() {
            _emailError = ErrorText.getEmailError(email: value!, context: context);
          });
        }
      },
    );
  }

  Widget _submitButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: AppLocalizations.of(context)!.submit,
      isLoading: false,
      onTap: () {},
      fontSize: 16,
      buttonColor: AppColors.scoButtonColor,
      elevation: 1,
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
}
