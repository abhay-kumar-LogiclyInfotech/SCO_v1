
import 'package:flutter/cupertino.dart';
import 'package:sco_v1/resources/widgets/subtitle_widget.dart';
import 'package:sco_v1/view/apply_scholarship/form_view_Utils.dart';
import 'package:sco_v1/view/main_view/scholarship_in_uae/bachelor_inside_uae/bachelor_inside_uae.dart';

import '../../../../resources/widgets/bullet_text_widget.dart';

getDoctorAboutTheProgramExternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      sectionTitle(title: "نبذه عن برنامج دكتور فى الطب"),
      kSmallSpace,
      const Text(
        '''في إطار حرص مكتب البعثات الدراسية بتوفير فرص الابتعاث في التخصصات الطبية المرموقة، يطرح المكتب برنامج “دكتور في الطب”
(Doctor of Medicine MD)  كأحد برامج الدراسات العليا المعتمدة.
يُعتبر برنامج دكتور في الطب درجة طبية متقدمة تُمنح من قبل كليات طبية عالمية مرموقة وتحظى باعتراف دولي واسع. في بعض الدول، مثل الولايات المتحدة وكندا، تُعد هذه الدرجة المؤهل الأساسي لممارسة مهنة الطب، مما يجعلها خطوة محورية في المسار المهني للأطباء. كما تفتح هذه الدرجة آفاقًا واسعة للتطور الوظيفي، وتوفر فرصًا متميزة للإقامة والتدريب في أرقى المستشفيات العالمية، مما يعزز كفاءة الأطباء ويؤهلهم لمستقبل مهني ناجح على المستوى الدولي.
يتطلب القبول في برنامج “دكتور في الطب” استيفاء مجموعة من الشروط الأكاديمية والمهنية، حيث يشترط حصول المتقدم على درجة البكالوريوس في تخصص ذي صلة، مثل العلوم الصحية أو الأحياء، بالإضافة إلى استيفاء المتطلبات المحددة من قبل الجامعات الطبية العالمية، والتي قد تشمل اجتياز اختبارات القبول مثل MCAT، وإثبات الكفاءة في اللغة الإنجليزية. كما أن القبول في هذا البرنامج يخضع لمعايير تنافسية، نظرًا لمحدودية المقاعد وتزايد الطلب على التخصص.'''
      )

    ]
  );
}
getDoctorTermsAndConditionsExternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      sectionTitle(title: "شروط ومتطلبات القبول فى البعثة"),
      kSmallSpace,
      const Text(
          '''
1. أن يكون المتقدّم من مواطني دولة الإمارات العربية المتحدة.
2. حصول الطالب على نسبة لا تقل عن 3.4 في درجة البكالوريوس
3. اجتياز اختبارات اللغة الإنجليزية: الآيلتس: 7.0 أو 90 توفل
4. أن يكون لديه قبول جامعي نهائي غير مشروط من إحدى الجامعات المتميزة والمعتمدة من قبل مكتب البعثات الدراسية.
5. أن يجتاز المقابلة الشخصية بنجاح.
6. إذا كان الطالب موظفًا- تقديم ما يثبت موافقة جهة عمله على التحاقه بالدراسة وحصوله على إجازة دراسية (إجازة تفرّغ للدراسة)
'''


      )


    ]
  );
}
getDoctorAdmissionCriteriaExternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      sectionTitle(title: "معايير القبول في الجامعات العالمية"),
      kSmallSpace,
      getBulletText('الحصول على درجة بكالوريوس "ما قبل الطب" بتقدير "امتياز " في احدى التخصصات الصحية او الطبية مثل الهندسة طبية والحيوية أو العلوم الصحية أو علوم الأحياء الدقيقة أو علوم الأعصاب او غيرها من التخصصات ذو العلاقة'),
      getBulletText('اجتياز اختبار MCAT.'),
      getBulletText('الحصول على (7.0) فما فوق في اختبار الآيلتس او 9.0 في التوفل.'),
      getBulletText('اجتياز المقابلة الشخصية بنجاح مع الجامعة، وتعتبر من أهم معايير قبول الطلبة في الجامعة.'),
    ]
  );
}
getDoctorAccreditedUniversitiesExternal(context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      sectionTitle(title: "الجامعات المعتمدة"),
      kSmallSpace,
    ]
  );
}