import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/data/datasources/movie_remote_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';

class MovieRemoteDataSourceProxy implements MovieRemoteDataSource {
  final MovieRemoteDataSource _inner;
  final Logger _logger;

  MovieRemoteDataSourceProxy({
    required MovieRemoteDataSource inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger;

  @override
  Future<List<MovieModel>> fetchMovies(String query) async {
    _logger.log('📡 fetchMovies: "$query"');
    try {
      final result = await _inner.fetchMovies(query);
      _logger.log('fetchMovies completed with ${result.length} results');
      return result;
    } catch (e) {
      _logger.log('fetchMovies error: $e');
      rethrow;
    }
  }

  @override
  Future<MovieModel?> fetchMovieDetails(String imdbID) async {
    _logger.log('fetchMovieDetails: "$imdbID"');
    try {
      final result = await _inner.fetchMovieDetails(imdbID);
      _logger.log('fetchMovieDetails completed: ${result?.title ?? "null"}');
      return result;
    } catch (e) {
      _logger.log('fetchMovieDetails error: $e');
      rethrow;
    }
  }
}
