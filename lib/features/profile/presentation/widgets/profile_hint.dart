import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class ProfileHint extends StatelessWidget {
  const ProfileHint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.profileInfoWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            LocaleKeys.avatarHint,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall,
          ).tr(),
        ),
      ),
    );
  }
}
