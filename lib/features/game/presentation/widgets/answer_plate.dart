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
    isOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: AppSize.buttonBorder,
            )),
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xff39b8c2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
