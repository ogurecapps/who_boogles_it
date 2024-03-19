import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/entry_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/game_board.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/search_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/status_text.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              children: [
                SearchField(),
                SizedBox(height: AppSize.defaultSpace / 2),
                GameBoard(),
                SizedBox(height: AppSize.defaultSpace / 2),
                StatusText(),
              ],
            ),
          )),
          EntryField(),
        ],
      ),
    );
  }
}
