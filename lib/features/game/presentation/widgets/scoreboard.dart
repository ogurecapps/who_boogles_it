import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_counter/smooth_counter.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

enum ScoreboardType { round, me, enemy }

class Scoreboard extends StatefulWidget {
  final ScoreboardType type;
  final int initScore;

  const Scoreboard({
    super.key,
    this.type = ScoreboardType.round,
    this.initScore = 0,
  });

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _score = widget.initScore;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) =>
          current is RightAnswerState || current is EndRoundState || current is FinalRightAnswerState,
      listener: (context, state) {
        if (state is RightAnswerState) {
          if (widget.type == ScoreboardType.round) {
            setState(() => _score += state.points);
          }
        } else if (state is EndRoundState) {
          if (widget.type == ScoreboardType.me && state.isMe) {
            setState(() => _score += state.roundScore);
          } else if (widget.type == ScoreboardType.enemy && !state.isMe) {
            setState(() => _score += state.roundScore);
          } else if (widget.type == ScoreboardType.round) {
            setState(() => _score = 0);
          }
        } else if (state is FinalRightAnswerState) {
          if (widget.type == ScoreboardType.me && state.isMe) {
            setState(() => _score += state.points);
          } else if (widget.type == ScoreboardType.enemy && !state.isMe) {
            setState(() => _score += state.points);
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
