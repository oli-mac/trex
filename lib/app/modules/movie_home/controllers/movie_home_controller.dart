import 'dart:convert';
import 'package:get/get.dart';
import '../model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieHomeController extends GetxController {
  final String _apiKey = "d0552fef38b5173dc714b1f0ca51bb32";

  var upcomingMovies = <Movie>[].obs;
  var popularMovies = <Movie>[].obs;
  var topRatedMovies = <Movie>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    isLoading.value = true;
    try {
      upcomingMovies.value = await _fetchMovies("upcoming");
      popularMovies.value = await _fetchMovies("popular");
      topRatedMovies.value = await _fetchMovies("top_rated");
    } catch (e) {
      Get.snackbar('Error', 'Failed to load movies');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Movie>> _fetchMovies(String category) async {
    final url = "https://api.themoviedb.org/3/movie/$category?api_key=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) => Movie.fromMap(movie)).toList();
    } else {
      throw Exception('Failed to load $category movies');
    }
  }
}
