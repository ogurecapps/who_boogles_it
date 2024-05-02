import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/app/app_theme.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/util/avatar_generator.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';
import 'package:who_boogles_it/features/game/presentation/bloc/game_bloc.dart';
import 'package:who_boogles_it/generated/locale_keys.g.dart';

class EnemySearch extends StatefulWidget {
  final Player enemy;

  const EnemySearch({super.key, required this.enemy});

  @override
  State<EnemySearch> createState() => _EnemySearchState();
}

class _EnemySearchState extends State<EnemySearch> with SingleTickerProviderStateMixin {
  late SvgPicture _avatar;
  late String _nickname;
  late final AnimationController _controller;

  bool _isFound = false;
  Duration _delay = 600.ms;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _avatar = widget.enemy.avatar;
    _nickname = widget.enemy.nickname;

    Timer.periodic(150.ms, (timer) async {
      if (_isFound) {
        setState(() {
          _avatar = widget.enemy.avatar;
          _nickname =
              '${widget.enemy.nickname} (${LocaleKeys.levelShort.tr()} ${widget.enemy.getLevelStats().level})';
        });
        timer.cancel();
      } else {
        final String nickname = locator<NicknameGenerator>().getRandomNickname();
        final SvgPicture avatar =
            await AvatarGenerator(_nickname, AppSize.gameAvatarSize, AppSize.gameAvatarSize).generate();

        setState(() {
          _nickname = nickname;
          _avatar = avatar;
        });
      }
    });

    Timer(
        4000.ms,
        () => setState(() {
              _isFound = true;
              _delay = 0.ms;
              _controller.reset();
              _controller.forward();
            }));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFound) {
          final GameBloc bloc = context.read<GameBloc>();
          bloc.add(LoadGameEvent(bloc.gameRepository.langCode));
        }
      },
      child: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: AppTheme.defaultRadius,
              boxShadow: [AppTheme.defaultBoxShadow],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [AppTheme.defaultBoxShadow],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      radius: AppSize.gameAvatarSize / 2 + AppSize.buttonBorder,
                      child: _avatar,
                    ),
                  ),
                  const SizedBox(height: AppSize.defaultSpace / 2),
                  Text(
                    _nickname,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.defaultSpace),
                    child: Text(
                      _isFound ? LocaleKeys.enemySearchEnd : LocaleKeys.enemySearchStart,
                      textAlign: TextAlign.center,
                    ).tr(),
                  )
                      .animate(
                        delay: _delay,
                        controller: _controller,
                      )
                      .slideY(
                        duration: 400.ms,
                        begin: 0.5,
                        end: 0,
                        curve: Curves.fastOutSlowIn,
                      )
                      .fadeIn(
                        duration: 400.ms,
                      ),
                ],
              ),
            ),
          ),
        ),
      )
          .animate()
          .slideY(
            delay: 200.ms,
            duration: 600.ms,
            begin: 0.1,
            end: 0,
            curve: Curves.fastOutSlowIn,
          )
          .fadeIn(
            delay: 200.ms,
            duration: 600.ms,
          ),
    );
  }
}
