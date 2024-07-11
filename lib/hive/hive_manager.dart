


import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../models/splash/commonData_model.dart';
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
  }




  static bool isDataStored() {
    return Boxes.getCommonDataBox().containsKey('commonData');
  }

  static CommonDataModel? getStoredData() {
    if (isDataStored()) {
      return Boxes.getCommonDataBox().get('commonData');
    }
    return null;
  }

  static void storeData(CommonDataModel data) async {
    await Boxes.getCommonDataBox().put('commonData', data);
    debugPrint('Data stored');
  }

  static void clearData() {
    Boxes.getCommonDataBox().delete('commonData');
    debugPrint('Data cleared');
  }
}