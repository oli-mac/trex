import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trex/app/modules/bookshome/controllers/search_controller.dart'
    as custom;

import 'package:trex/app/modules/BookDetail/views/components/book_loading.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController searchTextController = TextEditingController();
  final custom.SearchController controller = Get.put(custom.SearchController());

  String shorten(String text, [int maxLength = 25]) {
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Books')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Expanded(
              child: TextField(
                controller: searchTextController,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    controller.fetchSearchResults(value.trim());
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter book title...',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final query = searchTextController.text.trim();
                      if (query.isNotEmpty) {
                        controller.fetchSearchResults(query);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!controller.hasResults.value ||
                  controller.searchResults['items'] == null) {
                return const Center(
                    child: Column(
                  children: [
                    Image(image: AssetImage('assets/images/nobooks.png')),
                    SizedBox(height: 10),
                    Text('No Book results found.'),
                  ],
                ));
              }

              final List items = controller.searchResults['items'];

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index]['volumeInfo'];
                  final String title = item['title'] ?? 'No Title';
                  final String author =
                      (item['authors'] != null && item['authors'].isNotEmpty)
                          ? item['authors'][0]
                          : 'Unknown Author';
                  final String? thumbnail = item['imageLinks']?['thumbnail'];
                  final String? bookId = items[index]['id'];

                  return ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {
                      if (bookId != null) {
                        Get.to(() => BookLoading(volumeId: bookId));
                      }
                    },
                    leading: thumbnail != null
                        ? Image.network(thumbnail, width: 50, fit: BoxFit.cover)
                        : const Icon(Icons.book, size: 50),
                    title: Text(shorten(title),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('by ${shorten(author)}'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
