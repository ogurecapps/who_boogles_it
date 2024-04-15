import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class StatusText extends StatefulWidget {
  const StatusText({super.key});

  @override
  State<StatusText> createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String _text = '';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String getStatusText(GameState state) {
      final GameBloc bloc = context.read<GameBloc>();

      return switch (state) {
        EndRoundState(isSolved: true) =>
          '${state.isMe ? bloc.me.nickname : bloc.enemy.nickname} ${LocaleKeys.solved.tr()}',
        EndRoundState(isSolved: false) =>
          '${state.isMe ? bloc.enemy.nickname : bloc.me.nickname} ${LocaleKeys.lifesOver.tr()}',
        PlayerTurnState() =>
          '${LocaleKeys.startTurn.tr()} ${state.isMe ? bloc.me.nickname : bloc.enemy.nickname}',
        EnemyWritingState() => _text, // Skip status change
        SayAnswerState() || CheckAnswerState() => 'ProgressIndicator',
        ProcessAnswerState() =>
          state.points != 0 ? LocaleKeys.answerIsCorrect.tr() : LocaleKeys.answerIsWrong.tr(),
        SpendLifeState() => LocaleKeys.answerIsWrong.tr(),
        _ => LocaleKeys.round_1.tr(),
      };
    }

    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        var statusText = getStatusText(state);
        if (_text != statusText) {
          _text = statusText;
          _controller.reset();
          _controller.forward();
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: AppTheme.defaultRadius,
              boxShadow: [AppTheme.defaultBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultSpace),
              child: Center(
                child: state is SayAnswerState || state is CheckAnswerState
                    ? const LinearProgressIndicator()
                    : Text(
                        _text,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
              ),
            )
                .animate(
                  autoPlay: false,
                  controller: _controller,
                )
                .slideY(
                  duration: 400.ms,
                  begin: 0.5,
                  end: 0,
                  curve: Curves.fastOutSlowIn,
                )
                .fadeIn(
                  duration: 400.ms,
                ),
          ),
        );
      },
    );
  }
}
