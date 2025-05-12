import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trex/app/modules/setting/views/components/logout_button.dart';
import 'package:trex/app/modules/setting/views/components/settings_list_tile.dart';
import 'package:trex/app/modules/theme/controllers/theme_controller.dart';
import '../controllers/setting_controller.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.put(SettingController());
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          actions: [
            IconButton(
              icon: Obx(() {
                final isDark = Get.find<ThemeController>().themeMode.value ==
                    ThemeMode.dark;
                return Icon(
                    size: 30, isDark ? Icons.light_mode : Icons.dark_mode);
              }),
              onPressed: () => Get.find<ThemeController>().toggleTheme(),
            )
          ],
        ),
        body: Column(
          children: [
            // Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      SettingsListTile(
                        icon: BoxIcons.bx_user,
                        title: 'Edit Profile',
                        onTap: () {}, // Navigate to profile
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 20,
                      ),
                      SettingsListTile(
                        icon: HeroIcons.lock_closed,
                        title: 'Change Password',
                        onTap: () {},
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 20,
                      ),
                      SettingsListTile(
                        icon: HeroIcons.language,
                        title: 'Language',
                        onTap: () {},
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 20,
                      ),
                      SettingsListTile(
                        icon: BoxIcons.bx_info_circle,
                        title: 'About',
                        onTap: () {},
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 20,
                      ),
                      SettingsListTile(
                        icon: HeroIcons.presentation_chart_line,
                        title: 'Privacy Policy',
                        onTap: () {},
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 20,
                      ),
                      SettingsListTile(
                        icon: BoxIcons.bx_log_out,
                        title: 'Logout',
                        onTap: () {},
                      ),
                      // const SizedBox(height: 40),
                      // const LogoutButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
