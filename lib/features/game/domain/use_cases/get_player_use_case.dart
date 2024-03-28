import 'dart:ui';

import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class GetPlayerUseCase {
  final PlayerRepository repository;

  GetPlayerUseCase({required this.repository});

  Future<Player> execute(bool isMe) async {
    return (isMe ? await repository.getMe() : await repository.getEnemy())
        .buildAvatar(const Size(AppSize.gameAvatarSize, AppSize.gameAvatarSize));
  }
}
