import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/answer_plate.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/search_field.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Column(
        children: [
          const SearchField(),
          const SizedBox(height: AppSize.defaultSpace),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [AppTheme.defaultBoxShadow],
              ),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Row(children: [
                      AnswerPlate(number: 1, text: 'text', points: 5),
                      SizedBox(width: 6),
                      AnswerPlate(number: 2, text: 'text', points: 10),
                    ])
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
