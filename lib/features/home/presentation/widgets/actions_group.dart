import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class ActionsGroup extends StatefulWidget {
  const ActionsGroup({super.key});

  @override
  State<ActionsGroup> createState() => _ActionsGroupState();
}

class _ActionsGroupState extends State<ActionsGroup> with RouteAware, TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locator.get<RouteObserver<ModalRoute>>().subscribe(this, ModalRoute.of(context)!);
    });
    _controllers = List.generate(4, (_) => AnimationController(vsync: this));
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    for (var controller in _controllers) {
      controller.reset();
      controller.forward();
    }
    super.didPopNext();
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
      ).animate(controller: _controllers[controller]).flip(
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
            buildNavButton('/game', Icons.pageview, LocaleKeys.start, 400.ms, 0),
            buildNavButton('/profile', Icons.account_circle, LocaleKeys.profile, 600.ms, 1),
            buildNavButton('/settings', Icons.settings, LocaleKeys.settings, 800.ms, 2),
            Visibility(
              visible: (kIsWeb
                  ? false
                  : Platform.isAndroid || Platform.isLinux || Platform.isMacOS || Platform.isWindows),
              child: ElevatedButton.icon(
                onPressed: onExitPressed,
                icon: const Icon(Icons.cancel),
                label: const Text(LocaleKeys.exit).tr(),
              ),
            ).animate(controller: _controllers[3]).flip(
                  delay: 1000.ms,
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
