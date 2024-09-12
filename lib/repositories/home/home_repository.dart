import 'package:flutter/material.dart';
import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/models/home/HomeSliderModel.dart';

import '../../data/network/NetworkApiServices.dart';
import '../../resources/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

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

  // *------Apply Scholarship section start------*/

  // get all active scholarships
  Future<List<GetAllActiveScholarshipsModel>> getAllActiveScholarships({
    required dynamic headers,
  }) async {
    try {
      // defining list:
      List<GetAllActiveScholarshipsModel> list = [];

      dynamic response = await _dioBaseApiServices.dioGetApiService(
          url: AppUrls.getAllActiveScholarships, headers: headers);

      // converting response to list
      list = (response as List).map((element) {
        return GetAllActiveScholarshipsModel.fromJson(element);
      }).toList();

      // return list of scholarships
      return list;
    } catch (e) {
      throw e;
    }
  }

}
