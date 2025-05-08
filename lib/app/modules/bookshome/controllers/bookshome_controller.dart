import 'package:get/get.dart';

// lib/controllers/book_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookshomeController extends GetxController {
  var isLoading = true.obs;
  var thrillerBooks = <Book>[].obs;
  var fantasyBooks = <Book>[].obs;
  var horrorBooks = <Book>[].obs;
  var healthBooks = <Book>[].obs;
  var isSearching = false.obs;
  var searchResults = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  void fetchBooks() async {
    try {
      isLoading(true);
      thrillerBooks.value = await fetchCategory('thriller');
      fantasyBooks.value = await fetchCategory('fantasy');
      horrorBooks.value = await fetchCategory('horror');
      healthBooks.value = await fetchCategory('health');
    } finally {
      isLoading(false);
    }
  }

  void searchBooks(String query) {
    isSearching.value = true;
    final allBooks = [
      ...thrillerBooks,
      ...fantasyBooks,
      ...horrorBooks,
      ...healthBooks,
    ];
    final results = allBooks
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchResults.assignAll(results);
    isSearching.value = false;
  }

  Future<List<Book>> fetchCategory(String category) async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=subject:$category&download=epub&orderBy=newest&key=AIzaSyCjRQWdXpKp_VTWBrqvDEv6gHmftivMAPw';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List<dynamic>;
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load $category books');
    }
  }
}
