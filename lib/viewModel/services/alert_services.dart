import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import 'navigation_services.dart';

class AlertServices {
  final GetIt _getIt = GetIt.instance;
  late NavigationServices _navigationServices;

  AlertServices() {
    _navigationServices = _getIt.get<NavigationServices>();
  }

  void showToast({required String message, required BuildContext context}) {
    try {
      DelightToastBar(
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return ToastCard(
              leading: const Icon(
                Icons.notifications_active_outlined,
                size: 28,
                color: Colors.black,
              ),
              title: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                color: Colors.white,
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              color: Colors.white,
            );
          }
      ).show(context);
    } catch (error) {
      debugPrint("Something went wrong when showing the toast: $error");
    }
  }


  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white, // Added text color for better visibility
      fontSize: 15,
      toastLength: Toast.LENGTH_SHORT, // Added toast length for consistency
    );
  }
  void flushBarErrorMessages({
    required String message,
    required BuildContext context,
    required LanguageChangeViewModel provider,
  }) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        backgroundColor: Colors.white,
        textDirection: getTextDirection(provider), // Assuming getTextDirection is a function returning TextDirection
        messageColor: Colors.black,
        message: message,
        forwardAnimationCurve: Curves.bounceInOut,
        reverseAnimationCurve: Curves.easeInOutBack,
        duration: const Duration(seconds: 5),
        borderRadius: BorderRadius.circular(15),
        icon: const Icon(
          Icons.notifications_active_outlined,
          size: 28,
          color: Colors.black,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
      )..show(context),
    );
  }

  void showCustomSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Added color for better visibility
          ),
        ),
        behavior: SnackBarBehavior.floating, // Optional: Makes the SnackBar float
        duration: const Duration(seconds: 4), // Optional: Duration of the SnackBar
      ),
    );
  }
}
