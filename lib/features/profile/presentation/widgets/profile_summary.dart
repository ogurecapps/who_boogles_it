import 'package:flutter/material.dart';
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
      child: const Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LevelTitle(),
              SizedBox(height: 4),
              AvatarAndName(),
              SizedBox(height: 4),
              ProfileActions(),
              SizedBox(height: AppSize.defaultSpace),
              LevelIndicator(),
              SizedBox(height: 6),
              ProfileHint(),
            ],
          ),
        ),
      ),
    );
  }
}
