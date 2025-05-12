import 'package:get/get.dart';

import '../controllers/tvshows_detail_controller.dart';

class TvshowsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TvshowsDetailController>(
      () => TvshowsDetailController(),
    );
  }
}
