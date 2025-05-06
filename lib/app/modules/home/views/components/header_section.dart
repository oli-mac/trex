import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trex/app/modules/theme/controllers/theme_controller.dart';

class HeaderSection extends StatelessWidget {
  final String username;
  final String greeting;

  const HeaderSection({
    required this.username,
    required this.greeting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello $username! 😊',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(greeting,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          IconButton(
            icon: Obx(() {
              final isDark =
                  Get.find<ThemeController>().themeMode.value == ThemeMode.dark;
              return Icon(
                  size: 30, isDark ? Icons.light_mode : Icons.dark_mode);
            }),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          )
        ],
      ),
    );
  }
}
