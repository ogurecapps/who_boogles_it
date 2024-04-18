import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_counter/smooth_counter.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

enum ScoreboardType { round, me, enemy }

class Scoreboard extends StatefulWidget {
  final ScoreboardType type;
  const Scoreboard({super.key, this.type = ScoreboardType.round});

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) => current is ProcessAnswerState || current is EndRoundState,
      listener: (context, state) {
        if (widget.type == ScoreboardType.round && state is ProcessAnswerState && state.points != 0) {
          setState(() => _score += state.points);
        }

        if (state is EndRoundState) {
          if (widget.type == ScoreboardType.me && state.isMe) {
            setState(() => _score = state.roundScore);
          } else if (widget.type == ScoreboardType.enemy && !state.isMe) {
            setState(() => _score = state.roundScore);
          } else if (widget.type == ScoreboardType.round) {
            setState(() => _score = 0);
          }
        }
      },
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
          child: SmoothCounter(
            prefix: "-",
            suffix: "-",
            count: _score,
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
