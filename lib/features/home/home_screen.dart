import 'package:flutter/material.dart';
import 'package:who_boogles_it/features/home/presentation/widgets/actions_group.dart';
import 'package:who_boogles_it/features/home/presentation/widgets/game_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/jpg/placeholder.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 50.0),
                child: const GameTitle(),
              ),
              const Center(child: ActionsGroup()),
            ],
          ),
        ),
      ),
    );
  }
}
