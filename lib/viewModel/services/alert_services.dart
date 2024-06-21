import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'navigation_services.dart';

class AlertServices {
  final GetIt _getIt = GetIt.instance;
  late NavigationServices _navigationServices;

  AlertServices() {
    _navigationServices = _getIt.get<NavigationServices>();
  }

  void showToast({required String message}) {
    try {
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
              // title: Container(
              //     padding: EdgeInsets.zero,
              //     margin: EdgeInsets.zero,
              //     alignment: Alignment.center,
              //     ),
              title: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              color: Colors.black87,
            );
          }).show(_navigationServices.navigationStateKey.currentState!.context);
    } catch (error) {
      debugPrint("--------------->>>>>>>Something went wrong when showing the toast");
    }
  }

  toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black, fontSize: 15);
  }

  void flushBarErrorMessages(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
            message: message,
            forwardAnimationCurve: Curves.decelerate,
            reverseAnimationCurve: Curves.easeInOut,
            duration: const Duration(seconds: 5),
            borderRadius: BorderRadius.circular(15),
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 28,
              color: Colors.white,
            ),
            flushbarPosition: FlushbarPosition.TOP,
            margin: const EdgeInsets.symmetric(
              // vertical: MediaQuery.sizeOf(context).width * 0.02,
              // horizontal: MediaQuery.sizeOf(context).width * 0.04),
                vertical: 5,
                horizontal: 5))
          ..show(context));
  }

  snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )));
  }
}
