import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AnswerPlate extends StatefulWidget {
  final int number;
  final String text;
  final int points;

  const AnswerPlate({super.key, required this.number, required this.text, required this.points});

  @override
  State<AnswerPlate> createState() => _AnswerPlateState();
}

class _AnswerPlateState extends State<AnswerPlate> {
  late bool isOpen;

  @override
  void initState() {
    isOpen = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        Text(
          widget.text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          widget.points.toString(),
          style: Theme.of(context).textTheme.titleSmall,
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
            )),
        child: isOpen ? openedSide : closedSide,
      ),
    );
  }
}
