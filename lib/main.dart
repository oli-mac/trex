// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import 'app/routes/app_pages.dart';

// void main() {
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trex/app/config/connection_service.dart';
import 'package:trex/app/modules/splash/views/components/no_internet_widget.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => ConnectionService().init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ConnectionService connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Obx(() {
              return connectionService.isOnline.value
                  ? const SizedBox.shrink()
                  : NoInternetWidget();
            }),
          ],
        );
      },
    );
  }
}
