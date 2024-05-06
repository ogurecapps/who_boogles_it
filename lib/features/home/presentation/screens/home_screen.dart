import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/home/presentation/widgets/actions_group.dart';
import 'package:who_boogles_it/features/home/presentation/widgets/game_title.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      background: AppTheme.getBackground(),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 50.0),
            child: const GameTitle(),
          ),
          const Center(child: ActionsGroup()),
        ],
      ),
    );
  }
}
