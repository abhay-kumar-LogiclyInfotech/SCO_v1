import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sco_v1/data/response/ApiResponse.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';
import 'package:sco_v1/repositories/splash_repo/splash_repository.dart';
import 'package:sco_v1/resources/app_urls.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:http/http.dart' as http;

class CommonDataViewModel with ChangeNotifier {


  final SplashRepository myRepo = SplashRepository();
  ApiResponse<CommonDataModel>  apiResponse = ApiResponse.loading();

  setApiResponse(ApiResponse<CommonDataModel> response){
    apiResponse = response;
    notifyListeners();
  }



  void fetchCommonData() async {
    final String basicAuth =  'Basic ${base64Encode(utf8.encode('${Constants.username}:${Constants.password}'))}';
    final headers = <String, String>{'authorization': basicAuth};

    myRepo.fetchCommonData(headers: headers).then((value){

      debugPrint(value.toString());
      Constants.lovCodeMap = {
        for (var response in value.data!.response!)
          response.lovCode!: response
      };
      print("parsing Complete");
      print(Constants.lovCodeMap["GENDER"]!.values);
    }).onError((error,stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

    //
    // if (200 == 200) {
    //   // print('Response data: ${response.body}');
    //
    //   CommonDataModel lovCodeModel = CommonDataModel.fromJson(jsonDecode(response.body));
    //   // print(lovCodeModel);
    //   // print(lovCodeModel.data!.response![0].values![0].code.toString());
    //   // List<Values>? gender = lovCodeModel.data!.response!.firstWhere((element)=>element.lovCode == 'GENDER').values;
    //   // print(gender![0].valueArabic.toString());
    //
    //   // Convert the list to a map for faster lookups
    //   Constants.lovCodeMap = {
    //     for (var response in lovCodeModel.data!.response!)
    //       response.lovCode!: response
    //   };
    //   print("parsing Complete");
    //   print(Constants.lovCodeMap["GENDER"]!.values);
    //
    // } else {
    //   print('Request failed with status: ${response.statusCode}');
    // }
  }
}
