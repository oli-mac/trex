// movie_detail_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trex/app/config/constants.dart';

class MovieDetailController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> movieDetails = <String, dynamic>{}.obs;

  Future<void> fetchMovieDetails(int movieId) async {
    isLoading.value = true;
    final url =
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId?language=en-US");
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": kTMDBBearerToken
      },
    );
    if (response.statusCode == 200) {
      movieDetails.value = json.decode(response.body);
    }
    isLoading.value = false;
  }
}
