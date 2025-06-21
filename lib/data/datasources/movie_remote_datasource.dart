import 'package:dio/dio.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchMovies(String query);
  Future<MovieModel?> fetchMovieDetails(String imdbID);

 
}

class MovieRestDataSource implements MovieRemoteDataSource {
  final Dio dio;
  final String apiKey;

  MovieRestDataSource({required this.dio, required this.apiKey});

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

    final List results = response.data['Search'] ?? [];
    return results.map((e) => MovieModel.fromJson(e)).toList();
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
    }
    return null;
  }
}
