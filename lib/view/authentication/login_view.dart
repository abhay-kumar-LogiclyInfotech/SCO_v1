import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/components/custom_button.dart';

import '../../resources/components/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
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
              top: MediaQuery.sizeOf(context).height / 2.5,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.08,
              vertical: MediaQuery.sizeOf(context).width * 0.08,

            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(60, 60))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/company_logo.png",
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.01),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/email.svg",
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: CustomTextField(
                                currentFocusNode: _emailFocusNode,
                                controller: _emailController,
                                obscureText: false,
                                hintText: "Email Address",
                                textInputType: TextInputType.emailAddress,
                                isNumber: false,
                                onChanged: (value) {}))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),

                  CustomButton(
                    buttonName: "Login",
                    isLoading: false,
                    onTap: () {},
                    fontSize: 20,
                    buttonColor: AppColors.buttonColor,
                    elevation: 1,
                  ),
                  const SizedBox(height: 30,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: AppColors.darkGrey,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "or",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.darkGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: AppColors.darkGrey,
                      ))
                    ],
                  ),
                  const SizedBox(height: 30,),

                  CustomButton(
                    buttonName: "Sign in with UAE PASS",
                    isLoading: false,
                    onTap: () {},
                    fontSize: 15,
                    buttonColor: Colors.white,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    elevation: 1,
                    leadingIcon: const Icon(Icons.fingerprint),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
