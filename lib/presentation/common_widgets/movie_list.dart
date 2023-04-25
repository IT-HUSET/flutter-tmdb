import 'package:flutter/material.dart';
import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/presentation/common_widgets/movie_hero.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('movies/detail', arguments: movies[index]),
        child: _item(context, movies[index]),
      ),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _item(BuildContext context, Movie movie) {
    return Row(children: [
      Container(
        width: 80,
        height: 120,
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        alignment: Alignment.center,
        child: MovieHero(movie: movie),
      ),
      Text(
        movie.title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Spacer(),
      const Icon(Icons.chevron_right),
      const Padding(padding: EdgeInsets.only(right: 8)),
    ]);
  }
}
