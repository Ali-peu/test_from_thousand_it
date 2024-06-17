import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_from_thousand_it/movie_manager_bloc/movie_manager_bloc.dart';
import 'package:test_from_thousand_it/domain/themoviedb_api.dart';
import 'package:test_from_thousand_it/ui/pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            MovieManagerBloc(api: TheMovieDbApi())..add(FetchMovieList()),
        child: const MainPage(),
      ),
    );
  }
}
