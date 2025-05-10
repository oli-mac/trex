import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/bookshome_controller.dart';
import 'package:trex/app/modules/bookshome/models/book_model.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';
import 'package:trex/app/modules/bookshome/views/components/search_page.dart';
import 'package:trex/app/modules/BookDetail/views/components/book_loading.dart';

class BookshomeView extends GetView<BookshomeController> {
  BookshomeView({super.key});
  final BookshomeController controller = Get.put(BookshomeController());

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Spot"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => SearchPage());
              },
              icon: const Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: [
                CategorySection(
                    title: 'Thriller', categoryBooks: controller.thrillerBooks),
                CategorySection(
                    title: 'Fantasy', categoryBooks: controller.fantasyBooks),
                CategorySection(
                    title: 'Horror', categoryBooks: controller.horrorBooks),
                CategorySection(
                    title: 'Fiction', categoryBooks: controller.fictionBooks),
                CategorySection(
                    title: 'Health', categoryBooks: controller.healthBooks),
              ],
            );
          }
        }),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Book> categoryBooks;

  CategorySection({required this.title, required this.categoryBooks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryBooks.length,
            itemBuilder: (context, index) {
              final book = categoryBooks[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => BookLoading(volumeId: book.id));
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(book.thumbnail ?? ''),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Book ID: ${book.id}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
