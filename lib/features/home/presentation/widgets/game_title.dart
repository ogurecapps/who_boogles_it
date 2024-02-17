import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 42;
    const double linesSpacing = .9;
    const double borderSize = 5;
    const Color textColor = Color(0xffed5761);
    const Color borderColor = Colors.white;

    return Stack(
      children: [
        Text(
          LocaleKeys.gameTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              height: linesSpacing,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = borderSize
                ..color = borderColor),
        ).tr(),
        const Text(
          LocaleKeys.gameTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: linesSpacing,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: textColor,
          ),
        ).tr(),
      ],
    );
  }
}
