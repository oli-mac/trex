class BookDetailModel {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String rating;
  final String pageCount;
  final String language;
  final String publishDate;
  final String readLink;
  final String? downloadLink;

  BookDetailModel({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.pageCount,
    required this.language,
    required this.publishDate,
    required this.readLink,
    this.downloadLink,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    final info = json['volumeInfo'];
    final access = json['accessInfo'];
    return BookDetailModel(
      title: info['title'] ?? 'No Title',
      author: (info['authors'] != null && info['authors'].isNotEmpty)
          ? info['authors'][0]
          : 'Unknown',
      description: info['description'] ?? 'No description available',
      imageUrl: info['imageLinks']?['thumbnail'] ??
          'https://github.com/oli-mac/trex/blob/main/assets/images/logo.jpeg',
      rating: (info['averageRating']?.toString()) ?? 'Not available',
      pageCount: (info['pageCount']?.toString()) ?? 'Not available',
      language: (info['language']?.toString().toUpperCase()) ?? 'N/A',
      publishDate: info['publishedDate'] ?? 'Not available',
      readLink: access['webReaderLink'],
      downloadLink: access['epub']?['acsTokenLink'],
    );
  }
}
