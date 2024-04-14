import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/chat_bubble.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/entry_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/error_dialog.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/game_board.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/player_view.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/search_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/status_text.dart';

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameErrorState) {
          return const ErrorDialog();
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.defaultSpace),
              child: Column(
                children: [
                  const SearchField()
                      .animate()
                      .slideY(
                        delay: 200.ms,
                        duration: 400.ms,
                        begin: -1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 200.ms,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: AppSize.defaultSpace / 2),
                  const GameBoard(),
                  const SizedBox(height: AppSize.defaultSpace / 2),
                  const StatusText()
                      .animate()
                      .slideX(
                        delay: 800.ms,
                        duration: 400.ms,
                        begin: 0.1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 800.ms,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: 25),
                  Row(children: [
                    const PlayerView(isMe: false),
                    const ChatBubble(isMe: false),
                    Expanded(child: Container()),
                  ])
                      .animate()
                      .slideX(
                        delay: 1000.ms,
                        duration: 400.ms,
                        begin: -0.1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 1000.ms,
                        duration: 400.ms,
                      ),
                  Row(children: [
                    Expanded(child: Container()),
                    const ChatBubble(isMe: true),
                    const PlayerView(isMe: true),
                  ])
                      .animate()
                      .slideX(
                        delay: 1000.ms,
                        duration: 400.ms,
                        begin: 0.1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 1000.ms,
                        duration: 400.ms,
                      ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                const EntryField(),
              ],
            ),
          ],
        );
      },
    );
  }
}
