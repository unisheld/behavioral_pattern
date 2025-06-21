import 'dart:async';

import 'package:behavioral_pattern/app/logger.dart';
import 'package:behavioral_pattern/domain/entities/movie.dart';
import 'package:behavioral_pattern/presentation/movies/movie_bloc.dart';

class MoviesBlocProxy extends MoviesBloc {
  final MoviesBloc _inner;
  final Logger _logger;
  late final StreamSubscription _subscription;

  MoviesBlocProxy({
    required MoviesBloc inner,
    required Logger logger,
  })  : _inner = inner,
        _logger = logger,
        super(
          remoteDataSource: inner.remoteDataSource,
          localDataSource: inner.localDataSource,
        ) {
    _subscription = _inner.moviesStream.listen((data) {
      _logger.log(' Bloc: Emitting ${data.length} movies');
    });
  }

  @override
  Sink<String> get searchSink => _LoggedSink(
        inner: _inner.searchSink,
        logger: _logger,
      );

  @override
  Stream<List<Movie>> get moviesStream => _inner.moviesStream;

  @override
  void dispose() {
    _logger.log(' Bloc: Disposing');
    _subscription.cancel();
    _inner.dispose();
  }
}

class _LoggedSink implements Sink<String> {
  final Sink<String> inner;
  final Logger logger;

  _LoggedSink({
    required this.inner,
    required this.logger,
  });

  @override
  void add(String data) {
    logger.log('Bloc: searchSink received "$data"');
    inner.add(data);
  }

  @override
  void close() {
    logger.log(' Bloc: searchSink closed');
    inner.close();
  }
}
