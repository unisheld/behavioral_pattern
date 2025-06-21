import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieLocalDataSource {
  final Box<MovieModel> _box;

  MovieLocalDataSource(this._box);

  Future<void> cacheMovies(List<MovieModel> movies) async {
    await _box.clear();
    for (var movie in movies) {
      await _box.put(movie.id, movie);
    }
  }

  List<MovieModel> getCachedMovies() {
    return _box.values.toList();
  }

  MovieModel? getMovieById(String id) {
    return _box.get(id);
  }
}
