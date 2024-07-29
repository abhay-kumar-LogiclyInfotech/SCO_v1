import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/custom_vision_and_mission_container.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/vision_and_mission_viewModel.dart';

import '../../../resources/app_text_styles.dart';
import '../../../viewModel/language_change_ViewModel.dart';

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
      appBar: CustomSimpleAppBar(
        title: Text(
          "Vision, Mission, Values",
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
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: getTextDirection(langProvider),
        child: Consumer<VisionAndMissionViewModel>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //Vision Title:
                      Text(
                        provider.content?.visionMission.visionTitle.toString() ??
                            "",
                        style: AppTextStyles.titleBoldTextStyle(),
                      ),
                    ],
                  ),

                  //Vision Description:
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                          provider.content?.visionMission.visionText.toString() ??
                              "",
                          style: AppTextStyles.normalTextStyle()),
                    ],
                  ),


                  //Values:
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
                  //Values List:
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: provider.content?.values.valueItems.length,
                      itemBuilder: (context,index){

                        ValueItem value = provider!.content!.values.valueItems[index];

                    return CustomVisionAndMissionContainer(text: value.title);

                  }),


                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
