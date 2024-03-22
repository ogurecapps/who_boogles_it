import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  final String nickname;

  const PlayerView({super.key, required this.nickname});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  int life = 3;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
