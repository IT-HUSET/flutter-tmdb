import 'package:flutter/material.dart';
import 'package:tmdb/data/model/movie.dart';
import 'package:tmdb/data/repository/movie_repository.dart';
import 'package:tmdb/presentation/common_widgets/movie_list.dart';

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
            return MovieList(movies: snapshot.data!);
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
