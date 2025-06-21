import 'package:behavioral_pattern/data/models/movie_model.dart';
import 'package:behavioral_pattern/data/repositories/movie_local_datasource_impl.dart';
import 'package:behavioral_pattern/data/repositories/movie_remote_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:behavioral_pattern/app/logger.dart';

import 'package:behavioral_pattern/data/datasources/movie_local_datasource_proxy.dart';

import 'package:behavioral_pattern/data/datasources/movie_remote_datasource_proxy.dart';

import 'package:behavioral_pattern/data/repositories/movie_repository_impl.dart';
import 'package:behavioral_pattern/data/repositories/movie_repository_impl_proxy.dart';

import 'package:behavioral_pattern/domain/entities/movie.dart';

import 'package:behavioral_pattern/presentation/movies/movie_bloc.dart';
import 'package:behavioral_pattern/presentation/movies/movie_bloc_proxy.dart';

import 'package:behavioral_pattern/presentation/profile/profile_bloc.dart';
import 'package:behavioral_pattern/theme/factory/ui_factory.dart';

class MoviesScreen extends StatefulWidget {
  final ProfileBloc profileBloc;
  final String omdbApiKey;
  final UIFactory factory;

  const MoviesScreen({
    super.key,
    required this.profileBloc,
    required this.omdbApiKey,
    required this.factory,
  });

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesBloc _bloc;
  final _searchController = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initBloc();
  }

  Future<void> _initBloc() async {
    await Hive.initFlutter();
    final Box<MovieModel> box = await Hive.openBox<MovieModel>('moviesBox');
    final logger = ConsoleLogger();

    final localDataSourceImpl = MovieLocalDataSourceImpl(box);
    final localDataSourceProxy = MovieLocalDataSourceProxy(
      inner: localDataSourceImpl,
      logger: logger,
    );

    final remoteDataSourceImpl = MovieRemoteDataSourceImpl(
      dio: Dio(),
      apiKey: widget.omdbApiKey,
    );
    final remoteDataSourceProxy = MovieRemoteDataSourceProxy(
      inner: remoteDataSourceImpl,
      logger: logger,
    );

    final repositoryImpl = MovieRepositoryImpl(
      remoteDataSource: remoteDataSourceProxy,
      localDataSource: localDataSourceProxy,
    );
    final repositoryProxy = MovieRepositoryProxy(
      inner: repositoryImpl,
      logger: logger,
    );

    final baseBloc = MoviesBloc(
      remoteDataSource: remoteDataSourceProxy,
      localDataSource: localDataSourceProxy,
    );

    _bloc = MoviesBlocProxy(
      inner: baseBloc,
      logger: logger,
    );

    _bloc.searchSink.add('');

    setState(() => _initialized = true);
  }

  @override
  void dispose() {
    _bloc.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: widget.factory.createAppBar(title: 'Movies'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search movies',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _bloc.searchSink.add('');
                  },
                ),
              ),
              onChanged: (query) => _bloc.searchSink.add(query),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Movie>>(
                stream: _bloc.moviesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final movies = snapshot.data ?? [];
                  if (movies.isEmpty) {
                    return const Center(child: Text('No movies found'));
                  }
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(movie.title),
                          subtitle: Text(movie.year ?? ''),
                          onTap: () {
                            // TODO: add click processing
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
