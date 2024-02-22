import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_boogles_it/app/themes/app_size.dart';
import 'package:who_boogles_it/features/settings/presentation/widgets/language_selector.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({super.key});

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
                onPressed: () {},
                icon: const Icon(Icons.badge),
                label: const Text(LocaleKeys.about).tr(),
              ),
              space,
              ElevatedButton.icon(
                onPressed: onPrivacyPressed,
                icon: const Icon(Icons.lock),
                label: const Text(LocaleKeys.privacy).tr(),
              ),
              space,
              const LanguageSelector(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> onPrivacyPressed() async {
  var url = Uri.parse("https://ogurecapps.github.io/privacy-policy");

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw Exception('Could not launch $url');
  }
}
