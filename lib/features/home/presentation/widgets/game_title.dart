import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class GameTitle extends StatefulWidget {
  const GameTitle({super.key});

  @override
  State<GameTitle> createState() => _GameTitleState();
}

class _GameTitleState extends State<GameTitle> with RouteAware, SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locator.get<RouteObserver<ModalRoute>>().subscribe(this, ModalRoute.of(context)!);
    });
    _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _controller.reset();
    _controller.forward();
    super.didPopNext();
  }

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
        .animate(controller: _controller)
        .slideY(begin: .8, end: 0, duration: 1000.ms, curve: Curves.fastOutSlowIn)
        .fadeIn(duration: 800.ms);
  }
}
