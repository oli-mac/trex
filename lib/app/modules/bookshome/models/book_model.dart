class Book {
  final String id;
  final String title;
  final String? thumbnail;
  final String? author;
  final String? description;
  final String? language;
  final String? publishDate;
  final int? pageCount;
  final double? rating;

  Book({
    required this.id,
    required this.title,
    this.thumbnail,
    this.author,
    this.description,
    this.language,
    this.publishDate,
    this.pageCount,
    this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    return Book(
      id: json['id'],
      title: volumeInfo['title'] ?? 'No Title',
      thumbnail: volumeInfo['imageLinks']?['thumbnail']
          ?.replaceFirst('http://', 'https://'),
      author:
          (volumeInfo['authors'] != null && volumeInfo['authors'].isNotEmpty)
              ? volumeInfo['authors'][0]
              : 'Unknown',
      description: volumeInfo['description'],
      language: volumeInfo['language'],
      publishDate: volumeInfo['publishedDate'],
      pageCount: volumeInfo['pageCount'],
      rating: (volumeInfo['averageRating'] != null)
          ? double.tryParse(volumeInfo['averageRating'].toString())
          : null,
    );
  }
}
