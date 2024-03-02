import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NameEditor extends StatelessWidget {
  const NameEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 16, bottom: AppSize.defaultSpace),
        child: Column(children: [
          TextFormField(
            maxLength: 18,
            decoration: InputDecoration(
              labelText: LocaleKeys.nicknameLabel.tr(),
              hintText: LocaleKeys.nicknameHint.tr(),
              border: const OutlineInputBorder(),
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(LocaleKeys.done).tr(),
              onPressed: () => {},
            ),
          )
        ]),
      ),
    );
  }
}
