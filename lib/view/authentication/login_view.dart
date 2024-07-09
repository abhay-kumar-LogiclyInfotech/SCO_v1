import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_advanced_switch.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/splash_viewModels/commonData_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/components/custom_text_field.dart';
import '../../viewModel/services/navigation_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with MediaQueryMixin<LoginView> {
  late NavigationServices _navigationServices;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  bool _isArabic = false;
  final _languageController = ValueNotifier<bool>(false);
  bool _isLoading = true; // State to track loading

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  Future<void> getInitialLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? language = preferences.getString('language_code');
    debugPrint(language);

    if (language != null && language == 'ar') {
      _isArabic = true;
      _languageController.value = true;
    } else {
      _isArabic = false;
      _languageController.value = false;
    }

    setState(() {
      _isLoading = false; // Set loading to false after initialization
    });
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInitialLanguage();
    });
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
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.scoThemeColor),
        ),
      );
    }

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
                            const SizedBox(height: 40),
                            //email Address Field;
                            _emailAddressField(provider),
                            const SizedBox(height: 20),
                            //_passwordField
                            _passwordField(provider),
                            const SizedBox(height: 10),

                            //forgot password field:
                            _forgotPasswordLink(provider),
                            const SizedBox(height: 40),
                            //Login Button:
                            _loginButton(provider),
                            const SizedBox(height: 20),
                            //giving or option:
                            _or(),
                            const SizedBox(height: 20),
                            //sign in with Uae Pass button:
                            _signInWithUaePassButton(provider),
                            const SizedBox(height: 16),
                            //sign up link:
                            _signUpLink(provider),
                            const SizedBox(height: 23),
                            //Change Language:
                            _selectLanguage(),
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

  Widget _emailAddressField(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
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
        valueListenable: _obscurePassword,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            textDirection: getTextDirection(provider),
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
                  _obscurePassword.value = !_obscurePassword.value;
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

  Widget _forgotPasswordLink(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                //Implement Forgot Password link here:
                _navigationServices.pushNamed('/forgotPasswordView');
              },
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: const TextStyle(
                  color: AppColors.scoButtonColor,
                  fontSize: 14,
                ),
              ))
        ],
      ),
    );
  }

  Widget _loginButton(LanguageChangeViewModel provider) {
    return ChangeNotifierProvider(
        create: (context) => CommonDataViewModel(),
        child:
            Consumer<CommonDataViewModel>(builder: (context, lovCodeViewModel, _) {
          return CustomButton(
            textDirection: getTextDirection(provider),
            buttonName: AppLocalizations.of(context)!.login,
            isLoading: false,
            onTap: () async {
              lovCodeViewModel.fetchCommonData();
            },
            fontSize: 16,
            buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );

          // return Consumer<LovCodeViewModel>(builder: (context,lovCodeViewModel,_){
          //    return CustomButton(
          //      textDirection: getTextDirection(provider),
          //      buttonName: AppLocalizations.of(context)!.login,
          //      isLoading: false,
          //      onTap: () async{
          //        lovCodeViewModel.fetchData();
          //      },
          //      fontSize: 16,
          //      buttonColor: AppColors.scoButtonColor,
          //      elevation: 1,
          //    );
          //  },);
        }));
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

  Widget _signInWithUaePassButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: "Sign in with UAE PASS",
      isLoading: false,
      onTap: () {},
      fontSize: 16,
      buttonColor: Colors.white,
      borderColor: Colors.black,
      textColor: Colors.black,
      elevation: 1,
      leadingIcon: const Icon(Icons.fingerprint),
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

  Widget _selectLanguage() {
    debugPrint("Called selectLanguage Switch");
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("English"),
        const SizedBox(
          width: 10,
        ),
        CustomAdvancedSwitch(
          controller: _languageController,
          activeColor: AppColors.scoThemeColor,
          inactiveColor: Colors.grey,
          initialValue: _isArabic,
          onChanged: (value) {
            if (value) {
              Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .changeLanguage(const Locale('ar'));
            } else {
              Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .changeLanguage(const Locale('en'));
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        const Directionality(
            textDirection: TextDirection.rtl, child: Text("عربي")),
      ],
    );
  }
}
