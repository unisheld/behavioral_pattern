import 'package:behavioral_pattern/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String query);  
}
