import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../models/splash/commonData_model.dart';
import '../utils/constants.dart';
import 'boxes.dart';

class HiveManager {
  static Future<void> init() async {
    await Hive.initFlutter();
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(CommonDataModelAdapter());
    Hive.registerAdapter(DataAdapter());
    Hive.registerAdapter(ResponseAdapter());
    Hive.registerAdapter(ValuesAdapter());
    await Hive.openBox<CommonDataModel>('commonDataModelBox');
    await Hive.openBox("userDataBox");
  }

//*--------Common Data Start-------*
  static bool isDataStored() {
    return Boxes.getCommonDataBox().containsKey('commonData');
  }

  static CommonDataModel? getStoredData() {
    if (isDataStored()) {
      return Boxes.getCommonDataBox().get('commonData');
    }
    return null;
  }

  static Future<void> storeData(CommonDataModel data) async {
    await Boxes.getCommonDataBox().put('commonData', data);
    final response = getStoredData();

    if (response?.data?.response != null) {
      Map<String, Response> tempMap = {
        for (var res in response!.data!.response!) res.lovCode!: res
      };
      Constants.lovCodeMap = tempMap;
      debugPrint('Data stored');
    }
  }

  //when we logout clear Data:
  static Future<void> clearData() async{
   await Boxes.getCommonDataBox().delete('commonData');
    debugPrint('Data cleared');
  }

//*--------Common Data End-------*



  //*-------storing the UserID Start--------*
  static Future<void> storeUserId(String userId) async {
    await Boxes.getUserDataBox().put("userID", userId);
  }

  static bool isUserIdStored() {
    return Boxes.getUserDataBox().containsKey('userID');
  }

  static String? getUserId() {
    if (isUserIdStored()) {
      return Boxes.getUserDataBox().get("userID");
    }
    return null;
  }

  //when we logout clear Data:
  static Future<void> clearUserId() async{
    await Boxes.getUserDataBox().delete('userID');
    debugPrint('Data cleared');
  }
//*-------storing the UserID End--------*


  //*-------storing the Emirates Start--------*
  static Future<void> storeEmiratesId(String emiratesId) async {
    await Boxes.getUserDataBox().put("emiratesID", emiratesId);
  }

  static bool isEmiratesIdStored() {
    return Boxes.getUserDataBox().containsKey('emiratesID');
  }

  static String? getEmiratesId() {
    if (isUserIdStored()) {
      return Boxes.getUserDataBox().get("emiratesID");
    }
    return null;
  }

  //when we logout clear Data:
  static Future<void> clearEmiratesId() async{
   await Boxes.getUserDataBox().delete('emiratesID');
    debugPrint('emiratesID Data cleared');
  }
//*-------storing the Emirates End--------*


  //*-------storing the Name Start--------*
  static Future<void> storeName(String name) async {
    await Boxes.getUserDataBox().put("name", name);
  }

  static bool isNameStored() {
    return Boxes.getUserDataBox().containsKey('name');
  }

  static String? getName() {
    if (isUserIdStored()) {
      return Boxes.getUserDataBox().get("name");
    }
    return null;
  }

  //when we logout clear Data:
  static Future<void> clearName() async{
   await  Boxes.getUserDataBox().delete('name');
    debugPrint('Name cleared');
  }
//*-------storing the Name End--------*

  //*-------storing the Roles Start--------*
  static Future<void> storeRole(List<String> name) async {
    await Boxes.getUserDataBox().put("role", name);
  }

  static bool isRoleStored() {
    return Boxes.getUserDataBox().containsKey('role');
  }

  static List<String> getRole() {
    if (isUserIdStored()) {
      return Boxes.getUserDataBox().get("role");
    }
    return [];
  }

  //when we logout clear Data:
  static Future<void> clearRole() async{
    await Boxes.getUserDataBox().delete('role');
    debugPrint('Roles cleared');
  }
//*-------storing the Roles End--------*



}
