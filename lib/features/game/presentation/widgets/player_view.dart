import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/scoreboard.dart';

class PlayerView extends StatelessWidget {
  final bool isMe;
  const PlayerView({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) => previous is GameInitialState,
      builder: (context, state) {
        if (state is GameReadyState) {
          return Stack(
            alignment: Alignment.topCenter,
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
              const Padding(
                padding: EdgeInsets.only(top: 55),
                child: Scoreboard(),
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
