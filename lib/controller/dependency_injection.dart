import 'package:get/get.dart'; import '../../../../resources/app_urls.dart';

import 'internet_controller.dart';


class DependencyInjection{
  static void init(){
    Get.put<InternetController>(InternetController(),permanent: true);
  }
}