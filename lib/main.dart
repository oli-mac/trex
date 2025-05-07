import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trex/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:trex/app/routes/app_pages.dart';
import 'package:trex/app/config/config_service.dart';
import 'package:trex/app/config/connection_service.dart';
import 'package:trex/app/modules/theme/views/theme_view.dart';
import 'package:trex/app/modules/theme/controllers/theme_controller.dart';
import 'package:trex/app/modules/splash/views/components/no_internet_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => ConnectionService().init());
  Get.put(ThemeController()); // Add Theme Controller
  Get.put(BottomNavController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final ConnectionService connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode.value,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                Obx(() => connectionService.isOnline.value
                    ? const SizedBox.shrink()
                    : NoInternetWidget()),
              ],
            );
          },
        ));
  }
}
