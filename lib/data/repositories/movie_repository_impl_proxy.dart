import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/domain/entities/movie.dart';
import 'package:behavioral_pattern/domain/repositories/movie_repository.dart';

class MovieRepositoryProxy implements MovieRepository {
  final MovieRepository _inner;
  final Logger _logger;

  MovieRepositoryProxy({
    required MovieRepository inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<List<Movie>> fetchMovies(String query) async {
    _logger.log('Repository: fetchMovies("$query")');
    try {
      final movies = await _inner.fetchMovies(query);
      _logger.log('Repository: fetched ${movies.length} movies');
      return movies;
    } catch (e) {
      _logger.log('Repository: error occurred - $e');
      _logger.log('Attempting to return cached movies');
      rethrow;
    }
  }
}
