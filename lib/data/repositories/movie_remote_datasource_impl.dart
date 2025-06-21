import 'package:behavioral_pattern/data/datasources/movie_remote_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:dio/dio.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;
  final String apiKey;

  MovieRemoteDataSourceImpl({
    required this.dio,
    required this.apiKey,
  });

  @override
  Future<List<MovieModel>> fetchMovies(String query) async {
    final response = await dio.get(
      'https://www.omdbapi.com/',
      queryParameters: {
        'apikey': apiKey,
        's': query,
        'type': 'movie',
      },
    );

    if (response.statusCode == 200 && response.data['Search'] != null) {
      final List results = response.data['Search'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<MovieModel?> fetchMovieDetails(String imdbID) async {
    final response = await dio.get(
      'https://www.omdbapi.com/',
      queryParameters: {
        'apikey': apiKey,
        'i': imdbID,
        'plot': 'short',
      },
    );

    if (response.statusCode == 200 && response.data['Response'] == 'True') {
      return MovieModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
