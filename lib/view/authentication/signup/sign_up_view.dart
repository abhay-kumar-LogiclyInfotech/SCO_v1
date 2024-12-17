import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' as intl;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/kBackgrounds/kLoginSignUpBg.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/signup/signup_otp_verification_view.dart';
import 'package:sco_v1/viewModel/authentication/signup_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../data/response/status.dart';
import '../../../resources/components/change_language_button.dart';
import '../../../resources/components/custom_dropdown.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/input_formatters/emirates_id_input_formatter.dart';
import '../../../utils/constants.dart';
import '../../../viewModel/services/navigation_services.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with MediaQueryMixin<SignUpView> {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  // late TextEditingController _firstNameController;
  // late TextEditingController _secondNameController;
  // late TextEditingController _thirdFourthNameController;
  // late TextEditingController _familyNameController;
  // late TextEditingController _dobController;
  // late TextEditingController _dobDayController;
  // late TextEditingController _dobMonthController;
  // late TextEditingController _dobYearController;
  // late TextEditingController _genderController;
  // late TextEditingController _emailController;
  // late TextEditingController _confirmEmailController;
  // late TextEditingController _passwordController;
  // late TextEditingController _confirmPasswordController;
  // late TextEditingController _countryController;
  // late TextEditingController _emiratesIdController;
  // late TextEditingController _studentPhoneNumberController;
  //
  // late FocusNode _firstNameFocusNode;
  // late FocusNode _secondNameFocusNode;
  // late FocusNode _thirdFourthNameFocusNode;
  // late FocusNode _familyNameFocusNode;
  // late FocusNode _dobFocusNode;
  // late FocusNode _genderFocusNode;
  // late FocusNode _emailFocusNode;
  // late FocusNode _confirmEmailFocusNode;
  // late FocusNode _passwordFocusNode;
  // late FocusNode _confirmPasswordFocusNode;
  // late FocusNode _countryFocusNode;
  // late FocusNode _emiratesIdFocusNode;
  // late FocusNode _studentPhoneNumberFocusNode;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _thirdFourthNameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _dobDayController = TextEditingController();
  final TextEditingController _dobMonthController = TextEditingController();
  final TextEditingController _dobYearController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emiratesIdController = TextEditingController();
  final TextEditingController _studentPhoneNumberController = TextEditingController();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _secondNameFocusNode = FocusNode();
  final FocusNode _thirdFourthNameFocusNode = FocusNode();
  final FocusNode _familyNameFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _confirmEmailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _emiratesIdFocusNode = FocusNode();
  final FocusNode _studentPhoneNumberFocusNode = FocusNode();

  final ValueNotifier<bool> _passwordVisibility = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordVisibility =
      ValueNotifier<bool>(true);

  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _countryMenuItemsList = [];

  // Validations error Texts:
  String? _firstNameError;
  String? _secondNameError;
  String? _thirdNameError;
  String? _familyNameError;
  String? _dobError;
  String? _genderError;
  String? _emailError;
  String? _confirmEmailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _countryError;
  String? _emiratesError;
  String? _studentPhoneNumberError;

  @override
  void initState() {
    // _firstNameController = TextEditingController();
    // _secondNameController = TextEditingController();
    // _thirdFourthNameController = TextEditingController();
    // _familyNameController = TextEditingController();
    // _dobController = TextEditingController();
    // _dobDayController = TextEditingController();
    // _dobMonthController = TextEditingController();
    // _dobYearController = TextEditingController();
    // _genderController = TextEditingController();
    // _emailController = TextEditingController();
    // _confirmEmailController = TextEditingController();
    // _passwordController = TextEditingController();
    // _confirmPasswordController = TextEditingController();
    // _countryController = TextEditingController();
    // _emiratesIdController = TextEditingController();
    // _studentPhoneNumberController = TextEditingController();
    //
    // _firstNameFocusNode = FocusNode();
    // _secondNameFocusNode = FocusNode();
    // _thirdFourthNameFocusNode = FocusNode();
    // _familyNameFocusNode = FocusNode();
    // _dobFocusNode = FocusNode();
    // _genderFocusNode = FocusNode();
    // _emailFocusNode = FocusNode();
    // _confirmEmailFocusNode = FocusNode();
    // _passwordFocusNode = FocusNode();
    // _confirmPasswordFocusNode = FocusNode();
    // _countryFocusNode = FocusNode();
    // _emiratesIdFocusNode = FocusNode();
    // _studentPhoneNumberFocusNode = FocusNode();

    final provider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    _genderMenuItemsList = populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap['GENDER']!.values!,
        provider: provider);
    _countryMenuItemsList = populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
        provider: provider);

    super.initState();

    // Initialize error to null or empty string to prevent immediate validation
    _firstNameError = null; // or _familyNameError = '';
    _familyNameError = null; // or _familyNameError = '';
    _emailError = null; // or _emailError = '';
    _confirmEmailError = null; // or _confirmEmailError = '';
    _passwordError = null; // or _passwordError = '';
    _confirmPasswordError = null; // or _confirmPasswordError = '';
    _emiratesError = null; // or _emiratesError = '';
    _studentPhoneNumberError = null; // or _studentPhoneNumberError = '';

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final GetIt getIt = GetIt.instance;
      _navigationServices = getIt.get<NavigationServices>();
      _alertServices = getIt.get<AlertServices>();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _thirdFourthNameController.dispose();
    _familyNameController.dispose();
    _dobController.dispose();
    _dobDayController.dispose();
    _dobMonthController.dispose();
    _dobYearController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _countryController.dispose();
    _emiratesIdController.dispose();
    _studentPhoneNumberController.dispose();

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
    _studentPhoneNumberFocusNode.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   gender = [
  //     AppLocalizations.of(context)!.male,
  //     AppLocalizations.of(context)!.female,
  //     AppLocalizations.of(context)!.transgender,
  //   ];
  // }

  bool _processing = false;

  setProcessing(bool processing) {
    setState(() {
      _processing = processing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  _buildUI(),
    );
  }

  Widget _buildUI() {
    final localization = AppLocalizations.of(context)!;
    return Stack(
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
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(60, 60)),
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
                      child: FocusScope(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            //sign Up with UAE Pass;
                            _signUpWithUaePassButton(
                                langProvider: langProvider,
                                localization: localization),
                            const SizedBox(height: 20),
                            //or
                            _or(),
                            kFormHeight,
                            _firstName(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,
                            _secondName(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,
                            _thirdFourthName(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _familyName(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _dateOfBirth(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _gender(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _emailAddress(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _confirmEmailAddress(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _country(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _emiratesId(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _studentPhoneNumber(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _password(
                                langProvider: langProvider,
                                localization: localization),
                            kFormHeight,

                            _confirmPassword(
                                langProvider: langProvider,
                                localization: localization),

                            const SizedBox(height: 30),

                            //Sign Up Button:
                            _signUpButton(
                                langProvider: langProvider,
                                localization: localization),
                            const SizedBox(height: 15),

                            //Already have account sign in link:
                            _signInLink(
                                langProvider: langProvider,
                                localization: localization),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
    );
  }

  Widget _signUpWithUaePassButton(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomButton(
      textDirection: getTextDirection(langProvider),
      buttonName: localization.signUpWithUaePass,
      isLoading: false,
      fontSize: 15,
      buttonColor: Colors.white,
      borderColor: Colors.black,
      textColor: Colors.black,
      elevation: 1,
      leadingIcon: const Icon(Icons.fingerprint),
      onTap: () {
        _alertServices.toastMessage(localization.comingSoon);
      },

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
            fontSize: 18,
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

  Widget _firstName(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _firstNameFocusNode,
      nextFocusNode: _secondNameFocusNode,
      controller: _firstNameController,
      obscureText: false,
      hintText: localization.registrationFirstNameWatermark,
      textInputType: TextInputType.text,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _firstNameError,
      onChanged: (value) {
        if (_firstNameFocusNode.hasFocus) {
          setState(() {
            _firstNameError = ErrorText.getNameArabicEnglishValidationError(
                name: value!, context: context);
          });
        }
      },
    );
  }

  Widget _secondName(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _secondNameFocusNode,
      nextFocusNode: _thirdFourthNameFocusNode,
      controller: _secondNameController,
      obscureText: false,
      hintText: localization.registrationMiddleNameWatermark,
      textInputType: TextInputType.text,
      textCapitalization: true,
      errorText: _secondNameError,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        if (_secondNameFocusNode.hasFocus) {
          setState(() {
            _secondNameError = ErrorText.getNameArabicEnglishValidationError(
                name: value!, context: context);
          });
        }
      },
    );
  }

  Widget _thirdFourthName(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _thirdFourthNameFocusNode,
      nextFocusNode: _familyNameFocusNode,
      controller: _thirdFourthNameController,
      obscureText: false,
      hintText: localization.registrationThirdNameWatermark,
      textInputType: TextInputType.text,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _thirdNameError,
      onChanged: (value) {
        if (_thirdFourthNameFocusNode.hasFocus) {
          setState(() {
            _thirdNameError = ErrorText.getNameArabicEnglishValidationError(
                name: value!, context: context);
          });
        }
        _thirdFourthNameController.text = value!;
      },
    );
  }

  Widget _familyName(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _familyNameFocusNode,
      nextFocusNode: _dobFocusNode,
      controller: _familyNameController,
      obscureText: false,
      hintText: localization.registrationLastNameWatermark,
      textInputType: TextInputType.text,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/familyName.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _familyNameError,
      onChanged: (value) {
        // Validate only when user interacts with the field
        if (_familyNameFocusNode.hasFocus) {
          setState(() {
            _familyNameError = ErrorText.getNameArabicEnglishValidationError(
                name: value!, context: context);
          });
        }
      },
    );
  }

  Widget _dateOfBirth(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      readOnly: true,
      currentFocusNode: _dobFocusNode,
      nextFocusNode: _genderFocusNode,
      controller: _dobController,
      obscureText: false,
      hintText: localization.brithDateWatermark,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/calendar.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _dobError,
      onChanged: (value) async {},
      onTap: () async {
        setState(() {
          _dobError = null;
        });
        DateTime? dob = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1960),
            lastDate: DateTime.now().add(const Duration(days: 365)));
        if (dob != null) {
          _dobController.text =
              intl.DateFormat('yyyy-MM-dd').format(dob).toString();
          _dobDayController.text = intl.DateFormat('dd').format(dob).toString();
          _dobMonthController.text =
              intl.DateFormat('MM').format(dob).toString();
          _dobYearController.text =
              intl.DateFormat('yyyy').format(dob).toString();
        }
      },
    );
  }

  //Gender DropDown:
  Widget _gender(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomDropdown(
      leading: SvgPicture.asset("assets/gender.svg"),
      textDirection: getTextDirection(langProvider),
      menuItemsList: _genderMenuItemsList,
      currentFocusNode: _genderFocusNode,
      hintText: localization.genderWatermark,
      errorText: _genderError,
      onChanged: (value) {
        setState(() {
          _genderError = null;
          _genderController.text = value!;
          FocusScope.of(context).requestFocus(_emailFocusNode);
        });
      },
    );
  }

  Widget _emailAddress(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _confirmEmailFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: localization.registrationEmailAddressWatermark,
      textInputType: TextInputType.emailAddress,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emailError,
      onChanged: (value) {
        // Validate only when user interacts with the field
        if (_emailFocusNode.hasFocus) {
          setState(() {
            _emailError =
                ErrorText.getEmailError(email: value!, context: context);
          });
        }
      },
    );
  }

  Widget _confirmEmailAddress(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
        currentFocusNode: _confirmEmailFocusNode,
        nextFocusNode: _passwordFocusNode,
        controller: _confirmEmailController,
        obscureText: false,
        hintText: localization.registrationConfEmailAddress,
        textInputType: TextInputType.emailAddress,
        textCapitalization: true,
        leading: SvgPicture.asset(
          "assets/email.svg",
          // height: 18,
          // width: 18,
        ),
        errorText: _confirmEmailError,
        onChanged: (value) {
          // Validate only when user interacts with the field
          if (_confirmEmailFocusNode.hasFocus) {
            setState(() {
              _confirmEmailError =
                  ErrorText.getEmailError(email: value!, context: context);
            });
          }
        });
  }

  Widget _password(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return ValueListenableBuilder(
        valueListenable: _passwordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
              currentFocusNode: _passwordFocusNode,
              nextFocusNode: _confirmPasswordFocusNode,
              controller: _passwordController,
              hintText: localization.registrationPassword,
              textInputType: TextInputType.visiblePassword,
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
              errorText: _passwordError,
              onChanged: (value) {
                // Validate only when user interacts with the field
                if (_passwordFocusNode.hasFocus) {
                  setState(() {
                    _passwordError = ErrorText.getPasswordError(
                        password: value!, context: context);
                  });
                }
              });
        });
  }

  Widget _confirmPassword(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return ValueListenableBuilder(
        valueListenable: _confirmPasswordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            currentFocusNode: _confirmPasswordFocusNode,
            nextFocusNode: _countryFocusNode,
            controller: _confirmPasswordController,
            hintText: localization.registrationConfPassword,
            textInputType: TextInputType.text,
            leading: SvgPicture.asset(
              "assets/lock.svg",
              // height: 18,
              // width: 18,
            ),
            obscureText: obscurePassword,
            trailing: GestureDetector(
                onTap: () {
                  _confirmPasswordVisibility.value =
                      !_confirmPasswordVisibility.value;
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
            errorText: _confirmPasswordError,
            onChanged: (value) {
              // Validate only when user interacts with the field
              if (_confirmPasswordFocusNode.hasFocus) {
                setState(() {
                  _confirmPasswordError = ErrorText.getPasswordError(
                      password: value!, context: context);
                });
              }
            },
          );
        });
  }

  Widget _country(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomDropdown(
      leading: SvgPicture.asset("assets/country.svg"),
      textDirection: getTextDirection(langProvider),
      menuItemsList: _countryMenuItemsList,
      currentFocusNode: _countryFocusNode,
      hintText: localization.country,
      errorText: _countryError,
      onChanged: (value) {
        setState(() {
          _countryError = null;
          _countryController.text = value!;
          //This thing is creating error: don't know how to fix it:
          FocusScope.of(context).requestFocus(_emiratesIdFocusNode);
        });
      },
    );
  }

  Widget _emiratesId(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _emiratesIdFocusNode,
      nextFocusNode: _studentPhoneNumberFocusNode,
      controller: _emiratesIdController,
      obscureText: false,
      hintText: localization.emiratesId,
      textInputType: TextInputType.datetime,
      inputFormat: [EmiratesIDFormatter()],
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/emiratesId.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emiratesError,
      onChanged: (value) {
        // Validate only when user interacts with the field
        if (_emiratesIdFocusNode.hasFocus) {
          setState(() {
            _emiratesError = ErrorText.getEmirateIdError(
                emirateId: value!, context: context);
          });
        }
      },
    );
  }

  Widget _studentPhoneNumber(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _studentPhoneNumberFocusNode,
      controller: _studentPhoneNumberController,
      obscureText: false,
      hintText: localization.registrationMobileNumber,
      textInputType: TextInputType.phone,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/phoneNumber.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _studentPhoneNumberError,
      onChanged: (value) {
        if (_studentPhoneNumberFocusNode.hasFocus) {
          setState(() {
            _studentPhoneNumberError = ErrorText.getPhoneNumberError(
                phoneNumber: value!, context: context);
          });
        }
      },
    );
  }

  Widget _signUpButton(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return Consumer<SignupViewModel>(builder: (context, provider, _) {
      return CustomButton(
        textDirection: getTextDirection(langProvider),
        buttonName: localization.signUp,
        isLoading: provider.apiResponse.status == Status.LOADING ? true : false,
        fontSize: 16,
        // buttonColor: AppColors.scoButtonColor,
        elevation: 1,
        onTap: () async {

          try{
            // setProcessing(true);

            if(validateForm(langProvider: langProvider, signup: provider,localization:localization))
            {
              createForm();
              bool signUpResult = await provider.signup(langProvider: langProvider,form: form);
              if (signUpResult) {
                _navigationServices.pushReplacementCupertino(CupertinoPageRoute(builder: (context) => const OtpVerificationView()));
              }
              else {
                _alertServices.showErrorSnackBar(provider.apiResponse.message.toString());
              }
            }
          }catch (e){
            debugPrint(e.toString());
          }
        },

      );
    });
  }


  dynamic form = {};

  createForm(){
    form.clear();
    form = {
      "firstName": _firstNameController.text.trim(),
      "middleName": _secondNameController.text.trim(),
      "middleName2": _thirdFourthNameController.text.trim(),
      "lastName": _familyNameController.text.trim(),
      "emailAddress": _emailController.text.trim(),
      "confirmEmailAddress": _confirmEmailController.text.trim(),
      "day": _dobDayController.text.trim(),
      "month": _dobMonthController.text.trim(),
      "year": _dobYearController.text.trim(),
      "emirateId": _emiratesIdController.text.trim().replaceAll('-', ''),
      "isMale": (_genderController.text.toUpperCase() == 'M').toString().trim(),
      "country": _countryController.text.trim().toUpperCase(),
      "phoneNo": _studentPhoneNumberController.text.trim(),
      "password": _passwordController.text.trim(),
      "confirmPassword": _confirmPasswordController.text.trim()
    };
  }




  Widget _signInLink(
      {required LanguageChangeViewModel langProvider,
      required AppLocalizations localization}) {
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            localization.alreadyHaveAccount,
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
              _navigationServices.pushNamed("/loginView");
            },
            child: Text(
              localization.signIn,
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



  FocusNode? firstErrorFocusNode;


  //form extra validations:
  bool validateForm(
      {required LanguageChangeViewModel langProvider,
        required SignupViewModel signup,
        required AppLocalizations localization})
  {

    firstErrorFocusNode = null;

    if (_firstNameController.text.isEmpty || _firstNameError != null) {
      setState(() {
        _firstNameError = localization.registrationFirstNameValidate;
        firstErrorFocusNode ??= _firstNameFocusNode;
        // requestFocus(_firstNameFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.registrationFirstNameValidate);
      });
      // return false;
    }
    // else {
    //   signup.setFirstName(_firstNameController.text.trim());
    // }

    if (_secondNameController.text.isNotEmpty && _secondNameError != null) {
      setState(() {
        _secondNameError = localization.registrationMiddleNameValidate;
        firstErrorFocusNode ??= _secondNameFocusNode;

        // requestFocus(_secondNameFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.registrationMiddleNameValidate);
      });
      // return false;
    }

    // if (_secondNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: localization.enterSecondName, context: context, provider: langProvider);
    //   return false;
    // } else {
    // signup.setMiddleName(_secondNameController.text.trim());
    // }

    if (_thirdFourthNameController.text.isNotEmpty && _thirdNameError != null) {
      setState(() {
        _thirdNameError = localization.registrationThirdNameValidate;
        firstErrorFocusNode ??= _thirdFourthNameFocusNode;

        // requestFocus(_thirdFourthNameFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.registrationThirdNameValidate);
      });

      // return false;
    }

    // if (_thirdFourthNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: localization.enterThirdFourthName, context: context, provider: langProvider);
    //   return false;
    // } else {
    // signup.setMiddleName2(_thirdFourthNameController.text.trim());
    // }

    if (_familyNameController.text.isEmpty || _familyNameError != null) {
      setState(() {
        _familyNameError = localization.registrationLastNameValidate;
        firstErrorFocusNode ??= _familyNameFocusNode;
        // requestFocus(_familyNameFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.registrationLastNameValidate);
      });

      // return false;
    }
    // else {
    //   signup.setLastName(_familyNameController.text.trim());
    // }

    if (_dobController.text.isEmpty || !isFourteenYearsOld(_dobController.text)) {
      setState(() {
        _dobError = localization.brithDateValidate;
        firstErrorFocusNode ??= _dobFocusNode;

        // requestFocus(_dobFocusNode);
      });
      // _alertServices.flushBarErrorMessages(message: localization.brithDateValidate);
      // return false;
    }
    // else {
    //   // signup.setDob(_dobController.text);
    // }

    if (_dobDayController.text.isEmpty ||
        int.tryParse(_dobDayController.text) == null ||
        int.parse(_dobDayController.text) < 1 ||
        int.parse(_dobDayController.text) > 31) {
      // _alertServices.flushBarErrorMessages(message: localization.enterValidDay,);
      // return false;
    }
    // else {
    //   signup.setDay(_dobDayController.text.trim());
    // }

    if (_dobMonthController.text.isEmpty ||
        int.tryParse(_dobMonthController.text) == null ||
        int.parse(_dobMonthController.text) < 1 ||
        int.parse(_dobMonthController.text) > 12) {
      // _alertServices.flushBarErrorMessages(message: localization.enterValidMonth,);
      // return false;
    }
    // else {
    //   signup.setMonth(_dobMonthController.text.trim());
    // }

    if (_dobYearController.text.isEmpty || int.tryParse(_dobYearController.text) == null) {
      // _alertServices.flushBarErrorMessages(message: localization.enterValidYear,);
      // return false;
    }
    // else {
    //   signup.setYear(_dobYearController.text.trim());
    // }

    if (_genderController.text.isEmpty || _genderError != null) {
      setState(() {
        _genderError = localization.genderValidate;
        firstErrorFocusNode ??= _genderFocusNode;

        // requestFocus(_genderFocusNode);_alertServices.flushBarErrorMessages(message: localization.enterGender,
        // );
      });
      // return false;
    }
    // else {
    //   signup.setIsMale(_genderController.text.trim());
    // }

    if (_emailController.text.isEmpty ||
        !Validations.isEmailValid(_emailController.text) ||
        _emailError != null) {
      setState(() {
        _emailError = localization.registrationEmailAddressValidate;
        firstErrorFocusNode ??= _emailFocusNode;

        // requestFocus(_emailFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.enterValidEmail,);
      });

      // return false;
    }
    // else {
    //   signup.setEmailAddress(_emailController.text.trim().toLowerCase());
    // }

    if (_confirmEmailController.text.isEmpty ||
        _confirmEmailController.text != _emailController.text ||
        !Validations.isEmailValid(_confirmEmailController.text) ||
        _confirmEmailError != null) {
      setState(() {
        _confirmEmailError = localization.emailsDoNotMatch;
        firstErrorFocusNode ??= _confirmEmailFocusNode;

        // requestFocus(_confirmEmailFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.emailsDoNotMatch);
      });

      // return false;
    }
    // else {
    //   signup.setConfirmEmailAddress(
    //       _confirmEmailController.text.trim().toLowerCase());
    // }

    if (_countryController.text.isEmpty || _countryError != null) {
      setState(() {
        _countryError = localization.countryValidate;
        firstErrorFocusNode ??= _countryFocusNode;

        // requestFocus(_countryFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.enterCountry,);
      });

      // return false;
    }
    // else {
    //   signup.setCountry(_countryController.text.trim());
    // }

    if (_emiratesIdController.text.isEmpty ||
        !Validations.isValidEmirateId(_emiratesIdController.text)) {
      setState(() {
        _emiratesError = localization.emiratesIdValidate;
        firstErrorFocusNode ??= _emiratesIdFocusNode;

        // requestFocus(_emiratesIdFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.enterValidEmiratesId,);
      });

      // return false;
    }
    // else {
    //   signup.setEmirateId(
    //       _emiratesIdController.text.replaceAll("-", '').trim().toString());
    // }

    if (_studentPhoneNumberController.text.isEmpty ||
        !Validations.isPhoneNumberValid(_studentPhoneNumberController.text) ||
        _studentPhoneNumberError != null) {
      setState(() {
        _studentPhoneNumberError = localization.registrationMobileNumberValidate;
        firstErrorFocusNode ??= _studentPhoneNumberFocusNode;

        // requestFocus(_studentPhoneNumberFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.enterValidPhoneNumber,);
      });

      // return false;
    }
    // else {
    //   signup.setPhoneNo(_studentPhoneNumberController.text.trim());
    // }

    if (_passwordController.text.isEmpty || _passwordController.text.length < 8 || !Validations.isPasswordValid(_passwordController.text) ||
        _passwordError != null) {
      setState(() {
        _passwordError = localization.registrationPasswordValidate;
        firstErrorFocusNode ??= _passwordFocusNode;

        // requestFocus(_passwordFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.enterValidPassword,);
      });
      // return false;
    }
    // else {
    //   signup.setPassword(_passwordController.text.trim());
    // }

    if (_confirmPasswordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text ||
        !Validations.isPasswordValid(_confirmPasswordController.text) ||
        _confirmPasswordError != null) {
      setState(() {
        _confirmPasswordError = localization.passwordsDoNotMatch;
        firstErrorFocusNode ??= _confirmPasswordFocusNode;
        // requestFocus(_confirmPasswordFocusNode);
        // _alertServices.flushBarErrorMessages(message: localization.passwordsDoNotMatch,);
      });
      // return false;
    }
    // else {
    //   signup.setConfirmPassword(_confirmPasswordController.text.trim());
    // }



    if(firstErrorFocusNode != null)
    {
      FocusScope.of(context).requestFocus(firstErrorFocusNode);
      // _alertServices.toastMessage(localization.pleaseFillAllRequiredFields);
      _alertServices.showErrorSnackBar(localization.pleaseFillAllRequiredFields);

      return false;
    }
    else{
      return true;
    }
    return true;
  }

}

