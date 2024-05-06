import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class GameOverDialog extends StatelessWidget {
  final String winnerNickname;
  final int myScore;
  final int enemyScore;

  const GameOverDialog({
    super.key,
    required this.winnerNickname,
    required this.myScore,
    required this.enemyScore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: AppTheme.defaultRadius,
            boxShadow: [AppTheme.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Lottie.asset(
                    'assets/anim/${myScore >= enemyScore ? 'win' : 'lose'}.json',
                    width: 220,
                    height: 220,
                  ),
                ).animate().scale(
                      delay: 400.ms,
                      curve: Curves.fastOutSlowIn,
                    ),
                const SizedBox(height: AppSize.defaultSpace),
                Text(
                  myScore > enemyScore
                      ? LocaleKeys.win
                      : myScore < enemyScore
                          ? LocaleKeys.lose
                          : LocaleKeys.draw,
                  style: Theme.of(context).textTheme.titleLarge,
                )
                    .tr()
                    .animate()
                    .slideY(delay: 600.ms, begin: 0.3, end: 0, curve: Curves.fastOutSlowIn)
                    .fadeIn(delay: 600.ms),
                const SizedBox(height: AppSize.defaultSpace),
                Text(
                  myScore == enemyScore
                      ? '${LocaleKeys.gameOverDraw.tr()} $myScore : $enemyScore'
                      : '$winnerNickname ${LocaleKeys.gameOverTitle.tr()} $myScore : $enemyScore',
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .slideX(delay: 800.ms, duration: 400.ms, begin: 0.1, end: 0, curve: Curves.fastOutSlowIn)
                    .fadeIn(delay: 800.ms, duration: 400.ms),
                const SizedBox(height: AppSize.defaultSpace * 2),
                SizedBox(
                  width: AppSize.menuButtonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Future.delayed(300.ms, () => context.read<GameBloc>().add(RematchEvent()));
                    },
                    icon: const Icon(Icons.repeat),
                    label: const Text(LocaleKeys.rematch).tr(),
                  ).animate().flip(
                        delay: 1200.ms,
                        curve: Curves.fastOutSlowIn,
                      ),
                ),
                const SizedBox(height: AppSize.defaultSpace),
                SizedBox(
                  width: AppSize.menuButtonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.logout),
                    label: const Text(LocaleKeys.toMenu).tr(),
                  ).animate().flip(
                        delay: 1400.ms,
                        curve: Curves.fastOutSlowIn,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .slideY(
          duration: 600.ms,
          begin: 0.1,
          end: 0,
          curve: Curves.fastOutSlowIn,
        )
        .fadeIn(duration: 600.ms);
  }
}
