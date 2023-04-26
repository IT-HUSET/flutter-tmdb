import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/favorites/favorites_screen.dart';
import 'package:tmdb/presentation/main/main_scaffold.dart';
import 'package:tmdb/presentation/movies/movie_detail_screen.dart';
import 'package:tmdb/presentation/movies/movies_list_screen.dart';


void main() => runApp(
  AppStateProvider(
      appState: AppState(),
      child: const MovieApp()
  ),
);

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  Map<String, WidgetBuilder> _routes(AppState appState) => {
    'movies': (context) => _withMainScaffold(MoviesListScreen(movieRepository: appState.movieRepository), 0),
    'movies/detail': (context) => _withMainScaffold(const MovieDetailScreen(), 0),
    'favorites': (context) => _withMainScaffold(const FavoritesScreen(), 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'),
          displayMedium: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontFamily: 'PlayfairDisplay'),
          displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Creepster'),
        )
      ),
      initialRoute: 'movies',
      routes: _routes(AppState.of(context)),
    );
  }

  Widget _withMainScaffold(final Widget body, final int index) {
    return MainScaffold(body: body, currentIndex: index);
  }
}
