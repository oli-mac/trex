import 'package:get/get.dart';

import '../controllers/tvshows_home_controller.dart';

class TvshowsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TvshowsHomeController>(
      () => TvshowsHomeController(),
    );
  }
}
