import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelIndicator extends StatelessWidget {
  const LevelIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previous, current) => previous is PlayerInitialState, // One time
      builder: (context, state) {
        return SizedBox(
          width: AppSize.profileInfoWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: AppTheme.defaultRadius,
              boxShadow: [AppTheme.defaultBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.levelProgressHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ).tr(),
                  LinearProgressIndicator(value: state is PlayerReadyState ? state.levelIndicatorValue : 0),
                  Text(
                    state is PlayerReadyState ? state.levelIndicatorLegend : '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
