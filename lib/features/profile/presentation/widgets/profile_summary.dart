import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/level_progress_indicator.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/player_profile_widget.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_hint.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlayerProfileWidget(),
            SizedBox(height: AppSize.defaultSpace),
            LevelProgressIndicator(),
            SizedBox(height: 6),
            ProfileHint(),
          ],
        ),
      ),
    );
  }
}
