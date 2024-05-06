import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_size.dart';

class AppTheme {
  static final BoxShadow defaultBoxShadow = BoxShadow(
    color: AppColor.colorScheme.shadow.withOpacity(0.7),
    blurRadius: 2,
    offset: const Offset(1, 1),
  );

  static Object? getBackground() {
    if (backName != '') {
      return const DecorationImage(
        image: AssetImage("assets/images/jpg/$backName.jpg"),
        fit: BoxFit.cover,
      );
    }

    return null;
  }

  static const String backName = 'back_02';
  static const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(6));

  static ThemeData get light => ThemeData(
        fontFamily: 'MainFont',
        useMaterial3: true,
        colorScheme: AppColor.colorScheme,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'MainFont',
            color: AppColor.colorScheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: AppColor.colorScheme.onPrimary,
            fontSize: 17,
          ),
          bodySmall: TextStyle(
            fontFamily: 'MainFont',
            color: AppColor.colorScheme.outline,
            fontSize: 12,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'MainFont',
            color: AppColor.colorScheme.primary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'MainFont',
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
