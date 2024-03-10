import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';
import 'package:who_boogles_it/shared/presentation/util/single_anim_ctrl_state.dart';

class GameTitle extends StatefulWidget {
  const GameTitle({super.key});

  @override
  SingleAnimCtrlState createState() => _GameTitleState();
}

class _GameTitleState extends SingleAnimCtrlState {
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
    )
        .animate(controller: controller)
        .scaleXY(
          begin: 0.3,
          delay: 800.ms,
          duration: 1000.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(delay: 800.ms, duration: 1000.ms);
  }
}
