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
import '../../viewModel/services/navigation_services.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView>
    with MediaQueryMixin<ResetPasswordView> {
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
                            _heading(provider), const SizedBox(height: 40),

                            //_passwordField
                            _newPasswordField(provider),
                            const SizedBox(height: 15),

                            _confirmPasswordField(provider),
                            const SizedBox(height: 60),

                            //Login Button:
                            _submitButton(provider),
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
        AppLocalizations.of(context)!.resetNewPassword,
        style: const TextStyle(
          color: AppColors.scoButtonColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

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
                child: newPasswordValueNotifier
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
              // height: 18,
              // width: 18,
            ),
            obscureText: confirmPasswordValueNotifier,
            trailing: GestureDetector(
                onTap: () {
                  _confirmPasswordValueNotifier.value =
                      !_confirmPasswordValueNotifier.value;
                },
                child: confirmPasswordValueNotifier
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
}
