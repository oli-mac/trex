import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.offAllNamed('/movie-home');
        break;
      case 2:
        Get.offAllNamed('/bookshome');
        break;
      case 3:
        Get.offAllNamed('/setting');

        break;
    }
  }
}
