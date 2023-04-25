import 'package:flutter/material.dart';
import 'package:tmdb/data/model/movie.dart';

class MovieHero extends StatelessWidget {
  const MovieHero({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie.id,
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: movie.posterImageUrl,
      ),
    );
  }
}
