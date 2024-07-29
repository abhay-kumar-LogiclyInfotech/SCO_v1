import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/forgot_password/confirmation_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../../data/response/status.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/authentication/forgot_password_viewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class ForgotSecurityQuestionOtpVerificationView extends StatefulWidget {
  final String verificationOtp;
  final String userId;

  const ForgotSecurityQuestionOtpVerificationView(
      {super.key, required this.verificationOtp, required this.userId});

  @override
  State<ForgotSecurityQuestionOtpVerificationView> createState() =>
      _ForgotSecurityQuestionOtpVerificationViewState();
}

class _ForgotSecurityQuestionOtpVerificationViewState
    extends State<ForgotSecurityQuestionOtpVerificationView>
    with MediaQueryMixin<ForgotSecurityQuestionOtpVerificationView> {
  late NavigationServices _navigationServices;

  //verification code:
  late TextEditingController _verificationCodeController;

  //Loading button:
  bool _isLoading = false;

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
      backgroundColor: AppColors.scoBgColor,
      appBar: CustomSimpleAppBar(
          title: SvgPicture.asset(
        "assets/sco_logo.svg",
        fit: BoxFit.fill,
        height: 35,
        width: 110,
      )),
      body: _buildUI(context: context),
    );
  }

  Widget _buildUI({required BuildContext context}) {
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
          child: bgSecurityLogo(),
        )),
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
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(60, 60)),
          ),
          child: Column(
            children: [
              _title(),
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
                          _subHeading(provider),
                          const SizedBox(height: 25),
                          //pinPut Field:
                          _pinPutField(provider),
                          const SizedBox(height: 35),
                          //Login Button:
                          _submitButton(provider),
                          const SizedBox(height: 18),
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
    );
  }

  //*------Heading------/
  Widget _title() {
    return Text(
      AppLocalizations.of(context)!.answer_security_question,
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  //*------Subheading------*/
  Widget _subHeading(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
      child: Text(AppLocalizations.of(context)!.pleaseEnterCode,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center),
    );
  }

  //*------PinPut Field------*/
  Widget _pinPutField(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(),
        child: Consumer<ForgotPasswordViewModel>(
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

                    _verificationCodeController.text = pin.toString();

                    if (pin.isNotEmpty) {
                      bool result =
                          (pin.toString() == widget.verificationOtp.toString());

                      if (result) {
                        bool mailSent = await provider.sendForgotPasswordOnMail(
                          userId: widget.userId,
                          context: context,
                          langProvider: langProvider,
                        );

                        if (mailSent) {
                          _navigationServices.pushReplacementCupertino(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  ConfirmationView(isVerified: mailSent),
                            ),
                          );
                        } else {
                          _navigationServices.pushReplacementCupertino(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const ConfirmationView(isVerified: false),
                            ),
                          );
                        }
                      } else {
                        _navigationServices.pushReplacementCupertino(
                          CupertinoPageRoute(
                            builder: (context) =>
                                const ConfirmationView(isVerified: false),
                          ),
                        );
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }),
            );
          },
        ));
  }

  //*------Resend Verification Code Button------*/
  Widget _submitButton(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(),
        child: Consumer<ForgotPasswordViewModel>(
          builder: (context, provider, _) {
            return CustomButton(
              textDirection: getTextDirection(langProvider),
              buttonName: AppLocalizations.of(context)!.verify,
              isLoading: _isLoading,
              onTap: () async {
                //*------calling the verifyOtp method in the ViewModel------*
                if (_verificationCodeController.text.isNotEmpty &&
                    widget.verificationOtp.isNotEmpty) {
                  bool result = (widget.verificationOtp.toString() ==
                      _verificationCodeController.text.toString());
                  if (result) {
                    bool mailSent = await provider.sendForgotPasswordOnMail(
                        userId: widget.userId,
                        context: context,
                        langProvider: langProvider);

                    _navigationServices.pushReplacementCupertino(
                        CupertinoPageRoute(
                            builder: (context) =>
                                ConfirmationView(isVerified: mailSent)));
                  } else {
                    _navigationServices.pushReplacementCupertino(
                        CupertinoPageRoute(
                            builder: (context) =>
                                const ConfirmationView(isVerified: false)));
                  }
                }
              },
              fontSize: 16,
              buttonColor: AppColors.scoButtonColor,
              elevation: 1,
            );
          },
        ));
  }

  //*------Resend Verification Code------*/
  Widget _resendVerificationCodeButton(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
        create: (context) => ForgotPasswordViewModel(),
        child: Consumer<ForgotPasswordViewModel>(
          builder: (context, provider, _) {
            return InkWell(
              onTap: () async {
                bool result =
                    await provider.getForgotSecurityQuestionVerificationOtp(
                        userId: widget.userId,context: context);

                if (result) {
                  String? verificationOtp = provider
                      .forgotSecurityQuestionOtpVerificationResponse
                      .data
                      ?.data
                      ?.verificationCode;
                  if (verificationOtp != null && verificationOtp.isNotEmpty) {
                    _navigationServices.pushReplacementCupertino(
                        CupertinoPageRoute(
                            builder: (context) =>
                                ForgotSecurityQuestionOtpVerificationView(
                                    verificationOtp: verificationOtp,
                                    userId: widget.userId)));
                  }
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  provider.forgotSecurityQuestionOtpVerificationResponse
                              .status ==
                          Status.LOADING
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.scoThemeColor,
                            strokeWidth: 1.5,
                          ),
                        )
                      : Text(
                          AppLocalizations.of(context)!.resendVerificationCode,
                          style: const TextStyle(
                            color: AppColors.scoThemeColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            );
          },
        ));
  }
}
