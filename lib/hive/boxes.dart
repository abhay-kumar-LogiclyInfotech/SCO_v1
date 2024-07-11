import 'package:hive/hive.dart';
import 'package:sco_v1/models/splash/commonData_model.dart';

class Boxes {
  //key must be same as we used in the main function
  static Box<CommonDataModel> getCommonDataBox() => Hive.box<CommonDataModel>('commonDataModelBox');

}