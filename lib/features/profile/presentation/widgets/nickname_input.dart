import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class NicknameInput extends StatelessWidget {
  const NicknameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: LocaleKeys.nicknameLabel.tr(),
        hintText: LocaleKeys.nicknameHint.tr(),
        border: const OutlineInputBorder(),
      ),
      initialValue: "Player_0001",
      maxLength: 16,
      onChanged: (value) {},
    );
  }
}
