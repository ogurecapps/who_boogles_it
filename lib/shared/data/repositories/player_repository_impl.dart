import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  PlayerLocalDatasource playerLocalDatasource;

  PlayerRepositoryImpl({required this.playerLocalDatasource});

  @override
  Future<Player> getEnemy() {
    return playerLocalDatasource.getEnemy();
  }

  @override
  Future<Player> getMe() {
    return playerLocalDatasource.getMe();
  }

  @override
  Future<void> putPlayer(Player player) {
    return playerLocalDatasource.putPlayer(player);
  }
}
