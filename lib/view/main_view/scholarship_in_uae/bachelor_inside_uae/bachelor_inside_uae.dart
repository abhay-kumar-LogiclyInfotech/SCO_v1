import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../apply_scholarship/form_view_Utils.dart';
import '../../../../resources/widgets/widget.dart';


getBachelorTermsAndConditionsInternal(context){
  return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sectionTitle(title: 'شروط ومتطلبات التقديم لبرنامج المنح الدراسية - درجة البكالوريوس'),
        const CustomRichText(
          spans: [
            TextSpan(
              text:
              '''1. أن يكون المتقدّم للمنحة الدراسية من مواطني دولة الإمارات العربية المتحدة.
2. أن يكون حسن السيرة والسلوك.
3. ألا يكون قد مضى على تخرّج الطالب من الصف الثاني عشر أو ما يعادلها مدة تزيد عن سنتيْن.
''',
            ),
            TextSpan(
              text: '4. أن يكون حاصلاً على نسبة مئوية، لا تقلّ عن ',
            ),
            TextSpan(
              text: ' (90%) ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text:
              '''في شهادة الصف الثاني عشر أو ما يعادلها، علمًا بأن هذه النسبة قابلة للتغيير من سنة إلى أخرى، تبعًا لمعطيات الميدان التربوي، مثل: معدلات نجاح طلبة الصف الثاني عشر، ودرجاتهم، ومؤشرات نتائج الصف الثاني عشر، وقد كان شرط الحصول على المنحة الدراسية لخريجي الصف الثاني عشر بالأعوام السابقة، هو تحقيق نسبة''',
            ),
            TextSpan(
              text: ' (98%) ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text: 'فأعلى.',
            ),
            TextSpan(
              text: '''
              
5. أن يكون حاصلاً على القبول من إحدى الجامعات المُعترف بها من المكتب، والواردة في قائمة الجامعات في الموقع الإلكتروني للمكتب.
6. أن يجتاز الطالب المقابلة الشخصية مع مجلس الإدارة بنجاح.
7. أن يتعهّد الطالب بالالتزام باللوائح والأنظمة والتعليمات الصادرة عن السلطة المُختصة، طبقًا لأحكام المنحة.
8. أن يلتزم الطالب بالتخصّص والدراسة في الجامعة وفق المنحة الدراسية التي حصل عليها، وألّا يُغيّر تخصّصه أو جامعته إلّا بموافقة خطية من المكتب.
9. ألا يكون حاصلاً على منحة أو مساعدة دراسية من أيّ جهة أخرى.
10. ألا يكون موظفًا. '''
            ),

            TextSpan(
              text: '''11. بالنسبة للطالب الملتحق في الدرجة الجامعية الأولى (البكالوريوس)، أن يكون حاصلاً على معدّل تراكمي لا يقلّ عن '''
            ),
            TextSpan(
              text: ' (2.80) ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text: 'من أصل',
            ),
            TextSpan(
              text: ' (4.00) ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(
              text: '''، أو ما يعادله حسب نُظم الجامعات، ممن أنهى الفصل الدراسي الأول من إحدى الجامعات المعتمدة في المكتب.'''
            ),
            TextSpan(
              text: '''
              
12. الحصول على الدرجات والشروط العامة المطلوبة ''',
            ),
            TextSpan(
              text: "كما هو موضح في الجدول أدناه: ",
              style: TextStyle(color: AppColors.scoThemeColor)
            )
          ],
        ),
        getBulletText('الحصول على الدرجة المطلوبة في إحدى الاختبارات المعيارية للغة الإنجليزية (الآيلتس او التوفل).', squareBullet: true),
        getBulletText('الحصول على الدرجة المطلوبة للاختبار المعياري الرياضيات (سات SAT) أو ما يعادله للطلبة الملتحقين في الدراسة بالمنهاج (الخاص الأجنبي).', squareBullet: true),
        getBulletText('الحصول على الدرجة المطلوبة في المواد الدراسية العلمية للصف الثاني عشر، وذلك حسب التخصص المراد دراسته المرتبط مباشرة بالتخصص كالأتي:', squareBullet: true),
        getBulletText('''بالنسبة للطلبة المتقدمين لتخصص (الطب والعلوم الصحية): الحصول على النسبة المطلوبة أو ما يعادلها في الصف الثاني عشر في مادتين من المواد العلمية (الأحياء أو الكيمياء أو الفيزياء).''', squareBullet: true),
        getBulletText('''بالنسبة للطلبة المتقدمين لتخصص (الهندسة): الحصول على النسبة المطلوبة أو ما يعادلها في الصف الثاني عشر في المواد العلمية (الفيزياء) ومادة واحدة من المواد العلمية (الاحياء أو الكيمياء أو الكمبيوتر).''', squareBullet: true),
        getBulletText('''بالنسبة للطلبة المتقدمين لتخصص (علوم الحاسوب): الحصول على النسبة المطلوبة أو ما يعادلها في الصف الثاني عشر في المواد العلمية (الفيزياء والكمبيوتر).''', squareBullet: true),
        getBulletText('''بالنسبة للطلبة المتقدمين لتخصص (العلوم): الحصول على النسبة المطلوبة أو ما يعادلها في الصف الثاني عشر في مادة واحدة من المواد العلمية المرتبطة بالتخصص (الأحياء أو الكيمياء أو الفيزياء).''', squareBullet: true),
        getBulletText('''بالنسبة للطلبة المتقدمين لتخصص (العلوم الاجتماعية والإدارية والقانون والعلوم الإنسانية والرياضيات والاحصاء والعلوم الاكتوارية): الحصول على النسبة المطلوبة أو ما يعادلها في الصف الثاني عشر في (مادة الرياضيات).''', squareBullet: true),
        getBulletText('''الحصول على قبول جامعي من إحدى الجامعات والتخصصات المعتمدة لدى المكتب، وتعطى الأولوية للطلبة الحاصلين على علامات متميزة.''', squareBullet: true),
        const TappableImage(imagePath: "https://sco.ae/documents/20126/51507/UGRDINT25.png/407cde8e-a99e-a202-c34f-6b57607ebdcb?t=1735876079602"),
        subTitle('عملية اختيار الطلبة:'),
        getBulletText('''عدد المقاعد محدودة للطلبة، واستيفاء الطالب للشروط لا يعني القبول، وإنما يخضع لأسس ومعايير التنافس المعتمدة لدى المكتب للطلبة النخبة والمتميزين.''', squareBullet: true),
        getBulletText('''تعتبر الشروط المذكورة الحد الأدنى المطلوب للتأهل لتقديم طلب المنحة الدراسية.''', squareBullet: true),
        getBulletText('''يتم اختيار المتقدمين بناء على عملية تفاضلية تأخذ في الاعتبار مجموعة متنوعة من العوامل، تشمل الأداء الأكاديمي السابق للمتقدم في الصف العاشر والحادي عشر ونسبة الفصل الأول والنهائي للصف الثاني عشر، الاختبارات القياسية والمركزية، القبول الجامعي، واجتياز المقابلة الشخصية.''', squareBullet: true),
      ]);
}
getBachelorUniversityAndMajorsInternal(context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sectionTitle(title: 'قائمة الجامعات والتخصصات المعتمدة'),
]);
}
getBachelorUniversityAndSpecializationsInternal(context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sectionTitle(title: 'قائمة الجامعات المعتمدة لدى المكتب - درجة البكالوريوس - داخل الدولة'),
]);
}
getBachelorApprovedSpecializationInternal(context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sectionTitle(title: 'قائمة التخصّصات المعتمدة لدى المكتب - درجة البكالوريوس - داخل الدولة'),
]);
}
getBachelorScholarshipPrivilegesInternal(context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      sectionTitle(title: 'امتيازات منحة درجة البكالوريوس'),
      kSmallSpace,
      subTitle('النفقات الدراسية التي يتحملها مكتب البعثات الدراسية:'),
      kMinorSpace,
      const CustomRichText(spans: [
        TextSpan(
          text: '''
1. الرسوم الدراسية السنوية.
2. رسوم الكتب الدراسية.
3. كلفة السكن المشترك.
4. رسوم المواصلات في حال توفير الجامعة للمواصلات.
5. المكافأة الشهرية.
6. رسوم اختبار التوفل أو الآيلتس في الجامعة لثلاث مرات خلال السنة الأولى من الدراسة.
7. لا تغطّي المنحة رسوم الأنشطة الطلابية والحاسب الآلي المحمول. '''
        )
      ]),
        kSmallSpace,
        subTitle('الحوافز التشجيعية:'),
        kMinorSpace,
        const CustomRichText(spans: [
         TextSpan(text: '1. يحصل الطالب المتميز في نهاية كلّ فصل دراسي على رسالة تقدير في حال حصوله على معدّل تراكمي'),
        TextSpan(
          text: ' (3.50) ',
          style:  TextStyle(color: Colors.red ),
        ),
         TextSpan(text: ' فما فوق، وفي حال كان قام بالتسجيل لـ'),
        TextSpan(
          text: ' (15) ',
          style:  TextStyle(color: Colors.red),
        ),
         TextSpan(text: ' ساعة دراسية في الفصل الواحد.'),


TextSpan(text: '''
            
2. يحصل طالب الطب المتميز في نهاية السنة الأكاديمية على شهادة تقدير ومكافأة تشجيعية إذا كان المعدل'''),
            TextSpan(
              text: ' (84.5%) ',
              style: TextStyle(color: Colors.red),
            ),
            TextSpan(text: 'فما فوق.'),

          TextSpan(text: '''
    
3. يحصل الطالب المتميز عل مكافأة تميز في نهاية السنة الأكاديمية إذا كان المعدل'''),
          TextSpan(
            text: ' (3.8) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'بمجموع'),
          TextSpan(
            text: ' (30) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'ساعة معتمدة أو'),
          TextSpan(
            text: ' (10) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'مواد.'),
        ]),

        kSmallSpace,
        subTitle("مكافأة التميز والتخرج:"),
        kMinorSpace,
        const CustomRichText(
          spans: [
            TextSpan(text: '1. يتم صرف مكافأة التخرج وهي تساوي مقدار المخصص الشهري المقرر له عن شهر واحد، عند حصوله على المعدل المطلوب.\n'),
            TextSpan(text: '2. يتم صرف مكافأة التميز والتخرج المبكر.\n'),
            TextSpan(text: '3. يستحق الطالب صرف مكافأة مالية إذا تخرج قبل انتهاء المدة المقررة، بمدة لا تقل عن فصل دراسي رئيس (الأول أو الثاني) (عند حصوله على المعدل المطلوب).'),
          ],
        ),
]);
}
getBachelorStudentObligationsInternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(title: "التزامات الطالب لمنحة درجة البكالوريوس"),
      kSmallSpace,
      const CustomRichText(
        spans: [
          TextSpan(text: '1. الالتزام بالقيم ومبادئ الأخلاق الفاضلة، وأن يكون حسن السيرة والسلوك، والابتعاد عن أيّ تصرّف يخلّ باعتبارات الشرف والأمانة وسُمعة المكتب.\n'),
          TextSpan(text: '2. عدم تغيير الجامعة التي يدرس فيها أو التخصّص العلمي المُحدّد له، إلّا بعد الحصول على إذن كتابي مُسبق من المكتب.\n'),
          TextSpan(text: '3. التقيّد بأنظمة الإشراف العلمي والإداري والمُتابعة الأكاديمية، وجميع التوجيهات الصادرة إليه فيما يتعلّق بمساره الدراسي من الجانب الأكاديمي، حتى الحصول على الدرجة العلمية المطلوبة.\n'),
          TextSpan(text: '4. اجتياز اختبارات القبول المطلوبة كافّة في الجامعات.\n'),
          TextSpan(text: '5. الانتظام في الدراسة والجدّية، والحرص على تحصيل العلم، وبذل أقصى جهد في دراسته وأبحاثه للحصول على الدرجة العلمية المُقرّرة في المدّة المُحدّدة.\n'),
          TextSpan(text: '6. الإيعاز للجامعة أو الكلية بموافاة المكتب بنسخة من سجلّ العلامات الدراسية والمُعدّل التراكمي، موضَحة فيها الدرجات التي حصل عليها في كلّ مساق أو مادة، والمُعدّل العام، وأيّ تقرير علمي أو دراسي آخر يطلبه المكتب.\n'),
          TextSpan(text: '7. ألّا تقل عدد الساعات المُسجّلة في الفصل الدراسي الدراسي الواحد عن '),
          TextSpan(
            text: '(15) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'ساعة مُعتمدة أو '),
          TextSpan(
            text: '(5) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'مواد دراسية.\n'),
          TextSpan(text: '8. ألا تزيد مدة الدراسة عن '),
          TextSpan(
            text: '(5) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'سنوات (سنة تأسيسية وأربع سنوات للتخصص).\n'),
          TextSpan(text: '9. ألّا يقلّ المعدل التراكمي عن '),
          TextSpan(
            text: '(2.80) ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: 'من (4.00) في كل فصل دراسي ، أو ما يُعادله حسب نظم الجامعات.\n'),
          TextSpan(text: '10. الالتزام بنظام الحضور والغياب في الجامعة/الكلية، ما لم يكن لديه عذر طارئ أو قهري، يقبله المكتب.\n'),
          TextSpan(text: '11. إخطار المكتب بأيّ عائق أو مشكلة أو ظروف قد تحول بينه وبين مُتابعة الدراسة على النحو المطلوب، سواءً كانت خاضعةً لإرادته أو خارجةً عنها.\n'),
          TextSpan(text: '12. التعهّد بالالتزام باللوائح والأنظمة والتعليمات كافّة.\n'),
          TextSpan(text: '13. الالتزام بإنهاء برنامج اللغة الإنجليزية في الفترة المُحدّدة من الجامعة.\n'),
          TextSpan(text: '14. الالتزام بسداد قيمة الفصل الدراسي الذي يقوم بالانسحاب منه دون موافقة المكتب.\n'),
          TextSpan(text: '15. للمكتب الحقّ في إلغاء المنحة الدراسية المُقدّمة للطالب دون أن يكون له حقّ المطالبة بأيّ تعويض.\n'),
          TextSpan(text: '16. يلتزم الطالب بسداد قيمة المادة الدراسية المُسجّلة في الفصل الدراسي في الحالات الآتية:\n'),
        ],
      ),
      getBulletText('‌سحب هذه المادة الدراسية بعد انتهاء فترة السحب والإضافة المُحدّدة من الجامعة.'),
      getBulletText('‌إعادة دراسة المادة بالرغم من النجاح فيها، بهدف تحسين المُعدّل.'),
      getBulletText('‌الرسوب في المادة.'),
      getBulletText('تسجيل المادة وعدم الالتحاق بها.'),
      const CustomRichText(spans: [
        TextSpan(text: '''17. إبلاغ المكتب في حال الحصول على وظيفة.''')
      ]),
      kSmallSpace,
      subTitle("الجزاءات في المنحة الدراسية:"),
      kMinorSpace,
      const Text("في حال مخالفة الطالب أي شرط من شروط المنحة يحصل على:"),
      getBulletText("إنذار أكاديمي (أول. إنذار ثانٍ ونهائي) عند حصوله على معدل أقل من المطلوب."),
      getBulletText("إلغاء المنحة."),
      getBulletText("أيّ جزاء آخر مُناسب وفق ما تراه الجهة المانحة."),
    ],
  );
}
getBachelorApplyingProcedureInternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(title: "إجراءات التقديم لمنحة درجة البكالوريوس"),
      kSmallSpace,
      const Text("يجب على الطالب الراغب بالتقديم للمنحة والمستوفي للشروط كافة اتباع الإجراءات الآتية:"),
      subTitle("أولاً:"),
      const Text("تجهيز جميع الوثائق المطلوبة وعمل نسخة رقمية للمستندات والوثائق الآتية:"),
      const Text(
          '''
1. صورة شخصية حديثة للطالب بالزيّ الوطني، وخلفية بيضاء، بصيغة JPG أو PNG (أبعاد الصورة 4.5 / 3.5).
2. صورة عن جواز سفر الطالب متضمّنة صفحة الرقم الموحّد.
3. صورة عن جواز سفر وليّ أمر الطالب متضمّنة صفحة الرقم الموحّد.
4. صورة عن بطاقة الهوية من الجهتيْن.
5. صورة مصدّقة عن الشهادة النهائية للصف العاشر.
6. صورة مصدّقة عن الشهادة النهائية للصف الحادي عشر.
7. صورة مصدّقة عن شهادة الفصل الدراسي الأول للصف الثاني عشر (في حال التقديم للبعثة بعد ظهور درجات الفصل الدراسي الأول).
8. صورة مصدّقة عن شهادة الفصل الدراسي الثاني للصف الثاني عشر (في حال التقديم للبعثة بعد ظهور درجات الفصل الدراسي الثاني).
9. صورة مصدّقة عن الشهادة النهائية للصف الثاني عشر (في حال التقديم بعد ظهور الدرجات النهائية).
10. تقرير درجات اختبار الإمسات أوالتوفل أو الآيلتس والقبول الجامعي إن وجد.
11. السجل الدراسي للطلبة المُنتظمين بالدراسة في الجامعة.
'''
      ),
      kSmallSpace,

      subTitle("يُضاف إلى ذلك للمتقدّمين من أبناء المواطنات:"),
      kMinorSpace,
      getBulletText("صورة عن جواز الطالب مع الإقامة."),
      getBulletText("صورة عن جواز سفر ولي أمر الطالب مع الإقامة."),
      getBulletText("صورة كاملة عن خلاصة قيد الأم."),

      kSmallSpace,
      subTitle('ثانياً:'),
      kMinorSpace,
      const Text("تعبئة طلب التقديم عن طريق الدخول إلى الموقع الإلكتروني."),
      kSmallSpace,
       subTitle("ثالثاً:"),
      kMinorSpace,
      const Text("تحميل المستندات والوثائق بعد تعبئة الطلب واتباع الإرشادات الخاصة بتحميل المرفقات."),

      kSmallSpace,
      kSmallSpace,
      subTitle("ملاحظات:",AppColors.scoButtonColor),
      kMinorSpace,
      getBulletText("لا تقبل الطلبات التي ترسل عن طريق الفاكس أو تسلم باليد."),
      getBulletText("يرجى الاتصال بمكتب البعثات الدراسية لطلب المساعدة في حال واجهتكم أيّ صعوبات خلال عملية التقديم عن طريق الموقع (اتصل بنا)."),
      getBulletText("يتم استقبال الطلبات خلال فترات التقديم المعتمدة، والتي تظهر في صفحة التقديم الإلكتروني على الموقع الإلكتروني للمكتب.")
  ]);
}


Widget get kSmallSpace => const SizedBox.square(dimension: 10,);
Widget get kMinorSpace => const SizedBox.square(dimension: 5,);
class CustomRichText extends StatelessWidget {
  final List<InlineSpan> spans;

  const CustomRichText({super.key, required this.spans});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'droidArabicKufi', // Set your default font here
        ),
        children: spans,
      ),
    );
  }
}

class TappableImage extends StatelessWidget {
  final String imagePath;
  final bool isNetwork;

  const TappableImage({
    super.key,
    required this.imagePath,
    this.isNetwork = true,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = isNetwork
        ? Image.network(imagePath, fit: BoxFit.cover)
        : Image.asset(imagePath, fit: BoxFit.cover);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImagePage(
              imagePath: imagePath,
              isNetwork: isNetwork,
            ),
          ),
        );
      },
      child: imageWidget,
    );
  }
}
