import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/util/multi_anim_ctrl_state.dart';

class ActionsGroup extends StatefulWidget {
  const ActionsGroup({super.key});

  @override
  MultiAnimCtrlState createState() => _ActionsGroupState();
}

class _ActionsGroupState extends MultiAnimCtrlState {
  @override
  void initState() {
    controllers = List.generate(4, (_) => AnimationController(vsync: this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildNavButton(String path, IconData icon, String key, Duration delay, int controller) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSize.defaultSpace),
        child: ElevatedButton.icon(
          onPressed: () => context.push(path),
          icon: Icon(icon),
          label: Text(key).tr(),
        ),
      )
          .animate(
            controller: controllers[controller],
          )
          .flip(
            delay: delay,
            curve: Curves.fastOutSlowIn,
          );
    }

    return SizedBox(
        width: AppSize.menuButtonWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildNavButton('/game', Icons.pageview, LocaleKeys.start, 200.ms, 0),
            buildNavButton('/profile', Icons.account_circle, LocaleKeys.profile, 400.ms, 1),
            buildNavButton('/settings', Icons.settings, LocaleKeys.settings, 600.ms, 2),
            Visibility(
              visible: (kIsWeb
                  ? false
                  : Platform.isAndroid || Platform.isLinux || Platform.isMacOS || Platform.isWindows),
              child: ElevatedButton.icon(
                onPressed: onExitPressed,
                icon: const Icon(Icons.cancel),
                label: const Text(LocaleKeys.exit).tr(),
              ),
            )
                .animate(
                  controller: controllers[3],
                )
                .flip(
                  delay: 800.ms,
                  curve: Curves.fastOutSlowIn,
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
