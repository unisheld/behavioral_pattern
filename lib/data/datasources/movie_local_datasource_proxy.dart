import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/data/datasources/movie_local_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';

class MovieLocalDataSourceProxy implements MovieLocalDataSource {
  final MovieLocalDataSource _inner;
  final ConsoleLogger _logger;

  MovieLocalDataSourceProxy({
    required MovieLocalDataSource inner,
    required ConsoleLogger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    _logger.log('Local: cacheMovies (${movies.length} items)');
    await _inner.cacheMovies(movies);
    _logger.log('Local: cacheMovies completed');
  }

  @override
  List<MovieModel> getCachedMovies() {
    _logger.log('Local: getCachedMovies');
    return _inner.getCachedMovies();
  }

  @override
  MovieModel? getMovieById(String id) {
    _logger.log('Local: getMovieById "$id"');
    return _inner.getMovieById(id);
  }
}
