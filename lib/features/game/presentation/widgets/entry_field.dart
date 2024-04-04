import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class EntryField extends StatefulWidget {
  const EntryField({super.key});

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> with SingleTickerProviderStateMixin {
  bool _readOnly = true;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSubmitted(String text) {
    if (text != '') {
      setState(() => _readOnly = true);
      _controller.reverse();
      context.read<GameBloc>().add(PlayerSaysEvent(text.toUpperCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is PlayerTurnState) {
          _controller.forward();
          setState(() => _readOnly = false);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [AppTheme.defaultBoxShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.square(48),
                  ),
                  child: const Icon(Icons.logout),
                ),
                const SizedBox(width: AppSize.defaultSpace),
                Expanded(
                  child: TextFormField(
                    readOnly: _readOnly,
                    maxLength: 18,
                    onFieldSubmitted: (value) => onSubmitted(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я]')),
                    ],
                    decoration: InputDecoration(
                      hintText: LocaleKeys.entryHint.tr(),
                      counterText: '',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(
          autoPlay: false,
          controller: _controller,
        )
        .slideY(
          duration: 800.ms,
          begin: 1,
          end: 0,
          curve: Curves.fastOutSlowIn,
        );
  }
}
