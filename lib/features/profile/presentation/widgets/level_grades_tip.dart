import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelGradesTip extends StatelessWidget {
  const LevelGradesTip({super.key});

  Widget buildListItem(int index) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: Player.grades[index]),
        Text('grade_$index').tr(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocaleKeys.gradesHintTitle).tr(),
      content: SingleChildScrollView(
        child: ListBody(
          children: [for (var i = 0; i < Player.grades.length; i++) buildListItem(i)],
        ),
      ),
    );
  }
}
