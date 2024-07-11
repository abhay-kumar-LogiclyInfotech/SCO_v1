import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_dropdown.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/app_colors.dart';
import '../../../viewModel/services/navigation_services.dart';

class UpdateSecurityQuestionView extends StatefulWidget {
  const UpdateSecurityQuestionView({super.key});

  @override
  State<UpdateSecurityQuestionView> createState() =>
      _UpdateSecurityQuestionViewState();
}

class _UpdateSecurityQuestionViewState extends State<UpdateSecurityQuestionView>
    with MediaQueryMixin<UpdateSecurityQuestionView> {
  late NavigationServices _navigationService;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,
      body: _buildUI(context: context),
    );
  }

  Widget _buildUI({required BuildContext context}) {
    final provider = Provider.of<LanguageChangeViewModel>(context);
    return Padding(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _bgLogo(),
              const SizedBox(
                height: 50,
              ),
              _title(),
              _formField(),
            ],
          ),
        ));
  }

  //background static picture:
  Widget _bgLogo() {
    return SvgPicture.asset(
      "assets/security_question_bg.svg",
      fit: BoxFit.fill,
    );
  }

  //title:
  Widget _title() {
    return Text(
      "Security Question Setup",
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  Widget _formField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Security Question*"),
        CustomDropdown(
          leading: null,
          textDirection: TextDirection.rtl,
          genderList: const ["male", "Female"],
          onChanged: (value) {},
          currentFocusNode: FocusNode(),
          // hintText: "Security Question",
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
          fillColor: Colors.grey.shade200,
        ),
      ],
    );
  }
}
