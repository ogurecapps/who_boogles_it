import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) => previous is GameInitialState,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: AppTheme.defaultRadius,
              boxShadow: [AppTheme.defaultBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 2),
                  state is GameReadyState
                      ? AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '${state.question} ...',
                              speed: 80.ms,
                              cursor: '',
                            ),
                          ],
                        )
                      : const Text(''),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
