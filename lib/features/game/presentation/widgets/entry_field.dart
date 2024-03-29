import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class EntryField extends StatelessWidget {
  const EntryField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.square(48),
                  ),
                  child: const Icon(Icons.home)),
              const SizedBox(width: AppSize.defaultSpace),
              Expanded(
                child: TextFormField(
                  maxLength: 18,
                  onFieldSubmitted: (value) {},
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я]')),
                  ],
                  decoration: InputDecoration(
                    hintText: LocaleKeys.entryHint.tr(),
                    counterText: '',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
