import 'package:who_boogles_it/core/models/player.dart';
import 'package:who_boogles_it/shared/data/datasource/player_local_datasource.dart';
import 'package:who_boogles_it/shared/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  PlayerLocalDatasource localDatasource;

  PlayerRepositoryImpl({required this.localDatasource});

  @override
  Future<Player> getEnemy() {
    return localDatasource.getEnemy();
  }

  @override
  Future<Player> getMe() {
    return localDatasource.getMe();
  }

  @override
  Future<void> putPlayer(Player player) {
    return localDatasource.putPlayer(player);
  }
}
