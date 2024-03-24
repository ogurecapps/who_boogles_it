import 'dart:ui';

import 'package:who_boogles_it/app/app_size.dart';
import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class GetPlayerUseCase {
  final PlayerRepository repository;

  GetPlayerUseCase({required this.repository});

  Future<Player> execute() async {
    return (await repository.getMe())
        .buildAvatar(const Size(AppSize.profileAvatarSize, AppSize.profileAvatarSize));
  }
}
