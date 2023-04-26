import 'package:flutter/material.dart';
import 'package:tmdb/application/app_state.dart';

import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/presentation/common_widgets/movie_hero.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    AppState appState = AppState.of(context);
    final bool isFavorite = appState.isFavorite(movie);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: MovieHero(movie: movie)),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () => appState.toggleFavorite(movie),
            ),
            const Padding(padding: EdgeInsets.all(8))
          ],
        ),
      ),
    );
  }
}
