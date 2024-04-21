import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
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
  Set<String> allAnswers = {};

  List<Widget> buildAnswersTable(GameReadyState state) {
    List<Widget> table = [];
    const space = SizedBox(height: 6);
    var delay = 400;
    const delayStep = 200;
    final round = context.read<GameBloc>().round;

    for (var i = 0; i < 6; i++) {
      var answer = state.rightAnswers.elementAt(i).toLowerCase().split(',').toSet();
      allAnswers.addAll(answer);

      var plate = AnswerPlate(
        number: i + 1,
        answer: answer,
        points: GameBloc.points[round][i],
        startDelay: Duration(milliseconds: delay),
        isBonus: i == 5,
      );

      table.add(space);
      table.add(plate);

      delay += delayStep;
    }

    return table;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (previous, current) => current is CheckAnswerState,
      listener: (BuildContext context, GameState state) {
        if (state is CheckAnswerState && !allAnswers.contains(state.answer.toLowerCase())) {
          context.read<GameBloc>().add(ProcessAnswerEvent(0, state.isMe, false)); // Wrong answer
        }
      },
      buildWhen: (previous, current) => current is GameReadyState,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const [0.5, 0],
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        AppColor.backPalette.$1,
                      ],
                    ),
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
