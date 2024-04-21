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

  late List<AnimationController> _removeCtrls;
  late List<AnimationController> _addCtrls;

  final List<Duration> _delays = [1500.ms, 1800.ms, 2100.ms];

  @override
  void initState() {
    _removeCtrls = List.generate(3, (_) => AnimationController(vsync: this));
    _addCtrls = List.generate(3, (_) => AnimationController(vsync: this));
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _removeCtrls) {
      controller.dispose();
    }
    for (var controller in _addCtrls) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addHeart(int index) {
      return Stack(
        children: [
          Icon(size: 18, Icons.favorite, color: Theme.of(context).colorScheme.outline),
          const Icon(size: 18, Icons.favorite, color: AppColor.titleColor)
              .animate(controller: _addCtrls[index], delay: _delays[index]) // Adding
              .scaleXY(
                duration: 400.ms,
                curve: Curves.elasticOut,
              )
              .animate(autoPlay: false, controller: _removeCtrls[index]) // Removing
              .slideY(
                duration: 1600.ms,
                curve: Curves.fastOutSlowIn,
                end: -2.2,
              )
              .fadeOut(
                duration: 2000.ms,
                curve: Curves.fastOutSlowIn,
              )
        ],
      );
    }

    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (previous, current) => current is RightAnswerState || current is GetsBonusState,
      listener: (context, state) {
        if (state is RightAnswerState && widget.isMe != state.isMe) {
          // Minus one life point
          _removeCtrls[_lifes - 1].forward().then((value) {
            _lifes--;
            if (_lifes == 0) {
              context.read<GameBloc>().add(DieEvent(widget.isMe, state.isBonus)); // Game over
            } else {
              context.read<GameBloc>().add(NextTurnEvent(widget.isMe, state.isBonus)); // Continue
            }
          });
        } else if (state is GetsBonusState && widget.isMe == state.isMe) {
          if (_lifes < 3) {
            setState(() {
              _delays.map((e) => 0);
            });

            _removeCtrls[_lifes].reset();
            _addCtrls[_lifes].reset();
            _addCtrls[_lifes].forward().then((value) => _lifes++);
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
