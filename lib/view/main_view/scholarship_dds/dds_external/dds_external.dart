import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/resources/app_colors.dart';
import 'package:sco_v1/resources/widgets/subTitle_widget.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/bachelor_inside_uae/bachelor_inside_uae.dart';

import '../../../../resources/widgets/bullet_text_widget.dart';

getDdsOverView(context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    sectionTitle(
        title: "نبذة عن بعثة صاحب السمو رئيس الدولة للأطباء المتميزين"),
    kSmallSpace,
    const Text('''
          يسعى مكتب البعثات الدراسية إلى إتاحة الفرصة أمام الأطباء المواطنين المتميزين، لاستكمال دراستهم، وتدريبهم السريري، للحصول على أعلى الدرجات والشهادات في مختلف التخصصات الطبية والصحية. وذلك في إطار الحرص على تنمية وتطوير العنصر البشري في قطاع الرعاية الصحية في دولة الإمارات العربية المتحدة، والذي يعتبر من أهم القطاعات الاقتصادية الخدمية.

كما تهدف البعثة التي تأسست عام 2015 إلى تأهيل جيل قيادي من أبناء وبنات الإمارات، قادر على مواجهة تحديات المستقبل، وذلك من أجل رفد الدولة بكوادر وطاقات متميزة، تحمل على عاتقها مهمة تعزيز وتطوير عملية التنمية الشاملة التي وضع أسسها المغفور له بإذن الله الشيخ زايد بن سلطان آل نهيان، ويسير على خطاها بكل حكمة واقتدار صاحب السمو الشيخ محمد بن زايد آل نهيان رئيس الدولة حفظه الله.
          '''),
    kSmallSpace,
    TappableImage(
      imagePath:
          "https://www.sco.ae/documents/20126/35273/DQrns2jX0AEL0l0+%281%29.png/22d48737-fa41-f911-868f-e250396ab9d2?t=1561469186310",
      isNetwork: true,
    ),
    kSmallSpace,
    subTitle("الرؤية:", AppColors.scoButtonColor),
    Text('أن نكون جهة الابتعاث الرائدة لقادة المستقبل.'),
    kSmallSpace,
    subTitle("الرسالة:", AppColors.scoButtonColor),
    Text(
        'تقديم بعثات دراسية رائدة إلى الطلبة المتميّزين في أرقى الجامعات المحلية والعالمية، للمساهمة في إعداد جيل واعد، يواكب جهود التنمية والتطلعات المستقبلية للدولة.'),
    kSmallSpace,
    subTitle("أهداف البعثة:", AppColors.scoButtonColor),
    Text('''
1. اختيار نخبة من الأطباء المتميزين، وإيفادهم للدراسة والتدريب في المراكز الطبية العالمية المتميزة والجامعات المرموقة.
2. رفد الدولة بكوادر طبية وطنية مؤهلة في مختلف التخصصات الطبية، بهدف تنمية وتطوير العنصر البشري في قطاع الرعاية الصحية بالدولة، من خلال اكتساب أحدث المعارف وأفضل الخبرات.
'''),
    kSmallSpace,
    subTitle("برامج البعثة"),
    kSmallSpace,
    getBulletText("برامج طلبة كليات الطب"),
    Text('''
أولًا: برنامج التحضير للجزء الأول من امتحان التراخيص الأمريكية USMLE1 

     ثانيًا: منحة اجتياز الجزء الأول USMLE1 

     ثالثًا: برنامج التدريب الاختياري لطلبة الطب Electives

     رابعًا: برنامج سنة الامتياز لطلاب كلية الطب (السنة الأخيرة)
'''),
    kSmallSpace,
    getBulletText("برامج الأطباء الخريجين"),
    Text('''ولًا: برنامج أطباء الامتياز 

     ثانيًا: برامج التجسير 

     ثالثًا: برنامج التدريب القصير 
          ''')
  ]);
}

geetDdsMedicalCollegeProgram(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(title: "برامج طلبة كليات الطب"),
      kSmallSpace,
      subTitle("برامج طلبة كليات الطب",AppColors.scoButtonColor),
      getBulletText('أولًا: برنامج التحضير للجزء الأول من امتحان التراخيص الأمريكية USMLE1'),
      getBulletText('ثانيًا: منحة اجتياز الجزء الأول USMLE1'),
      getBulletText('ثالثًا: برنامج التدريب الاختياري لطلبة الطب Electives'),
      getBulletText('رابعًا: برنامج سنة الامتياز لطلاب كلية الطب (السنة الأخيرة)'),
      kSmallSpace,
      subTitle('أولًا: برنامج التحضير للجزء الأول من امتحان التراخيص الأمريكية USMLE1',AppColors.scoButtonColor),
      Text('برنامج مخصص لطلبة كليات الطب المتميزين، يهدف إلى تحضيرهم لاجتياز الجزء الأول من امتحان التراخيص الطبية الأمريكية USMLE1'),
      kSmallSpace,
      subTitle("الشروط العامة لبرنامج التحضير للجزء الأول من امتحان USMLE1:",AppColors.scoButtonColor),
      getBulletText('أن يكون الطالب من مواطني دولة الإمارات العربية المتحدة.'),
      getBulletText('أن يكون الطالب يدرس حاليا في إحدى كليات الطب داخل أو خارج الدولة.'),
      getBulletText('أن يكون حاصلا على معدل تراكمي 3.0 على الأقل أو ما يعادلها خلال سنوات الدراسة.'),
      getBulletText('توقيع تعهد بالالتزام بكافة شروط وقواعد البرنامج.'),
      subTitle("* تعطى الأولوية للطلبة الحاصلين على علامات متميزة نظرا لمحدودية المقاعد."),
      kSmallSpace,
      kSmallSpace,
      subTitle("امتيازات برنامج التحضير لامتحان الجزء الأول USMLE1:",Colors.black),
      getBulletText('توفير الدعم الإداري والإرشاد الأكاديمي للطالب خلال الالتحاق البرنامج.'),
      getBulletText('مخصصات مالية للكتب والمراجع للجزء الأول، تصرف مرة واحدة.'),
      getBulletText('الإلحاق بدورات تحضيرية للجزء الأول من الامتحان.'),
      getBulletText('تسديد رسوم امتحان USMLE1.'),

      subTitle('رابعًا: برنامج سنة الامتياز لطلاب كلية الطب (السنة الأخيرة)', AppColors.scoButtonColor),
      getBulletText('يهدف هذا البرنامج إلى إلحاق طلبة السنة الأخيرة بكليات الطب داخل الدولة، وقبل التخرج، بكليات الطب في الولايات المتحدة لمدة عام، ومعادلة هذه الفترة كمقابل لسنة الامتياز، بشرط موافقة جهات التراخيص الطبية في الدولة.'),
      kSmallSpace,

      subTitle('شروط الالتحاق بالبرنامج:', AppColors.scoButtonColor),
      getBulletText('أن يكون الطالب من مواطني دولة الإمارات العربية المتحدة.'),
      getBulletText('أن يكون الطالب في السنة الأخيرة من الدراسة بإحدى كليات الطب داخل أو خارج الدولة.'),
      getBulletText('أن يكون حاصلا على معدل تراكمي 3.5 على الأقل خلال سنوات الدراسة.'),
      getBulletText('اجتياز الجزء الأول USMLE1 والجزء الثاني USMLE2.'),
      getBulletText('الحصول على قبول في برنامج يعادل سنة الامتياز في إحدى المستشفيات العالمية المعتمدة في الولايات المتحدة الأمريكية.'),
      kSmallSpace,

      subTitle('امتيازات البرنامج:', AppColors.scoButtonColor),
      getBulletText('تغطية كافة الرسوم الدراسية أو مصاريف التدريب.'),
      getBulletText('مكافأة شهرية مجزية.'),
      getBulletText('بدل تذاكر سفر.'),
      getBulletText('تأمين صحي للمبتعث.'),
      kSmallSpace,

      subTitle('التزامات الطالب:', AppColors.scoButtonColor),
      getBulletText('الحفاظ على معدل تراكمي 3.0 على الأقل خلال سنوات الدراسة.'),
      getBulletText('الانتظام في حضور الدورات التدريبية.'),
      getBulletText('بعد اجتياز جميع أجزاء الامتحان، واستيفاء باقي الشروط، يلتزم الطالب بالتقديم على رخصة مزاولة المهنة في الولايات المتحدة ECFMG Certificate، والتقديم على برامج الأطباء المقيمين في التخصص من خلال نظام ERAS.'),
      getBulletText('الحرص على تحصيل العلم وبذل أقصى الجهد في الدراسة، والتقديم للامتحانات المطلوبة واستيفاء كافة المتطلبات.'),
      getBulletText('التقيد بأنظمة الإشراف الإداري والمتابعة الأكاديمية وبالتوجيهات الصادرة عن المكتب.'),
      getBulletText('الالتزام برد جميع النفقات المالية التي صرفت للطالب في حالة انسحابه من البرنامج، أو إلغاء التحاق الطالب بالبرنامج لسبب عائد له، أو مخالفة ضوابط المكتب، أو لأي من الأسباب وفقا للأحكام النافذة.'),
      kSmallSpace,

      subTitle('الوثائق والمستندات المطلوبة لبرامج طلبة كليات الطب:', AppColors.scoButtonColor),
      getBulletText('صورة شخصية حديثة بالزي الوطني.'),
      getBulletText('صورة عن جواز السفر متضمنة صفحة الرقم الموحد.'),
      getBulletText('صورة عن بطاقة الهوية مصورة من الجهتين على صفحة واحدة.'),
      getBulletText('صورة كاملة عن خلاصة القيد تشمل جميع أفراد الأسرة.'),
      getBulletText('صورة عن السجل الدراسي لجميع السنوات الدراسية السابقة.'),
      getBulletText('صورة من امتحان USMLE1 للمتقدمين لبرنامج منحة اجتياز الجزء الأول.'),
      getBulletText('نتيجة امتحان IFOM إن وجدت.'),
      kSmallSpace,

      subTitle('مستندات إضافية للمتقدمين لبرنامج سنة الامتياز:', AppColors.scoButtonColor),
      getBulletText('رسالة القبول من المستشفى خارج الدولة.'),
      getBulletText('صور من امتحان الجزء الأول USMLE1 والجزء الثاني USMLE2 .'),
      kSmallSpace,

      subTitle('بعد الحصول على المنحة أو البعثة تستكمل المستندات التالية:', AppColors.scoButtonColor),
      getBulletText('شهادة حسن السير والسلوك.'),
      getBulletText('توقيع تعهد بالالتزام بشروط وقواعد الإيفاد.'),
      kSmallSpace,

      subTitle('إجراءات التقديم للبعثة:', AppColors.scoButtonColor),
      getBulletText('يجب على الطالب الراغب بالتقديم للبعثة والمستوفي لكافة الشروط اتباع الإجراءات التالية:'),
      getBulletText('تقديم طلب البعثة عن طريق الموقع الإلكتروني للمكتب'),
      getBulletText('تحميل المستندات والوثائق المطلوبة'),
      kSmallSpace,

      getBulletText('ملاحظة: التقديم للبعثة لا يعني ضمان الحصول على البعثة، ويخضع الطلب للشروط والأحكام وتوفر المقاعد الدراسية.'),



    ],
  );
}

getDdsGraduationPhycian(context) {
  return Column(
    children: [],
  );
}

getDdsMedicalLicenseTest(context) {
  return Column(
    children: [],
  );
}

getDdsTrainingProgramForHealthProfessionals(context) {
  return Column(
    children: [],
  );
}
