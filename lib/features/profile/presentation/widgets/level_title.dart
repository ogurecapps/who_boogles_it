import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class LevelTitle extends StatelessWidget {
  const LevelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      buildWhen: (previous, current) => previous is PlayerInitialState,
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: state is PlayerReadyState ? state.player.getLevel().grade : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: Colors.white, width: AppSize.buttonBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              state is PlayerReadyState ? '${LocaleKeys.level.tr()} ${state.player.getLevel().level}' : '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
