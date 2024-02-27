import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/settings/presentation/widgets/settings_buttons.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Column(children: [
        const SettingsButtons(),
        SizedBox(
          width: AppSize.menuButtonWidth,
          child: ElevatedButton.icon(
            onPressed: () => context.go(''),
            icon: const Icon(Icons.arrow_back_ios),
            label: const Text(LocaleKeys.back).tr(),
          ),
        ),
      ]),
    );
  }
}
