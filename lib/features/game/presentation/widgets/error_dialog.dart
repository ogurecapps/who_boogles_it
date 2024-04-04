import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: AppTheme.defaultRadius,
            boxShadow: [AppTheme.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.error,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ).tr(),
                const SizedBox(height: 40),
                SizedBox(
                  width: AppSize.menuButtonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                    label: const Text(LocaleKeys.back).tr(),
                  ).animate().flip(
                        delay: 800.ms,
                        curve: Curves.fastOutSlowIn,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .slideY(
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.1,
          end: 0,
          curve: Curves.fastOutSlowIn,
        )
        .fadeIn(
          delay: 200.ms,
          duration: 600.ms,
        );
  }
}
