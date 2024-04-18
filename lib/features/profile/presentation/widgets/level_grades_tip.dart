import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelGradesTip extends StatelessWidget {
  const LevelGradesTip({super.key});

  Widget buildListItem(int index) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: AppColor.grades[index]),
        Text('grade_$index').tr(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocaleKeys.gradesHintTitle).tr(),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      content: SingleChildScrollView(
        child: ListBody(
          children: [for (var i = 0; i < AppColor.grades.length; i++) buildListItem(i)],
        ),
      ),
    );
  }
}
