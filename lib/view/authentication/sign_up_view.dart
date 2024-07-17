import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/authentication/signup_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../resources/components/custom_dropdown.dart';
import '../../resources/components/custom_text_field.dart';
import '../../utils/constants.dart';
import '../../viewModel/services/navigation_services.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with MediaQueryMixin<SignUpView> {
  late NavigationServices _navigationServices;
  late AlertServices _alertServices;

  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _thirdFourthNameController;
  late TextEditingController _familyNameController;
  late TextEditingController _dobController;
  late TextEditingController _dobDayController;
  late TextEditingController _dobMonthController;
  late TextEditingController _dobYearController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;
  late TextEditingController _confirmEmailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _countryController;
  late TextEditingController _emiratesIdController;
  late TextEditingController _studentPhoneNumberController;

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
  late FocusNode _studentPhoneNumberFocusNode;

  final ValueNotifier<bool> _passwordVisibility = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _confirmPasswordVisibility =
      ValueNotifier<bool>(true);



  List<DropdownMenuItem> _genderMenuItemsList = [];
  List<DropdownMenuItem> _countryMenuItemsList = [];

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    _firstNameController = TextEditingController();
    _secondNameController = TextEditingController();
    _thirdFourthNameController = TextEditingController();
    _familyNameController = TextEditingController();
    _dobController = TextEditingController();
    _dobDayController = TextEditingController();
    _dobMonthController = TextEditingController();
    _dobYearController = TextEditingController();
    _genderController = TextEditingController();
    _emailController = TextEditingController();
    _confirmEmailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _countryController = TextEditingController();
    _emiratesIdController = TextEditingController();
    _studentPhoneNumberController = TextEditingController();

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
    _studentPhoneNumberFocusNode = FocusNode();

    final provider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    _genderMenuItemsList = populateDropdown(
        menuItemsList: Constants.lovCodeMap['GENDER']!.values!,
        provider: provider);
    _countryMenuItemsList = populateDropdown(
        menuItemsList: Constants.lovCodeMap['COUNTRY']!.values!,
        provider: provider);

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    // gender = [
    //   AppLocalizations.of(context)!.male,
    //   AppLocalizations.of(context)!.female,
    // ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Stack(
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
                  builder: (context, provider, _) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          //sign Up with UAE Pass;
                          _signUpWithUaePassButton(provider),
                          const SizedBox(height: 20),
                          //or
                          _or(),
                          const SizedBox(height: 10),

                          _firstName(provider),
                          const SizedBox(height: 10),

                          _secondName(provider),
                          const SizedBox(height: 10),

                          _thirdFourthName(provider),
                          const SizedBox(height: 10),

                          _familyName(provider),
                          const SizedBox(height: 10),

                          _dateOfBirth(provider),
                          const SizedBox(height: 10),

                          _gender(provider),
                          const SizedBox(height: 10),

                          _emailAddress(provider),
                          const SizedBox(height: 10),

                          _confirmEmailAddress(provider),
                          const SizedBox(height: 10),

                          _password(provider),
                          const SizedBox(height: 10),

                          _confirmPassword(provider),
                          const SizedBox(height: 10),

                          _country(provider),
                          const SizedBox(height: 10),

                          _emiratesId(provider),
                          const SizedBox(height: 10),

                          _studentPhoneNumber(provider),
                          const SizedBox(height: 30),

                          //Sign Up Button:
                          _signUpButton(provider),
                          const SizedBox(height: 15),

                          //Already have account sign in link:
                          _signInLink(provider),

                          const SizedBox(
                            height: 5,
                          ),
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

  Widget _signUpWithUaePassButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: "Sign up with UAE PASS",
      isLoading: false,
      onTap: () {},
      fontSize: 15,
      buttonColor: Colors.white,
      borderColor: Colors.black,
      textColor: Colors.black,
      elevation: 1,
      leadingIcon: const Icon(Icons.fingerprint),
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

  Widget _firstName(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _firstNameFocusNode,
      nextFocusNode: _secondNameFocusNode,
      controller: _firstNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.firstName,
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _firstNameController.text = value!;
      },
    );
  }

  Widget _secondName(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _secondNameFocusNode,
      nextFocusNode: _thirdFourthNameFocusNode,
      controller: _secondNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.secondName,
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _secondNameController.text = value!;
      },
    );
  }

  Widget _thirdFourthName(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _thirdFourthNameFocusNode,
      nextFocusNode: _familyNameFocusNode,
      controller: _thirdFourthNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.thirdFourthName,
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _thirdFourthNameController.text = value!;
      },
    );
  }

  Widget _familyName(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _familyNameFocusNode,
      nextFocusNode: _dobFocusNode,
      controller: _familyNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.familyName,
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/familyName.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _familyNameController.text = value!;
      },
    );
  }

  Widget _dateOfBirth(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      readOnly: true,
      currentFocusNode: _dobFocusNode,
      nextFocusNode: _genderFocusNode,
      controller: _dobController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.dob,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/calendar.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) async {},
      onTap: () async {
        DateTime? dob = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1960),
            lastDate: DateTime.now().add(const Duration(days: 365)));
        if (dob != null) {
          _dobController.text =
              intl.DateFormat('dd-MM-yyyy').format(dob).toString();
          _dobDayController.text = intl.DateFormat('dd').format(dob).toString();
          _dobMonthController.text =
              intl.DateFormat('MM').format(dob).toString();
          _dobYearController.text =
              intl.DateFormat('yyyy').format(dob).toString();
          debugPrint(_dobDayController.text);
          debugPrint(_dobMonthController.text);
          debugPrint(_dobYearController.text);
        }
      },
    );
  }

  //Gender DropDown:
  Widget _gender(LanguageChangeViewModel provider) {
    return CustomDropdown(
      leading: SvgPicture.asset("assets/gender.svg"),
      textDirection: getTextDirection(provider),
      menuItemsList: _genderMenuItemsList,
      onChanged: (value) {
        debugPrint(value.toString());
        _genderController.text = value!;

        //This thing is creating error: don't know how to fix it:
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
      currentFocusNode: _genderFocusNode,
      hintText: AppLocalizations.of(context)!.gender,
    );
  }

  Widget _emailAddress(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _confirmEmailFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emailAddress,
      textInputType: TextInputType.emailAddress,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _emailController.text = value!;
      },
    );
  }

  Widget _confirmEmailAddress(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _confirmEmailFocusNode,
      nextFocusNode: _passwordFocusNode,
      controller: _confirmEmailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.confirmEmailAddress,
      textInputType: TextInputType.emailAddress,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _confirmEmailController.text = value!;
      },
    );
  }

  Widget _password(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _passwordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            textDirection: getTextDirection(provider),
            currentFocusNode: _passwordFocusNode,
            nextFocusNode: _confirmPasswordFocusNode,
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,
            textInputType: TextInputType.visiblePassword,
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
            onChanged: (value) {
              _passwordController.text = value!;
            },
          );
        });
  }

  Widget _confirmPassword(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _confirmPasswordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            textDirection: getTextDirection(provider),
            currentFocusNode: _confirmPasswordFocusNode,
            nextFocusNode: _countryFocusNode,
            controller: _confirmPasswordController,
            hintText: AppLocalizations.of(context)!.confirmPassword,
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
            onChanged: (value) {
              _confirmPasswordController.text = value!;
            },
          );
        });
  }

  Widget _country(LanguageChangeViewModel provider) {
    return CustomDropdown(
      leading: SvgPicture.asset("assets/country.svg"),
      textDirection: getTextDirection(provider),
      menuItemsList: _countryMenuItemsList,
      onChanged: (value) {
        _countryController.text = value!;
        //This thing is creating error: don't know how to fix it:
        FocusScope.of(context).requestFocus(_emiratesIdFocusNode);
      },
      currentFocusNode: _countryFocusNode,
      hintText: AppLocalizations.of(context)!.country,
    );
  }

  Widget _emiratesId(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _emiratesIdFocusNode,
      nextFocusNode: _studentPhoneNumberFocusNode,
      controller: _emiratesIdController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emiratesId,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/emiratesId.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _emiratesIdController.text = value!;
      },
    );
  }

  Widget _studentPhoneNumber(LanguageChangeViewModel provider) {
    return CustomTextField(
      textDirection: getTextDirection(provider),
      currentFocusNode: _studentPhoneNumberFocusNode,
      controller: _studentPhoneNumberController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.studentMobileNumber,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/phoneNumber.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {
        _studentPhoneNumberController.text = value!;
      },
    );
  }

  Widget _signUpButton(LanguageChangeViewModel provider) {
    return CustomButton(
      textDirection: getTextDirection(provider),
      buttonName: AppLocalizations.of(context)!.signUp,
      isLoading: false,
      onTap: () {
        final signupProvider =
            Provider.of<SignupViewModel>(context, listen: false);

        bool result =
            validateForm(langProvider: provider, signup: signupProvider);
        if (result) {
          signupProvider.signup(context: context, langProvider: provider);
        }
      },
      fontSize: 16,
      buttonColor: AppColors.scoButtonColor,
      elevation: 1,
    );
  }

  Widget _signInLink(LanguageChangeViewModel provider) {
    return Directionality(
      textDirection: getTextDirection(provider),
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
              _navigationServices.pushNamed("/loginView");
            },
            child: Text(
              AppLocalizations.of(context)!.signIn,
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

  bool validateForm(
      {required LanguageChangeViewModel langProvider,
      required SignupViewModel signup}) {
    if (_firstNameController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter your first name",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setFirstName(_firstNameController.text);
    }

    // if (_secondNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: "Enter your second name", context: context, provider: langProvider);
    //   return false;
    // } else {
    signup.setMiddleName(_secondNameController.text);
    // }

    // if (_thirdFourthNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: "Enter your third/fourth name", context: context, provider: langProvider);
    //   return false;
    // } else {
    signup.setMiddleName2(_thirdFourthNameController.text);
    // }

    if (_familyNameController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter your family name or last name",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setLastName(_familyNameController.text);
    }

    if (_dobController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter your date of birth",
          context: context,
          provider: langProvider);
      return false;
    } else {
      // signup.setDob(_dobController.text);
    }

    if (_dobDayController.text.isEmpty ||
        int.tryParse(_dobDayController.text) == null ||
        int.parse(_dobDayController.text) < 1 ||
        int.parse(_dobDayController.text) > 31) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid day",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setDay(_dobDayController.text);
    }

    if (_dobMonthController.text.isEmpty ||
        int.tryParse(_dobMonthController.text) == null ||
        int.parse(_dobMonthController.text) < 1 ||
        int.parse(_dobMonthController.text) > 12) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid month",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setMonth(_dobMonthController.text);
    }

    if (_dobYearController.text.isEmpty ||
        int.tryParse(_dobYearController.text) == null) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid year",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setYear(_dobYearController.text);
    }

    if (_genderController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter your gender",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setIsMale(_genderController.text);
    }

    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid email",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setEmailAddress(_emailController.text);
    }

    if (_confirmEmailController.text.isEmpty ||
        _confirmEmailController.text != _emailController.text) {
      _alertServices.flushBarErrorMessages(
          message: "Emails do not match",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setConfirmEmailAddress(_confirmEmailController.text);
    }

    if (_countryController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter your country",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setCountry(_countryController.text);
    }

    if (_emiratesIdController.text.isEmpty ) {
      _alertServices.flushBarErrorMessages(
          message: "Enter valid Emirates ID",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setEmirateId(_emiratesIdController.text);
    }

    if (_studentPhoneNumberController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid phone number",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setPhoneNo(_studentPhoneNumberController.text);
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 8) {
      _alertServices.flushBarErrorMessages(
          message: "Enter a valid password (at least 8 characters)",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setPassword(_passwordController.text);
    }

    if (_confirmPasswordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text) {
      _alertServices.flushBarErrorMessages(
          message: "Passwords do not match",
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setConfirmPassword(_confirmPasswordController.text);
    }

    return true;
  }
}
