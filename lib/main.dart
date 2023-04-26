import 'package:flutter/material.dart';

import 'package:tmdb/application/app_state.dart';
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
    'movies': (context) => MoviesListScreen(movieRepository: appState.movieRepository),
    'movies/detail': (context) => const MovieDetailScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
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
}
