import 'dart:async';

import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:behavioral_pattern/data/datasources/movie_local_datasource.dart';
import 'package:behavioral_pattern/data/datasources/movie_remote_datasource.dart';
import 'package:behavioral_pattern/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  final _searchQueryController = BehaviorSubject<String>();
  final _moviesController = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get moviesStream => _moviesController.stream;
  Sink<String> get searchSink => _searchQueryController.sink;

  MoviesBloc({
    required this.remoteDataSource,
    required this.localDataSource,
  }) {
    _searchQueryController.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen(_searchMovies);
  }

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      final cachedModels = localDataSource.getCachedMovies();
      final cachedMovies = cachedModels.map(_toEntity).toList();
      _moviesController.add(cachedMovies);
      return;
    }

    try {
      final remoteModels = await remoteDataSource.fetchMovies(query);

      await localDataSource.cacheMovies(remoteModels);

      final remoteMovies = remoteModels.map(_toEntity).toList();
      _moviesController.add(remoteMovies);
    } catch (e) {
      final cachedModels = localDataSource.getCachedMovies();
      final cachedMovies = cachedModels.map(_toEntity).toList();
      _moviesController.add(cachedMovies);
    }
  }

  Movie _toEntity(MovieModel model) {
    return Movie(
      imdbID: model.id,
      title: model.title,
      posterUrl: model.posterUrl,
      year: model.year,
    );
  }

  void dispose() {
    _searchQueryController.close();
    _moviesController.close();
  }
}
