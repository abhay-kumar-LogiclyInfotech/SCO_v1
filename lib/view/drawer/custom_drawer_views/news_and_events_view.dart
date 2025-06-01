import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/data/response/status.dart';
import 'package:sco_v1/resources/components/tiles/custom_news_and_events_tile.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/drawer/custom_drawer_views/news_and_events_details_view.dart';
import 'package:sco_v1/viewModel/drawer/news_and_events_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/navigation_services.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';

class NewsAndEventsView extends StatefulWidget {
  const NewsAndEventsView({super.key});

  @override
  State<NewsAndEventsView> createState() => _NewsAndEventsViewState();
}

class _NewsAndEventsViewState extends State<NewsAndEventsView>
    with MediaQueryMixin {
  late NavigationServices _navigationServices;

  @override
  void initState() {
    super.initState();
    //register services:
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {

      final provider = Provider.of<NewsAndEventsViewmodel>(context, listen: false);
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    await provider.newsAndEvents(context: context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(AppLocalizations.of(context)!.news,
            style: AppTextStyles.appBarTitleStyle()),
      ),
      body: Utils.modelProgressHud(
          processing: false,
          child: Utils.pageRefreshIndicator(
              child: _buildUi(context), onRefresh: _onRefresh)),
    );
  }

  Widget _buildUi(context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Container(
      padding:  EdgeInsets.all(kPadding),
      child: Consumer<NewsAndEventsViewmodel>(
        builder: (context, provider, _) {
          switch (provider.newsAndEventsResponse.status) {
            case Status.LOADING:
              return Utils.pageLoadingIndicator(context: context);

            case Status.ERROR:
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.somethingWentWrong,
                ),
              );

            case Status.COMPLETED:
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.parsedNewsAndEventsModelList.length,
                  itemBuilder: (context, index) {
                    final item = provider.parsedNewsAndEventsModelList[index];
                    final languageId = getTextDirection(langProvider) == TextDirection.rtl ? 'ar_SA' : 'en_US';
                    return Padding(
                      padding: EdgeInsets.only(bottom: kCardSpace),
                      child: CustomNewsAndEventsTile(
                        title: item.getTitle(languageId),
                        imageId: item.coverImageFileEntryId,
                        subTitle: item.getDescription(languageId),
                        date: item.getFormattedDate(langProvider),
                        onTap: () {
                          print(item.coverImageFileEntryId);
                          _navigationServices
                              .pushCupertino(CupertinoPageRoute(
                            builder: (context) => NewsAndEventsDetailView(
                                imageId: item.coverImageFileEntryId,
                                date: item.getFormattedDate(langProvider).toString(),
                                title: item.getTitle(languageId),
                                subTitle: item.getDescription(languageId),
                                content: item.getContent(languageId)),
                          ));
                        },
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
    );
  }
}
