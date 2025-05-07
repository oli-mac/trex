import 'package:get/get.dart';

import '../controllers/bookshome_controller.dart';

class BookshomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookshomeController>(
      () => BookshomeController(),
    );
  }
}
