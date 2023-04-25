import 'package:flutter/material.dart';

import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/data/repository/movie_repository.dart';
import 'package:tmdb/presentation/common_widgets/movie_hero.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  @override
  State<StatefulWidget> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late Future<List<Movie>> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = widget.movieRepository.fetchMovies();
  }

  void _refresh() {
    setState(() {
      futureMovie = Future.value([]);
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        futureMovie = widget.movieRepository.fetchMovies();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovie,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _MovieList(movies: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _MovieList extends StatelessWidget {
  const _MovieList({required this.movies});

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