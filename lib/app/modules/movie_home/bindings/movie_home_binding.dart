import 'package:get/get.dart';

import '../controllers/movie_home_controller.dart';

class MovieHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieHomeController>(
      () => MovieHomeController(),
    );
  }
}
