import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AppTheme {
  ThemeData buildThemeData() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'SofiaSans',
            ),
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
          side: MaterialStatePropertyAll(BorderSide(
            color: colorScheme.primary,
            width: AppSize.buttonBorder,
          )),
        ),
      ),
      fontFamily: 'SofiaSans',
    );
  }
}
