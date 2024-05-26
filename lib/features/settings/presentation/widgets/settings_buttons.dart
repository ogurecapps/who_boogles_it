import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/util/logger.dart';
import 'package:who_boogles_it/features/settings/presentation/widgets/language_selector.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/util/multi_anim_ctrl_state.dart';

class SettingsButtons extends StatefulWidget {
  const SettingsButtons({super.key});

  @override
  MultiAnimCtrlState createState() => _SettingsButtonsState();
}

class _SettingsButtonsState extends MultiAnimCtrlState {
  @override
  void initState() {
    controllers = List.generate(3, (_) => AnimationController(vsync: this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Widget space = SizedBox(height: AppSize.defaultSpace);

    return Expanded(
      child: Center(
        child: SizedBox(
          width: AppSize.menuButtonWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.push('/about'),
                icon: const Icon(Icons.badge),
                label: const Text(LocaleKeys.about).tr(),
              )
                  .animate(
                    controller: controllers[0],
                  )
                  .flip(
                    delay: 200.ms,
                    curve: Curves.fastOutSlowIn,
                  ),
              space,
              ElevatedButton.icon(
                onPressed: onPrivacyPressed,
                icon: const Icon(Icons.lock),
                label: const Text(LocaleKeys.privacy).tr(),
              )
                  .animate(
                    controller: controllers[1],
                  )
                  .flip(
                    delay: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  ),
              space,
              const LanguageSelector()
                  .animate(
                    controller: controllers[2],
                  )
                  .flip(
                    delay: 600.ms,
                    curve: Curves.fastOutSlowIn,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  //@override
  //void didPopNext() {} // No animations play when we close a list of languages
}

Future<void> onPrivacyPressed() async {
  var url = Uri.parse("https://ogurecapps.github.io/privacy-policy");

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    Logger.print('Could not launch $url', level: 'ERROR');
  }
}
