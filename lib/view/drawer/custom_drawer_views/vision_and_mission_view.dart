import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/vision_and_mission_viewModel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/custom_vision_and_mission_container.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VisionAndMissionView extends StatefulWidget {
  const VisionAndMissionView({super.key});

  @override
  State<VisionAndMissionView> createState() => _VisionAndMissionViewState();
}

class _VisionAndMissionViewState extends State<VisionAndMissionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final provider =
          Provider.of<VisionAndMissionViewModel>(context, listen: false);
      final langProvider =
          Provider.of<LanguageChangeViewModel>(context, listen: false);
      await provider.getVisionAndMission(
          context: context, langProvider: langProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        title: Text(
          AppLocalizations.of(context)!.vision_mission_values,
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body: _buildUi(context),
    );
  }

  Widget _buildUi(context) {
    final langProvider =
        Provider.of<LanguageChangeViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: getTextDirection(langProvider),
        child: Consumer<VisionAndMissionViewModel>(
          builder: (context, provider, _) {
            switch (provider.visionAndMissionResponse.status) {
              case Status.LOADING:
                return const Center(
                  child: CupertinoActivityIndicator (
                  color: AppColors.scoThemeColor,
                              ),
                );

              case Status.ERROR:
                return Text(
            AppLocalizations.of(context)!.error_fetching_data,
                  style: AppTextStyles.subTitleTextStyle(),
                );

              case Status.COMPLETED:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //Vision and mission top image:
                      Image.asset("assets/vision_and_mission.png"),

                      const SizedBox(height: 20),



                      //*---------Vision Title---------*/
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //Vision Title:
                          Text(
                            provider.content?.visionMission.visionTitle
                                    .toString() ??
                                "",
                            style: AppTextStyles.titleBoldTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //*--------Vision Description--------*/
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                              provider.content?.visionMission.visionText
                                      .toString() ??
                                  "",
                              style: AppTextStyles.normalTextStyle(),
                          textAlign: TextAlign.left,),
                        ],
                      ),
                      const SizedBox(height: 20),

                      //*---------Values Title--------*/
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //Values Title:
                          Text(
                            provider.content?.values.valuesTitle.toString() ??
                                "",
                            style: AppTextStyles.titleBoldTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //*---------Values List----------*/
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.content?.values.valueItems.length,
                          itemBuilder: (context, index) {
                            ValueItem value =
                                provider.content!.values.valueItems[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CustomVisionAndMissionContainer(
                                  title: value.title,
                              description: value.text,
                              ),
                            );
                          }),
                      const SizedBox(height: 20),

                      //*---------Goals Title---------*/
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            provider.content?.goals.goalsTitle.toString() ??
                                "",
                            style: AppTextStyles.titleBoldTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //*-------Goals List-----------*/
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.content?.goals.goals.length,
                          itemBuilder: (context, index) {
                            String goal = provider.content?.goals.goals[index] ?? '';

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CustomVisionAndMissionContainer(
                                  title: goal),
                            );
                          }),
                    ],
                  ),
                );
              case null:
                return const SizedBox.shrink();

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
