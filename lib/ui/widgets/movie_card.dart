import 'package:flutter/material.dart';
import 'package:test_from_thousand_it/app/app_theme.dart';
import 'package:test_from_thousand_it/data/movie_model.dart';
import 'package:test_from_thousand_it/ui/pages/current_movie_page.dart';
import 'package:test_from_thousand_it/ui/widgets/avarage_vote_circle.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({required this.movieModel, super.key});

  final MovieModel movieModel;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  double getNumber(double input, {int precision = 2}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  Container movieBox({required double? movieBoxHeight}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                'http://image.tmdb.org/t/p/w500${widget.movieModel.imageUrl}'),
          ),
          border: Border.all(color: Colors.white, width: 1)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvarageVoteCircle(movieModel: widget.movieModel),
                justCircleWithStar()
              ],
            ),
          ),
          Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.movieModel.name,
                  textAlign: TextAlign.center,
                  style: AppTheme.meduim,
                ),
                Text(widget.movieModel.releaseDate,
                    textAlign: TextAlign.center, style: AppTheme.meduim),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CurrentMoviePage(movieModel: widget.movieModel)));
      },
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: widget.movieModel.imageUrl.isNotEmpty
                        ? Image.network(
                            'http://image.tmdb.org/t/p/w500${widget.movieModel.imageUrl}',
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              return Center(child: child);
                            },
                          )
                        : const SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movieModel.name,
                          textAlign: TextAlign.center,
                          style: AppTheme.meduim,
                        ),
                        Text(
                          'Оценка: ${widget.movieModel.voteAvarage}',
                          maxLines: 6,
                          style: AppTheme.meduim.copyWith(
                              fontWeight: FontWeight.w200, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: movieBox(
              movieBoxHeight: MediaQuery.of(context).size.height * 0.5),
        );
      }),
    );
  }
}
