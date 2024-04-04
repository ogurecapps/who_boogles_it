import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getStatus(GameState state) {
      final TextStyle? style = Theme.of(context).textTheme.bodySmall;

      return switch (state) {
        PlayerTurnState() => Text('${LocaleKeys.startTurn.tr()} ${state.nickname}', style: style)
            .animate()
            .slideY(
              duration: 400.ms,
              begin: 0.5,
              end: 0,
              curve: Curves.fastOutSlowIn,
            )
            .fadeIn(
              duration: 400.ms,
            ),
        _ => const LinearProgressIndicator(),
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
