import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trex/app/config/constants.dart';

class TvshowsDetailController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> seriousDetails = <String, dynamic>{}.obs;
  var selectedSeason = "".obs;

  /// Fetches details of a TV show with the given ID.
  ///
  /// This function fetches the details of a TV show using the
  /// [TheMovieDB API](https://developers.themoviedb.org/3/getting-started/introduction).
  /// The result is stored in the [seriousDetails] field.
  ///
  /// The function returns a [Future] that completes when the request is
  /// finished. The [isLoading] field is set to true while the request is
  /// in progress, and false when the request is finished.
  Future<void> fetchTvShowDetails(int tvId) async {
    isLoading.value = true;
    final url =
        Uri.parse("https://api.themoviedb.org/3/tv/$tvId?language=en-US");
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": kTMDBBearerToken
      },
    );
    if (response.statusCode == 200) {
      seriousDetails.value = json.decode(response.body);
    }
    isLoading.value = false;
  }

  @override

  /// Called when the controller is about to be destroyed.
  ///
  /// This is useful for cleaning up any resources that the controller
  /// allocated. For example, if the controller allocated a stream,
  /// this is a good place to close the stream.
  ///
  /// This function is guaranteed to be called after the widget's dispose
  /// method has been called, and before the controller is removed from
  /// memory.
  ///
  /// The default implementation does nothing.
  void onClose() {
    selectedSeason.value = "";
    super.onClose();
  }
}
