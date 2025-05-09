import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../utils/utils.dart';
import '../language_change_ViewModel.dart';
import 'navigation_services.dart';

class AlertServices {
  late NavigationServices _navigationServices;

  AlertServices() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
  }
/// --------------------------------------------------------------------------------------------------------------------------------
  // Show DelightToastBar
  void showToast({required String message}) {
    dynamic myContext = _navigationServices.navigationStateKey.currentContext;

    DelightToastBar(
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return ToastCard(
          leading: const Icon(
            Icons.notifications_active_outlined,
            size: 28,
            color: Colors.white,
          ),
          title: Text(
            textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(myContext,listen: false)),
            message,
            style: const TextStyle(color: Colors.white),
          ),
          color: AppColors.scoButtonColor,
        );
      },
    ).show(myContext);
  }

  // FlushBar notification
  void flushBarErrorMessages({
    required String message,
    LanguageChangeViewModel? provider,
  }) {
    dynamic myContext = _navigationServices.navigationStateKey.currentContext;

    showFlushbar(
      context: myContext,
      flushbar: Flushbar(
        backgroundColor: AppColors.scoButtonColor,
        messageColor: Colors.white,
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(15),
        textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(myContext,listen: false)),
        icon: const Icon(
          Icons.notifications_active_outlined,
          size: 28,
          color: Colors.white,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      ),
    );
  }

  //// The above messages are not perfect with context changes
  ///--------------------------------------------------------------------------------------------------------------------------------

  // FlutterToast
  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.scoThemeColor,
      textColor: Colors.white,
      fontSize: 15,
      toastLength: Toast.LENGTH_LONG,
    );
  }


  // Custom SnackBar
  void showCustomSnackBar(String message) {
    dynamic myContext = _navigationServices.navigationStateKey.currentContext;

    ScaffoldMessenger.of(myContext).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(myContext,listen: false)),
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Custom error SnackBar
  void showErrorSnackBar(String message) {
    dynamic myContext = _navigationServices.navigationStateKey.currentContext;
    ScaffoldMessenger.of(myContext).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          textDirection: getTextDirection(Provider.of<LanguageChangeViewModel>(myContext,listen: false)),
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
