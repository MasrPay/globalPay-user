import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  // late ConnectivityResult _connectivityResult;
  // late StreamSubscription<ConnectivityResult> _streamSubscription;
  late StreamSubscription<List<ConnectivityResult>> streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    await _connectivity.checkConnectivity();
    // _streamSubscription =
        // _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    streamSubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
        });
  }
  @override
  void onClose() {
    streamSubscription.cancel();
  }
  Future<void> _initConnectivity() async {
    // _connectivityResult =
    await _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (kDebugMode) print("STATUS : $connectivityResult");

    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  // @override
  // void onClose() {
  //   _streamSubscription.cancel();
  // }
}
