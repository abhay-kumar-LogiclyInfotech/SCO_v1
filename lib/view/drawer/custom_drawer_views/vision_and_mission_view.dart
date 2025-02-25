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
          AppLocalizations.of(context)!.aBriefAboutSCO,
          style: AppTextStyles.appBarTitleStyle(),
        ),
      ),
      body: _buildUi(context),
    );
  }

  Widget _buildUi(context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: getTextDirection(langProvider),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*--------- about sco Title---------*/
              titleDescription(text: localization.aboutSCO,isTitle: true),
              const SizedBox(height: 10,),
              //*--------- about sco Description---------*/
              titleDescription(text:  '''انطلاقًا من التوجيهات السديدة والرؤية الحكيمة للمغفور له (بإذن الله) الشيخ زايد بن سلطان آل نهيان "طيّب الله ثراه"، وتجسيدًا لمقولة سموه المأثورة "إن أكبر استثمار للمال هو استثماره في بناء أجيال من المتعلّمين والمثقفين"، وفي إطار النهج الذي اختطّه الشيخ محمد بن زايد آل نهيان رئيس الدولة "حفظه الله" في السير على خُطى الوالد القائد في دعم وتعزيز دور ومكانة العلم والتعليم، يحظى مكتب البعثات الدراسية اليوم بمكانة مرموقة ودور فعال في دعم المسيرة التعليمية التي تشهدها الدولة، ويهدف المكتب الذي تأسّس سنة 1999 بإشراف ومتابعة مباشرة من سمو الشيخ منصور بن زايد آل نهيان نائب رئيس الدولة، نائب رئيس مجلس الوزراء رئيس ديوان الرئاسة، إلى اختيار نخبة الطلبة الإماراتيين المتميزين في مسيرتهم الدراسية، وإيفادهم في بعثات دراسية إلى الجامعات المحلية والعالمية المرموقة، من أجل التخصّص في شتى المجالات التي تلبّي احتياجات التنمية في الدولة ورفدها بكوادر مواطنة وجيل مؤهل وفق أرفع المستويات العلمية لمواصلة مسيرة البناء والتطوير التي تشهدها دولة الإمارات العربية المتحدة، ويشرف مكتب البعثات الدراسية على إدارة البعثات الدراسية خارج الدولة والمنح الدراسية داخل الدولة.'''),


              Consumer<VisionAndMissionViewModel>(
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Vision and mission top image:
                          // Image.asset("assets/vision_and_mission.png"),

                          const SizedBox(height: 20),

                          //*---------Vision Title---------*/
                          titleDescription(text:provider.content?.visionMission.visionTitle.toString() ?? "",isTitle: true),

                          const SizedBox(height: 10),
                          //*--------Vision Description--------*/
                          titleDescription(text: provider.content?.visionMission.visionText.toString() ??""),
                          const SizedBox(height: 20),

                          //*---------Values Title--------*/
                          titleDescription(text: provider.content?.values.valuesTitle.toString() ?? "",isTitle: true),
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
                          titleDescription(text: provider.content?.goals.goalsTitle.toString() ?? "",isTitle: true),

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
                      );
                    case null:
                      return const SizedBox.shrink();

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleDescription({required text, bool isTitle = false}){
    return Text(
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      text,
      style:isTitle ? AppTextStyles.titleBoldTextStyle()  : AppTextStyles.normalTextStyle(),
      textAlign: TextAlign.justify,

    );
  }

}
