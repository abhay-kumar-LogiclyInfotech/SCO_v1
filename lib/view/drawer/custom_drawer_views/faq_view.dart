import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/utils/constants.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/resources/components/tiles/custom_expansion_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/faq_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';

class FaqView extends StatefulWidget {
  const FaqView({super.key});

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> with MediaQueryMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    final provider = Provider.of<FaqViewModel>(context, listen: false);
    await provider.getFaq(context: context, langProvider: langProvider);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(localization.faqs, style: AppTextStyles.appBarTitleStyle()),
      ),
      body: Utils.pageRefreshIndicator(child: _buildUi(context), onRefresh: _onRefresh),
    );
  }

  Widget _buildUi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Consumer<FaqViewModel>(
        builder: (context, provider, _) {
          switch (provider.faqResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator(context: context);
            case Status.ERROR:
              return Center(
                  child: Text(
                      AppLocalizations.of(context)!.somethingWentWrong));
            case Status.COMPLETED:
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.questionAnswers.length,
                  itemBuilder: (context, index) {
                    bool isLastIndex = (index ==
                        provider.questionAnswers.length -
                            1); // Replace 10 with your itemCount if dynamic

                    final question =
                        provider.questionAnswers[index].question.toString();
                    final answer =
                        provider.questionAnswers[index].answer.toString();

                    if (question != 'null' && answer != 'null') {
                      return Padding(
                        padding: EdgeInsets.only(bottom: kTileSpace),
                        child: CustomExpansionTile(
                            title: question,
                            leading: Image.asset(Constants.faq,height: 20,width: 20,),
                            trailing: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                            expandedContent: Text(answer)),
                      );
                    }
                  });

            default:
              return Text(
                AppLocalizations.of(context)!.somethingWentWrong,
              );
          }
        },
      ),
    );
  }
}
