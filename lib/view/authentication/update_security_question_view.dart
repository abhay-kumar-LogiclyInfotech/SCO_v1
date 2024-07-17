import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/main_view/home_view.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/app_colors.dart';
import '../../../viewModel/services/navigation_services.dart';
import '../../resources/components/custom_dropdown.dart';
import '../../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UpdateSecurityQuestionView extends StatefulWidget {
  const UpdateSecurityQuestionView({super.key});

  @override
  State<UpdateSecurityQuestionView> createState() =>
      _UpdateSecurityQuestionViewState();
}

class _UpdateSecurityQuestionViewState extends State<UpdateSecurityQuestionView>
    with MediaQueryMixin<UpdateSecurityQuestionView> {
  late NavigationServices _navigationService;



  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();



  List<DropdownMenuItem> _securityQuestionItemsList = [];

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();

    final provider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    _securityQuestionItemsList = populateDropdown(
        menuItemsList: Constants.lovCodeMap['GENDER']!.values!,
        provider: provider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,
      appBar: CustomSimpleAppBar(
          title: SvgPicture.asset(
        "assets/sco_logo.svg",
        fit: BoxFit.fill,
        height: 35,
        width: 110,
      )),
      body: _buildUI(context: context),
    );
  }

  Widget _buildUI({required BuildContext context}) {
    final provider = Provider.of<LanguageChangeViewModel>(context);
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
          child: _bgLogo(),
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
                  builder: (context, provider, _) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          _formField(langProvider: provider)
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

  //background static picture:
  Widget _bgLogo() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SvgPicture.asset(
        "assets/security_question_bg.svg",
        // fit: BoxFit.fill,
      ),
    );
  }

  //title:
  Widget _title() {
    return Text(
      "Security Question Setup",
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  Widget _formField({required LanguageChangeViewModel langProvider}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown(
          leading: SvgPicture.asset("assets/country.svg"),
          textDirection: getTextDirection(langProvider),
          menuItemsList: _securityQuestionItemsList,
          onChanged: (value) {
            _questionController.text = value!;
            //This thing is creating error: don't know how to fix it:
            FocusScope.of(context).requestFocus(_answerFocusNode);
          },
          currentFocusNode: _questionFocusNode,
          hintText: AppLocalizations.of(context)!.country,
        )
      ],
    );
  }
}
