import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:who_boogles_it/features/profile/presentation/bloc/player_bloc.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size.square(48),
                ),
                child: const Icon(Icons.sync)),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.square(48)),
                child: const Icon(Icons.edit)),
          ],
        );
      },
    );
  }
}
