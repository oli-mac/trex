class Serious {
  final int id;
  final String title;
  final String? backDropPath;
  final String overview;
  final String posterPath;

  Serious({
    required this.id,
    required this.title,
    this.backDropPath,
    required this.overview,
    required this.posterPath,
  });

  factory Serious.fromMap(Map<String, dynamic> map) {
    return Serious(
      id: map['id'],
      title: map['original_name'],
      backDropPath: map['backdrop_path'],
      overview: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath,
    };
  }
}
