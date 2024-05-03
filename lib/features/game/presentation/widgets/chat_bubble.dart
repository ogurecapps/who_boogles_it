import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

enum ContentState { writing, text, dice }

class ChatBubble extends StatefulWidget {
  final bool isMe;

  const ChatBubble({super.key, required this.isMe});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with TickerProviderStateMixin {
  static const int diceStep = 180;
  static const double bubbleWidth = 200;

  ContentState _content = ContentState.text;
  String _text = '';
  late final AnimationController _controller;
  late final AnimationController _rotationController;
  int _dice = 0;
  int _diceResult = 0;
  bool _diceStop = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: diceStep * 6));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is SayAnswerState) {
          if (state.isMe) {
            if (widget.isMe) {
              _controller.forward();
              setState(() {
                _content = ContentState.text;
                _text = state.answer;
              });
            }
          } else {
            if (!widget.isMe) {
              setState(() {
                _content = ContentState.text;
                _text = state.answer;
              });
            }
          }
        } else if (state is PlayerTurnState && state.isMe == widget.isMe) {
          _controller.reverse().then((value) => setState(() {
                _content = ContentState.text;
                _text = '';
              }));
        } else if (state is EnemyWritingState && !widget.isMe) {
          _controller.forward().then((value) => setState(() => _content = ContentState.writing));
        } else if (state is DiceRollState && state.isMe == widget.isMe) {
          _controller.forward().then((value) {
            setState(() {
              _content = ContentState.dice;
              _diceStop = false;
            });

            Timer.periodic(const Duration(milliseconds: diceStep), (timer) {
              if (_diceStop) {
                setState(() => _dice = _diceResult);
                _rotationController.stop();
                _rotationController.reset();
                timer.cancel();
              } else {
                setState(() => _dice = _dice == 5 ? 0 : _dice + 1);
              }
            });

            _rotationController.loop();
          });
        } else if (state is DiceResultState && state.isMe == widget.isMe) {
          setState(() {
            _diceResult = state.result;
            _diceStop = true;
          });
        } else if (state is BubblesResetState) {
          _controller.reverse().then((value) => setState(() {
                _content = ContentState.text;
                _text = '';
              }));
        }
      },
      buildWhen: (previous, current) => current is GameReadyState,
      builder: (context, state) {
        if (state is GameReadyState) {
          final Player player = widget.isMe ? state.me : state.enemy;

          return Bubble(
            color: widget.isMe ? AppColor.bubbleColor : Theme.of(context).colorScheme.onPrimary,
            nip: widget.isMe ? BubbleNip.rightBottom : BubbleNip.leftTop,
            margin: widget.isMe ? const BubbleEdges.only(right: 5) : const BubbleEdges.only(left: 5),
            padding: const BubbleEdges.only(left: AppSize.defaultSpace),
            child: Column(
              children: [
                SizedBox(
                  width: bubbleWidth,
                  child: Text(
                    '${player.nickname}:',
                    style: TextStyle(
                      color: player.getLevelStats().grade,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                IndexedStack(
                  index: _content.index,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: JumpingDots(
                        color: Theme.of(context).primaryColor,
                        radius: 4,
                        innerPadding: 0.6,
                        verticalOffset: 5,
                        animationDuration: 150.ms,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SizedBox(width: bubbleWidth, child: Text(_text, textAlign: TextAlign.left)),
                    ),
                    RotationTransition(
                      turns: _rotationController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: SvgPicture.asset(
                          'assets/images/svg/dice_$_dice.svg',
                          colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
