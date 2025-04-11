import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  // Variable to hold current connection status
  // set initial true to prevent unnecessary bugs
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      // No network connection available
      isConnected.value = false;
      Get.rawSnackbar(
        messageText: const Text("PLEASE CONNECT TO THE INTERNET", style: TextStyle(color: Colors.white, fontSize: 14)),
        icon: const Icon(Icons.wifi_off,color: Colors.white,),
        isDismissible: false,
        duration:  const Duration(days: 1),
        backgroundColor: Colors.red,
        margin: const EdgeInsets.only(bottom: 80,left: 20,right: 20),
        // margin: EdgeInsets.zero,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 10,
      );
    } else{
      // Network connection available
      isConnected.value = true;
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

}