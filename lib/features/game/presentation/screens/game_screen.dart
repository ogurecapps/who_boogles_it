import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/game_body.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class GameScreen extends StatelessWidget {
  final String langCode;
  const GameScreen({super.key, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc()..add(LoadGameEvent(langCode)),
      child: const ScaffoldWrapper(
        padding: EdgeInsets.zero,
        body: GameBody(),
      ),
    );
  }
}
