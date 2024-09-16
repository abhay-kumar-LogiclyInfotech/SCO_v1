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

import '../../resources/app_colors.dart';
import 'navigation_services.dart';

class AlertServices {
  final GetIt _getIt = GetIt.instance;
  late NavigationServices _navigationServices;

  // Flag to track if a notification is being shown
  bool _isNotificationShowing = false;

  AlertServices() {
    _navigationServices = _getIt.get<NavigationServices>();
  }

  // Function to reset flag
  void _resetNotificationFlag() {
    _isNotificationShowing = false;
  }

// Show DelightToastBar with flag control
  void showToast({required String message, required BuildContext context}) {
    if (!_isNotificationShowing) {
      _isNotificationShowing = true;
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
          },
        ).show(context);

        // Manually reset the flag after a delay (e.g., the expected duration of the toast)
        Future.delayed(const Duration(seconds: 3), () {
          _resetNotificationFlag();
        });
      } catch (error) {
        _resetNotificationFlag();
        debugPrint("Something went wrong when showing the toast: $error");
      }
    }
  }


  // FlutterToast with flag control
  void toastMessage(String message) {
    if (!_isNotificationShowing) {
      _isNotificationShowing = true;
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_SHORT,
      ).then((_) => _resetNotificationFlag()); // Reset flag after dismissal
    }
  }

  // FlushBar notification with flag control
  void flushBarErrorMessages({
    required String message,
    required BuildContext context,
    required LanguageChangeViewModel provider,
  }) {
    if (!_isNotificationShowing) {
      _isNotificationShowing = true;
      showFlushbar(
        context: context,
        flushbar: Flushbar(
          backgroundColor: AppColors.scoButtonColor,
          textDirection: getTextDirection(provider),
          messageColor: Colors.white,
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.decelerate,
          duration: const Duration(seconds: 5),
          borderRadius: BorderRadius.circular(15),
          icon: const Icon(
            Icons.notifications_active_outlined,
            size: 28,
            color: Colors.white,
          ),
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
        )..show(context).then((_) => _resetNotificationFlag()), // Reset flag after dismissal
      );
    }
  }

  // Custom SnackBar with flag control
  void showCustomSnackBar(String message, BuildContext context) {
    if (!_isNotificationShowing) {
      _isNotificationShowing = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      ).closed.then((_) => _resetNotificationFlag()); // Reset flag after dismissal
    }
  }
}
