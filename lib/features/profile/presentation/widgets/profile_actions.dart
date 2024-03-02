import 'package:flutter/material.dart';
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
            onPressed: () => {context.read<PlayerBloc>().add(const RandomPlayerEvent())},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              minimumSize: const Size.square(48),
            ),
            child: const Icon(Icons.sync)),
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return const NameEditor();
                  });
            },
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), padding: EdgeInsets.zero, minimumSize: const Size.square(48)),
            child: const Icon(Icons.edit)),
      ],
    );
  }
}
