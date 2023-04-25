import 'dart:convert';

import 'package:tmdb/data/api/movie_db_api.dart';
import 'package:tmdb/data/model/movie.dart';

class MovieRepository {
  MovieRepository(this._api);

  final MovieDBApi _api;

  Future<List<Movie>> fetchMovies() async {
    final String body = await _api.get('/movie/popular');
    return _parseMovies(body);
  }

  // A function that converts a response body into a List<Movie>.
  List<Movie> _parseMovies(String responseBody) {
    final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
    final list = parsed['results'].cast<Map<String, dynamic>>();

    return list.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
