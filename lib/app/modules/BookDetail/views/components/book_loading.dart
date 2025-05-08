import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trex/app/modules/BookDetail/models/book_detail_model.dart';
import 'package:trex/app/modules/BookDetail/views/book_detail_view.dart';

class BookLoading extends StatelessWidget {
  final String volumeId;

  BookLoading({required this.volumeId});

  Future<Map<String, dynamic>> fetchBookDetails(String id) async {
    final url = 'https://www.googleapis.com/books/v1/volumes/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Book not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchBookDetails(volumeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final volumeInfo = snapshot.data!['volumeInfo'];

          final book = BookDetailModel(
            title: volumeInfo['title'] ?? 'No Title',
            author: (volumeInfo['authors'] as List<dynamic>?)?.join(', ') ??
                'Unknown Author',
            description:
                volumeInfo['description'] ?? 'No description available.',
            imageUrl: volumeInfo['imageLinks']?['thumbnail'] ?? '',
            rating: volumeInfo['averageRating']?.toString() ?? 'none',
            pageCount: volumeInfo['pageCount']?.toString() ?? 'none',
            language: volumeInfo['language'] ?? 'none',
            publishDate: volumeInfo['publishedDate'] ?? 'none',
            readLink: snapshot.data!['accessInfo']?['webReaderLink'] ?? '',
            downloadLink: snapshot.data!['accessInfo']?['pdf']?['downloadLink'],
          );

          return BookDetailView(book: book);
        } else {
          final bookData = snapshot.data!;
          final volumeInfo = bookData['volumeInfo'];
          return Scaffold(
            appBar: AppBar(title: Text(volumeInfo['title'] ?? 'No Title')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${volumeInfo['title'] ?? 'N/A'}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                      'Authors: ${volumeInfo['authors']?.join(', ') ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text(
                      'Authors: ${volumeInfo['authors']?.join(', ') ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text(
                      'Description: ${volumeInfo['description'] ?? 'No description available.'}'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
