import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      return Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: AppSize.profileAvatarSize / 2 + AppSize.buttonBorder,
            child: state is PlayerReadyState ? state.player.avatar : null,
          ),
          const SizedBox(height: AppSize.defaultSpace),
          SizedBox(
            width: AppSize.profileAvatarSize + 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  state is PlayerReadyState ? state.player.nickname : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
