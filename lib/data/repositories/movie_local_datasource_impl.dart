import 'package:behavioral_pattern/data/datasources/movie_local_datasource.dart';
import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:hive/hive.dart';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final Box<MovieModel> _box;

  MovieLocalDataSourceImpl(this._box);

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    await _box.clear();
    for (var movie in movies) {
      await _box.put(movie.id, movie);
    }
  }

  @override
  List<MovieModel> getCachedMovies() {
    return _box.values.toList();
  }

  @override
  MovieModel? getMovieById(String id) {
    return _box.get(id);
  }
}
