import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trex/app/modules/BookDetail/views/components/book_loading.dart';

class SearchFilter extends StatelessWidget {
  final Map<String, dynamic> d;
  const SearchFilter({Key? key, required this.d}) : super(key: key);

  String shorten(String text, [int maxLength = 25]) {
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    final List items = d['items'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        leading: BackButton(onPressed: () => Get.back()),
      ),
      body: items.isEmpty
          ? const Center(child: Text('No results found.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index]['volumeInfo'];
                final String title = item['title'] ?? 'No Title';
                final String author =
                    (item['authors'] != null && item['authors'].isNotEmpty)
                        ? item['authors'][0]
                        : 'Unknown Author';
                final String? thumbnail = item['imageLinks']?['thumbnail'];
                final String? bookId = d['items'][index]['id'];

                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: thumbnail != null
                      ? Image.network(thumbnail, width: 50, fit: BoxFit.cover)
                      : const Icon(Icons.book, size: 50),
                  title: Text(shorten(title),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('by ${shorten(author)}'),
                  trailing: IconButton(
                      onPressed: () {
                        if (bookId != null) {
                          Get.to(() => BookLoading(volumeId: bookId));
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded)),
                );
              },
            ),
    );
  }
}
