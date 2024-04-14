import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/scoreboard.dart';

class PlayerView extends StatefulWidget {
  final bool isMe;

  const PlayerView({super.key, required this.isMe});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> with TickerProviderStateMixin {
  int _lifes = 3;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    _controllers = List.generate(3, (_) => AnimationController(vsync: this));
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addHeart(int index) {
      var delay = 1500;

      return Stack(
        children: [
          Icon(size: 18, Icons.favorite, color: Theme.of(context).colorScheme.outline),
          const Icon(size: 18, Icons.favorite, color: AppColor.titleColor)
              .animate() // Showing (auto)
              .scaleXY(
                delay: Duration(milliseconds: delay + index * 300),
                duration: 400.ms,
                curve: Curves.elasticOut,
              )
              .animate(autoPlay: false, controller: _controllers[index]) // Removing (on wrong answer)
              .slideY(
                duration: 2000.ms,
                curve: Curves.fastOutSlowIn,
                end: -2.2,
              )
              .fadeOut(
                duration: 2400.ms,
                curve: Curves.fastOutSlowIn,
              )
        ],
      );
    }

    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (previous, current) => current is ProcessAnswerState,
      listener: (context, state) {
        if (state is ProcessAnswerState && widget.isMe == state.isMe) {
          if (state.points == 0) {
            _controllers[_lifes - 1].forward().then((value) {
              _lifes--;
              if (_lifes == 0) {
                // Game over
              }
            });
          }
        }
      },
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
                  child: widget.isMe ? state.me.avatar : state.enemy.avatar,
                ),
              ),
              Positioned(
                top: 55,
                child: Scoreboard(type: widget.isMe ? ScoreboardType.me : ScoreboardType.enemy),
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
