import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeViewModel with ChangeNotifier {
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  LanguageChangeViewModel();

  Future<void> changeLanguage(Locale type) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _appLocale = type;

    if (type == const Locale('en')) {
      /// if the current selected language is  en_US then set the notifier value to false
      setLanguageControllerValue(false);
      await sharedPreferences.setString('language_code', 'en');
    } else {
      /// if the current selected language is  Arabic then set the notifier value to tru
      setLanguageControllerValue(true);
      await sharedPreferences.setString('language_code', 'ar');
    }
    notifyListeners();
  }

 ValueNotifier<bool> _languageController = ValueNotifier<bool>(false);

  setLanguageControllerValue(value){
    _languageController.value = value;
    notifyListeners();
  }
  ValueNotifier<bool> get languageController => _languageController;

}
