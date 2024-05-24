import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class UpdateDatabase extends StatelessWidget {
  const UpdateDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: AppTheme.defaultRadius,
            boxShadow: [AppTheme.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Lottie.asset(
                      'assets/anim/update.json',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const Text(
                    LocaleKeys.updateDatabase,
                    textAlign: TextAlign.center,
                  ).tr(),
                ],
              ),
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
