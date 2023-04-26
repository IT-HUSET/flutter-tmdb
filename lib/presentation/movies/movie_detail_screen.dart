import 'package:flutter/material.dart';

import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/presentation/common_widgets/movie_hero.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

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
            const Padding(padding: EdgeInsets.all(8))
          ],
        ),
      ),
    );
  }
}
