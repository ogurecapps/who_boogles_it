import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_theme.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: AppTheme.defaultRadius,
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Text(
              'Round 1',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }
}
