import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';
import 'package:tmdb/presentation/common_widgets/movie_list.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: appState.favoriteCount > 0
          ? MovieList(movies: appState.favorites)
          : const Center(child: Text('No favorites yet!')),
    );
  }
}
