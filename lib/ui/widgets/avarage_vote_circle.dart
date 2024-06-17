import 'package:flutter/material.dart';
import 'package:test_from_thousand_it/app/app_theme.dart';
import 'package:test_from_thousand_it/data/movie_model.dart';

class AvarageVoteCircle extends StatelessWidget {
const AvarageVoteCircle({ super.key, required this.movieModel });
final MovieModel movieModel;

  double getNumber(double input, {int precision = 2}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));


  @override
  Widget build(BuildContext context){
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
            child: Text(
                getNumber(movieModel.voteAvarage, precision: 1).toString(),
                style: AppTheme.meduim.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 20))),
      ),
    );
  }
  }

  Widget justCircleWithStar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Center(
            child: Icon(
          Icons.star,
          color: Colors.yellow,
          size: 25,
        )),
      ),
    );
  }