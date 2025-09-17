import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/cards/home_view_card.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/drawer/vision_and_mission_viewModel.dart';

import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_text_styles.dart';
import '../../../resources/components/custom_vision_and_mission_container.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../l10n/app_localizations.dart';


class VisionAndMissionView extends StatefulWidget {
  const VisionAndMissionView({super.key});

  @override
  State<VisionAndMissionView> createState() => _VisionAndMissionViewState();
}

class _VisionAndMissionViewState extends State<VisionAndMissionView> with MediaQueryMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      final provider = Provider.of<VisionAndMissionViewModel>(context, listen: false);
      final langProvider = Provider.of<LanguageChangeViewModel>(context, listen: false);
      await provider.getVisionAndMission(context: context, langProvider: langProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(
        title: Text(
          AppLocalizations.of(context)!.aboutSCO,
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
      padding:  EdgeInsets.all(kPadding),
      child: Directionality(
        textDirection: getTextDirection(langProvider),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*--------- about sco Title---------*/

              aboutScoCustomCard(title:  localization.aboutSCO, content: const Text( '''انطلاقًا من التوجيهات السديدة والرؤية الحكيمة للمغفور له (بإذن الله) الشيخ زايد بن سلطان آل نهيان "طيّب الله ثراه"، وتجسيدًا لمقولة سموه المأثورة "إن أكبر استثمار للمال هو استثماره في بناء أجيال من المتعلّمين والمثقفين"، وفي إطار النهج الذي اختطّه الشيخ محمد بن زايد آل نهيان رئيس الدولة "حفظه الله" في السير على خُطى الوالد القائد في دعم وتعزيز دور ومكانة العلم والتعليم، يحظى مكتب البعثات الدراسية اليوم بمكانة مرموقة ودور فعال في دعم المسيرة التعليمية التي تشهدها الدولة، ويهدف المكتب الذي تأسّس سنة 1999 بإشراف ومتابعة مباشرة من سمو الشيخ منصور بن زايد آل نهيان نائب رئيس الدولة، نائب رئيس مجلس الوزراء رئيس ديوان الرئاسة، إلى اختيار نخبة الطلبة الإماراتيين المتميزين في مسيرتهم الدراسية، وإيفادهم في بعثات دراسية إلى الجامعات المحلية والعالمية المرموقة، من أجل التخصّص في شتى المجالات التي تلبّي احتياجات التنمية في الدولة ورفدها بكوادر مواطنة وجيل مؤهل وفق أرفع المستويات العلمية لمواصلة مسيرة البناء والتطوير التي تشهدها دولة الإمارات العربية المتحدة، ويشرف مكتب البعثات الدراسية على إدارة البعثات الدراسية خارج الدولة والمنح الدراسية داخل الدولة.''',textAlign: TextAlign.justify,), langProvider: langProvider),
              // titleDescription(text: localization.aboutSCO,isTitle: true),
              // kSmallSpace,              //*--------- about sco Description---------*/
              // CustomVisionAndMissionContainer(
              //   title: '''انطلاقًا من التوجيهات السديدة والرؤية الحكيمة للمغفور له (بإذن الله) الشيخ زايد بن سلطان آل نهيان "طيّب الله ثراه"، وتجسيدًا لمقولة سموه المأثورة "إن أكبر استثمار للمال هو استثماره في بناء أجيال من المتعلّمين والمثقفين"، وفي إطار النهج الذي اختطّه الشيخ محمد بن زايد آل نهيان رئيس الدولة "حفظه الله" في السير على خُطى الوالد القائد في دعم وتعزيز دور ومكانة العلم والتعليم، يحظى مكتب البعثات الدراسية اليوم بمكانة مرموقة ودور فعال في دعم المسيرة التعليمية التي تشهدها الدولة، ويهدف المكتب الذي تأسّس سنة 1999 بإشراف ومتابعة مباشرة من سمو الشيخ منصور بن زايد آل نهيان نائب رئيس الدولة، نائب رئيس مجلس الوزراء رئيس ديوان الرئاسة، إلى اختيار نخبة الطلبة الإماراتيين المتميزين في مسيرتهم الدراسية، وإيفادهم في بعثات دراسية إلى الجامعات المحلية والعالمية المرموقة، من أجل التخصّص في شتى المجالات التي تلبّي احتياجات التنمية في الدولة ورفدها بكوادر مواطنة وجيل مؤهل وفق أرفع المستويات العلمية لمواصلة مسيرة البناء والتطوير التي تشهدها دولة الإمارات العربية المتحدة، ويشرف مكتب البعثات الدراسية على إدارة البعثات الدراسية خارج الدولة والمنح الدراسية داخل الدولة.''',
              // ),
              kSmallSpace,

              Consumer<VisionAndMissionViewModel>(
                builder: (context, provider, _) {
                  switch (provider.visionAndMissionResponse.status) {
                    case Status.LOADING:
                      return Utils.spinkitThreeBounce();

                    case Status.ERROR:
                      return Text(
                  AppLocalizations.of(context)!.error_fetching_data,
                        style: AppTextStyles.subTitleTextStyle(),
                      );

                    case Status.COMPLETED:
                      // print('Title : ${provider.content?.values.valuesTitle.toString()}');
                      // print('Body : ${provider.content?.visionMission.visionText.toString()}');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Vision and mission top image:
                          // Image.asset("assets/vision_and_mission.png"),
                          // kSmallSpace,


                          //*---------Vision Title---------*/
                          // titleDescription(text:provider.content?.visionMission.visionTitle.toString() ?? "",isTitle: true),
                          //
                          // kSmallSpace,
                          // //*--------Vision Description--------*/
                          // // titleDescription(text: provider.content?.visionMission.visionText.toString() ??""),
                          // CustomVisionAndMissionContainer(title: provider.content?.visionMission.visionText.toString() ??"",),

                          aboutScoCustomCard(title: provider.content?.visionMission.visionTitle.toString() ?? "", content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(),
                              Text(provider.content?.visionMission.visionText.toString() ??"",textAlign: TextAlign.start,),
                            ],
                          ), langProvider: langProvider),

                          kSmallSpace,

                          aboutScoCustomCard(
                            title: provider.content?.visionMission.missionTitle.toString() ?? "",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(),
                                Text(provider.content?.visionMission.missionText.toString() ?? "", textAlign: TextAlign.start,),
                              ],
                            ),
                            langProvider: langProvider,
                          ),

                          kSmallSpace,

                          aboutScoCustomCard(title: provider.content?.goals.goalsTitle.toString() ?? "", content:  ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: provider.content?.goals.goals.length,
                              itemBuilder: (context, index) {
                                String goal = provider.content?.goals.goals[index] ?? '';

                                return Padding(
                                  padding:  EdgeInsets.only(bottom: kCardPadding),
                                  child: Text(goal),
                                );
                              }), langProvider: langProvider),


                          kSmallSpace,

                          //*---------Values Title--------*/
                          // titleDescription(text: provider.content?.values.valuesTitle.toString() ?? "",isTitle: true),
                          // kSmallSpace,
                          //
                          // //*---------Values List----------*/
                          // ListView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.zero,
                          //     itemCount: provider.content?.values.valueItems.length,
                          //     itemBuilder: (context, index) {
                          //       ValueItem value =
                          //           provider.content!.values.valueItems[index];
                          //
                          //       return Padding(
                          //         padding: EdgeInsets.only(
                          //           bottom: (index < ((provider.content?.values?.valueItems?.length ?? 1) - 1)) ? 10.0 : 0,
                          //         ),
                          //         child: CustomVisionAndMissionContainer(
                          //             title: value.title,
                          //         description: value.text,
                          //         ),
                          //       );
                          //     }),
                          // kSmallSpace,

                          // aboutScoCustomCard(title: provider.content?.values.valuesTitle.toString() ?? "", content: ListView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.zero,
                          //     itemCount: provider.content?.values.valueItems.length,
                          //     itemBuilder: (context, index) {
                          //       ValueItem value = provider.content!.values.valueItems[index];
                          //       return Padding(
                          //         padding: EdgeInsets.only(
                          //           bottom: (index < ((provider.content?.values.valueItems.length ?? 1) - 1)) ? kCardPadding : 0,
                          //         ),
                          //         child:
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //              Text(
                          //               value.title,
                          //               style: value.text != null
                          //                   ? const TextStyle(color: AppColors.scoThemeColor)
                          //                   : null,
                          //               textAlign: TextAlign.justify,
                          //             ),
                          //             value.text != null
                          //                 ? Text(value.text!,textAlign: TextAlign.justify,)
                          //                 : const SizedBox.shrink()
                          //           ],
                          //         )
                          //         ,
                          //       );
                          //     }), langProvider: langProvider),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: provider.content?.values.asMap().entries.map((entry) {
                              final index = entry.key;
                              final section = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (index > 0)  kSmallSpace, // 🔹 space before new title
                                  aboutScoCustomCard(
                                    title: section.valuesTitle,
                                    content: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: section.valueItems.length,
                                      itemBuilder: (context, i) {
                                        ValueItem value = section.valueItems[i];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: (i < (section.valueItems.length - 1)) ? kCardPadding : 0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.title,
                                                style: value.text.isNotEmpty
                                                    ? const TextStyle(color: AppColors.scoThemeColor)
                                                    : null,
                                                textAlign: TextAlign.justify,
                                              ),
                                              value.text.isNotEmpty
                                                  ? Text(value.text, textAlign: TextAlign.justify)
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    langProvider: langProvider,
                                  ),
                                ],
                              );
                            }).toList() ?? [],
                          ),


                          // //*---------Goals Title---------*/
                          // titleDescription(text: provider.content?.goals.goalsTitle.toString() ?? "",isTitle: true),
                          //
                          // kSmallSpace,
                          // //*-------Goals List-----------*/
                          // ListView.builder(
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.zero,
                          //     itemCount: provider.content?.goals.goals.length,
                          //     itemBuilder: (context, index) {
                          //       String goal = provider.content?.goals.goals[index] ?? '';
                          //
                          //       return Padding(
                          //         padding: const EdgeInsets.only(bottom: 10.0),
                          //         child: CustomVisionAndMissionContainer(title: goal),
                          //       );
                          //     })

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
      text,
      textDirection: getTextDirection(context.read<LanguageChangeViewModel>()),
      style:isTitle ? AppTextStyles.titleBoldTextStyle()  : AppTextStyles.normalTextStyle(),
      textAlign: TextAlign.justify,

    );
  }

  Widget aboutScoCustomCard({required title,required content, required langProvider}){
    return  HomeViewCard(title: title,titleSize: 16,showArrow: false,contentPadding: EdgeInsets.only(left: kCardPadding,right: kCardPadding,bottom: kCardPadding,top: 8), content: content , langProvider: langProvider);

  }

}
