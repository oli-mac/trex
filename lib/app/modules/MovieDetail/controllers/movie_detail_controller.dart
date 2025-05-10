// movie_detail_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMDU1MmZlZjM4YjUxNzNkYzcxNGIxZjBjYTUxYmIzMiIsIm5iZiI6MTc0NjQ3NDIyMy40NDYsInN1YiI6IjY4MTkxNGVmMjgxNTI1MDMwMTg0ZDVkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WxL4QZjzxXCQlq974m0H6awOQO5KfaCFSiLWTri4p8o"
      },
    );
    if (response.statusCode == 200) {
      movieDetails.value = json.decode(response.body);
    }
    isLoading.value = false;
  }
}
