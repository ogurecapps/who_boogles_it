import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/answer_plate.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/scoreboard.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Set<String> answers = {};

  List<Widget> buildAnswersTable(GameReadyState state) {
    List<Widget> table = [];
    const space = SizedBox(width: 6, height: 6);
    var index = 0;
    var delay = 400;
    const delayStep = 200;
    final round = context.read<GameBloc>().round;

    for (var i = 0; i < 3; i++) {
      // Rows
      List<Widget> widgetsRow = [];
      for (var j = 0; j < 2; j++) {
        // Columns
        widgetsRow.add(
          AnswerPlate(
            number: index + 1,
            text: state.rightAnswers.elementAt(index),
            points: GameBloc.points[round][index],
            startDelay: Duration(milliseconds: delay),
          ),
        );

        answers.add(state.rightAnswers.elementAt(index).toUpperCase());

        if (j == 0) widgetsRow.add(space);

        index++;
        delay += delayStep;
      }
      table.add(space);
      table.add(Row(children: widgetsRow));
    }

    return table;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (previous, current) => current is CheckAnswerState,
      listener: (BuildContext context, GameState state) {
        if (state is CheckAnswerState && !answers.contains(state.answer.toUpperCase())) {
          // Wrong answer
          context.read<GameBloc>().add(const ProcessAnswerEvent(0));
        }
      },
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
              const Align(
                alignment: Alignment.topCenter,
                child: Scoreboard(),
              ).animate().slideY(
                    delay: 400.ms,
                    duration: 400.ms,
                    begin: .1,
                    end: 0,
                    curve: Curves.fastOutSlowIn,
                  )
            ],
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms);
      },
    );
  }
}
