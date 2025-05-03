import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  final RxBool isOnline = true.obs;

  Future<ConnectionService> init() async {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final hasConnection =
          results.any((result) => result != ConnectivityResult.none);
      isOnline.value = hasConnection;
    });

    final initialResult = await Connectivity().checkConnectivity();
    isOnline.value = initialResult != ConnectivityResult.none;

    return this;
  }
}
