import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/answer_plate.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  List<Widget> buildAnswersTable(GameReadyState state) {
    var round = 0; // Read from state?
    List<Widget> table = [];
    const space = SizedBox(width: 6, height: 6);
    var index = 0;

    for (var i = 0; i < 3; i++) {
      // Rows
      List<Widget> widgetsRow = [];
      for (var j = 0; j < 2; j++) {
        // Columns
        widgetsRow.add(
          AnswerPlate(
              number: index + 1,
              text: state.rightAnswers.elementAt(index),
              points: GameState.points[round][index]),
        );
        if (j == 0) widgetsRow.add(space);
        index++;
      }
      table.add(space);
      table.add(Row(children: widgetsRow));
    }

    return table;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) => current is GameReadyState,
      builder: (context, state) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: state is GameReadyState ? buildAnswersTable(state) : [],
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
                        '0000',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
