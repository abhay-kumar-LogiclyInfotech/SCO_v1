import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/controller/internet_controller.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/repositories/home/home_repository.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../data/response/ApiResponse.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';

class GetAllActiveScholarshipsViewModel with ChangeNotifier {





  //*------Accessing Api Services------*

  late AlertServices _alertServices;
  GetAllActiveScholarshipsViewModel(){
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

  final HomeRepository _homeRepository = HomeRepository();

  ApiResponse<List<GetAllActiveScholarshipsModel>> _apiResponse = ApiResponse.none();

  ApiResponse<List<GetAllActiveScholarshipsModel>> get apiResponse => _apiResponse;

  set _setApiResponse(ApiResponse<List<GetAllActiveScholarshipsModel>> response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<bool> getAllActiveScholarships(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider}) async {
    InternetController internetController =  Get.find<InternetController>();

    if (internetController.isConnected.value) {
      try {
        _setApiResponse = ApiResponse.loading();

        // clearing the list first
        _apiResponse.data?.clear();

        //*-----Create Headers-----*
        final headers = <String, String>{
          'authorization': Constants.basicAuthWithUsernamePassword
        };

        //*-----Calling Api Start-----*
        final response = await _homeRepository.getAllActiveScholarships(headers: headers);
        //*-----Calling Api End-----*

        _setApiResponse = ApiResponse.completed(response);
        return true;
      } catch (error) {
        // debugPrint('Printing Error: $error');
        _setApiResponse = ApiResponse.error(error.toString());
        _alertServices.toastMessage(error.toString());

        return false;
      }
    } else {
      return false;
    }
  }

///************************************************************************************

 final List<Map<String,dynamic>> scholarshipRequestType= [
    {
      "code":"INT",
      "value":"Scholarships In UAE",
      "valueArabic":"المنح الدراسية في الإمارات العربية المتحدة",
      "description": "انطلاقًـا مـن حـرص وزارة شـؤون الرئاسـة علـى رفـع المسـتوى الأكاديمـي والعلمـي للمواطنيـن، وإعـداد كـوادر وطنيـة مؤهّلـة أكاديميًّـا وعمليًّـا، تلبـّي متطلبـات سـوق العمـل المتطـوّرة والمتغيّـرة فـي الدولـة، وتسـهم فـي دفـع مسـيرة التنميـة الحضاريـة وتنهــض بالوطــن والمجتمــع، تــمّ إطــلاق برنامــج «المنــح الدراســية داخــل الدولــة» ســنة 2000، ولا زال البرنامــج مســتمرًا تحــت إشـراف إدارة البعثـات الداخليـة فـي مكتـب البعثـات الدراسـية التابـع لـوزارة شـؤون الرئاسـة.",
      "image": Constants.scholarshipInUae,
      "seeMore":false
    },
    {
      "code":"EXT",
      "value":"Scholarships Abroad",
      "valueArabic":"المنح الدراسية في الخارج",
      "description": "تسعى بعثة صاحب السمو رئيس الدولة للطلبة المتميزين علميًا إلى إتاحة الفرصة أمام الطلبة المواطنين المتميزين علميًا لاستكمال دراستهم للحصول على درجة البكالوريوس، أو الدراسات العليا في الجامعات العالمية المرموقة، التي يتنافس على الدراسة فيها نخبة الطلبة في جميع أنحاء العالم، وذلك في إطار الحرص على تنمية وتطوير العنصر البشري في دولة الإمارات العربية المتحدة الذي يعدّ عماد التنمية والركيزة التي يُبنى عليها حاضر ومستقبل الدولة",
      "image": Constants.scholarshipInAbroad,
      "seeMore":false


    },
    {
      "code":"DDS",
      "value":"Distinguished Doctor",
      "valueArabic":"المهن الطبية",
      "description": "انطلاقًـا مـن حـرص وزارة شـؤون الرئاسـة علـى رفـع المسـتوى الأكاديمـي والعلمـي للمواطنيـن، وإعـداد كـوادر وطنيـة مؤهّلـة أكاديميًّـا وعمليًّـا، تلبـّي متطلبـات سـوق العمـل المتطـوّرة والمتغيّـرة فـي الدولـة، وتسـهم فـي دفـع مسـيرة التنميـة الحضاريـة وتنهــض بالوطــن والمجتمــع، تــمّ إطــلاق برنامــج «المنــح الدراســية داخــل الدولــة» ســنة 2000، ولا زال البرنامــج مســتمرًا تحــت إشـراف إدارة البعثـات الداخليـة فـي مكتـب البعثـات الدراسـية التابـع لـوزارة شـؤون الرئاسـة.",
      "image": Constants.doctorsScholarship,
      "seeMore":false
    },
  ];


  void toggleSeeMore(int index){
    scholarshipRequestType[index]["seeMore"] = !scholarshipRequestType[index]["seeMore"];
    notifyListeners();
  }

///************************************************************************************

}
