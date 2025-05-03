// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:trex/app/modules/theme/views/theme_view.dart';

// class ThemeController extends GetxController {
//   Rx<ThemeMode> themeMode = ThemeMode.light.obs;

//   ThemeMode get currentTheme => themeMode.value;

//   void toggleTheme() {
//     themeMode.value =
//         themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     Get.changeThemeMode(themeMode.value);
//   }

//   ThemeData getThemeData() {
//     return themeMode.value == ThemeMode.light
//         ? AppTheme.lightTheme
//         : AppTheme.darkTheme;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trex/app/config/config_service.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  final ConfigService configService = Get.find();

  @override
  void onInit() {
    themeMode.value =
        configService.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    super.onInit();
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
      configService.saveTheme(true);
    } else {
      themeMode.value = ThemeMode.light;
      configService.saveTheme(false);
    }
    Get.changeThemeMode(themeMode.value);
  }
}
