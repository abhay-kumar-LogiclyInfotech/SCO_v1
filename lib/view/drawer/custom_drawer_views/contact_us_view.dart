import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/viewModel/drawer/contact_us_viewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_dropdown.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart'; // Add this package

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {


  late AlertServices _alertServices;

  // //webUrl:
  // final String webUrl = "www.sco.ae";


  //poBox:
  final String poBoxNumber = "73505";

  //phone no. 1:
  final String phoneNo1 = "+971 2 6413999";

  //phone no. 2:
  final String phoneNo2 = "+97122228391";

  Future<void> _launchUrl(uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _makePhoneCall({required String phoneNumber, required AppLocalizations localization}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    // Check permission before making a call
    var status = await Permission.phone.status;
    if (status.isGranted) {
      await launchUrl(launchUri);
    } else {
      // Request permission
      if (await Permission.phone.request().isGranted) {
        await launchUrl(launchUri);
      } else {
        // Handle the case where permission is not granted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localization.phoneCallPermissionDenied)),
        );
      }
    }
  }

  // FocusNodes for each field
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _inquiryTypeFocusNode = FocusNode(); // Note: Not used with controller
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();
  final FocusNode _captchaFocusNode = FocusNode();

  // TextEditingControllers for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _inqueryTypeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  // Error variables
  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _inquiryTypeError;
  String? _subjectError;
  String? _messageError;

  List<DropdownMenuItem> _inquiryTypeMenuItemsList = [];

  //*-----Creating stuff for random Captcha------*
  double _angle = 0;
  String? _captchaText;

  void _generateRandomCaptcha() {
    setState(() {
      int randomNumber = 100000 + Random().nextInt(900000);
      _captchaText = '$randomNumber';
    });
  }

  void _rotate() {
    setState(() {
      _generateRandomCaptcha();
      // Increment the angle by 360 degrees
      _angle += 180.0;
    });
  }



  void _initializeData(){
    //Rooting the angle and generating the new captcha
    _rotate();

    final provider =
    Provider.of<LanguageChangeViewModel>(context, listen: false);
    _inquiryTypeMenuItemsList = populateCommonDataDropdown(
        menuItemsList: Constants.lovCodeMap['CONTACT_US_TYPE']!.values!,
        provider: provider);
  }

  @override
  void initState() {
    super.initState();

    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
    _initializeData();

  }

  @override
  void dispose() {
    // Dispose FocusNodes and Controllers to free resources
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    _inquiryTypeFocusNode.dispose(); // Note: Not used with controller
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomSimpleAppBar(
        title: Text(
          localization.contactUs,
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body: SafeArea(child: _buildUi(localization: localization)),
    );
  }

  Widget _buildUi({required localization}) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              //*----Common Contact Details Section-----*/
              _commonContactDetailsSection(langProvider: langProvider ,localization: localization),

              const SizedBox(height: 30),

              //*-----Static Text (Write To US)-----*/
              _writeToUs(langProvider: langProvider ,localization: localization),
              const SizedBox(height: 30),

              //*----Inquery Form------*/
              _inqueryForm(langProvider: langProvider ,localization: localization),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //*----Common Contact Details-----*
  Widget _commonContactDetailsSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    final String poBox = localization.poBox;
    final String phoneNo = localization.phoneNo;
    final String website = localization.website;
    final String unitedArabEmirates = localization.unitedArabEmirates;
    final String poBoxTapMessage = localization.poBoxTapMessage;
    final String webUrl = localization.webUrl;

    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: AppColors.scoButtonColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*----Heading Text-----*
                  RichText(
                    text: TextSpan(
                      text: unitedArabEmirates,
                      style: AppTextStyles.titleBoldThemeColorTextStyle().copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 7),
                  //*----Post Office Text-----*
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        poBox,
                        style: AppTextStyles.normalThemeColorTextStyle().copyWith(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle the tap event here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$poBoxTapMessage$poBox')),
                          );
                        },
                        child: Text(
                          " $poBoxNumber ",
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  //*----Phone Number----*/
                  Row(
                    children: [
                      Text(phoneNo,
                          style: AppTextStyles.normalThemeColorTextStyle().copyWith(color: Colors.white)),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _makePhoneCall(phoneNumber:phoneNo1,localization: localization);
                          },
                          child: Text(
                            phoneNo1,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      const Text(
                        ', ',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _makePhoneCall(phoneNumber: phoneNo2,localization: localization);
                          },
                          child: Text(
                            phoneNo2,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  //*----Website Link-----*
                  Row(
                    children: [
                      Text(
                        website,
                        style: AppTextStyles.normalThemeColorTextStyle().copyWith(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () => _launchUrl(webUrl),
                        child: Text(
                          webUrl,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //*----Address Image From Map ----*
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.asset(
                "assets/sidemenu/img.png",
                filterQuality: FilterQuality.high,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*----Write To Us Section-----*
  Widget _writeToUs({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return Directionality(
        textDirection: getTextDirection(langProvider),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              localization.writeToUs,
              style: AppTextStyles.titleBoldTextStyle(),
            )
          ],
        ));
  }

  Widget _inqueryForm({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return Column(
      children: [
        _nameSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _emailSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _mobileSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _inqueryTypeSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _subjectSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _messageSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 10),
        _createCaptchaSection(),
        _captchaSection(langProvider: langProvider ,localization: localization),
        const SizedBox(height: 30),
        _submitButton(langProvider: langProvider ,localization: localization),
      ],
    );
  }

//*----Name Section-----*
  Widget _nameSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _nameFocusNode,
      nextFocusNode: _emailFocusNode,
      controller: _nameController,
      obscureText: false,
      hintText: localization.fullName,
      textInputType: TextInputType.text,
      textCapitalization: true,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _nameError,
      onChanged: (value) {
        if (_nameFocusNode.hasFocus) {
          setState(() {
            _nameError =
                ErrorText.getEmptyFieldError(name: value!, context: context);
          });
        }
      },
    );
  }

//*-----Email Section-----*
  Widget _emailSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _mobileFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: localization.emailAddress,
      textInputType: TextInputType.text,
      textCapitalization: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emailError,
      onChanged: (value) {
        if (_emailFocusNode.hasFocus) {
          setState(() {
            _emailError =
                ErrorText.getEmailError(email: value!, context: context);
          });
        }
      },
    );
  }

//*-----Mobile Section-----*
  Widget _mobileSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _mobileFocusNode,
      nextFocusNode: _inquiryTypeFocusNode,
      controller: _mobileController,
      obscureText: false,
      hintText: localization.mobile,
      textInputType: TextInputType.phone,
      textCapitalization: true,
      leading: SvgPicture.asset("assets/phoneNumber.svg"),
      errorText: _mobileError,
      onChanged: (value) {
        if (_mobileFocusNode.hasFocus) {
          setState(() {
            _mobileError = ErrorText.getPhoneNumberError(
                phoneNumber: value!, context: context);
          });
        }
      },
    );
  }

//*------inquery Section-----*
  Widget _inqueryTypeSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomDropdown(
      leading: SvgPicture.asset("assets/inquiry_type.svg"),
      textDirection: getTextDirection(langProvider),
      menuItemsList: _inquiryTypeMenuItemsList,
      useScreenWidthToAdjustDropdown: true,
      onChanged: (value) {
        _inqueryTypeController.text = value!;
        //This thing is creating error: don't know how to fix it:
        FocusScope.of(context).requestFocus(_subjectFocusNode);
      },
      currentFocusNode: _inquiryTypeFocusNode,
      hintText: localization.selectInquiryType,
    );
  }

//*------subject Section-----*
  Widget _subjectSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _subjectFocusNode,
      nextFocusNode: _messageFocusNode,
      controller: _subjectController,
      obscureText: false,
      hintText: localization.subject,
      textInputType: TextInputType.text,
      textCapitalization: true,
      leading: SvgPicture.asset("assets/subject.svg"),
      // This field is not required:
      errorText: _subjectError,
      onChanged: (value) {
        if (_subjectFocusNode.hasFocus) {
          setState(() {
            _subjectError =
                ErrorText.getEmptyFieldError(name: value!, context: context);
          });
        }
      },
    );
  }

//*------message Section-----*
  Widget _messageSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _messageFocusNode,
      nextFocusNode: _captchaFocusNode,
      controller: _messageController,
      obscureText: false,
      hintText: localization.message,
      textInputType: TextInputType.multiline,
      textCapitalization: true,
      leading: SvgPicture.asset("assets/email.svg"),
      errorText: _messageError,
      // maxLines: 1,
      onChanged: (value) {
        if (_messageFocusNode.hasFocus) {
          setState(() {
            _messageError =
                ErrorText.getEmptyFieldError(name: value!, context: context);
          });
        }
      },
    );
  }

//*------generate Captcha-----*
  Widget _createCaptchaSection() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.darkGrey),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            _captchaText ?? '',
            style: AppTextStyles.titleTextStyle(),
          ),
        ),
        Transform.rotate(
            angle: _angle * 3.1415927 / 180, // Convert degrees to radians
            child: IconButton(
                onPressed: _rotate,
                icon: const Icon(
                  Icons.rotate_right,
                  size: 30,
                )))
      ],
    );
  }

//*------Captcha Section-----*
  Widget _captchaSection({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return CustomTextField(
      currentFocusNode: _captchaFocusNode,
      controller: _captchaController,
      obscureText: false,
      hintText: localization.enterCaptcha,
      textInputType: TextInputType.number,
      leading: SvgPicture.asset(
        "assets/captcha.svg",
        // height: 18,
        // width: 18,
      ),
      onChanged: (value) {},
    );
  }

//*------Submit Section-----*
  Widget _submitButton({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    return ChangeNotifierProvider(
      create: (context) => ContactUsViewModel(),
      child: Consumer<ContactUsViewModel>(
        builder: (context, provider, child) {
          return CustomButton(
            textDirection: getTextDirection(langProvider),
            buttonName: localization.send,
            isLoading: provider.contactUsResponse.status == Status.LOADING ? true : false,
            onTap: () async {
              bool validated = _validateForm(langProvider: langProvider,localization: localization);

              if (validated) {
                provider.fullName = _nameController.text.toString();
                provider.email = _emailController.text.toLowerCase().toString();
                provider.phoneNumber = _mobileController.text;
                provider.contactUsType = _inqueryTypeController.text;
                provider.subject = _subjectController.text;
                provider.comment = _messageController.text;

                bool result = await provider.contactUS(
                    context: context, langProvider: langProvider);

                if (result) {
                  // _alertServices.showCustomSnackBar(
                  //    "Your Query Submitted Successfully.",
                  //     // context: context,
                  //     // provider: langProvider
                  // );
                  //*-------Clearing all Fields--------*/
                  setState(() {
                    _nameController.clear();
                    _emailController.clear();
                    _mobileController.clear();
                    _inqueryTypeController.clear();
                    _subjectController.clear();
                    _messageController.clear();
                    _captchaController.clear();
                    _rotate();
                  });
                }
              }
            },
            fontSize: 16,
            // buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );
        },
      ),
    );
  }

  //Extra validations for better user Experience:
  bool _validateForm({required LanguageChangeViewModel langProvider, required AppLocalizations localization}) {
    // Validate Full Name
    if (_nameController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.nameCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Email Id
    if (_emailController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.emailCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Phone Number
    if (_mobileController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.mobileCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Inquiry Type
    if (_inqueryTypeController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.inquiryTypeCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Subject
    if (_subjectController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
     localization.subjectCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Message
    if (_messageController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.messageCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    // Validate Captcha
    if (_captchaController.text.isEmpty) {
      _alertServices.showErrorSnackBar(
       localization.captchaCantBeEmpty,
        // context: context,
        // provider: langProvider,
      );
      return false;
    } else if (_captchaController.text != _captchaText) {
      _rotate();
      _alertServices.showErrorSnackBar(
       localization.captchaDoesNotMatch,
        // context: context,
        // provider: langProvider,
      );
      return false;
    }

    return true;
  }
}
