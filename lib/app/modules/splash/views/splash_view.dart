import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Obx(() {
        final step = controller.splashStep.value;

        if (step == 0) {
          return Center(
              child: Image.asset(
            isDark ? 'assets/images/logo-dark.png' : 'assets/images/logo.png',
          ));
        } else if (step == 1) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              size: 45,
              color: Colors.blue,
              secondRingColor: Colors.green,
              thirdRingColor: Colors.orange,
            ),
          );
        } else {
          // step == 2
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/no-connection.png',
                  height: 200,
                ),
              ),
              ElevatedButton(
                onPressed: controller.startSplash,
                child: const Text('Retry'),
              ),
            ],
          );
        }
      }),
    );
  }
}
