import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/settings/presentation/widgets/settings_buttons.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';
import 'package:who_boogles_it/shared/presentation/util/single_anim_ctrl_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SingleAnimCtrlState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends SingleAnimCtrlState {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Column(children: [
        const SettingsButtons(),
        SizedBox(
          width: AppSize.menuButtonWidth,
          child: ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
            label: const Text(LocaleKeys.back).tr(),
          )
              .animate(
                controller: controller,
              )
              .flip(
                delay: 800.ms,
                curve: Curves.fastOutSlowIn,
              ),
        ),
      ]),
    );
  }
}
