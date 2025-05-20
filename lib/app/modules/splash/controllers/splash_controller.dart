import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashController extends GetxController {
  var isConnected = false.obs;
  var splashStep = 0.obs; // 0: Image, 1: Loading, 2: No Internet
  var connectionType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    startSplash();
  }

  void startSplash() async {
    splashStep.value = 0;
    await Future.delayed(Duration(seconds: 2));
    splashStep.value = 1;

    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      splashStep.value = 2;
      isConnected.value = false;
    } else {
      isConnected.value = true;
      connectionType.value =
          result == ConnectivityResult.mobile ? 'Mobile Data' : 'Wi-Fi';

      Get.snackbar(
        'Connection Established',
        'You are connected via $connectionType',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

      await Future.delayed(Duration(seconds: 2));
      Get.offAllNamed('/home');
    }
  }
}
