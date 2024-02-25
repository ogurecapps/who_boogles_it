import 'package:who_boogles_it/models/player.dart';

abstract class PlayerLocalDatasource {
  Future<Player> getMe();
  Future<Player> getEnemy();
  Future<void> putPlayer(Player player);
}
