import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/data/datasources/movie_local_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';

class MovieLocalDataSourceProxy implements MovieLocalDataSource {
  final MovieLocalDataSource _inner;
  final Logger _logger;

  MovieLocalDataSourceProxy({
    required MovieLocalDataSource inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    _logger.log('LocalDataSource: cacheMovies called with ${movies.length} movies');
    await _inner.cacheMovies(movies);
    _logger.log('LocalDataSource: cacheMovies completed');
  }

  @override
  List<MovieModel> getCachedMovies() {
    _logger.log('LocalDataSource: getCachedMovies called');
    final movies = _inner.getCachedMovies();
    _logger.log('LocalDataSource: getCachedMovies returned ${movies.length} movies');
    return movies;
  }

  @override
  MovieModel? getMovieById(String id) {
    _logger.log('LocalDataSource: getMovieById called with id="$id"');
    final movie = _inner.getMovieById(id);
    _logger.log(movie != null
        ? 'LocalDataSource: getMovieById found movie "${movie.title}"'
        : 'LocalDataSource: getMovieById did not find movie');
    return movie;
  }
}
