import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../resources/components/custom_text_field.dart';
import '../../viewModel/services/navigation_services.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with MediaQueryMixin<SignUpView> {
  late NavigationServices _navigationServices;

  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _thirdFourthNameController;
  late TextEditingController _familyNameController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;
  late TextEditingController _confirmEmailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _countryController;
  late TextEditingController _emiratesIdController;
  late TextEditingController _mobileNumberController;

  late FocusNode _firstNameFocusNode;
  late FocusNode _secondNameFocusNode;
  late FocusNode _thirdFourthNameFocusNode;
  late FocusNode _familyNameFocusNode;
  late FocusNode _dobFocusNode;
  late FocusNode _genderFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _confirmEmailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;
  late FocusNode _countryFocusNode;
  late FocusNode _emiratesIdFocusNode;
  late FocusNode _mobileNumberFocusNode;

  final ValueNotifier<bool> _passwordVisibility = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordVisibility = ValueNotifier<bool>(true);


  @override
  void initState() {




    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    _firstNameController = TextEditingController();
    _secondNameController = TextEditingController();
    _thirdFourthNameController = TextEditingController();
    _familyNameController = TextEditingController();
    _dobController = TextEditingController();
    _genderController = TextEditingController();
    _emailController = TextEditingController();
    _confirmEmailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _countryController = TextEditingController();
    _emiratesIdController = TextEditingController();
    _mobileNumberController = TextEditingController();

    _firstNameFocusNode = FocusNode();
    _secondNameFocusNode = FocusNode();
    _thirdFourthNameFocusNode = FocusNode();
    _familyNameFocusNode = FocusNode();
    _dobFocusNode = FocusNode();
    _genderFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _confirmEmailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _countryFocusNode = FocusNode();
    _emiratesIdFocusNode = FocusNode();
    _mobileNumberFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _thirdFourthNameController.dispose();
    _familyNameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _countryController.dispose();
    _emiratesIdController.dispose();
    _mobileNumberController.dispose();

    _firstNameFocusNode.dispose();
    _secondNameFocusNode.dispose();
    _thirdFourthNameFocusNode.dispose();
    _familyNameFocusNode.dispose();
    _dobFocusNode.dispose();
    _genderFocusNode.dispose();
    _emailFocusNode.dispose();
    _confirmEmailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _countryFocusNode.dispose();
    _emiratesIdFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
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
            child: Consumer<LanguageChangeViewModel>(
              builder: (context, provider, _) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/company_logo.png",
                        ),
                      ),
                      const SizedBox(height: 40),
                      //email Address Field;
                      _emailAddressField(provider),
                      const SizedBox(height: 20),
                      //_passwordField
                      _passwordField(provider),
                      const SizedBox(height: 10),

                      //Sign Up Button:
                      _signUpButton(provider),
                      const SizedBox(height: 20),

                      //Already have account sign in link:
                      _signInLink(provider),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailAddressField(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection:
          provider.appLocale == const Locale('en') || provider.appLocale == null
              ? TextDirection.ltr
              : TextDirection.rtl,
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _passwordFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.idEmailOrMobile,
      textInputType: TextInputType.emailAddress,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {},
    );
  }

  Widget _passwordField(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _passwordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            textDirection: provider.appLocale == const Locale('en') ||
                    provider.appLocale == null
                ? TextDirection.ltr
                : TextDirection.rtl,
            currentFocusNode: _passwordFocusNode,
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,
            textInputType: TextInputType.text,
            isNumber: false,
            leading: SvgPicture.asset(
              "assets/lock.svg",
              // height: 18,
              // width: 18,
            ),
            obscureText: obscurePassword,
            trailing: GestureDetector(
                onTap: () {
                  _passwordVisibility.value = !_passwordVisibility.value;
                },
                child: obscurePassword
                    ? const Icon(
                        Icons.visibility_off_rounded,
                        color: AppColors.darkGrey,
                      )
                    : const Icon(
                        Icons.visibility_rounded,
                        color: AppColors.darkGrey,
                      )),
            onChanged: (value) {},
          );
        });
  }

  Widget _signUpButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection:
          provider.appLocale == const Locale('en') || provider.appLocale == null
              ? TextDirection.ltr
              : TextDirection.rtl,
      buttonName: AppLocalizations.of(context)!.signUp,
      isLoading: false,
      onTap: () {},
      fontSize: 20,
      buttonColor: AppColors.scoButtonColor,
      elevation: 1,
    );
  }

  Widget _signInLink(LanguageChangeViewModel provider) {
    return Directionality(
    textDirection: provider.appLocale == const Locale('en') ||
        provider.appLocale == null
        ? TextDirection.ltr
        : TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            AppLocalizations.of(context)!.alreadyHaveAccount,
            style: const TextStyle(
                color: AppColors.scoButtonColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            //Implement sign in link here:
            onTap: () {
              _navigationServices.goBack();
            },
            child:  Text(
    AppLocalizations.of(context)!.signIn
    ,
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
