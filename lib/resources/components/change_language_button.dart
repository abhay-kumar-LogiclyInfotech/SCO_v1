import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModel/language_change_ViewModel.dart';
import '../app_colors.dart';
import 'custom_advanced_switch.dart';

class ChangeLanguageButton extends StatefulWidget {
   ChangeLanguageButton({super.key});

  @override
  State<ChangeLanguageButton> createState() => _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends State<ChangeLanguageButton> with MediaQueryMixin {

  bool _isArabic = false;
  final _languageController = ValueNotifier<bool>(false);
  bool _isLoading = false;
  setIsLoading(isLoading){
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> getInitialLanguage() async {

    setIsLoading(true);

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? language = preferences.getString('language_code');

    if (language != null && language == 'ar') {
      _isArabic = true;
      _languageController.value = true;
    } else {
      _isArabic = false;
      _languageController.value = false;
    }
    setState(() {
      _isLoading = false; // Set loading to false after initialization
    });
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)async {
     await getInitialLanguage();
    });    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return  Utils.modelProgressHud(processing: _isLoading,child:  Positioned(
      left: kPadding,
      child: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("English"),
            const SizedBox(
              width: 10,
            ),

            Consumer<LanguageChangeViewModel>(
              builder: (context,provider,_){
                return CustomAdvancedSwitch(
                  controller: _languageController,
                  activeColor: AppColors.scoThemeColor,
                  inactiveColor: Colors.grey,
                  initialValue: _isArabic,
                  onChanged: (value) async{
                    if (value) {
                      Provider.of<LanguageChangeViewModel>(context, listen: false).changeLanguage(const Locale('ar'));
                      await getInitialLanguage();
                      setState(() {
                      });
                    } else {
                      Provider.of<LanguageChangeViewModel>(context, listen: false).changeLanguage(const Locale('en'));
                      await getInitialLanguage();
                      setState(() {
                      });
                    }
                  },
                );
              },
            )
            ,
            const SizedBox(width: 10
            ),
            const Directionality(textDirection: TextDirection.rtl, child: Text("عربي")),
          ],
        ),
      ),
    ));

  }
}
