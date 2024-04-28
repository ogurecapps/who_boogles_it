import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/routes/custom_transition.dart';
import 'package:who_boogles_it/features/game/presentation/screens/game_screen.dart';
import 'package:who_boogles_it/features/home/presentation/screens/home_screen.dart';
import 'package:who_boogles_it/features/profile/presentation/screens/profile_screen.dart';
import 'package:who_boogles_it/features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    observers: [locator.get<RouteObserver<ModalRoute>>()],
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'game',
            pageBuilder: (context, state) => CustomTransition.buildPage<void>(
              context: context,
              state: state,
              page: const GameScreen(langCode: 'ru'), // context.locale.languageCode - dynamic
            ),
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => CustomTransition.buildPage<void>(
              context: context,
              state: state,
              page: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: 'settings',
            pageBuilder: (context, state) => CustomTransition.buildPage<void>(
              context: context,
              state: state,
              page: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
