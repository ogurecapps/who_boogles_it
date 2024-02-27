import 'package:flutter/material.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/bottom_bar.dart';
import 'package:who_boogles_it/features/profile/presentation/widgets/nickname_input.dart';
import 'package:who_boogles_it/shared/presentation/screens/scaffold_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      background: Theme.of(context).colorScheme.background,
      body: const Column(children: [
        SizedBox(height: AppSize.defaultSpace),
        NicknameInput(),
        SizedBox(height: AppSize.defaultSpace),
        Expanded(child: Placeholder()),
        SizedBox(height: AppSize.defaultSpace),
        BottomBar(),
      ]),
    );
  }
}
