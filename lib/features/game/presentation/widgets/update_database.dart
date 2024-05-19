import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';

class UpdateDatabase extends StatelessWidget {
  const UpdateDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: AppTheme.defaultRadius,
            boxShadow: [AppTheme.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Lottie.asset(
                      'assets/anim/update.json',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const Text(
                    'Скачиваем самые странные запросы из Интернета...',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
