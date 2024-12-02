import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/hive/hive_manager.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/kBackgrounds/kLoginSignUpBg.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/signup/terms_and_conditions_view.dart';
import 'package:sco_v1/viewModel/authentication/otp_verification_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../data/response/status.dart';
import '../../../main.dart';
import '../../../resources/components/change_language_button.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/services/alert_services.dart';
import '../../../viewModel/services/navigation_services.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView>
    with MediaQueryMixin<OtpVerificationView> {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  //verification code:
  late TextEditingController _verificationCodeController;

  //userId:
  String? _userId;

  //Loading button:
  bool _isLoading = false;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    _verificationCodeController = TextEditingController();

    super.initState();
    debugPrint(HiveManager.getUserId());
    _userId = HiveManager.getUserId();
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
          const KLoginSignupBg(),
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

                            //pinPut Field:
                            _pinPutField(provider),
                            const SizedBox(height: 35),

                            _timeLimit(provider),
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
          Positioned(left: 10, child: SafeArea(child: ChangeLanguageButton())),
        ],
      ),
    );
  }

  Widget _heading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(AppLocalizations.of(context)!.otp_verification,
          style: AppTextStyles.titleBoldTextStyle()),
    );
  }

  Widget _subHeading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(AppLocalizations.of(context)!.otp_verification_message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center),
    );
  }

  Widget _pinPutField(LanguageChangeViewModel langProvider) {
    return Consumer<OtpVerificationViewModel>(
      builder: (context, provider, _) {
        return Directionality(
          textDirection: getTextDirection(langProvider),
          child: Pinput(
            length: 7,
            // obscureText: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            defaultPinTheme: Constants.defaultPinTheme,
            focusedPinTheme: Constants.defaultPinTheme.copyWith(
                decoration: Constants.defaultPinTheme.decoration!
                    .copyWith(border: Border.all(color: Colors.green))),
            onCompleted: (pin) async {
              setState(() {
                _isLoading = true;
              });
              //*------setting values in the controller------*
              _verificationCodeController.text = pin.toString();

              //*------calling the verifyOtp method in the ViewModel------*
              if (pin.isNotEmpty) {
                bool result = await provider.verifyOtp(
                  // context: context,
                  langProvider: langProvider,
                  userId: _userId,
                  otp: pin.toString(),
                );

                if (result) {
                  _navigationServices.pushReplacementCupertino(
                      CupertinoPageRoute(
                          builder: (context) =>
                              const TermsAndConditionsView()));
                }

                setState(() {
                  _isLoading = false;
                });
              }

              setState(() {
                _isLoading = false;
              });
            },
          ),
        );
      },
    );
  }

  //Time limit text:
  Widget _timeLimit(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(
        AppLocalizations.of(context)!.time_limit,
        style: const TextStyle(fontSize: 12, color: Colors.red),
      ),
    );
  }

  // or separator:
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

  Widget _submitButton(LanguageChangeViewModel langProvider) {
    return Consumer<OtpVerificationViewModel>(
      builder: (context, provider, _) {
        return CustomButton(
          textDirection: getTextDirection(langProvider),
          buttonName: AppLocalizations.of(context)!.submit,
          isLoading:
              (provider.otpVerificationResponse.status == Status.LOADING ||
                      _isLoading)
                  ? true
                  : false,
          onTap: () async {
            //*------calling the verifyOtp method in the ViewModel------*
            if (_verificationCodeController.text.isNotEmpty) {
              bool result = await provider.verifyOtp(
                // context: context,
                langProvider: langProvider,
                userId: _userId,
                otp: _verificationCodeController.text,
              );

              if (result) {
                _navigationServices.pushReplacementCupertino(CupertinoPageRoute(
                    builder: (context) => const TermsAndConditionsView()));
              }
            } else {
              // _alertServices.flushBarErrorMessages(
              //     message: "Please Enter Valid Otp");
              _alertServices.showErrorSnackBar("Please Enter valid OTP");
            }
          },
          fontSize: 16,
          buttonColor: AppColors.scoButtonColor,
          elevation: 1,
        );
      },
    );
  }

  Widget _resendVerificationCodeButton(LanguageChangeViewModel langProvider) {
    return Consumer<OtpVerificationViewModel>(builder: (context, provider, _) {
      return CustomButton(
        buttonName: AppLocalizations.of(context)!.resend_code,
        isLoading: provider.resendOtpResponse.status == Status.LOADING ? true : false,
        // isLoading: false,
        textDirection: getTextDirection(langProvider),
        buttonColor: Colors.white,
        textColor: AppColors.scoButtonColor,
        borderColor: AppColors.scoButtonColor,
        fontSize: 16,
        loaderColor: AppColors.scoButtonColor,
        onTap: () async {
          provider.resendOtp(
              langProvider: langProvider,
              userId: _userId);
        },
      );
    });
  }
}
