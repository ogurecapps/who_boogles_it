import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/features/game/presentation/screens/game_screen.dart';
import 'package:who_boogles_it/features/home/presentation/screens/home_screen.dart';
import 'package:who_boogles_it/features/profile/presentation/screens/profile_screen.dart';
import 'package:who_boogles_it/features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'game',
            builder: (BuildContext context, GoRouterState state) {
              return const GameScreen();
            },
          ),
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
