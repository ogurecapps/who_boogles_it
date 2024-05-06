import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/profile_summary.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      resizeToAvoidBottomInset: false,
      background: AppTheme.getBackground(),
      body: Column(
        children: [
          const ProfileSummary(),
          SizedBox(
            width: AppSize.menuButtonWidth,
            child: ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
              label: const Text(LocaleKeys.back).tr(),
            ).animate().flip(
                  delay: 1400.ms,
                  curve: Curves.fastOutSlowIn,
                ),
          ),
        ],
      ),
    );
  }
}
