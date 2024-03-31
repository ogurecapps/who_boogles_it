import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;

  const ChatBubble({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameReadyState) {
          final Player player = isMe ? state.me : state.enemy;

          return Visibility(
            visible: false,
            child: Bubble(
              color: isMe ? AppColor.bubbleColor : Theme.of(context).colorScheme.onPrimary,
              nip: isMe ? BubbleNip.rightBottom : BubbleNip.leftTop,
              margin: isMe ? const BubbleEdges.only(right: 5) : const BubbleEdges.only(left: 5),
              child: Column(
                children: [
                  Text(
                    '${player.nickname}:',
                    style: TextStyle(
                      color: player.getLevelStats().grade,
                      fontSize: 14,
                    ),
                  ),
                  const Text('Hello, World!'),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
