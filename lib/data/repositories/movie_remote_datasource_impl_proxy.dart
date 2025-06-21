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
    _logger.log('RemoteDataSource: fetchMovies called with query="$query"');
    final movies = await _inner.fetchMovies(query);
    _logger.log('RemoteDataSource: fetchMovies returned ${movies.length} movies');
    return movies;
  }

  @override
  Future<MovieModel?> fetchMovieDetails(String imdbID) async {
    _logger.log('RemoteDataSource: fetchMovieDetails called with imdbID="$imdbID"');
    final movie = await _inner.fetchMovieDetails(imdbID);
    if (movie != null) {
      _logger.log('RemoteDataSource: fetchMovieDetails found movie "${movie.title}"');
    } else {
      _logger.log('RemoteDataSource: fetchMovieDetails found no movie');
    }
    return movie;
  }
}
