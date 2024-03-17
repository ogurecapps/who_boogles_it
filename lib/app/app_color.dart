import 'package:flutter/material.dart';

class AppColor {
  static const backPalette = (
    Color(0xff39b8c2),
    Color(0xff62698f),
    Color(0xfffc6999),
    Color(0xff8ce5a4),
  );

  static const grades = [
    Color(0xff818181),
    Color(0xffed5761),
    Color(0xff0f8b61),
    Color(0xff2a60c9),
    Color(0xffffb445),
    Color(0xff6e12bd),
  ];

  static const titleColor = Color(0xffed5761);
  static const pageColor = Color(0xfffcf5e4);

  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff0061a4),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffd1e4ff),
        onPrimaryContainer: Color(0xff111314),
        secondary: Color(0xff006781),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffb9eaff),
        onSecondaryContainer: Color(0xff101314),
        tertiary: Color.fromARGB(255, 29, 21, 17),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffffdbce),
        onTertiaryContainer: Color(0xff141211),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff141212),
        background: Color(0xfff8fafc),
        onBackground: Color(0xff090909),
        surface: Color(0xfff8fafc),
        onSurface: Color(0xff090909),
        surfaceVariant: Color(0xffe0e6e9),
        onSurfaceVariant: Color(0xff111212),
        outline: Color(0xff7c7c7c),
        outlineVariant: Color(0xffc8c8c8),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff101315),
        onInverseSurface: Color(0xfff5f5f5),
        inversePrimary: Color(0xff99daff),
        surfaceTint: Color(0xff0061a4),
      );
}
