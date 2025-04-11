import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_confirmation_widget.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import '../../../l10n/app_localizations.dart';


import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../login/login_view.dart';

class ConfirmationView extends StatefulWidget {
  final bool isVerified;

  const ConfirmationView({super.key, required this.isVerified});

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView>
    with MediaQueryMixin<ConfirmationView> {
  late NavigationServices _navigationServices;

  //Loading button:
  bool _isLoading = false;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
                  builder: (context, langProvider, _) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 33),

                          //Confirmation Message
                          _confirmationMessage(langProvider: langProvider),

                          const SizedBox(height: 40),

                          //Login Button:
                          _clickToLogin(langProvider: langProvider),
                          const SizedBox(height: 18),
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

  //*----show Title of the Page--------*
  Widget _title() {
    return Text(
      AppLocalizations.of(context)!.confirmation_title,
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  //*-----show confirmation Message-----*
  Widget _confirmationMessage({required LanguageChangeViewModel langProvider}) {
    return widget.isVerified
        ? //Correct Confirmation message:
        CustomConfirmationWidget(
            backgroundColor: const Color(0xff00CC99).withOpacity(0.15),
            iconBackgroundColor: Colors.green,
            icon: Icons.check,
            headline:  AppLocalizations.of(context)!.correct,
            message:
            AppLocalizations.of(context)!.correct_message)
        : //Incorrect Confirmation message
        CustomConfirmationWidget(
            backgroundColor: Colors.red.withOpacity(0.1),
            iconBackgroundColor: Colors.red,
            icon: Icons.close,
            headline: AppLocalizations.of(context)!.wrong,
            message:  AppLocalizations.of(context)!.wrong_message);
  }

  /*
  * Move to Login Page
  */
  Widget _clickToLogin({required LanguageChangeViewModel langProvider}) {
    return CustomButton(
      textDirection: getTextDirection(langProvider),
      buttonName:  AppLocalizations.of(context)!.click_here_to_login,
      isLoading: false,
      onTap: () async {
        //*------calling the verifyOtp method in the ViewModel------*
        // setState(() {
        //   _isLoading = true;
        // });
        _navigationServices.goBackUntilFirstScreen();
        _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=>const LoginView()));
        // setState(() {
        //   _isLoading = false;
        // });
      },
      fontSize: 16,
      // buttonColor: AppColors.scoButtonColor,
      elevation: 1,
    );
  }
}
