// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
mixin _$MovieModel {
  @HiveField(0)
  @JsonKey(name: 'imdbID')
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(name: 'Title')
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'Year')
  String? get year => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: 'Poster')
  String? get posterUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
          MovieModel value, $Res Function(MovieModel) then) =
      _$MovieModelCopyWithImpl<$Res, MovieModel>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'imdbID') String id,
      @HiveField(1) @JsonKey(name: 'Title') String title,
      @HiveField(2) @JsonKey(name: 'Year') String? year,
      @HiveField(3) @JsonKey(name: 'Poster') String? posterUrl});
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res, $Val extends MovieModel>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? year = freezed,
    Object? posterUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieModelImplCopyWith<$Res>
    implements $MovieModelCopyWith<$Res> {
  factory _$$MovieModelImplCopyWith(
          _$MovieModelImpl value, $Res Function(_$MovieModelImpl) then) =
      __$$MovieModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'imdbID') String id,
      @HiveField(1) @JsonKey(name: 'Title') String title,
      @HiveField(2) @JsonKey(name: 'Year') String? year,
      @HiveField(3) @JsonKey(name: 'Poster') String? posterUrl});
}

/// @nodoc
class __$$MovieModelImplCopyWithImpl<$Res>
    extends _$MovieModelCopyWithImpl<$Res, _$MovieModelImpl>
    implements _$$MovieModelImplCopyWith<$Res> {
  __$$MovieModelImplCopyWithImpl(
      _$MovieModelImpl _value, $Res Function(_$MovieModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? year = freezed,
    Object? posterUrl = freezed,
  }) {
    return _then(_$MovieModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieModelImpl implements _MovieModel {
  const _$MovieModelImpl(
      {@HiveField(0) @JsonKey(name: 'imdbID') required this.id,
      @HiveField(1) @JsonKey(name: 'Title') required this.title,
      @HiveField(2) @JsonKey(name: 'Year') this.year,
      @HiveField(3) @JsonKey(name: 'Poster') this.posterUrl});

  factory _$MovieModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieModelImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: 'imdbID')
  final String id;
  @override
  @HiveField(1)
  @JsonKey(name: 'Title')
  final String title;
  @override
  @HiveField(2)
  @JsonKey(name: 'Year')
  final String? year;
  @override
  @HiveField(3)
  @JsonKey(name: 'Poster')
  final String? posterUrl;

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, year: $year, posterUrl: $posterUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, year, posterUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      __$$MovieModelImplCopyWithImpl<_$MovieModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieModelImplToJson(
      this,
    );
  }
}

abstract class _MovieModel implements MovieModel {
  const factory _MovieModel(
          {@HiveField(0) @JsonKey(name: 'imdbID') required final String id,
          @HiveField(1) @JsonKey(name: 'Title') required final String title,
          @HiveField(2) @JsonKey(name: 'Year') final String? year,
          @HiveField(3) @JsonKey(name: 'Poster') final String? posterUrl}) =
      _$MovieModelImpl;

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$MovieModelImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: 'imdbID')
  String get id;
  @override
  @HiveField(1)
  @JsonKey(name: 'Title')
  String get title;
  @override
  @HiveField(2)
  @JsonKey(name: 'Year')
  String? get year;
  @override
  @HiveField(3)
  @JsonKey(name: 'Poster')
  String? get posterUrl;
  @override
  @JsonKey(ignore: true)
  _$$MovieModelImplCopyWith<_$MovieModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
