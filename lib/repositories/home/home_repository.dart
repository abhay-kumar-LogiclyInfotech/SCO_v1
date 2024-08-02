import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/models/home/HomeSliderModel.dart';

import '../../data/network/NetworkApiServices.dart';
import '../../resources/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  //*------Home Slider Method-------*
  Future<List<HomeSliderModel>> homeSlider({required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
      url: AppUrls.homeSlider,
      headers: headers,
    );

    List<HomeSliderModel> homeSliderItemsList = [];

    for (var item in response) {
      homeSliderItemsList.add(HomeSliderModel.fromJson(item));
    }

    return homeSliderItemsList;
  }
}
