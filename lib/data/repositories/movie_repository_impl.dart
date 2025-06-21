import 'package:behavioral_pattern/data/datasources/movie_local_datasource.dart';
import 'package:behavioral_pattern/data/datasources/movie_remote_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:behavioral_pattern/domain/entities/movie.dart';
import 'package:behavioral_pattern/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Movie>> fetchMovies(String query) async {
    try {
      final remoteMovies = await remoteDataSource.fetchMovies(query);
      await localDataSource.cacheMovies(remoteMovies);
      return remoteMovies.map((model) => model.toEntity()).toList();
    } catch (e) {
      final cachedModels = localDataSource.getCachedMovies();
      if (cachedModels.isNotEmpty) {
        return cachedModels.map((model) => model.toEntity()).toList();
      }
      rethrow;
    }
  }
}
