import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/resources/components/custom_news_and_events_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/faq_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';

class NewsAndEventsView extends StatefulWidget {
  const NewsAndEventsView({super.key});

  @override
  State<NewsAndEventsView> createState() => _NewsAndEventsViewState();
}

class _NewsAndEventsViewState extends State<NewsAndEventsView>
    with MediaQueryMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final provider = Provider.of<FaqViewModel>(context, listen: false);
      final langProvider =
          Provider.of<LanguageChangeViewModel>(context, listen: false);
      await provider.getFaq(context: context, langProvider: langProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(
          "News & Events",
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body: _buildUi(context),
    );
  }

  Widget _buildUi(context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Consumer<FaqViewModel>(
          builder: (context, provider, _) {
            switch (provider.faqResponse.status) {
              case Status.LOADING:
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: AppColors.scoThemeColor,
                  ),
                );

              case Status.ERROR:
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.somethingWentWrong,
                  ),
                );

              case Status.COMPLETED:
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.questionAnswers.length,
                    itemBuilder: (context, index) {
                      bool isLastIndex = (index ==
                          provider.questionAnswers.length - 1); // Replace 10 with your itemCount if dynamic

                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(top: 30.0, bottom: 15.0)
                            : isLastIndex
                                ? const EdgeInsets.only(bottom: 30.0)
                                : const EdgeInsets.only(bottom: 15.0),
                        child: CustomNewsAndEventsTile(
                          title: "Conclusion of the forum for new students in the scholarship. Conclusion of the forum for new students in the scholarship",
                          imagePath: '',
                          subTitle: 'The Scholarships Office concluded the..',
                          date: "30-July-2024",
                          onTap: () {},
                        ),
                      );
                    });

              default:
                return Text(
                  AppLocalizations.of(context)!.somethingWentWrong,
                );
            }
          },
        ),
      ),
    );
  }
}
