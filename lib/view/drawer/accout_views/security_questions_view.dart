import 'package:flutter/material.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/view/authentication/signup/update_security_question_view.dart';

class SecurityQuestionsView extends StatefulWidget {
  const SecurityQuestionsView({super.key});

  @override
  State<SecurityQuestionsView> createState() => _SecurityQuestionsViewState();
}

class _SecurityQuestionsViewState extends State<SecurityQuestionsView> {
  @override
  Widget build(BuildContext context) {
    return UpdateSecurityQuestionView(updatingSecurityQuestion: true,);
  }
}
