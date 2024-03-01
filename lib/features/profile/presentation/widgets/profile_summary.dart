import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/avatar.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/level_indicator.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_actions.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_hint.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({super.key});

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  @override
  void initState() {
    super.initState();
    context.read<PlayerBloc>().add(const GetPlayerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(),
            SizedBox(height: 6),
            ProfileActions(),
            SizedBox(height: AppSize.defaultSpace),
            LevelIndicator(),
            SizedBox(height: 6),
            ProfileHint(),
          ],
        ),
      ),
    );
  }
}
