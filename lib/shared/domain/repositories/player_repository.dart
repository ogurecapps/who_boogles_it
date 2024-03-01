import 'package:who_boogles_it/core/models/player.dart';

abstract class PlayerRepository {
  Future<Player> getMe();
  Future<Player> getEnemy();
  Future<void> putPlayer(Player player);
}
