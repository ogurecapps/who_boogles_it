import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/answer_plate.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Row(children: [
                AnswerPlate(number: 1, text: 'девушку', points: 100),
                SizedBox(width: 6),
                AnswerPlate(number: 2, text: 'подругу', points: 80),
              ]),
              SizedBox(height: 6),
              Row(children: [
                AnswerPlate(number: 3, text: 'собаку', points: 40),
                SizedBox(width: 6),
                AnswerPlate(number: 4, text: 'компанию', points: 20),
              ]),
              SizedBox(height: 6),
              Row(children: [
                AnswerPlate(number: 5, text: 'кошку', points: 10),
                SizedBox(width: 6),
                AnswerPlate(number: 6, text: 'песню', points: 5),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
