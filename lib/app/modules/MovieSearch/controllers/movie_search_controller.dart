import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trex/app/config/constants.dart';

class MovieSearchController extends GetxController {
  var results = [].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var query = ''.obs;

  final scrollController = ScrollController();

  @override
  void onInit() {
    debounce(query, (_) {
      if (query.isNotEmpty) {
        page.value = 1;
        results.clear();
        hasMore.value = true;
        searchMovies();
      }
    }, time: Duration(milliseconds: 600));

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (!isLoading.value && hasMore.value) {
          page.value += 1;
          searchMovies();
        }
      }
    });

    super.onInit();
  }

  Future<void> searchMovies() async {
    if (query.isEmpty) return;

    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/multi?query=${query.value}&include_adult=false&language=en-US&page=${page.value}');

    final headers = {
      'accept': 'application/json',
      'Authorization': kTMDBBearerToken
    };

    isLoading.value = true;
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newResults = data['results'] ?? [];
        if (newResults.length < 20) {
          hasMore.value = false;
        }
        results.addAll(newResults);
      } else {
        hasMore.value = false;
        Get.snackbar("Error", "Status ${response.statusCode}");
      }
    } catch (e) {
      hasMore.value = false;
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
