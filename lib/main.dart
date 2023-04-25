import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/favorites/favorites_screen.dart';
import 'package:tmdb/presentation/main/main_scaffold.dart';
import 'package:tmdb/presentation/movies/movie_detail_screen.dart';
import 'package:tmdb/presentation/movies/movies_list_screen.dart';
import 'package:tmdb/presentation/settings/settings_screen.dart';
import 'package:tmdb/presentation/sign_in/sign_in.dart';


void main() => runApp(const MovieApp());

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final _appState = AppState();
  bool _isLoggedIn = false;

  Map<String, WidgetBuilder> get _routes => {
    'sign_in': (context) => const SignInScreen(),
    'movies': (context) => _withMainScaffold(MoviesListScreen(movieRepository: _appState.movieRepository), 0),
    'movies/detail': (context) => _withMainScaffold(const MovieDetail(), 0),
    'favorites': (context) => _withMainScaffold(const FavoritesScreen(), 1),
    'settings': (context) => _withMainScaffold(const SettingsScreen(), 2),
  };

  @override
  void initState() {
    super.initState();
    _appState.addListener(_appStateChanged);
  }

  void _appStateChanged() {
    if (_isLoggedIn != _appState.isLoggedIn) {
      _isLoggedIn = _appState.isLoggedIn;
      _navigatorKey.currentState?.pushReplacementNamed(_isLoggedIn ? 'movies' : 'sign_in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      appState: _appState,
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay'),
            displayMedium: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontFamily: 'PlayfairDisplay'),
            displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Creepster'),
          )
        ),
        navigatorKey: _navigatorKey,
        initialRoute: 'sign_in',
        routes: _routes,
      ),
    );
  }

  Widget _withMainScaffold(final Widget body, final int index) {
    return MainScaffold(body: body, currentIndex: index);
  }
}
