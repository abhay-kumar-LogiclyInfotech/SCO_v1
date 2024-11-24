import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';

class Constants {
  static const String USERNAME = "liferay_access@sco.ae";
  static const String PASSWORD = "India@1234";
  static String basicAuthWithUsernamePassword = 'Basic ${base64Encode(utf8.encode('${Constants.USERNAME}:${Constants.PASSWORD}'))}';
  static const String basicAuth = 'Basic bGlmZXJheV9hY2Nlc3NAc2NvLmFlOkluZGlhQDEyMzQ=';

  static Map<String, Response> lovCodeMap = {};

  static RegExp get emiratesIdRegex =>
      RegExp(r'\b784-[0-9]{4}-[0-9]{7}-[0-9]{1}\b');

  static PinTheme defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -1,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]));


  static const String newsImageUrl = "https://lh3.googleusercontent.com/NCE_l5_GJBa2YT_XNhAUf0aAH7-T5gWc15JfQKZ9YINax0698zDeFK64OnPbun9XDVGd=s142";


  static const dynamic scholarshipRequestType= [

    {
      "code":"INT",
      "value":"Scholarships In UAE",
      "valueArabic":"المنح الدراسية في الإمارات العربية المتحدة"
    },
    {
      "code":"EXT",
      "value":"Scholarships Abroad",
      "valueArabic":"المنح الدراسية في الخارج"
    }

  ];


  /// All types of combinations are available now for Creating request
 static final requestStructureList = [
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "1",
      "fields": [
        {"title": "Suspension semester:", "type": "text", "required": true},
        {"title": "GPA:", "type": "number", "required": true},
        {"title": "Attach the last academic record:", "type": "file", "required": true},
        {"title": "Reason for suspension:", "type": "textArea", "required": true},
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
        {"title": "Academic extension period:", "type": "text", "required": true},
        {"title": "GPA:", "type": "number", "required": true},
        {"title": "Attach the last academic record:", "type": "file", "required": true},
        {"title": "Reason for academic extension:", "type": "textArea", "required": true},
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "3",
      "fields": [
        {"title": "Destination:", "type": "text", "required": true},
        {"title": "Travel date:", "type": "date", "required": true},
        {"title": "Return date:", "type": "date", "required": true},
        {"title": "Emergency phone number:", "type": "text", "required": true},
        {"title": "Inform the academic advisor in case of changes in information", "type": "text", "required": true},
        {"title": "The reason:", "type": "textArea", "required": true},

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
        {"title": "Postpone semester:", "type": "text", "required": true},
        {"title": "Reason for requesting postponement:", "type": "textArea", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
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
        {"title": "Withdrawal season:", "type": "text", "required": true},
        {"title": "Reason for withdrawing from the semester/scholarship:", "type": "textArea", "required": true},
        {"title": "Attach a document supporting the application:", "type": "file", "required": true},
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "AA",
      "requestSubType": "6",
      "fields": [
        {"title": "Name of the university to which you want to transfer:", "type": "text", "required": true},
        {"title": "The number of credited hours in the new university:", "type": "number", "required": true},
        {"title": "The cost of the number of non-accounted hours at the university:", "type": "number", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},
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
        {"title": "The name of the specialization to be changed:", "type": "text", "required": true},
        {"title": "The number of hours credited in the new specialization:", "type": "number", "required": true},
        {"title": "The cost of the number of unaccounted hours:", "type": "number", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Name of the university to which you want to transfer:", "type": "text", "required": true},
        {"title": "The number of credited hours in the new university:", "type": "number", "required": true},
        {"title": "The name of the specialization to be changed:", "type": "text", "required": true},
        {"title": "The cost of the number of unaccounted hours:", "type": "number", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Name of the university to study courses in:", "type": "text", "required": true},
        {"title": "Semester:", "type": "text", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Date:", "type": "date", "required": true},
        {"title": "Time:", "type": "time", "required": true},
        {"title": "Reason:", "type": "textArea", "required": true}
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
        {"title": "Date of enrollment of the escort to the mission headquarters:", "type": "date", "required": true},
        {"title": "Date of return of the escort to the mission headquarters:", "type": "date", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Compensation chapter:", "type": "text", "required": true},
        {"title": "The cost of tuition fees", "type": "number", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "FR",
      "requestSubType": "3",
      "fields": [
        {"title": "The value of medical compensation", "type": "number", "required": true},
        {"title": "Treatment type:", "type": "text", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Date of joining the mission headquarters:", "type": "date", "required": true},
        {"title": "Date of departure from the mission headquarters:", "type": "date", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Date of joining the husband/wife to the place of dispatch:", "type": "date", "required": true},
        {"title": "Attach documents supporting the application:", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "The reason for issuing the message", "type": "textArea", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "2",
      "fields": [
        {"title": "The reason for issuing the message", "type": "textArea", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "3",
      "fields": [
        {"title": "The reason for issuing the message", "type": "textArea", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AA",
      "requestType": "OL",
      "requestSubType": "4",
      "fields": [
        {"title": "The entity", "type": "text", "required": true},
        {"title": "The reason for issuing the message", "type": "textArea", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "EI",
      "requestType": "AA1",
      "requestSubType": "1",
      "fields": [
        {"title": "University approval", "type": "text", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

      ],
      "conditions": []
    },
    {
      "requestCategory": "EI",
      "requestType": "FR1",
      "requestSubType": "1",
      "fields": [
        {"title": "Departure Date", "type": "date", "required": true},
        {"title": "Return Date", "type": "date", "required": true},
        {"title": "Destination", "type": "text", "required": true},
        {"title": "Declaration of not changing the request type (either ticket or cash allowance), Declaration of not changing the destination", "type": "text", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

      ],
      "conditions": []
    },
    {
      "requestCategory": "EI",
      "requestType": "AA1",
      "requestSubType": "2",
      "fields": [
        {"title": "Destination:", "type": "text", "required": true},
        {"title": "Travel date:", "type": "date", "required": true},
        {"title": "Return date:", "type": "date", "required": true},
        {"title": "Emergency phone number:", "type": "text", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

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
        {"title": "Attach a letter from the bank (showing IBAN number, bank account number, and bank name)", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "FR2",
      "requestSubType": "1",
      "fields": [
        {"title": "The reason:", "type": "textArea", "required": true},
        {"title": "Send final academic record – diploma certificate", "type": "file", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "FR2",
      "requestSubType": "2",
      "fields": [
        {"title": "The reason:", "type": "textArea", "required": true},
        {"title": "Attach exit and entry stamp for passport:", "type": "file", "required": true},
        {"title": "Attach a letter from the bank (showing IBAN number, bank account number, and bank name)", "type": "file", "required": true}
      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "AR",
      "requestSubType": "1",
      "fields": [
        {"title": "Determine the entities to which the graduate has previously applied", "type": "text", "required": true},
        {"title": "Register in employment platforms in the country (mention the platforms) and send CV", "type": "file", "required": true},
        {"title": "The Reason:", "type": "textArea", "required": true},

      ],
      "conditions": []
    },
    {
      "requestCategory": "AL",
      "requestType": "AR",
      "requestSubType": "Adding / changing the job status of the graduate",
      "fields": [
        {"title": "Add the employer", "type": "text", "required": false},
        {"title": "If not working, specify the entities applied to and the employment platforms registered in, reason for not wanting to work, national service start and end dates, postgraduate studies (name of the institution)", "type": "text", "required": false}
      ],
      "conditions": []
    } /// This is not available more and no lov code available for this
  ];



}

enum MilitaryStatus { yes, no, postponed, exemption }
enum ScholarshipStatus{applyScholarship,appliedScholarship,approvedScholarship}
enum AttachmentType {request,employment}
