import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trex/app/modules/home/views/components/header_section.dart';
import 'package:trex/app/modules/home/views/components/welcome_banner.dart';
import 'package:trex/app/modules/home/views/components/bottom_navigation.dart';
import 'package:trex/app/modules/home/views/components/ongoing_projects_grid.dart';
import 'package:trex/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderSection(
                username: 'Bunny',
                greeting: 'Good Morning',
              ),
              SizedBox(height: 8),
              WelcomeBanner(
                message: "Welcome!\nLet T-rex organize your media",
              ),
              OngoingProjectsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
