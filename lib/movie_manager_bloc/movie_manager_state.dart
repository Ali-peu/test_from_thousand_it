part of 'movie_manager_bloc.dart';

enum PageStatus {initial,loading,success, failure}
class MovieManagerState extends Equatable{

  final PageStatus pageStatus;
  final List<MovieModel> movieList;
  

  const MovieManagerState({
    this.pageStatus = PageStatus.initial,
    this.movieList = const [],
  });

     MovieManagerState copyWith({
     PageStatus? pageStatus,
     List<MovieModel>? movieList,
  }){
    return MovieManagerState(
      pageStatus: pageStatus ?? this.pageStatus,
      movieList:  movieList ?? this.movieList
    );
  }


  @override
  List<Object?> get props => [pageStatus, movieList];
  }
