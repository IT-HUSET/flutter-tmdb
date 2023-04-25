import 'package:flutter/material.dart';
import 'package:tmdb/data/repository/movie_repository.dart';
import 'package:tmdb/presentation/favorites/favorites_screen.dart';
import 'package:tmdb/presentation/movies/movie_detail_screen.dart';
import 'package:tmdb/presentation/movies/movies_list_screen.dart';
import 'package:tmdb/presentation/settings/settings_screen.dart';

class AppRouter {
  AppRouter(this._movieRepository);

  final MovieRepository _movieRepository;

  late final Map<String, WidgetBuilder> routes = {
    'movies': (context) => MoviesListScreen(movieRepository: _movieRepository),
    'movies/detail': (context) => const MovieDetail(),
    'favorites': (context) => const FavoritesScreen(),
    'settings': (context) => const SettingsScreen(),
  };
}
