import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:tmdb/data/api/movie_db_api.dart';
import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/data/repository/movie_repository.dart';

/// InheritedWidget class that provides the [AppState] to its descendants, and rebuilds them when the [AppState] changes.
class AppStateProvider extends InheritedNotifier {
  const AppStateProvider({
    Key? key,
    required this.appState,
    required Widget child,
  }) : super(key: key, notifier: appState, child: child);

  final AppState appState;

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) => appState != oldWidget.appState;
}

/// The main state object of the app, functioning as a single single store and shared source of truth.
class AppState extends ChangeNotifier {
  final MovieRepository movieRepository = MovieRepository(MovieDBApi());

  final List<Movie> _favorites = <Movie>[];
  List<Movie> get favorites => UnmodifiableListView(_favorites); // Only expose an unmodifiable view of the list

  int get favoriteCount => _favorites.length;
  bool isFavorite(Movie movie) => _favorites.contains(movie);
  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>()!.appState;
  }
}
