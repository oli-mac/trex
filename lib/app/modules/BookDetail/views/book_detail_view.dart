import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';
import 'package:trex/app/modules/BookDetail/models/book_detail_model.dart';

class BookDetailView extends StatelessWidget {
  final BookDetailModel book;
  BookDetailView({required this.book});

  Future openfile(String url, String filename) async {
    final file = await downloadfile(url, filename);
    print("----------------------------------------------------------");
    print(file?.path);
    print("----------------------------------------------------------");

    if (file != null) {
      OpenFile.open(file.path);
    }
  }

  Future<io.File?> downloadfile(String url, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = io.File('${dir.path}/$filename');
      final response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final raf = file.openSync(mode: io.FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header & Book Cover
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.imageUrl),
                      fit: BoxFit.cover,
                      opacity: 0.4,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          Container(
                            height: 230,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(book.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            book.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "by ${book.author}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Detail Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _detailColumn("Rating", book.rating,
                          icon: Icons.star_rate),
                      _detailColumn("Pages", book.pageCount,
                          icon: Icons.library_books_outlined),
                      _detailColumn("Language", book.language,
                          icon: Icons.language),
                      _detailColumn("Publish Date", book.publishDate,
                          icon: Icons.calendar_today),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Description
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What's it about?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Html(data: book.description),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(book.readLink));
                        },
                        style: ElevatedButton.styleFrom(
                            splashFactory: InkSplash.splashFactory),
                        child: Text("READ BOOK"),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (book.downloadLink != null) {
                            await launchUrl(Uri.parse(book.downloadLink!));
                          }
                        },
                        child: Icon(Icons.download_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailColumn(String title, dynamic value, {IconData? icon}) {
    icon ??= Icons.info_outline;
    final displayValue = (value == null || value.toString().trim().isEmpty)
        ? 'Not available'
        : value.toString();
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Color(0xFF6DE1D2),
            ),
            const SizedBox(width: 8),
            Text(
              displayValue,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
