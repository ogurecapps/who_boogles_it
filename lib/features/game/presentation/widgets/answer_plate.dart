import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AnswerPlate extends StatefulWidget {
  final int number;
  final String text;
  final int points;
  final Duration startDelay;

  const AnswerPlate({
    super.key,
    required this.number,
    required this.text,
    required this.points,
    required this.startDelay,
  });

  @override
  State<AnswerPlate> createState() => _AnswerPlateState();
}

class _AnswerPlateState extends State<AnswerPlate> {
  late bool isOpen;

  @override
  void initState() {
    isOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BorderSide side = BorderSide(color: Theme.of(context).primaryColor, width: AppSize.buttonBorder);

    final Widget closedSide = Center(
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
    );

    final Widget openedSide = Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border(left: side, top: side, bottom: side),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              widget.points.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );

    return Expanded(
      child: DecoratedBox(
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
        child: isOpen ? openedSide : closedSide,
      ),
    ).animate().flip(delay: widget.startDelay, curve: Curves.fastOutSlowIn);
  }
}
