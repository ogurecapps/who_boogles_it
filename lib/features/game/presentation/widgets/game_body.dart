import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/chat_bubble.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/enemy_search.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/entry_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/error_dialog.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/game_board.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/next_round_dialog.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/player_view.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/search_field.dart';
import 'package:who_boogles_it/features/game/presentation/widgets/status_text.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (previous, current) => current is RoundTipState || current is NextRoundDialogState,
      listener: (context, state) {
        if (state is RoundTipState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (innerContext) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                scrollable: true,
                title: Text('round_${state.round}'.tr()),
                content: Text('descRound_${state.round}'.tr()),
                actions: [
                  SizedBox(
                    width: AppSize.menuButtonWidth,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<GameBloc>().add(DiceRollEvent());
                        context.pop();
                      },
                      icon: const Icon(Icons.check_box),
                      label: const Text(LocaleKeys.gotIt).tr(),
                    ).animate().flip(
                          delay: 400.ms,
                          curve: Curves.fastOutSlowIn,
                        ),
                  ),
                ],
              );
            },
          );
        } else if (state is NextRoundDialogState) {
          showModalBottomSheet(
              enableDrag: false,
              isDismissible: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              context: context,
              builder: (innerContext) {
                return BlocProvider.value(
                  value: BlocProvider.of<GameBloc>(context),
                  child: NextRoundDialog(winnerIsMe: state.isWinnerMe, players: state.players),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is EnemySearchStartState) {
          return EnemySearch(enemy: state.enemy);
        } else if (state is GameErrorState) {
          return const ErrorDialog();
        } else if (state is GameInitialState) {
          return Container(); // Destroy widgets
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
                        duration: 400.ms,
                        begin: -1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        duration: 400.ms,
                      ),
                  const SizedBox(height: AppSize.defaultSpace / 2),
                  const GameBoard(),
                  const SizedBox(height: AppSize.defaultSpace / 2),
                  const StatusText()
                      .animate()
                      .slideX(
                        delay: 600.ms,
                        duration: 400.ms,
                        begin: 0.1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 600.ms,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: AppSize.defaultSpace),
                  Row(children: [
                    const PlayerView(isMe: false),
                    const ChatBubble(isMe: false),
                    Expanded(child: Container()),
                  ])
                      .animate()
                      .slideX(
                        delay: 800.ms,
                        duration: 400.ms,
                        begin: -0.1,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        delay: 800.ms,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: AppSize.defaultSpace),
                  Row(children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      child: const ChatBubble(isMe: true),
                      onTap: () {
                        if (state is DiceRollState && state.isMe) {
                          context.read<GameBloc>().add(DiceStopEvent());
                        }
                      },
                    ),
                    const PlayerView(isMe: true),
                  ])
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
