import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trex/app/modules/BookDetail/models/book_detail_model.dart';

class BookDetailController extends GetxController {
  var isLoading = true.obs;
  var book = Rxn<BookDetailModel>();

  Future<void> fetchBook(String id) async {
    try {
      final url =
          "https://www.googleapis.com/books/v1/volumes?q=isbn:$id&key=AIzaSyCjRQWdXpKp_VTWBrqvDEv6gHmftivMAPw";
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      if (data['items'] != null && data['items'].length > 0) {
        book.value = BookDetailModel.fromJson(data['items'][0]);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load book details.");
    } finally {
      isLoading.value = false;
    }
  }
}
