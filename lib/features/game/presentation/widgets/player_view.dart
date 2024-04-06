import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/scoreboard.dart';

class PlayerView extends StatelessWidget {
  final bool isMe;
  const PlayerView({super.key, required this.isMe});

  Widget addHeart(int index) {
    var delay = 1400;
    return const Icon(size: 18, Icons.favorite, color: AppColor.titleColor).animate().scaleXY(
          delay: Duration(milliseconds: delay + index * 300),
          duration: 400.ms,
          curve: Curves.elasticOut,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) => current is GameReadyState,
      builder: (context, state) {
        if (state is GameReadyState) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [AppTheme.defaultBoxShadow],
                ),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  radius: AppSize.gameAvatarSize / 2 + AppSize.buttonBorder,
                  child: isMe ? state.me.avatar : state.enemy.avatar,
                ),
              ),
              const Positioned(
                top: 55,
                child: Scoreboard(),
              )
                  .animate()
                  .slideY(
                    delay: 1000.ms,
                    duration: 400.ms,
                    begin: -0.5,
                    end: 0,
                    curve: Curves.fastOutSlowIn,
                  )
                  .fadeIn(
                    delay: 1000.ms,
                    duration: 400.ms,
                  ),
              Positioned(
                bottom: 55,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(.7),
                    borderRadius: AppTheme.defaultRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    child: Row(children: [for (var i = 0; i < 3; i++) addHeart(i)]),
                  ),
                ),
              )
                  .animate()
                  .slideY(
                    delay: 1000.ms,
                    duration: 400.ms,
                    begin: 0.5,
                    end: 0,
                    curve: Curves.fastOutSlowIn,
                  )
                  .fadeIn(
                    delay: 1000.ms,
                    duration: 400.ms,
                  ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
