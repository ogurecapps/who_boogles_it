import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/themes/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.go(''),
            icon: const Icon(Icons.cancel),
            label: const Text(LocaleKeys.cancel).tr(),
          ),
        ),
        const SizedBox(width: AppSize.defaultSpace),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.go(''),
            icon: const Icon(Icons.save),
            label: const Text(LocaleKeys.save).tr(),
          ),
        ),
      ],
    );
  }
}
