import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SettingView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'SettingView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
