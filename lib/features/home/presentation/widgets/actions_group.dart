import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class ActionsGroup extends StatelessWidget {
  const ActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildNavButton(String path, IconData icon, String key) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSize.defaultSpace),
        child: ElevatedButton.icon(
          onPressed: () => context.push(path),
          icon: Icon(icon),
          label: Text(key).tr(),
        ),
      );
    }

    return SizedBox(
        width: AppSize.menuButtonWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildNavButton('/game', Icons.pageview, LocaleKeys.start),
            buildNavButton('/profile', Icons.account_circle, LocaleKeys.profile),
            buildNavButton('/settings', Icons.settings, LocaleKeys.settings),
            Visibility(
              visible: (kIsWeb
                  ? false
                  : Platform.isAndroid || Platform.isLinux || Platform.isMacOS || Platform.isWindows),
              child: ElevatedButton.icon(
                onPressed: onExitPressed,
                icon: const Icon(Icons.cancel),
                label: const Text(LocaleKeys.exit).tr(),
              ),
            ),
          ],
        ));
  }

  void onExitPressed() {
    Future.delayed(300.ms, () {
      if (!kIsWeb) {
        if (Platform.isAndroid) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else {
          exit(0);
        }
      }
    });
  }
}
