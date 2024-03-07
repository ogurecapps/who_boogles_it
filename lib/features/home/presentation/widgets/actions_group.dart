import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class ActionsGroup extends StatelessWidget {
  const ActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ElevatedButton buildNavButton(String path, IconData icon, String key) {
      return ElevatedButton.icon(
        onPressed: () => context.push(path),
        icon: Icon(icon),
        label: Text(key).tr(),
      );
    }

    const Widget space = SizedBox(height: AppSize.defaultSpace);

    return SizedBox(
        width: AppSize.menuButtonWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildNavButton('/game', Icons.pageview, LocaleKeys.start),
            space,
            buildNavButton('/profile', Icons.account_circle, LocaleKeys.profile),
            space,
            buildNavButton('/settings', Icons.settings, LocaleKeys.settings),
            space,
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
    Future.delayed(const Duration(milliseconds: 300), () {
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
