import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

class ChatBubble extends StatefulWidget {
  final bool isMe;

  const ChatBubble({super.key, required this.isMe});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with SingleTickerProviderStateMixin {
  bool _visible = false;
  String _text = '';
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is PlayerAnswerState && widget.isMe) {
          _controller.forward();
          setState(() {
            _visible = true;
            _text = state.answer;
          });
        }
      },
      buildWhen: (previous, current) => previous is GameInitialState,
      builder: (context, state) {
        if (state is GameReadyState) {
          final Player player = widget.isMe ? state.me : state.enemy;

          return Visibility(
            visible: _visible,
            child: Bubble(
              color: widget.isMe ? AppColor.bubbleColor : Theme.of(context).colorScheme.onPrimary,
              nip: widget.isMe ? BubbleNip.rightBottom : BubbleNip.leftTop,
              margin: widget.isMe ? const BubbleEdges.only(right: 5) : const BubbleEdges.only(left: 5),
              child: Column(
                children: [
                  Text(
                    '${player.nickname}:',
                    style: TextStyle(
                      color: player.getLevelStats().grade,
                      fontSize: 14,
                    ),
                  ),
                  Text(_text),
                ],
              ),
            ),
          )
              .animate(
                autoPlay: false,
                controller: _controller,
              )
              .slideX(
                duration: 400.ms,
                begin: 0.1 * (widget.isMe ? 1 : -1),
                end: 0,
                curve: Curves.fastOutSlowIn,
              )
              .fadeIn(
                duration: 400.ms,
              );
        } else {
          return Container();
        }
      },
    );
  }
}
