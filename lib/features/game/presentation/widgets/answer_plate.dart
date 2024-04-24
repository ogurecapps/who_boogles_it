import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';

class AnswerPlate extends StatefulWidget {
  final int number;
  final Set<String> answer; // May contain synonyms
  final int points;
  final Duration startDelay;
  final bool isBonus;

  const AnswerPlate({
    super.key,
    required this.number,
    required this.answer,
    required this.points,
    required this.startDelay,
    required this.isBonus,
  });

  @override
  State<AnswerPlate> createState() => _AnswerPlateState();
}

class _AnswerPlateState extends State<AnswerPlate> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late final AnimationController _controller;
  late Duration _delay;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _delay = widget.startDelay;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void answerIsCorrect(CheckAnswerState state) {
    _controller.reverse().then((value) => setState(() {
          _isOpen = true;
          _delay = 0.ms;
          _controller.forward();
          context.read<GameBloc>().add(ProcessAnswerEvent(widget.points, state.isMe, widget.isBonus));
        }));
  }

  @override
  Widget build(BuildContext context) {
    final Widget closedSide = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.surfaceTint,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: AppSize.buttonBorder,
        ),
      ),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).secondaryHeaderColor,
              width: AppSize.buttonBorder,
            ),
          ),
          child: SizedBox(
            width: 23,
            child: Text(
              widget.number.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );

    final Widget openedSide = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: AppSize.buttonBorder,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                widget.answer.first,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Stack(
              children: [
                Visibility(
                  visible: widget.isBonus,
                  child: const Icon(
                    size: 26,
                    Icons.favorite,
                    color: AppColor.titleColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 6, left: widget.points.toString().length > 1 ? 5 : 9), // Workaround
                  child: Text(
                    widget.points.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) => current is CheckAnswerState || current is OpenAnswerState,
      listener: (context, state) {
        if (state is CheckAnswerState) {
          if (widget.answer.contains(state.answer.toLowerCase())) {
            if (_isOpen) {
              context.read<GameBloc>().add(ProcessAnswerEvent(0, state.isMe, false)); // Wrong answer
            } else {
              answerIsCorrect(state);
            }
          }
        } else if (state is OpenAnswerState) {
          if (widget.answer.contains(state.answer.toLowerCase())) {
            _controller.reverse().then((value) => setState(() {
                  _isOpen = true;
                  _delay = 0.ms;
                  _controller.forward();
                }));
          }
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 27,
        child: IndexedStack(
          index: _isOpen ? 1 : 0,
          children: [closedSide, openedSide],
        ),
      ).animate(delay: _delay, controller: _controller).flip(curve: Curves.fastOutSlowIn),
    );
  }
}
