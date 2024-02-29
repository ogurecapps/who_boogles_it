import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelProgressIndicator extends StatelessWidget {
  const LevelProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.profileInfoWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(LocaleKeys.levelProgressHint,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  )).tr(),
              const LinearProgressIndicator(
                value: 1 / 2,
              ),
              const Text('1/2',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
