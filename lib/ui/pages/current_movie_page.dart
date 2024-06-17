import 'package:flutter/material.dart';
import 'package:test_from_thousand_it/app/app_theme.dart';
import 'package:test_from_thousand_it/data/movie_model.dart';
import 'package:test_from_thousand_it/ui/widgets/avarage_vote_circle.dart';

class CurrentMoviePage extends StatelessWidget {
  final MovieModel movieModel;
  const CurrentMoviePage({super.key, required this.movieModel});
  DecoratedBox whiteBoxForText({required Widget child}) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: child);
  }

  Widget secondaryTextInfo({required String text, required String textValue}) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Text("$text : $textValue",
            style: AppTheme.meduim
                .copyWith(fontSize: 15, fontWeight: FontWeight.w100)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          title: Text(movieModel.name,
              style: AppTheme.meduim.copyWith(color: Colors.white))),
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(children: [
            Stack(
              children: [
                Image.network(
                    'http://image.tmdb.org/t/p/w500${movieModel.imageUrl}'),
                Positioned(
                    right: 0, child: AvarageVoteCircle(movieModel: movieModel)),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      whiteBoxForText(
                          child: Text(movieModel.name,
                              style: AppTheme.meduim
                                  .copyWith(color: Colors.black))),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: whiteBoxForText(
                            child: Text(movieModel.releaseDate,
                                style: AppTheme.meduim
                                    .copyWith(color: Colors.black))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(movieModel.description,
                            maxLines: 20,
                            style: AppTheme.meduim.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w200)),
                      ),
                      secondaryTextInfo(
                          text: 'id', textValue: movieModel.id.toString()),
                      secondaryTextInfo(
                          text: 'Оригинальный язык',
                          textValue: movieModel.originalLanguage),
                      secondaryTextInfo(
                          text: 'Оригинальное название',
                          textValue: movieModel.originalTitle),
                      secondaryTextInfo(
                          text: 'Жанры',
                          textValue: movieModel.genreIDs.toString()),
                      secondaryTextInfo(
                          text: 'Популярность',
                          textValue: movieModel.popularity.toString()),
                      secondaryTextInfo(
                          text: 'Видео',
                          textValue: movieModel.isVideo != null
                              ? movieModel.isVideo! == true
                                  ? 'Да'
                                  : 'Нет'
                              : 'Нет информации'),
                      secondaryTextInfo(
                          text: 'Количества оценок',
                          textValue: movieModel.voteCount.toString()),
                      secondaryTextInfo(
                          text: 'Для взрослых',
                          textValue: movieModel.adult != null
                              ? movieModel.adult! == true
                                  ? 'Да'
                                  : 'Нет'
                              : 'Нет информации'),
                    ]),
              ),
            )
          ]);
        }
        return ListView(
          children: [
            Stack(children: [
              Image.network(
                  'http://image.tmdb.org/t/p/w500${movieModel.imageUrl}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AvarageVoteCircle(movieModel: movieModel),
                  justCircleWithStar()
                ],
              ),
              Positioned(
                bottom: 0,
                // alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      whiteBoxForText(
                          child: Text(movieModel.name,
                              style: AppTheme.meduim
                                  .copyWith(color: Colors.black))),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: whiteBoxForText(
                            child: Text(movieModel.releaseDate,
                                style: AppTheme.meduim
                                    .copyWith(color: Colors.black))),
                      ),
                    ],
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(movieModel.description,
                  style: AppTheme.meduim
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w200)),
            ),
            secondaryTextInfo(text: 'id', textValue: movieModel.id.toString()),
            secondaryTextInfo(
                text: 'Оригинальный язык',
                textValue: movieModel.originalLanguage),
            secondaryTextInfo(
                text: 'Оригинальное название',
                textValue: movieModel.originalTitle),
            secondaryTextInfo(
                text: 'Жанры', textValue: movieModel.genreIDs.toString()),
            secondaryTextInfo(
                text: 'Популярность',
                textValue: movieModel.popularity.toString()),
            secondaryTextInfo(
                text: 'Видео',
                textValue: movieModel.isVideo != null
                    ? movieModel.isVideo! == true
                        ? 'Да'
                        : 'Нет'
                    : 'Нет информации'),
            secondaryTextInfo(
                text: 'Количества оценок',
                textValue: movieModel.voteCount.toString()),
            secondaryTextInfo(
                text: 'Для взрослых',
                textValue: movieModel.adult != null
                    ? movieModel.adult! == true
                        ? 'Да'
                        : 'Нет'
                    : 'Нет информации'),
          ],
        );
      })),
    );
  }
}
