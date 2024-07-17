import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/resources/app_urls.dart';

import '../../models/authentication/signup_model.dart';

class AuthenticationRepository {

  //*-----Object of Api Services-----*
  final BaseApiServices _apiServices = NetworkApiServices();


  //*-----Signup Method-----*
  Future<SignupModel> signup(
      {required dynamic headers, required dynamic body}) async {

      dynamic response = await _apiServices.getPostApiServices(
          url: "https://stg.sco.ae/o/mopa-sco-api/users/register", headers: headers, body: body);
      return SignupModel.fromJson(response);
  }

  //*-----Login Method-----*


}
