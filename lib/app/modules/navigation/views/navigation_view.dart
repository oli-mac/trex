import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:trex/app/modules/navigation/controllers/navigation_controller.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();

    return Obx(() => Scaffold(
          body: child,
          bottomNavigationBar: CurvedNavigationBar(
            key: GlobalKey(),
            index: controller.selectedIndex.value,
            backgroundColor: Colors.transparent,
            items: const [
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.home_outlined,
                    color: Color(0xFF6DE1D2),
                  ),
                  label: 'Home',
                  labelStyle: TextStyle(
                    color: Color(0xFF6DE1D2),
                  )),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.video_collection_outlined,
                    color: Color(0xFF6DE1D2),
                  ),
                  label: 'Movies',
                  labelStyle: TextStyle(
                    color: Color(0xFF6DE1D2),
                  )),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.my_library_books_outlined,
                    color: Color(0xFF6DE1D2),
                  ),
                  label: 'Books',
                  labelStyle: TextStyle(
                    color: Color(0xFF6DE1D2),
                  )),
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF6DE1D2),
                  ),
                  label: 'Settings',
                  labelStyle: TextStyle(
                    color: Color(0xFF6DE1D2),
                  )),
            ],
            onTap: controller.changeTab,
          ),
        ));
  }
}
