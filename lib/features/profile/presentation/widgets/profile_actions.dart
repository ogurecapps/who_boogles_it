import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/name_editor.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
                onPressed: () {
                  if (BlocProvider.of<PlayerBloc>(context).state is! PlayerReadyState) return;
                  context.read<PlayerBloc>().add(const RandomPlayerNameEvent());
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size.square(48),
                ),
                child: const Icon(Icons.sync))
            .animate()
            .scale(
              delay: 600.ms,
              curve: Curves.fastOutSlowIn,
            ),
        const SizedBox(width: 8),
        ElevatedButton(
                onPressed: () {
                  if (BlocProvider.of<PlayerBloc>(context).state is! PlayerReadyState) return;
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      context: context,
                      builder: (innerContext) {
                        return BlocProvider.value(
                          value: BlocProvider.of<PlayerBloc>(context),
                          child: const NameEditor(),
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.square(48)),
                child: const Icon(Icons.edit))
            .animate()
            .scale(
              delay: 800.ms,
              curve: Curves.fastOutSlowIn,
            ),
      ],
    );
  }
}
