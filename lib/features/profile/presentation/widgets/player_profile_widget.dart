import 'package:flutter/material.dart';

class PlayerProfileWidget extends StatefulWidget {
  const PlayerProfileWidget({super.key});

  @override
  State<PlayerProfileWidget> createState() => _PlayerProfileWidgetState();
}

class _PlayerProfileWidgetState extends State<PlayerProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Помятый_Крот',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              minimumSize: const Size.square(45),
            ),
            child: const Icon(Icons.sync)),
        const SizedBox(width: 8),
        ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), padding: EdgeInsets.zero, minimumSize: const Size.square(45)),
            child: const Icon(Icons.edit)),
      ],
    );
  }
}
