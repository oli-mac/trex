import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/serious_model.dart';

class TvshowsHomeController extends GetxController {
  //TODO: Implement TvshowsHomeController
  final String _apiKey = "d0552fef38b5173dc714b1f0ca51bb32";

  var airingTodaySerious = <Serious>[].obs;
  var popularSerious = <Serious>[].obs;
  var onTheAirSerious = <Serious>[].obs;
  var topRatedSerious = <Serious>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSerious();
  }

  void fetchSerious() async {
    isLoading.value = true;
    try {
      airingTodaySerious.value = await _fetchSerious("airing_today");
      popularSerious.value = await _fetchSerious("popular");
      onTheAirSerious.value = await _fetchSerious("on_the_air");
      topRatedSerious.value = await _fetchSerious("top_rated");
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load movies $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Serious>> _fetchSerious(String category) async {
    final url = "https://api.themoviedb.org/3/tv/$category?api_key=$_apiKey";

    final response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      print("Category: $category");
      for (var item in data) {
        print(item['name']);
        print("Backdrop: ${item['backdrop_path']}");
      }
      return data.map((serious) => Serious.fromMap(serious)).toList();
    } else {
      throw Exception('Failed to load $category serious');
    }
  }
}
