class Movie {
  final int id;
  final String title;
  final String posterPath;

  /// This is a bit of a hacky way to get the full image url, real application should use the configuration api
  /// (https://developers.themoviedb.org/3/configuration/get-api-configuration)
  String get posterImageUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['original_title'],
      posterPath: json['poster_path'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Movie) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id;
}
