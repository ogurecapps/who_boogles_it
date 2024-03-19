import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/answer_plate.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 128,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: AppTheme.defaultRadius,
                boxShadow: [AppTheme.defaultBoxShadow],
              ),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    SizedBox(height: 6),
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
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [AppTheme.defaultBoxShadow],
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                    border: Border.all(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: AppSize.buttonBorder,
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '000',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
