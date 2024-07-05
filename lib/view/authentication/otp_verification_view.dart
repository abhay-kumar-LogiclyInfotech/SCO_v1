import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../utils/constants.dart';
import '../../viewModel/services/navigation_services.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView>
    with MediaQueryMixin<OtpVerificationView> {
  late NavigationServices _navigationServices;

  late TextEditingController _verificationCodeController;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    _verificationCodeController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _verificationCodeController.dispose();
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

                            //pinPut Field:
                            _pinPutField(provider),
                            const SizedBox(height: 35),

                            _timeLimit(),
                            const SizedBox(height: 13),

                            //Login Button:
                            _submitButton(provider),
                            const SizedBox(height: 20),

                            //Or Field:
                            _or(),
                            const SizedBox(height: 20),
                            //Resend Verification Code Button:
                            _resendVerificationCodeButton(provider),
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
      child: const Text(
        "Code Verification",
        style: TextStyle(
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
      child: const Text(
          "We send a verification code to your email.\nEnter Verification code here!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center),
    );
  }

  Widget _pinPutField(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Pinput(
        length: 6,
        // obscureText: true,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: Constants.defaultPinTheme,
        focusedPinTheme: Constants.defaultPinTheme.copyWith(
            decoration: Constants.defaultPinTheme.decoration!
                .copyWith(border: Border.all(color: Colors.green))),
        onCompleted: (pin) => debugPrint(pin),
        // onCompleted: (pin) {
        //   //When password is filled completely perform operations and then move to the reset password Screen:
        //   // if we are at signup page verification then need to go to the login Screen
        // },
      ),
    );
  }

  Widget _timeLimit() {
    return const Text(
      "Time Limit 5 Minutes",
      style: TextStyle(fontSize: 12, color: Colors.red),
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

  Widget _resendVerificationCodeButton(LanguageChangeViewModel provider) {
    return CustomButton(
      buttonName: "Resend Code",
      isLoading: false,
      textDirection: getTextDirection(provider),
      onTap: () {},
      buttonColor: Colors.white,
      textColor: AppColors.scoButtonColor,
      borderColor: AppColors.scoButtonColor,
      fontSize: 16,
    );
  }
}
