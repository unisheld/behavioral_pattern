import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:behavioral_pattern/domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
@HiveType(typeId: 1, adapterName: 'MovieModelAdapter')
class MovieModel with _$MovieModel {
  const factory MovieModel({
    @HiveField(0) @JsonKey(name: 'imdbID') required String id,
    @HiveField(1) @JsonKey(name: 'Title') required String title,
    @HiveField(2) @JsonKey(name: 'Year') String? year,
    @HiveField(3) @JsonKey(name: 'Poster') String? posterUrl,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}

extension MovieModelX on MovieModel {
  Movie toEntity() {
    return Movie(
      imdbID: id,
      title: title,
      year: year,
      posterUrl: posterUrl,
    );
  }
}
