import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AppTheme {
  static final BoxShadow defaultBoxShadow = BoxShadow(
    color: AppColor.colorScheme.shadow.withOpacity(0.7),
    blurRadius: 2,
    offset: const Offset(1, 1),
  );

  static ThemeData get light => ThemeData(
        fontFamily: 'SofiaSans',
        useMaterial3: true,
        colorScheme: AppColor.colorScheme,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'SofiaSans',
            color: AppColor.colorScheme.primary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: AppColor.colorScheme.onPrimary,
            fontSize: 17,
          ),
          bodySmall: TextStyle(
            fontFamily: 'SofiaSans',
            color: AppColor.colorScheme.secondary,
            fontSize: 14,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'SofiaSans',
            color: AppColor.colorScheme.primary,
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
              color: AppColor.colorScheme.primary,
              width: AppSize.buttonBorder,
            )),
          ),
        ),
      );
}
