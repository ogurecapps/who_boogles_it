import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/avatar_and_name.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/level_indicator.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/level_title.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_actions.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_hint.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc()..add(const GetPlayerEvent()),
      child: Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LevelTitle()
                  .animate()
                  .slideY(delay: 200.ms, begin: -0.5, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 200.ms),
              const SizedBox(height: 4),
              const AvatarAndName(),
              const SizedBox(height: 4),
              const ProfileActions(),
              const SizedBox(height: AppSize.defaultSpace),
              const LevelIndicator()
                  .animate()
                  .slideX(delay: 800.ms, duration: 400.ms, begin: 0.1, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 800.ms, duration: 400.ms),
              const SizedBox(height: 6),
              const ProfileHint()
                  .animate()
                  .slideX(delay: 1000.ms, duration: 400.ms, begin: 0.1, end: 0, curve: Curves.fastOutSlowIn)
                  .fadeIn(delay: 1000.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
