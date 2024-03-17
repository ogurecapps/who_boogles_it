import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import 'package:who_boogles_it/app/app_color.dart';

class CustomTransition {
  static CustomTransitionPage buildPage<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget page,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: 400.ms,
      reverseTransitionDuration: 400.ms,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => TurnPageTransition(
        animation: animation,
        overleafColor: AppColor.pageColor,
        animationTransitionPoint: 0.5,
        direction: TurnDirection.rightToLeft,
        child: child,
      ),
    );
  }
}
