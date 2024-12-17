import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_checkbox_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/signup/update_security_question_view.dart';
import 'package:sco_v1/viewModel/authentication/terms_and_conditions_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../../resources/app_colors.dart';
import '../../../../viewModel/services/navigation_services.dart';
import '../../../data/response/status.dart';
import '../../../hive/hive_manager.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView>
    with MediaQueryMixin<TermsAndConditionsView> {
  late NavigationServices _navigationService;
  late AlertServices _alertServices;

  //acceptance status:
  bool isChecked = false;

  //userId:
  String? _userId;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    super.initState();

    debugPrint(HiveManager.getUserId());
    _userId = HiveManager.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        title: Text(AppLocalizations.of(context)!.termsAndConditions,
            style: AppTextStyles.appBarTitleStyle()),inNotifications: true,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);

    return Directionality(
      textDirection: getTextDirection(langProvider),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*-------Acceptance of terms through use-----*//
              Text(
                  AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_points_p1),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_points_p2),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_points_p3),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_points_p4),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .acceptance_of_terms_through_use_points_p5),
              const SizedBox(height: 15),

              //*-------Copyright-----*//
              Text(AppLocalizations.of(context)!.copyright_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              normalTermsText(
                  text: AppLocalizations.of(context)!.copyright_points_p1 +
                      AppLocalizations.of(context)!.copyright_points_p2),
              const SizedBox(height: 15),

              //*-------Intellectual property rights-----*//
              Text(
                  AppLocalizations.of(context)!
                      .intellectual_property_rights_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .intellectual_property_rights_points_p1),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .intellectual_property_rights_points_p2),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .intellectual_property_rights_points_p3),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .intellectual_property_rights_points_p4),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .intellectual_property_rights_points_p5),
              const SizedBox(height: 15),

              //*-------Independence of texts-----*//
              Text(
                  AppLocalizations.of(context)!
                      .severability_of_provisions_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              normalTermsText(
                  text:
                      '${AppLocalizations.of(context)!.severability_of_provisions_points_p1} ${AppLocalizations.of(context)!.severability_of_provisions_points_p2}'),

              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .severability_of_provisions_points_p3),
              const SizedBox(height: 15),

              //*--------Applicable law-------*//
              Text(AppLocalizations.of(context)!.applicable_law_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              normalTermsText(
                  text:
                      "${AppLocalizations.of(context)!.applicable_law_points_p1} ${AppLocalizations.of(context)!.applicable_law_points_p2} ${AppLocalizations.of(context)!.applicable_law_points_p3}"),

              const SizedBox(height: 15),

              //*--------Applicable law-------*//
              Text(
                  AppLocalizations.of(context)!
                      .governing_law_and_jurisdiction_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              normalTermsText(
                  text:
                      "${AppLocalizations.of(context)!.governing_law_and_jurisdiction_points_p1} ${AppLocalizations.of(context)!.governing_law_and_jurisdiction_points_p2}"),
              const SizedBox(height: 20),

              //*--------Disclaimer-------*//
              Text(AppLocalizations.of(context)!.disclaimer_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              bulletTermsText(
                  text: AppLocalizations.of(context)!.disclaimer_description),
              const SizedBox(height: 20),

              //*--------Privacy Policy-------*//
              Text(AppLocalizations.of(context)!.privacy_policy_heading,
                  style: AppTextStyles.titleBoldTextStyle()),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_consent_to_use_of_information,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_consent_to_use_of_information),
              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_information_collection_and_disclosure_policies,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_information_collection_and_disclosure_policies),
              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_information_usage_and_disclosure_policies,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_information_usage_and_disclosure_policies),
              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_cookies,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_cookies),
              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_links,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_links),

              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_surveys,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_surveys),

              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_security,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_security),

              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_notification_of_changes,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_notification_of_changes),

              const SizedBox(
                height: 10,
              ),
              bulletTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_heading_updates_to_privacy_policy,
                  textColor: AppColors.scoThemeColor),
              normalTermsText(
                  text: AppLocalizations.of(context)!
                      .privacy_policy_description_updates_to_privacy_policy),

              const SizedBox(
                height: 50,
              ),

              //*--------Terms and Conditions End-------*//

              _checkButton(langProvider),
              const SizedBox(
                height: 10,
              ),
              _acceptButton(langProvider),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Accept Button:
  Widget _checkButton(LanguageChangeViewModel langProvider) {
    return SafeArea(
        child: CustomCheckBoxTile(
      isChecked: isChecked,
      controlAffinity: langProvider.appLocale == const Locale('en')
          ? ListTileControlAffinity.leading
          : ListTileControlAffinity.trailing,
      title:  AppLocalizations.of(context)!
          .acceptTermsAndConditions,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
          debugPrint(isChecked.toString());
        });
      },
    ));
  }

  //Submit Button::
  Widget _acceptButton(LanguageChangeViewModel langProvider) {
    return SafeArea(
      child: Consumer<TermsAndConditionsViewModel>(
          builder: (context, provider, _) {
        return CustomButton(
            buttonName:  AppLocalizations.of(context)!
                .acceptAndContinue,
            isLoading:
                provider.termsAndConditionsResponse.status == Status.LOADING
                    ? true
                    : false,
            textDirection: TextDirection.ltr,
            fontSize: 16,
            // buttonColor: AppColors.scoButtonColor,
            elevation: 1,
            onTap: () async {
              if(!isChecked) {
                // _alertServices.flushBarErrorMessages(message:AppLocalizations.of(context)!.acceptTermsAndConditions);
                _alertServices.showErrorSnackBar(AppLocalizations.of(context)!.acceptTermsAndConditions);
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.acceptTermsAndConditions)));
              }
              if (isChecked && _userId != null) {
                bool result = await provider.updateTermsAndConditions(
                    // context: context,
                    langProvider: langProvider,
                    userId: _userId!);

                if (result) {
                  _navigationService.pushReplacementCupertino(
                      CupertinoPageRoute(
                          builder: (context) => UpdateSecurityQuestionView()));
                }
              }

            });
      }),
    );
  }
}
