import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trex/app/modules/home/views/components/bottom_navigation.dart';
import 'package:trex/app/modules/home/views/components/header_section.dart';
import 'package:trex/app/modules/home/views/components/ongoing_projects_grid.dart';
import 'package:trex/app/modules/home/views/components/welcome_banner.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 227, 219, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.rocket_launch),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
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
              // SearchBar(),
              SizedBox(height: 12),
              WelcomeBanner(
                message: "Welcome!\nLet's schedule your projects",
              ),
              OngoingProjectsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
