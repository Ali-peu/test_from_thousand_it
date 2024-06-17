
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_from_thousand_it/data/movie_model.dart';
import 'package:test_from_thousand_it/domain/themoviedb_api.dart';

part 'movie_manager_event.dart';
part 'movie_manager_state.dart';

class MovieManagerBloc extends Bloc<MovieManagerEvent, MovieManagerState> {
  MovieManagerBloc({required this.api}) : super(const MovieManagerState()) {
    on<RefreshPage>((event, emit) async {
      emit(state.copyWith(movieList: [], pageStatus: PageStatus.loading));

      final data = await api.refreshPage();
      if (data.isNotEmpty) {
        _currentPage = 2;
        final List<MovieModel> updatedMovieList = List.from(state.movieList);
        updatedMovieList.addAll(data);
        return emit(state.copyWith(
            movieList: updatedMovieList, pageStatus: PageStatus.success));
      } else {

        return emit(state.copyWith(pageStatus: PageStatus.failure));
      }
    });
    on<FetchMovieList>((event, emit) async {
      final data = await api.getMovies(
          page: event.pageNumber == null ? _currentPage : event.pageNumber!);
      if (data.isNotEmpty) {
        final List<MovieModel> updatedMovieList = List.from(state.movieList);
        updatedMovieList.addAll(data);
        _currentPage++;
        emit(state.copyWith(
            movieList: updatedMovieList, pageStatus: PageStatus.success));
      } else {
        emit(state.copyWith(pageStatus: PageStatus.failure));
      }
    });

  }

  int _currentPage = 1;

  final TheMovieDbApi api;
}
