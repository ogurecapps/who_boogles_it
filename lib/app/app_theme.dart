import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AppTheme {
  static final BoxShadow defaultBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.6),
    blurRadius: 2,
    offset: const Offset(1, 1),
  );

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'SofiaSans',
          color: colorScheme.primary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        bodySmall: const TextStyle(
          fontFamily: 'SofiaSans',
          color: Colors.blueGrey,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'SofiaSans',
          color: colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
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
