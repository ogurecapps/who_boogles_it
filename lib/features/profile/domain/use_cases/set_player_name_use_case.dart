import 'dart:ui';

import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/di/locator.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/core/util/nickname_generator.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class SetPlayerNameUseCase {
  final PlayerRepository playerRepository;

  SetPlayerNameUseCase({required this.playerRepository});

  Future<Player> execute({required String name}) async {
    var player = await playerRepository.getMe();

    if (name == '') {
      player.nickname = locator<NicknameGenerator>().getRandomNickname();
    } else {
      player.nickname = name;
    }

    await player.buildAvatar(const Size(AppSize.profileAvatarSize, AppSize.profileAvatarSize));
    await playerRepository.putPlayer(player);

    return player;
  }
}
