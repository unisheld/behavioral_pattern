import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') String? year,
    @JsonKey(name: 'imdbID') required String imdbID,
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'Poster') String? posterUrl,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
