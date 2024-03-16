import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/level_grades_tip.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelTitle extends StatelessWidget {
  const LevelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previous, current) => previous is PlayerInitialState, // One time
      builder: (context, state) {
        return GestureDetector(
          onTap: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return const LevelGradesTip();
              }),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: state is PlayerReadyState ? state.levelGrade : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              border: Border.all(color: Colors.white, width: AppSize.buttonBorder),
              boxShadow: [AppTheme.defaultBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                state is PlayerReadyState ? '${LocaleKeys.level.tr()} ${state.level}' : '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
