import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <String, dynamic>{}.obs;
  var hasResults = false.obs;

  Future<void> fetchSearchResults(String query) async {
    isLoading.value = true;
    hasResults.value = false;

    final url =
        'https://www.googleapis.com/books/v1/volumes?q=intitle:${Uri.encodeComponent(query)}&maxResults=40&orderBy=newest';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        searchResults.value = jsonDecode(response.body) as Map<String, dynamic>;
        hasResults.value = true;
      } else {
        searchResults.clear();
      }
    } catch (e) {
      print('Error fetching data: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
