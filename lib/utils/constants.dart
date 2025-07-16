import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';
import '../../l10n/app_localizations.dart';

import '../models/apply_scholarship/FillScholarshipFormModels.dart';


class Constants {


  static Map<String, Response> lovCodeMap = {};

  static RegExp get emiratesIdRegex => RegExp(r'\b784-[0-9]{4}-[0-9]{7}-[0-9]{1}\b');



  static const String newsImageUrl = "https://lh3.googleusercontent.com/NCE_l5_GJBa2YT_XNhAUf0aAH7-T5gWc15JfQKZ9YINax0698zDeFK64OnPbun9XDVGd=s142";
  static const double latitude = 24.4525803;
  static const double longitude = 54.3112618;

  static const String scholarshipInUae = "assets/sidemenu/sco_programs_images/INT.png";
  static const String scholarshipInAbroad= "assets/sidemenu/sco_programs_images/EXT.png";
  static const String doctorsScholarship = "assets/sidemenu/sco_programs_images/doctors_scholarship.png";

  static const String bachelorsInUae = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/UGRD.png";
  static const String graduatesInUAE = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/PGRD.png";
  static const String meteorologicalInUAE = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/MET.png";

  static const String bachelorsOutsideUae = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/UGRD.png";
  static const String graduatesOutsideUae = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/PGRD.png";
  static const String distinguishedDoctorsOutsideUae = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/DOCTORS.png";


  /// sco_programs_expansion_tile_images
  static const String applyingProcedure = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/applying procedures.png";
  static const String conditions = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/conditions.png";
  static const String faq = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/FAQ.png";
  static const String privileges = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/privileges.png";
  static const String universityList = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/university list.png";
  static const String useFullWebsites = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/Userful websites.png";
  static const String fallback = "assets/sidemenu/sco_programs_images/sco_programs_expansion_tile_images/Group 328.png";





  static const referenceValuesHighSchool = [
    {"code": "1", "value": "Gr10", "order": 1}, // 10th grade
    {"code": "2", "value": "Gr11-Term1", "order": 2}, // 11th first term
    {"code": "3", "value": "Gr11-Final", "order": 3}, // 11th final
    {"code": "4", "value": "Gr12-Term1", "order": 4}, // 12th mid term (Term 1)
    {"code": "8", "value": "Gr12-Term2", "order": 5}, // 12th mid term (Term 2)
    {"code": "5", "value": "Gr12-Final", "order": 6}, // 12th final
    {"code": "6", "value": "Elementary", "order": 0}, // Below 10th grade
    {"code": "7", "value": "Preliminary", "order": 0}, // Below 10th grade
  ];

  static const referenceValuesGraduation = [
    {"code": "UG", "value": "Bachelor", "order": 1},
    {"code": "MD", "value": "Bachelor of Medicine", "order": 2},
    {"code": "DP", "value": "Diploma", "order": 3},
    {"code": "IC", "value": "Internship Certificate", "order": 4},
    {"code": "PG", "value": "Master", "order": 5},
    {"code": "MF", "value": "Membership or Fellowship", "order": 6},
    {"code": "PHD", "value": "PhD", "order": 7},
    {"code": "SB", "value": "Specialty Board (Arab, US, CAN.)", "order": 8},
    {"code": "1", "value": "Year 1", "order": 9},
    {"code": "2", "value": "Year 2", "order": 10},
    {"code": "3", "value": "Year 3", "order": 11},
    {"code": "4", "value": "Year 4", "order": 12},
    {"code": "5", "value": "Year 5", "order": 13},
    {"code": "6", "value": "Year 6", "order": 14},
  ];





// "SERVICE_TYPE#AA": [
// {"code": "AA", "value": "Academic Advisement", "valueArabic": "الإرشاد الأكاديمي"},
// {"code": "FR", "value": "Financial Requests", "valueArabic": "الطلبات المالية"},
// {"code": "OL", "value": "Official Letter Request", "valueArabic": "طلب رسالة رسمية"}
// ],
// "SERVICE_TYPE#AL": [
// {"code": "AR", "value": "Administrative requests", "valueArabic": "Administrative requests"},
// {"code": "FR2", "value": "Financial Requests", "valueArabic": "Financial Requests"}
// ],
// "SERVICE_TYPE#EI": [
// {"code": "AA1", "value": "Academic Advisement", "valueArabic": "تسجيل ساعات أقل من المطلوب"},
// {"code": "FR1", "value": "Financial Requests", "valueArabic": "Financial Requests"}
// ]


// "SERVICE_CATEGORY": [
// {"code": "AA", "value": "Academic Advisement", "valueArabic": "الإرشاد الأكاديمي"},
// {"code": "AL", "value": "Alumni", "valueArabic": "شؤون الخريجين"},
// {"code": "EI", "value": "Educational initiatives", "valueArabic": "المبادرات التعليمية"}
// ]

// final serviceSubType ={
// "SERVICE_SUBTYPE#FR": [
// {"code": "1", "value": "Compensation for companion allowance", "valueArabic": "تعويض بدل مرافق"},
// {"code": "2", "value": "Tuition fee compensation", "valueArabic": "تعويض رسوم دراسية"},
// {"code": "3", "value": "Medical treatment compensation", "valueArabic": "تعويض علاجي"},
// {"code": "4", "value": "Compensation for study visit allowance (Part Time)", "valueArabic": "تعويض بدل زيارة دراسية (الطلبة الدارسين بالنظام ال"},
// {"code": "5", "value": "Payment of a marriage allowance", "valueArabic": "صرف علاوة زواج"}
// ],
// "SERVICE_SUBTYPE#AA1": [
// {"code": "1", "value": "Logging hours less than required", "valueArabic": "تسجيل ساعات أقل من المطلوب"},
// {"code": "2", "value": "Permission to travel/leave to the country of schl", "valueArabic": "Permission to travel/leave to the country of schl"}
// ],
// "SERVICE_SUBTYPE#OL": [
// {"code": "1", "value": "Student visa request letter", "valueArabic": "رسالة طلب تأشيرة دراسية visa Request letter"},
// {"code": "2", "value": "Financial guarantee letter", "valueArabic": "رسالة ضمان مالي"},
// {"code": "3", "value": "National service letter", "valueArabic": "رسالة خدمة وطنية"},
// {"code": "4", "value": "to whom it may concern letter", "valueArabic": "رسالة الى من يهمه الامر"}
// ],
// "SERVICE_SUBTYPE#FR1": [
// {"code": "1", "value": "Request to issue a ticket / exchange a cash ticket", "valueArabic": "طلب اصدار تذكرة / صرف بدل تذكرة نقدي"},
// {"code": "2", "value": "Add / change the bank account number", "valueArabic": "إضافة / تغيير رقم الحساب البنكي"}
// ],
// "SERVICE_SUBTYPE#FR2": [
// {"code": "1", "value": "Cert equivalency letter from higher education", "valueArabic": "رسالة معادلة الشهادة من التعليم العالي"},
// {"code": "2", "value": "Graduation award payment", "valueArabic": "صرف مكافأة التخرج"}
// ],
// "SERVICE_SUBTYPE#AA": [
// {"code": "1", "value": "Suspension from a semester", "valueArabic": "ايقاف من فصل دراسي"},
// {"code": "10", "value": "Meeting Request", "valueArabic": "طلب اجتماع"}, ///TODO: Add one by default from your side: Added by me
// {"code": "2", "value": "Academic extension", "valueArabic": "تمديد دراسي"},
// {"code": "3", "value": "Permission to travel/leave to the country of schl", "valueArabic": "إذن سفر/المغادرة الى بلد الابتعاث"},
// {"code": "4", "value": "Postpone a semester", "valueArabic": "تأجيل فصل دراسي"},
// {"code": "5", "value": "Withdrawing from the scholarship", "valueArabic": "انسحاب من البعثة/المنحة"},
// {"code": "6", "value": "University change", "valueArabic": "تغيير جامعة"},
// {"code": "7", "value": "major change", "valueArabic": "تغيير تخصص"},
// {"code": "8", "value": "Change major and university", "valueArabic": "تغيير التخصص والجامعة"},
// {"code": "9", "value": "Study subjects at another university", "valueArabic": "دراسة مواد دراسية بجامعة أخرى"}
// ],
// "SERVICE_SUBTYPE#AR": [
// {"code": "1", "value": "Assistance in finding job", "valueArabic": "طلب مساعدة للحصول على وظيفة"}
// ]
// }
  /// All types of combinations are available now for Creating request
 static final requestStructureList = [
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "1",
      "fields": [
        {"title": "Suspension semester:","titleAr":"فصل الايقاف:", "type": "text", "required": true},
        {"title": "GPA:","titleAr":"المعدل التراكمي:", "type": "number", "required": true},
        {"title": "Reason for suspension:","titleAr":"سبب الايقاف:", "type": "textArea", "required": true},
        {"title": "Attach the last academic record:", "type": "file", "required": true,"titleAr":"ارفاق آخر سجل دراسي:"},

      ],
      "conditions": [
        "الحصول على موافقة مسبقة من المكتب",
        "أن لا يؤثر الإيقاف بالانسحاب من مواد وسداد رسوم دراسية"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "2",
      "fields": [
        {"title": "Academic extension period:", "type": "text", "required": true,"titleAr":"مدة التمديد الدراسي:"},
        {"title": "GPA:", "type": "number", "required": true,"titleAr":"المعدل التراكمي:"},
        {"title": "Reason for academic extension:", "type": "textArea", "required": true,"titleAr":"سبب التمديد الدراسي:"},
        {"title": "Attach the last academic record:", "type": "file", "required": true,"titleAr":"ارفاق آخر سجل دراسي:"},

      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "3",
      "fields": [
        {"title": "Destination:", "type": "text", "required": true,"titleAr":"الوجهة:"},
        {"title": "Travel date:", "type": "date", "required": true,"titleAr":"تاريخ السفر:"},
        {"title": "Return date:", "type": "date", "required": true,"titleAr":"تاريخ العودة:"},
        {"title": "Emergency phone number:", "type": "text", "required": true,"titleAr":"رقم هاتف الطوارئ:"},
        // {"title": "Inform the academic advisor in case of changes in information", "type": "text", "required": true,"titleAr":""},
        {"title": "The reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "أن لا يؤثر طلب إذن سفر/المغادرة على الالتزام الدراسي",
        "أن يكون إذن سفر/المغادرة خلال الإجازات الرسمية المعتمدة لدى الجامعة."
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "4",
      "fields": [
        {"title": "Postpone semester:", "type": "text", "required": true,"titleAr":"الفصل الدراسي للتأجيل :"},
        {"title": "Reason for requesting postponement:", "type": "textArea", "required": true,"titleAr":"سبب طلب فصل التأجيل:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
      ],
      "conditions": [
        "الحصول على موافقة مسبقة",
        "أن لا يؤثر التأجيل بسداد رسوم دراسية فترة الايقاف"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "5",
      "fields": [
        {"title": "Withdrawal semester:", "type": "text", "required": true,"titleAr":"فصل الانسحاب:"},
        {"title": "Reason for withdrawing from the semester/scholarship:", "type": "textArea", "required": true,"titleAr":"سبب الانسحاب من البعثة/المنحة:"},
        {"title": "Attach a document supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "6",
      "fields": [
        {"title": "Name of the university to which you want to transfer:", "type": "text", "required": true,"titleAr":"اسم الجامعة المراد الانتقال لها: "},
        {"title": "The number of credited hours in the new university:", "type": "number", "required": true,"titleAr":"عدد الساعات المحتسبة في الجامعة الجديدة:"},
        {"title": "The cost of the number of non-accounted hours at the university:", "type": "number", "required": true,"titleAr":"تكلفة عدد الساعات الغير المحتسبة في الجامعة:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},
      ],
      "conditions": [
        "الحصول على موافقة مسبقة من المكتب",
        "ان تكون الجامعة ضمن الجامعات المعتمدة لدى المكتب للعام الدراسي الذي يرغب الطالب التغيير فيه",
        "ألا يترتب على انتقال الطالب من جامعة الى أخرى تمديد سنوات الدراسة، وتأخر تاريخ التخرج.",
        "تزويد المكتب بإفادة من الجامعة بالقبول الجامعي و معادلة الساعات الدراسية المنجزة في الجامعة السابقة",
        "يشترط على الطالب تزويد المكتب برسالة من إفادة من التعليم العالي تفيد بمعادلة الجامعة عند التخرج. (يطبق لخارج الدولة)"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "7",
      "fields": [
        {"title": "The name of the specialization to be changed:", "type": "text", "required": true,"titleAr":"اسم التخصص المراد تغييره:"},
        {"title": "The number of hours credited in the new specialization:", "type": "number", "required": true,"titleAr":"عدد الساعات المحتسبة في التخصص الجديدة: "},
        {"title": "The cost of the number of unaccounted hours:", "type": "number", "required": true,"titleAr":"تكلفة عدد الساعات الغير المحتسبة:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "الحصول على موافقة مسبقة من المكتب",
        "أن يكون التخصص الجديد معتمد ضمن قائمة التخصصات والجامعات المعتمدة لدى المكتب",
        "ألا يؤثر تغيير تخصصه الدراسي على تاريخ موعد التخرج المحدد مسبقاً من قبل مجلس الإدارة",
        "تزويد المكتب بإفادة من الجامعة تفيد بمعادلة الساعات الدراسية المنجزة في التخصص السابق",
        "يشترط على الطالب تزويد المكتب برسالة من إفادة من التعليم العالي تفيد بمعادلة التخصص عند التخرج. (يطبق لخارج الدولة)"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "8",
      "fields": [
        {"title": "Name of the university to which you want to transfer:", "type": "text", "required": true,"titleAr":"اسم الجامعة المراد الانتقال لها:"},
        {"title": "The number of credited hours in the new university:", "type": "number", "required": true,"titleAr":"عدد الساعات المحتسبة في الجامعة الجديدة:"},
        {"title": "The name of the specialization to be changed:", "type": "text", "required": true,"titleAr":"اسم التخصص المراد تغييره:"},
        {"title": "The cost of the number of unaccounted hours:", "type": "number", "required": true,"titleAr":"تكلفة عدد الساعات الغير المحتسبة: "},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب: "},

      ],
      "conditions": [
        "الحصول على موافقة مسبقة من المكتب",
        "أن يكون التخصص والجامعة معتمد ضمن قائمة التخصصات والجامعات المعتمدة لدى المكتب",
        "ألا يؤثر تغيير تخصصه الدراسي على تاريخ موعد التخرج المحدد مسبقاً من قبل مجلس الإدارة",
        "تزويد المكتب بإفادة من الجامعة تفيد بمعادلة الساعات الدراسية المنجزة في التخصص السابق",
        "يشترط على الطالب تزويد المكتب برسالة من إفادة من التعليم العالي تفيد بمعادلة التخصص والجامعة عند التخرج. (يطبق لخارج الدولة)"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "9",
      "fields": [
        {"title": "Name of the university to study courses in:", "type": "text", "required": true,"titleAr":"اسم الجامعة لدراسة مواد فيها:"},
        {"title": "Semester:", "type": "text", "required": true,"titleAr":"الفصل الدراسي:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "الحصول على موافقة مسبقة من المكتب",
        "أن يكون التخصص والجامعة معتمد ضمن قائمة التخصصات والجامعات المعتمدة لدى المكتب",
        "ألا يؤثر تغيير تخصصه الدراسي على تاريخ موعد التخرج المحدد مسبقاً من قبل مجلس الإدارة",
        "تزويد المكتب بإفادة من الجامعة تفيد بمعادلة الساعات الدراسية المنجزة في التخصص السابق",
        "يشترط على الطالب تزويد المكتب برسالة من إفادة من التعليم العالي تفيد بمعادلة التخصص والجامعة عند التخرج. (يطبق لخارج الدولة)"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "10",
      "fields": [
        {"title": "Date:", "type": "date", "required": true,"titleAr":"التاريخ:"},
        {"title": "Time:", "type": "time", "required": true,"titleAr":"الساعة:"},
        {"title": "Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"}
      ],
      "conditions": [
        "إدخال سبب طلب الاجتماع مع تحديد اليوم والساعة."
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "1",
      "fields": [
        {"title": "Date of enrollment of the escort to the mission headquarters:", "type": "date", "required": true,"titleAr":"تاريخ التحاق المرافق لمقر البعثة:"},
        {"title": "Date of return of the escort to the mission headquarters:", "type": "date", "required": true,"titleAr":"تاريخ عودة المرافق لمقر البعثة: "},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "ان يكون المرافق من الدرجة الأولى حتى الثانية للطالبة",
        "ان لا يسبق للطالبة الالتحاق ببعثة خارج الدولة"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "2",
      "fields": [
        {"title": "Compensation chapter:", "type": "text", "required": true,"titleAr":"فصل التعويض: "},
        {"title": "The cost of tuition fees", "type": "number", "required": true,"titleAr":"تكلفة الرسوم الدراسية:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "3",
      "fields": [
        {"title": "The value of medical compensation", "type": "number", "required": true,"titleAr":"قيمة التعويض العلاجي:"},
        {"title": "Treatment type:", "type": "text", "required": true,"titleAr":"نوع العلاج: "},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":" السبب: "},

      ],
      "conditions": [
        "أن يكون العلاج في مقر الابتعاث وخلال فترة الدراسة",
        "ان لا يكون العلاج مغطى بالتأمين الصحي الخاص لدى المكتب",
        "ان لا يكون العلاج بغرض تجميلي",
        "أن لا تكون تكلفة العلاج عالية مقارنة بالتكلفة المتعارف عليها في بلد الابتعاث",
        "أن الأصل في جميع الطلبات العلاجية الضرورة والحاجة الطبية، مع ضرورة اخذ موافقة مسبقة من المكتب قبل بدء العلاج",
        "لا يغطي المكتب تكاليف عمليات الاسنان التجميلية وتكاليف عمليات التقويم والتبيض وزراعة الاسنان",
        "لا يتم تعويض الفواتير التي قد مر عليها أكثر من 6 أشهر"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "4",
      "fields": [
        {"title": "Date of joining the mission headquarters:", "type": "date", "required": true,"titleAr":"تاريخ الالتحاق بمقر البعثة: "},
        {"title": "Date of departure from the mission headquarters:", "type": "date", "required": true,"titleAr":"تاريخ مغادرة مقر البعثة:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "ان يقدم الطالب رسالة رسمية من الجامعة تفيد فترة الزيارة الدراسية والسبب",
        "ارسال ختم الخروج والدخول لجواز السفر"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "5",
      "fields": [
        {"title": "Date of joining the husband/wife to the place of dispatch:", "type": "date", "required": true,"titleAr":"تاريخ التحاق الزوج/الزوجة لمقر الايفاد:"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "تمنح العلاوة للمبتعث الذي يقيم معه الزوج/الزوجة والأولاد في مقر الدراسة بشكل دائم خلال مدة الدراسة",
        "أما اذا كان الزوج/الزوجة ترافقه بصفة مؤقتة، فإن الطالب لا يستحق صرف العلاوة",
        "يبدئ صرف علاوة الزواج بدءً من تاريخ وصولهم الى مقر البعثة",
        "ختم الدخول لجواز السفر –التأشيرة الدراسية – عقد الزواج"
      ]
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "1",
      "fields": [
        {"title": "The reason for issuing the message", "type": "textArea", "required": true,"titleAr":"سبب اصدار الرسالة: "}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "2",
      "fields": [
        {"title": "The reason for issuing the message", "type": "textArea", "required": true,"titleAr":"سبب اصدار الرسالة:"}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "3",
      "fields": [
        {"title": "The reason for issuing the message", "type": "textArea", "required": true,"titleAr":"سبب اصدار الرسالة: "}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "4",
      "fields": [
        {"title": "The entity", "type": "text", "required": true,"titleAr":"الجهة:"},
        {"title": "The reason for issuing the message", "type": "textArea", "required": true,"titleAr":"الأسباب: "}
      ],
      "conditions": []
    },
    {
      "requestCategory": "EI",
      "requestType": "AA1",
      "requestSubType": "1",
      "fields": [
        // {"title": "University approval", "type": "text", "required": true,"titleAr":""},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"الأسباب: "},

      ],
      "conditions": []
    },
    {
      "requestCategory": "EI",
      "requestType": "FR1",
      "requestSubType": "1",
      "fields": [
        {"title": "Departure Date", "type": "date", "required": true,"titleAr":"الذهاب: "},
        {"title": "Return Date", "type": "date", "required": true,"titleAr":"العودة:"},
        {"title": "Destination", "type": "text", "required": true,"titleAr":"الوجهة:"},
        // {"title": "Declaration of not changing the request type (either ticket or cash allowance), Declaration of not changing the destination", "type": "text", "required": true,"titleAr":""},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},
      ],
      "conditions": []
    },

   /// Take care of this: this is missing in given response by backend
    {
      "requestCategory": "EI",
      "requestType": "AA1",
      "requestSubType": "2",
      "fields": [
        {"title": "Destination:", "type": "text", "required": true,"titleAr":"الوجهة:"},
        {"title": "Travel date:", "type": "date", "required": true,"titleAr":"تاريخ السفر: "},
        {"title": "Return date:", "type": "date", "required": true,"titleAr":"   تاريخ العودة:  "},
        {"title": "Emergency phone number:", "type": "text", "required": true,"titleAr":"رقم هاتف الطوارئ:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": [
        "ان لا يؤثر طلب إذن سفر/المغادرة على الالتزام الدراسي",
        "أن يكون إذن سفر/المغادرة خلال الإجازات الرسمية المعتمدة لدى الجامعة"
      ]
    },
    {
      "requestCategory": "EI",
      "requestType": "FR1",
      "requestSubType": "2",
      "fields": [
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "FR2",
      "requestSubType": "1",
      "fields": [
        {"title": "The reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},
        {"title": "Send final academic record – diploma certificate", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "FR2",
      "requestSubType": "2",
      "fields": [
        {"title": "The reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},
        {"title": "Attach exit and entry stamp for passport:", "type": "file", "required": true,"titleAr":"(ختم الدخول لجواز السفر –التأشيرة الدراسية – عقد الزواج)"},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true,"titleAr":"ارفاق مستندات تدعم الطلب:"}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "AR",
      "requestSubType": "1",
      "fields": [
        {"title": "Determine the entities to which the graduate has previously applied", "type": "text", "required": true,"titleAr":"تحديد الجهات التي تقدم لها الخريج سابقا: "},
        // {"title": "Register in employment platforms in the country (mention the platforms) and send CV", "type": "file", "required": true,"titleAr":""},
        {"title": "The Reason:", "type": "textArea", "required": true,"titleAr":"السبب:"},

      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "AR",
      "requestSubType": "2",
      "fields": [
        // {"title": "Add the employer", "type": "text", "required": false},
        // {"title": "If not working, specify the entities applied to and the employment platforms registered in, reason for not wanting to work, national service start and end dates, postgraduate studies (name of the institution)", "type": "text", "required": false}
        {"title": "Reason", "type": "textArea", "required": false,"titleAr":"السبب:"}
      ],
      "conditions": []
    } /// This is not available more and no lov code available for this
  ];


static String getNameOfScholarshipByConfigurationKey({required AppLocalizations localization, required String configurationKey }){
    var scholarshipName = '';
   switch(configurationKey){
     case 'SCOUGRDINT':
       scholarshipName = localization.internalBachelor;
       break;
     case 'SCOUGRDEXT':
       scholarshipName = localization.externalBachelor;
       break;
     case 'SCOPGRDINT':
       scholarshipName = localization.internalPostgraduate;
       break;
     case 'SCOPGRDEXT':
       scholarshipName = localization.externalPostgraduate;
       break;
     case 'SCOMETLOGINT':
       scholarshipName = localization.internalMeterological;
       break;
     case 'SCOACTUGRD':
       scholarshipName = localization.actuarialScience;
       break;
     case 'SCOUPPEXT':
       scholarshipName = localization.universityPreparationProgram;
       break;
     case 'SCODDSEXT':
       scholarshipName = localization.externalDoctors;
       break;
     case 'SCOAHCPEXT':
       scholarshipName = localization.medicalProfessionsProgram;
       break;
     case 'SCOPGRDMDEXT':
       scholarshipName = localization.postGraduationExternalMedicine;
       break;
   default:
         scholarshipName = '- -';

   }
   return scholarshipName;
 }

}



String markHighestHighSchoolQualification(List<Map<String, dynamic>> referenceValues, List<Map<String, dynamic>> hsRecords) {
  // Step 1: Create a map of code to order based on the reference list
  final Map<String, int> orderMap = {
    for (var item in referenceValues) item['code']: item['order']
  };

  // Step 2: Track the record with the highest qualification
  Map<String, dynamic>? highestQualificationRecord;
  int highestOrder = -1;

  // Step 3: Find the record with the highest order
  for (var record in hsRecords) {
    final hsLevel = record['hsLevel'] as String?;
    if (hsLevel != null && orderMap.containsKey(hsLevel)) {
      final order = orderMap[hsLevel]!;

      // If this record has a higher order, update the highest qualification record
      if (order > highestOrder) {
        highestOrder = order;
        highestQualificationRecord = record;
      }
    }
  }

  // Step 4: Mark all records as false initially
  for (var record in hsRecords) {
    record['highestQualification'] = false;
  }

  // Step 5: Mark the highest qualification record as true
  if (highestQualificationRecord != null) {
    highestQualificationRecord['highestQualification'] = true;
    return highestQualificationRecord['hsLevel'];
  }
  return '';
}


bool shouldShowGraduationSection(String academicCareer) {
  return academicCareer != 'SCHL' && academicCareer != 'HCHL';
}

bool shouldShowHighSchoolDetails(String academicCareer) {
  return academicCareer == 'UG' || academicCareer == 'UGRD' || academicCareer == 'SCHL' || academicCareer == 'HCHL';
}

bool shouldShowUniversityAndMajors(String academicCareer) {
  return academicCareer != 'SCHL';
}

bool shouldShowUniversityList({required String academicCareer, required String admitType}){
  return academicCareer != 'HCHL' || admitType == 'UPP';
}


bool shouldShowRequiredExaminations(String academicCareer) {
  return !(academicCareer == 'SCHL' || academicCareer == 'HCHL');
}


bool shouldShowEmploymentHistory(String configurationKey) {
  return (configurationKey == 'SCOPGRDINT' || configurationKey == 'SCOPGRDEXT' || configurationKey == 'SCODDSEXT' || configurationKey == 'SCOAHCPEXT' || configurationKey == 'SCOPGRDMDEXT');}


bool shouldShowAttachmentSectionForExt({required String configurationKey}){
  return configurationKey == 'SCOUPPEXT';
}





String markHighestGraduationQualification(List<Map<String, dynamic>> referenceValues, List<Map<String, dynamic>> graduationRecords) {
  // Step 1: Create a map of code to order based on the reference list
  final Map<String, int> orderMap = {
    for (var item in referenceValues) item['code']: item['order']
  };

  // Step 2: Track the record with the highest qualification
  Map<String, dynamic>? highestQualificationRecord;
  int highestOrder = -1;

  // Step 3: Find the record with the highest order
  for (var record in graduationRecords) {
    final graduationLevel = record['level'] as String?;
    if (graduationLevel != null && orderMap.containsKey(graduationLevel)) {
      final order = orderMap[graduationLevel]!;

      // If this record has a higher order, update the highest qualification record
      if (order > highestOrder) {
        highestOrder = order;
        highestQualificationRecord = record;
      }
    }
  }

  // Step 4: Mark all records as false initially
  for (var record in graduationRecords) {
    record['highestQualification'] = false;
  }

  // Step 5: Mark the highest qualification record as true
  if (highestQualificationRecord != null) {
    highestQualificationRecord['highestQualification'] = true;
    return highestQualificationRecord['level'];
  }
  return '';
}



bool shouldShowAddGraduationButton({required scholarshipType, required academicCareer}){
  return (!(scholarshipType == 'INT' && academicCareer == 'UGRD') && academicCareer != 'UGRD');
}


String getHighestQualification(
    {required String academicCareer,
      required String scholarshipType,
      required List<Map<String,dynamic>> highSchoolRecords,
      required List<Map<String, dynamic>> graduationRecords,
      required List<GraduationInfo> graduationDetailsList,
    }
    )
{
  bool showHighSchool = shouldShowHighSchoolDetails(academicCareer);
  bool showGraduation = shouldShowGraduationSection(academicCareer);

  print("show High School: $showHighSchool");
  print("show Graduation Details: $showGraduation");


  String highestQualification = '';

  /// If we have graduation details then it is obvious that we can get highestQualification from graduation details only
  if(showGraduation){
    bool showingAddGraduationButton = shouldShowAddGraduationButton(scholarshipType: scholarshipType, academicCareer: academicCareer);
    /// If we are not showing the add more button then check if we have any detail which have parameter currently studying.
    /// If bool found with currently studying set highest qualification from graduation details
    if(!showingAddGraduationButton){
      final currentlyStudying = graduationDetailsList.any((element){return element.currentlyStudying;});
      // if(currentlyStudying){
        /// If after finding that student is currently studying from graduation then set highest qualification from graduation.
        highestQualification = markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecords);

      // }
      // if(!currentlyStudying){
      //   /// If we are not showing the add more button and also the currently studying for graduation in false then we have to check highest
      //   /// qualification from highSchool list and set highest qualification flags from high school list too.
      //   highestQualification = markHighestHighSchoolQualification(Constants.referenceValuesHighSchool, highSchoolRecords);
      // }
    }

    /// If we are showing the add more button which means we have enough number of graduation details.
    /// Now set the boolean flag for all and set highest qualification also.
    if(showingAddGraduationButton) {
      highestQualification = markHighestGraduationQualification(Constants.referenceValuesGraduation, graduationRecords);
      log(jsonEncode(graduationRecords));
    }
  }

  /// When we are showing only high school then get highest qualification from highschool only
  if(showHighSchool && !showGraduation){
    highestQualification = markHighestHighSchoolQualification(Constants.referenceValuesHighSchool, highSchoolRecords);
    log(jsonEncode(graduationRecords));
  }

  // debugPrint("Printing the Highest Level: $highestQualification");
  return highestQualification;
}




enum MilitaryStatus { yes, no, postponed, exemption }
enum ScholarshipStatus{applyScholarship,appliedScholarship,approvedScholarship}
enum AttachmentType {request,employment,updateNote}
enum EditApplicationSection {education,employmentHistory,requiredExaminations,universityPriority}
