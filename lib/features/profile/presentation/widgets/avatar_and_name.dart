import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';

class AvatarAndName extends StatelessWidget {
  const AvatarAndName({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle style =
        TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 26, fontWeight: FontWeight.bold);

    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      return Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: AppSize.profileAvatarSize / 2 + AppSize.buttonBorder,
            child: state is PlayerReadyState
                ? state.avatar.animate().shimmer(delay: 600.ms)
                : Icon(
                    Icons.hourglass_top_rounded,
                    size: 70,
                    color: Colors.blueGrey[100],
                  ),
          ).animate().scale(
                delay: 400.ms,
                curve: Curves.fastOutSlowIn,
              ),
          const SizedBox(height: AppSize.defaultSpace),
          SizedBox(
            width: AppSize.profileAvatarSize + 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: state is PlayerReadyState
                    ? Text(state.nickname, textAlign: TextAlign.center, style: style)
                        .animate()
                        .slideY(delay: 200.ms, begin: 0.3, end: 0, curve: Curves.fastOutSlowIn)
                        .fadeIn(delay: 200.ms)
                    : Text('', textAlign: TextAlign.center, style: style),
              ),
            ),
          )
        ],
      );
    });
  }
}
