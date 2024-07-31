import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/validations_and_errorText.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/signup/signup_otp_verification_view.dart';
import 'package:sco_v1/viewModel/authentication/signup_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../data/response/status.dart';
import '../../../resources/components/custom_dropdown.dart';
import '../../../resources/components/custom_text_field.dart';
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

  // Validations error Texts:
  String? _firstNameError;
  String? _familyNameError;
  String? _emailError;
  String? _confirmEmailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _emiratesError;
  String? _studentPhoneNumberError;

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
                            height: 20,
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
      currentFocusNode: _firstNameFocusNode,
      nextFocusNode: _secondNameFocusNode,
      controller: _firstNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.firstName,
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
            _firstNameError =
                ErrorText.getNameError(name: value!, context: context);
          });
        }
      },
    );
  }

  Widget _secondName(LanguageChangeViewModel provider) {
    return CustomTextField(
      currentFocusNode: _secondNameFocusNode,
      nextFocusNode: _thirdFourthNameFocusNode,
      controller: _secondNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.secondName,
      textInputType: TextInputType.text,
      textCapitalization: true,
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
      currentFocusNode: _thirdFourthNameFocusNode,
      nextFocusNode: _familyNameFocusNode,
      controller: _thirdFourthNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.thirdFourthName,
      textInputType: TextInputType.text,
      textCapitalization: true,
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
      currentFocusNode: _familyNameFocusNode,
      nextFocusNode: _dobFocusNode,
      controller: _familyNameController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.familyName,
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
            _familyNameError =
                ErrorText.getNameError(name: value!, context: context);
          });
        }
      },
    );
  }

  Widget _dateOfBirth(LanguageChangeViewModel provider) {
    return CustomTextField(
      readOnly: true,
      currentFocusNode: _dobFocusNode,
      nextFocusNode: _genderFocusNode,
      controller: _dobController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.dob,
      textInputType: TextInputType.datetime,
      textCapitalization: true,
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
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _confirmEmailFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emailAddress,
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

  Widget _confirmEmailAddress(LanguageChangeViewModel provider) {
    return CustomTextField(
        currentFocusNode: _confirmEmailFocusNode,
        nextFocusNode: _passwordFocusNode,
        controller: _confirmEmailController,
        obscureText: false,
        hintText: AppLocalizations.of(context)!.confirmEmailAddress,
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

  Widget _password(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _passwordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
              currentFocusNode: _passwordFocusNode,
              nextFocusNode: _confirmPasswordFocusNode,
              controller: _passwordController,
              hintText: AppLocalizations.of(context)!.password,
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

  Widget _confirmPassword(LanguageChangeViewModel provider) {
    return ValueListenableBuilder(
        valueListenable: _confirmPasswordVisibility,
        builder: (context, obscurePassword, child) {
          return CustomTextField(
            currentFocusNode: _confirmPasswordFocusNode,
            nextFocusNode: _countryFocusNode,
            controller: _confirmPasswordController,
            hintText: AppLocalizations.of(context)!.confirmPassword,
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
      currentFocusNode: _emiratesIdFocusNode,
      nextFocusNode: _studentPhoneNumberFocusNode,
      controller: _emiratesIdController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.emiratesId,
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

  Widget _studentPhoneNumber(LanguageChangeViewModel provider) {
    return CustomTextField(
      currentFocusNode: _studentPhoneNumberFocusNode,
      controller: _studentPhoneNumberController,
      obscureText: false,
      hintText: AppLocalizations.of(context)!.studentMobileNumber,
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

  Widget _signUpButton(LanguageChangeViewModel langProvider) {
    return ChangeNotifierProvider(
        create: (context) => SignupViewModel(),
        child: Consumer<SignupViewModel>(builder: (context, provider, _) {
          return CustomButton(
            textDirection: getTextDirection(langProvider),
            buttonName: AppLocalizations.of(context)!.signUp,
            isLoading: provider.apiResponse.status == Status.LOADING ? true : false,
            onTap: ()async {
              bool result =
                  validateForm(langProvider: langProvider, signup: provider);
              if (result) {
              bool signUpResult = await provider.signup(context: context, langProvider: langProvider);
              if(signUpResult){
                _navigationServices.pushCupertino(CupertinoPageRoute(builder: (context)=> const OtpVerificationView()) );
              }
              }
            },
            fontSize: 16,
            buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );
        }));
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


  //form extra validations:
  bool validateForm(
      {required LanguageChangeViewModel langProvider,
      required SignupViewModel signup})
  {
    if (_firstNameController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterFirstName,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setFirstName(_firstNameController.text.trim());
    }

    // if (_secondNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: AppLocalizations.of(context)!.enterSecondName, context: context, provider: langProvider);
    //   return false;
    // } else {
    signup.setMiddleName(_secondNameController.text.trim());
    // }

    // if (_thirdFourthNameController.text.isEmpty) {
    //   _alertServices.flushBarErrorMessages(message: AppLocalizations.of(context)!.enterThirdFourthName, context: context, provider: langProvider);
    //   return false;
    // } else {
    signup.setMiddleName2(_thirdFourthNameController.text.trim());
    // }

    if (_familyNameController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterFamilyName,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setLastName(_familyNameController.text.trim());
    }

    if (_dobController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterDateOfBirth,
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
          message: AppLocalizations.of(context)!.enterValidDay,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setDay(_dobDayController.text.trim());
    }

    if (_dobMonthController.text.isEmpty ||
        int.tryParse(_dobMonthController.text) == null ||
        int.parse(_dobMonthController.text) < 1 ||
        int.parse(_dobMonthController.text) > 12) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidMonth,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setMonth(_dobMonthController.text.trim());
    }

    if (_dobYearController.text.isEmpty ||
        int.tryParse(_dobYearController.text) == null) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidYear,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setYear(_dobYearController.text.trim());
    }

    if (_genderController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterGender,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setIsMale(_genderController.text.trim());
    }

    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidEmail,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setEmailAddress(_emailController.text.trim().toLowerCase());
    }

    if (_confirmEmailController.text.isEmpty ||
        _confirmEmailController.text != _emailController.text) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.emailsDoNotMatch,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setConfirmEmailAddress(
          _confirmEmailController.text.trim().toLowerCase());
    }

    if (_countryController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterCountry,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setCountry(_countryController.text.trim());
    }

    if (_emiratesIdController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidEmiratesId,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setEmirateId(
          _emiratesIdController.text.replaceAll("-", '').trim().toString());
    }

    if (_studentPhoneNumberController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidPhoneNumber,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setPhoneNo(_studentPhoneNumberController.text.trim());
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 8) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.enterValidPassword,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setPassword(_passwordController.text.trim());
    }

    if (_confirmPasswordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.passwordsDoNotMatch,
          context: context,
          provider: langProvider);
      return false;
    } else {
      signup.setConfirmPassword(_confirmPasswordController.text.trim());
    }

    return true;
  }
}

class EmiratesIDFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', '');

    // Limit to 15 characters
    if (text.length > 15) {
      text = text.substring(0, 15);
    }

    // Add dashes at specific positions
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 2 || i == 6 || i == 13) && i != text.length - 1) {
        buffer.write('-');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
