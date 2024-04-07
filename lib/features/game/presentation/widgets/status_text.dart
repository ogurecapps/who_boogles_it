import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodySmall;

    Widget getStatus(GameState state) {
      return switch (state) {
        PlayerTurnState() => Text(
            '${LocaleKeys.startTurn.tr()} ${state.isMe ? state.me.nickname : state.enemy.nickname}',
            style: textStyle),
        SayAnswerState() || CheckAnswerState() => const LinearProgressIndicator(),
        ProcessAnswerState() => Text(
            state.points != 0 ? LocaleKeys.answerIsCorrect.tr() : LocaleKeys.answerIsWrong.tr(),
            style: textStyle),
        _ => Text(LocaleKeys.round_1.tr(), style: textStyle),
      };
    }

    return BlocBuilder<GameBloc, GameState>(
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
                child: getStatus(state),
              ),
            ),
          ),
        );
      },
    );
  }
}
