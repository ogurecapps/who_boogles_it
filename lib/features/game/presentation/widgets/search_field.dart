import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_color.dart';
import 'package:who_boogles_it/app/app_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.colorScheme.onPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [AppTheme.defaultBoxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 2),
              const Text('Как развесилить самую грустную ...'),
            ],
          ),
        ),
      ),
    );
  }
}
