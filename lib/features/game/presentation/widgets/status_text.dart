import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_theme.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: AppTheme.defaultRadius,
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: Text(
          'Раунд 1',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
