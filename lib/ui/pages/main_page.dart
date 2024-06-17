import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_from_thousand_it/movie_manager_bloc/movie_manager_bloc.dart';
import 'package:test_from_thousand_it/ui/widgets/movie_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      context.read<MovieManagerBloc>().add(FetchMovieList());
    }
  }

  Future<void> onRefresh() async {
    context.read<MovieManagerBloc>().add(RefreshPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Популярное'),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieManagerBloc, MovieManagerState>(
        builder: (context, state) {
          return EasyRefresh(
            // showChildOpacityTransition: false,
            onRefresh: () async {
              context.read<MovieManagerBloc>().add(RefreshPage());
            },
            onLoad: () async {
            },
            child: ColoredBox(
              color: Colors.transparent,
              child: BlocBuilder<MovieManagerBloc, MovieManagerState>(
                builder: (context, state) {
                  if (state.pageStatus == PageStatus.success ||
                      state.movieList.isNotEmpty) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index == state.movieList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return MovieCard(movieModel: state.movieList[index]);
                      },
                      itemCount: state.movieList.length + 1,
                    );
                  } else if (state.pageStatus == PageStatus.failure) {
                    return ListView(children: const [
                      Center(
                        child: Text(
                            'Sorry, something gone wrong. Please try again after few minutes'),
                      ),
                    ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
