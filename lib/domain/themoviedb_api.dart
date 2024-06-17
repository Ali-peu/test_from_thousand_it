
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:test_from_thousand_it/data/movie_model.dart';

class TheMovieDbApi {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZTEzNTUyMGY2MGJjYjRiNzMwOGFjYmE2MDgzMjRmOSIsInN1YiI6IjY1MGJjMGVmNTFhNjRlMDBhZTkyMjFmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.u95-yNJpg8-4krnkm4daK8VeBu2VJtC55yAfbyT1fSk',
      'accept': 'application/json',
    },
  ))
    ..interceptors.add(DioCacheInterceptor(
        options: CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    )));

  Future<List<MovieModel>> refreshPage() async {
    const String url =
        'https://api.themoviedb.org/3/movie/popular?language=ru-RU&page=1';

    final List<MovieModel> movies = [];

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 304) {
        final data = response.data['results'];
        for (final item in data) {
          movies.add(MovieModel.fromJson(item));
        }

        return movies;
      }
    } on Exception catch (error) {
      debugPrint('Error on getMovies: ${error.toString()}');
      return movies;
    }
    return movies;
  }

  Future<List<MovieModel>> getMovies({required int page}) async {
    final String url =
        'https://api.themoviedb.org/3/movie/popular?language=ru-RU&page=$page';

    final List<MovieModel> movies = [];

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 304) {
        final data = response.data['results'];
        for (final item in data) {
          movies.add(MovieModel.fromJson(item));
        }
        return movies;
      }
    } on Exception catch (error) {
      debugPrint('Error on getMovies: ${error.toString()}');
      return movies;
    }

    return movies;
  }
}
