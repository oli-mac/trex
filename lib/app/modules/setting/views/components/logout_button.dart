import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(BoxIcons.bx_log_out),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(400, 50),
        elevation: 1,
        backgroundColor: Colors.blueAccent.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Get.defaultDialog(
          title: "Log Out",
          middleText: "Are you sure you want to log out?",
          textConfirm: "Yes",
          textCancel: "No",
          confirmTextColor: Colors.white,
          onConfirm: () {
            // Add logout logic
            Get.back();
          },
        );
      },
      label: const Text(
        'Log Out',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
