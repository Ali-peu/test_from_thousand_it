part of 'movie_manager_bloc.dart';

@immutable
sealed class  MovieManagerEvent  {}


class FetchMovieList extends MovieManagerEvent{
  final int? pageNumber;
  FetchMovieList({this.pageNumber});

}

class RefreshPage extends MovieManagerEvent{

}
