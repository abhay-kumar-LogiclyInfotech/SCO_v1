import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/validations_and_errorText.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart'; // Add this package

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {

  //webUrl:
  final String webUrl = "https://www.sco.ae";
  //poBox:
  final String poBox = "73505";
  //phone no. 1:
  final String phoneNo1 = "+918091771052";
  //phone no. 2:
  final String phoneNo2 = "+971509876543";





  Future<void> _launchUrl(uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }

  bool _hasCallSupport = false;
  Future<void>? _launched;

  Future<void> _makePhoneCall(String phoneNumber) async {
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
          const SnackBar(content: Text('Phone call permission denied')),
        );
      }
    }
  }

  // FocusNodes for each field
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _inquiryTypeFocusNode =
      FocusNode(); // Note: Not used with controller
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  // TextEditingControllers for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Error variables
  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _inquiryTypeError;
  String? _subjectError;
  String? _messageError;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
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
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(
          "Contact Us",
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          //*----Common Contact Details Section-----*/
          _commonContactDetailsSection(langProvider: langProvider),

          const SizedBox(height: 30,),

          //*-----Static Text (Write To US)-----*/
          Directionality(
              textDirection: getTextDirection(langProvider),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Write To US-",
                    style: AppTextStyles.titleBoldTextStyle(),
                  )
                ],
              )),
          const SizedBox(height: 30,),


          //*----Inquery Form------*/
          _inqueryForm(langProvider: langProvider)
        ],
      ),
    );
  }

  //*----Common Contact Details-----*
  Widget _commonContactDetailsSection(
      {required LanguageChangeViewModel langProvider}) {
    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      text: "United Arab Emirates - Abu Dhabi",
                      style: AppTextStyles.titleBoldThemeColorTextStyle(),
                    ),
                  ),
                  const SizedBox(height: 7),
                  //*----Post Office Text-----*
                  Row(
                    children: [
                      Text(
                        "PO Box ",
                        style: AppTextStyles.normalThemeColorTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle the tap event here
                          // For example, you might want to show a dialog or navigate somewhere
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('PO Box tapped: $poBox')),
                          );
                        },
                        child: Text(
                          poBox,
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
                      Text(
                          "Phone No: ",
                          style: AppTextStyles.normalThemeColorTextStyle()),
                      Flexible(
                        child: GestureDetector(
                          onTap: (){
                            _makePhoneCall(phoneNo1);

                          },

                         child:  Text(
                            phoneNo1,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      const Text(
                        ', ',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap : () {
                            _makePhoneCall(phoneNo2);
                          },
                          child:   Text(
                            phoneNo2,
                            style:
                            const TextStyle(color: Colors.white, fontSize: 14),

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
              "Website: ",
              style: AppTextStyles.normalThemeColorTextStyle(),
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
                "assets/sidemenu/address_map_image.png",
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inqueryForm({required LanguageChangeViewModel langProvider}) {
    return Column(
      children: [
        _nameSection(langProvider: langProvider),
        const SizedBox(height: 10,),
        _emailSection(langProvider: langProvider),
      ],
    );
  }

//*----Name Section-----*
  Widget _nameSection({required LanguageChangeViewModel langProvider}) {
    return CustomTextField(
      textDirection: getTextDirection(langProvider),
      currentFocusNode: _nameFocusNode,
      nextFocusNode: _emailFocusNode,
      controller: _nameController,
      obscureText: false,
      hintText: "Full Name",
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/name.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _nameError,
      onChanged: (value) {
        if (_nameFocusNode.hasFocus) {
          setState(() {
            _nameError = ErrorText.getNameError(name: value!, context: context);
          });
        }
      },
    );
  }

  //*-----Email Section-----*
  Widget _emailSection({required LanguageChangeViewModel langProvider}) {
    return CustomTextField(
      textDirection: getTextDirection(langProvider),
      currentFocusNode: _emailFocusNode,
      nextFocusNode: _mobileFocusNode,
      controller: _emailController,
      obscureText: false,
      hintText: "Email",
      textInputType: TextInputType.text,
      textCapitalization: true,
      isNumber: false,
      leading: SvgPicture.asset(
        "assets/email.svg",
        // height: 18,
        // width: 18,
      ),
      errorText: _emailError,
      onChanged: (value) {
        if (_nameFocusNode.hasFocus) {
          setState(() {
            _emailError = ErrorText.getEmailError(email: value!, context: context);
          });
        }
      },
    );
  }

}
